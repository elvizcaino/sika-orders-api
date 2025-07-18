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
    public class TaxTableRepositoryImpl(IOptions<ConnectionConfiguration> cnn) : ITaxTableRepository
    {
        private readonly ConnectionConfiguration _cnn = cnn.Value;

        public async Task<List<TaxTableDto>> GetAll()
        {
            List<TaxTableDto> taxTableData = [];

            try
            {
                using var cnn = new SqlConnection(_cnn.SqlConnection);
                await cnn.OpenAsync();

                SqlCommand cmd = new("sp_GetTaxTable", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync()) 
                    {
                        taxTableData.Add(new TaxTableDto
                        {
                            Code = reader["Code"].ToString(),
                            Value = Convert.ToDecimal(reader["Value"])
                        });
                    }
                }
                return taxTableData;

            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los datos: " + ex.Message, ex);
            }
        }

        public async Task<TaxTableDto?> GetByCode(string id)
        {
            TaxTableDto? taxTableData = null;

            try
            {
                using var cnn = new SqlConnection(_cnn.SqlConnection);
                await cnn.OpenAsync();

                SqlCommand cmd = new("sp_GetTaxTableByCode", cnn) 
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@Code", id);

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    if (await reader.ReadAsync())
                    {
                        taxTableData = new TaxTableDto
                        {
                            Code = reader["Code"].ToString(),
                            Value = Convert.ToDecimal(reader["Value"])
                        };
                    }
                }

                return taxTableData;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los datos: " + ex.Message, ex);
            }
        }

        public async Task<string> Upsert([FromBody] IEnumerable<TaxTableDto> taxTable, string userName)
        {
            string value = "";

            try
            {
                var taxTableRecords = TaxTableRecord.Records(taxTable);

                using var cnn = new SqlConnection(_cnn.SqlConnection);
                cnn.Open();

                using (var cmdContext = new SqlCommand("EXEC sp_set_session_context @key=N'UserName', @value=@userName;", cnn))
                {
                    cmdContext.Parameters.AddWithValue("@userName", userName);
                    await cmdContext.ExecuteNonQueryAsync();
                }

                SqlCommand cmd = new("sp_UpsertTaxTable", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add("@TaxTable", SqlDbType.Structured).Value = taxTableRecords;
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

                SqlCommand cmd = new("sp_DeleteTaxTable", cnn)
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
