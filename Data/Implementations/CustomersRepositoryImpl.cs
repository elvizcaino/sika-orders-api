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
    public class CustomersRepositoryImpl(IOptions<ConnectionConfiguration> cnn) : ICustomersRepository
    {
        private readonly ConnectionConfiguration _cnn = cnn.Value;

        public async Task<List<CustomersDto>> GetAll()
        {
            List<CustomersDto> customersData = [];

            try
            {
                using var cnn = new SqlConnection(_cnn.SqlConnection);
                await cnn.OpenAsync();

                SqlCommand cmd = new("sp_GetCustomers", cnn) 
                {
                    CommandType = CommandType.StoredProcedure
                };

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        customersData.Add(new CustomersDto
                        {
                            CustAccount = reader["CustAccount"] != DBNull.Value ? reader["CustAccount"].ToString() : null,
                            RIF = reader["RIF"] != DBNull.Value ? reader["RIF"].ToString() : null,
                            FullName = reader["FullName"] != DBNull.Value ? reader["FullName"].ToString() : null,
                            Phone = reader["Phone"] != DBNull.Value ? reader["Phone"].ToString() : null,
                            Address = reader["Address"] != DBNull.Value ? reader["Address"].ToString() : null,
                            WithholdingAgent = reader["WithholdingAgent"] != DBNull.Value ? Convert.ToBoolean(reader["WithholdingAgent"]) : null,
                            WithholdingCode = reader["WithholdingCode"] != DBNull.Value ? reader["WithholdingCode"].ToString() : null
                        });
                    }
                }
                return customersData;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener todos los clientes: " + ex.Message, ex);
            }
        }

        public async Task<CustomersDto?> GetByIdentification(string id)
        {
            CustomersDto? customerData = null;

            try
            {
                using var cnn = new SqlConnection(_cnn.SqlConnection);
                await cnn.OpenAsync();

                SqlCommand cmd = new("sp_GetCustomerByIdentification", cnn) 
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@Identification", id);

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    if (await reader.ReadAsync())
                    {
                        customerData = new CustomersDto
                        {
                            CustAccount = reader["CustAccount"] != DBNull.Value ? reader["CustAccount"].ToString() : null,
                            RIF = reader["RIF"] != DBNull.Value ? reader["RIF"].ToString() : null,
                            FullName = reader["FullName"] != DBNull.Value ? reader["FullName"].ToString() : null,
                            Phone = reader["Phone"] != DBNull.Value ? reader["Phone"].ToString() : null,
                            Address = reader["Address"] != DBNull.Value ? reader["Address"].ToString() : null,
                            WithholdingAgent = reader["WithholdingAgent"] != DBNull.Value ? Convert.ToBoolean(reader["WithholdingAgent"]) : null,
                            WithholdingCode = reader["WithholdingCode"] != DBNull.Value ? reader["WithholdingCode"].ToString() : null
                        };
                    }
                }
                return customerData;
            }
            catch (Exception ex)
            {
                throw new Exception($"Error al obtener el cliente por identificación ({id}): " + ex.Message, ex);
            }
        }

        public async Task<string> Upsert([FromBody] IEnumerable<CustomersDto> data, string userName)
        {
            string value = "";

            try
            {
                var records = CustomersRecord.Records(data);

                using var cnn = new SqlConnection(_cnn.SqlConnection);
                cnn.Open();

                using (var cmdContext = new SqlCommand("EXEC sp_set_session_context @key=N'UserName', @value=@userName;", cnn))
                {
                    cmdContext.Parameters.AddWithValue("@userName", userName);
                    await cmdContext.ExecuteNonQueryAsync();
                }

                SqlCommand cmd = new("sp_UpsertCustomers", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add("@CustomersData", SqlDbType.Structured).Value = records;
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

                SqlCommand cmd = new("sp_DeleteCustomers", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add("@CustAccount", SqlDbType.NVarChar, 20).Value = code;

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
