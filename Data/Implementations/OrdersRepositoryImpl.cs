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
    public class OrdersRepositoryImpl(IOptions<ConnectionConfiguration> cnn) : IOrdersRepository
    {
        private readonly ConnectionConfiguration _cnn = cnn.Value;

        public async Task<OrdersTableDto?> GetOrdersTableByOrderNumber(string orderNumber)
        {
            using var cnn = new SqlConnection(_cnn.SqlConnection);
            cnn.Open();

            SqlCommand cmd = new("sp_GetOrdersTableByOrderNumber", cnn)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@OrderNumber", orderNumber);

            var reader = await cmd.ExecuteReaderAsync();

            OrdersTableDto? ordersTable = null;
            if (await reader.ReadAsync())
            {
                ordersTable = new OrdersTableDto
                {
                    Id = reader.GetInt32(0),
                    CreatedAt = reader.GetDateTime(1),
                    UpdatedAt = reader.GetDateTime(2),
                    OrderNumber = reader.GetString(3),
                    CustAccount = reader.GetString(4),
                    CustRIF = reader.GetString(5),
                    CustIdentification = reader.GetString(6),
                    CustName = reader.GetString(7),
                    TotalAmount = reader.GetDecimal(8),
                    Status = reader.GetString(9),
                    OrdersLines = []
                };
            }

            if (ordersTable != null && await reader.NextResultAsync())
            {
                while (await reader.ReadAsync())
                {
                    var orderLine = new OrdersLinesDto
                    {
                        Id = reader.GetInt32(0),
                        CreatedAt = reader.GetDateTime(1),
                        UpdatedAt = reader.GetDateTime(2),
                        OrderNumber = reader.GetString(3),
                        LineNum = reader.GetInt32(4),
                        ItemId = reader.GetString(5),
                        ItemName = reader.GetString(6),
                        Quantity = reader.GetInt32(7),
                        UnitPrice = reader.GetDecimal(8),
                        TotalAmount = reader.GetDecimal(9),
                        Status = reader.GetString(10)
                    };
                    ordersTable.OrdersLines.Add(orderLine);
                }
            }

            return ordersTable;
        }

        public async Task<string?> Insert([FromBody] OrdersInsertDto ordersDto)
        {
            string? value = null;

            try
            {
                var ordersLines = OrdersLinesRecord.Records(ordersDto.OrdersLines);

                using var cnn = new SqlConnection(_cnn.SqlConnection);
                cnn.Open();

                SqlCommand cmd = new("sp_InsertOrders", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@OrderNumber", ordersDto.OrderNumber);
                cmd.Parameters.AddWithValue("@CustAccount", ordersDto.CustAccount);
                cmd.Parameters.AddWithValue("@CustRIF", ordersDto.CustRIF);
                cmd.Parameters.AddWithValue("@CustIdentification", ordersDto.CustIdentification);
                cmd.Parameters.AddWithValue("@CustName", ordersDto.CustName);
                cmd.Parameters.AddWithValue("@TotalAmount", ordersDto.TotalAmount);
                cmd.Parameters.AddWithValue("@Status", ordersDto.Status);
                cmd.Parameters.Add("@OrdersLines", SqlDbType.Structured).Value = ordersLines;
                cmd.Parameters.Add("@ReturnValue", SqlDbType.Int).Direction = ParameterDirection.Output;

                var res = await cmd.ExecuteNonQueryAsync();

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
    
        public async Task<string?> Update(OrdersUpdateDto ordersDto)
        {
            string? value = null;

            try
            {
                var ordersLines = OrdersLinesRecord.Records(ordersDto.OrdersLines);

                using var cnn = new SqlConnection(_cnn.SqlConnection);
                cnn.Open();

                SqlCommand cmd = new("sp_UpdateOrders", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@OrderNumber", ordersDto.OrderNumber);
                cmd.Parameters.AddWithValue("@CustAccount", ordersDto.CustAccount);
                cmd.Parameters.AddWithValue("@CustRIF", ordersDto.CustRIF);
                cmd.Parameters.AddWithValue("@CustIdentification", ordersDto.CustIdentification);
                cmd.Parameters.AddWithValue("@CustName", ordersDto.CustName);
                cmd.Parameters.AddWithValue("@TotalAmount", ordersDto.TotalAmount);
                cmd.Parameters.AddWithValue("@Status", ordersDto.Status);
                cmd.Parameters.Add("@OrdersLines", SqlDbType.Structured).Value = ordersLines;
                cmd.Parameters.Add("@ReturnValue", SqlDbType.Int).Direction = ParameterDirection.Output;

                var res = await cmd.ExecuteNonQueryAsync();

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
    }
}
