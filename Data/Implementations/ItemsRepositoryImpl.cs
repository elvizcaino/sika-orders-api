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
    public class ItemsRepositoryImpl(IOptions<ConnectionConfiguration> cnn) : IItemsRepository
    {
        private readonly ConnectionConfiguration _cnn = cnn.Value;

        public async Task<List<ItemsDto>> GetAll()
        {
            List<ItemsDto> itemsData = [];

            try
            {
                using var cnn = new SqlConnection(_cnn.SqlConnection);
                await cnn.OpenAsync();

                SqlCommand cmd = new("sp_GetItems", cnn) 
                {
                    CommandType = CommandType.StoredProcedure
                };

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        itemsData.Add(new ItemsDto
                        {
                            ItemId = reader["ItemId"] != DBNull.Value ? reader["ItemId"].ToString() : null,
                            ItemName = reader["ItemName"] != DBNull.Value ? reader["ItemName"].ToString() : null,
                            GroupId = reader["GroupId"] != DBNull.Value ? reader["GroupId"].ToString() : null,
                            TaxCode = reader["TaxCode"] != DBNull.Value ? reader["TaxCode"].ToString() : null,
                            PriceUSD = reader["PriceUSD"] != DBNull.Value ? Convert.ToDecimal(reader["PriceUSD"]) : null
                        });
                    }
                }
                return itemsData;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener todos los artículos: " + ex.Message, ex);
            }
        }

        public async Task<ItemsDto?> GetById(string itemId)
        {
            ItemsDto? itemData = null;

            try
            {
                using var cnn = new SqlConnection(_cnn.SqlConnection);
                await cnn.OpenAsync();

                SqlCommand cmd = new("sp_GetItemByItemId", cnn) 
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@ItemId", itemId);

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    if (await reader.ReadAsync())
                    {
                        itemData = new ItemsDto
                        {
                            ItemId = reader["ItemId"] != DBNull.Value ? reader["ItemId"].ToString() : null,
                            ItemName = reader["ItemName"] != DBNull.Value ? reader["ItemName"].ToString() : null,
                            GroupId = reader["GroupId"] != DBNull.Value ? reader["GroupId"].ToString() : null,
                            TaxCode = reader["TaxCode"] != DBNull.Value ? reader["TaxCode"].ToString() : null,
                            PriceUSD = reader["PriceUSD"] != DBNull.Value ? Convert.ToDecimal(reader["PriceUSD"]) : null
                        };
                    }
                }
                return itemData;
            }
            catch (Exception ex)
            {
                throw new Exception($"Error al obtener el artículo por id ({itemId}): " + ex.Message, ex);
            }
        }

        public async Task<string> Upsert([FromBody] IEnumerable<ItemsDto> data, string userName)
        {
            string value = "";

            try
            {
                var records = ItemsRecord.Records(data);

                using var cnn = new SqlConnection(_cnn.SqlConnection);
                cnn.Open();

                using (var cmdContext = new SqlCommand("EXEC sp_set_session_context @key=N'UserName', @value=@userName;", cnn))
                {
                    cmdContext.Parameters.AddWithValue("@userName", userName);
                    await cmdContext.ExecuteNonQueryAsync();
                }

                SqlCommand cmd = new("sp_UpsertItems", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.Add("@ItemsData", SqlDbType.Structured).Value = records;
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

        public async Task<string> Delete(string itemId, string userName)
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

                SqlCommand cmd = new("sp_DeleteItems", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                }; 

                cmd.Parameters.Add("@ItemId", SqlDbType.NVarChar, 20).Value = itemId;

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
