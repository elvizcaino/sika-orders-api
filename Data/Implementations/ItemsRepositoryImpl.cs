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
