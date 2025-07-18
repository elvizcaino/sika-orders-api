using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Options;
using OrdersAPI.Data.Configuration;
using OrdersAPI.Data.DTOs;
using OrdersAPI.Data.Interfaces;
using OrdersAPI.Data.Records;
using System.Data;

namespace OrdersAPI.Data.Implementations
{
    public class WithholdingsRepositoryImpl(IOptions<ConnectionConfiguration> cnn) : IWithholdingsRepository
    {
        private readonly ConnectionConfiguration _cnn = cnn.Value;

        public async Task<List<WithholdingsDto>> GetAll()
        {
            List<WithholdingsDto> withholdingsData = [];

            try
            {
                using var cnn = new SqlConnection(_cnn.SqlConnection);
                await cnn.OpenAsync();

                SqlCommand cmd = new("sp_GetWithholdings", cnn) 
                {
                    CommandType = CommandType.StoredProcedure
                };

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        withholdingsData.Add(new WithholdingsDto
                        {
                            Code = reader["Code"] != DBNull.Value ? reader["Code"].ToString() : null,
                            Name = reader["Name"] != DBNull.Value ? reader["Name"].ToString() : null,
                            Type = reader["Type"] != DBNull.Value ? reader["Type"].ToString() : null,
                            ContributorType = reader["ContributorType"] != DBNull.Value ? reader["ContributorType"].ToString() : null,
                            Percent = reader["Percent"] != DBNull.Value ? Convert.ToDecimal(reader["Percent"]) : null,
                            BaseMin = reader["BaseMin"] != DBNull.Value ? Convert.ToDecimal(reader["BaseMin"]) : null,
                            Subtrahend = reader["Subtrahend"] != DBNull.Value ? Convert.ToDecimal(reader["Subtrahend"]) : null,
                            TaxBasePercent = reader["TaxBasePercent"] != DBNull.Value ? Convert.ToDecimal(reader["TaxBasePercent"]) : null
                        });
                    }
                }
                return withholdingsData;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los datos: " + ex.Message, ex);
            }
        }

        public async Task<WithholdingsDto?> GetByCode(string code)
        {
            WithholdingsDto? withholdingData = null;

            try
            {
                using var cnn = new SqlConnection(_cnn.SqlConnection);
                await cnn.OpenAsync();

                SqlCommand cmd = new("sp_GetWithholdingByCode", cnn) 
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@Code", code);

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    if (await reader.ReadAsync())
                    {
                        withholdingData = new WithholdingsDto
                        {
                            Code = reader["Code"] != DBNull.Value ? reader["Code"].ToString() : null,
                            Name = reader["Name"] != DBNull.Value ? reader["Name"].ToString() : null,
                            Type = reader["Type"] != DBNull.Value ? reader["Type"].ToString() : null,
                            ContributorType = reader["ContributorType"] != DBNull.Value ? reader["ContributorType"].ToString() : null,
                            Percent = reader["Percent"] != DBNull.Value ? Convert.ToDecimal(reader["Percent"]) : null,
                            BaseMin = reader["BaseMin"] != DBNull.Value ? Convert.ToDecimal(reader["BaseMin"]) : null,
                            Subtrahend = reader["Subtrahend"] != DBNull.Value ? Convert.ToDecimal(reader["Subtrahend"]) : null,
                            TaxBasePercent = reader["TaxBasePercent"] != DBNull.Value ? Convert.ToDecimal(reader["TaxBasePercent"]) : null
                        };
                    }
                }
                return withholdingData;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los datos: " + ex.Message, ex);
            }
        }

        public async Task<string> Upsert([FromBody] IEnumerable<WithholdingsDto> data, string userName)
        {
            string value = "";

            try
            {
                var records = WithholdingsRecord.Records(data);

                using var cnn = new SqlConnection(_cnn.SqlConnection);
                cnn.Open();

                using (var cmdContext = new SqlCommand("EXEC sp_set_session_context @key=N'UserName', @value=@userName;", cnn))
                {
                    cmdContext.Parameters.AddWithValue("@userName", userName);
                    await cmdContext.ExecuteNonQueryAsync();
                }

                SqlCommand cmd = new("sp_UpsertWithholdings", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add("@WithholdingsData", SqlDbType.Structured).Value = records;
                cmd.Parameters.Add("@ReturnValue", SqlDbType.Int).Direction = ParameterDirection.Output;

                await cmd.ExecuteNonQueryAsync();

                var res = cmd.Parameters["@ReturnValue"].Value as int? ?? 0;

                if (res > 0)
                {
                    value = "OK";
                }

            }
            catch (Exception ex)
            {
                value = ex.Message;
            }

            return value;
        }

        public async Task<string> Delete(string code, string userName)
        {
            string value = "";

            try
            {
                using var cnn = new SqlConnection(_cnn.SqlConnection);
                cnn.Open();

                using (var cmdContext = new SqlCommand("EXEC sp_set_session_context @key=N'UserName', @value=@userName;", cnn))
                {
                    cmdContext.Parameters.AddWithValue("@userName", userName);
                    await cmdContext.ExecuteNonQueryAsync();
                }

                SqlCommand cmd = new("sp_DeleteWithholdings", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add("@Code", SqlDbType.NVarChar, 10).Value = code;

                await cmd.ExecuteNonQueryAsync();

                value = "OK";

            }
            catch (Exception ex)
            {
                value = ex.Message;
            }

            return value;
        }
    }
}
