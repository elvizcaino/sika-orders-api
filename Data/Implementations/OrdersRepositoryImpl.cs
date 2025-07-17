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
                    CustAddress = reader.GetString(8),
                    IssueDate = reader.GetDateTime(9),
                    DueDate = reader.GetDateTime(10),
                    SalesPersonId = reader.GetString(11),
                    SalesPersonName = reader.GetString(12),
                    RegionId = reader.GetString(13),
                    RegionName = reader.GetString(14),
                    CreditDays = reader.GetString(15),
                    BaseTaxable = reader.GetDecimal(16),
                    Base0 = reader.GetDecimal(17),
                    TaxRate = reader.GetDecimal(18),
                    TotalTaxes = reader.GetDecimal(19),
                    CurrencyCode = reader.IsDBNull(20) ? null : reader.GetString(20),
                    ControlNumber = reader.IsDBNull(21) ? null : reader.GetString(21),
                    Status = reader.GetString(22),
                    OrdersLines = []
                };
            }

            if (ordersTable != null)
            {
                await reader.NextResultAsync();

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
                        Unit = reader.IsDBNull(7) ? null : reader.GetString(7),
                        Quantity = reader.GetInt32(8),
                        Kgs = reader.GetDecimal(9),
                        TotalKgs = reader.GetDecimal(10),
                        UnitPrice = reader.GetDecimal(11),
                        TotalAmount = reader.GetDecimal(12),
                        TaxCode = reader.IsDBNull(13) ? null : reader.GetString(13),
                        TaxValue = reader.IsDBNull(14) ? null : reader.GetDecimal(14),
                        TaxAmount = reader.IsDBNull(15) ? null : reader.GetDecimal(15),
                        DiscAmount = reader.IsDBNull(16) ? null : reader.GetDecimal(16),
                        DiscPercent = reader.IsDBNull(17) ? null : reader.GetDecimal(17),
                        Status = reader.GetString(18)
                    };
                    ordersTable.OrdersLines.Add(orderLine);
                }

                await reader.NextResultAsync();
                var orderTotals = new OrdersTotalsDto
                { 
                    Id = reader.GetInt32(0),
                    CreatedAt = reader.GetDateTime(1),
                    UpdatedAt = reader.GetDateTime(2),
                    OrderNumber = reader.GetString(3),
                    TotalKgs = reader.GetDecimal(4),
                    Subtotal = reader.GetDecimal(5),
                    DiscPrice = reader.GetDecimal(6),
                    BaseTaxable = reader.GetDecimal(7),
                    TotalTax = reader.GetDecimal(8),
                    TotalToPay = reader.GetDecimal(9),
                    Observs = reader.IsDBNull(10) ? null : reader.GetString(10),
                };
                ordersTable.OrdersTotals = orderTotals;
            }

            return ordersTable;
        }

        public async Task<string> Exists(string orderNumber)
        {
            using var cnn = new SqlConnection(_cnn.SqlConnection);
            cnn.Open();

            SqlCommand cmd = new("sp_CheckIfOrderExists", cnn)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@OrderNumber", orderNumber);
            cmd.Parameters.Add("@ReturnValue", SqlDbType.Int).Direction = ParameterDirection.Output;

            await cmd.ExecuteNonQueryAsync();

            int returnValue = (int)cmd.Parameters["@ReturnValue"].Value;

            if (returnValue == 0)
            {
                return $"No existe la orden {orderNumber}";
            }
            else
            {
                return "OK";
            }
        }

        public async Task<string> Insert([FromBody] OrdersInsertDto ordersDto, string userName)
        {
            string value = "";

            try
            {
                List<OrdersTotalsDto> ordersTotal = [ordersDto.OrdersTotals];
                var ordersLines = OrdersLinesRecord.Records(ordersDto.OrdersLines);
                var ordersTotals = OrdersTotalsRecord.Records(ordersTotal);

                using var cnn = new SqlConnection(_cnn.SqlConnection);
                cnn.Open();

                using (var cmdContext = new SqlCommand("EXEC sp_set_session_context @key=N'UserName', @value=@userName;", cnn))
                {
                    cmdContext.Parameters.AddWithValue("@userName", userName);
                    await cmdContext.ExecuteNonQueryAsync();
                }

                SqlCommand cmd = new("sp_InsertOrders", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@OrderNumber", ordersDto.OrderNumber);
                cmd.Parameters.AddWithValue("@CustAccount", ordersDto.CustAccount);
                cmd.Parameters.AddWithValue("@CustRIF", ordersDto.CustRIF);
                cmd.Parameters.AddWithValue("@CustIdentification", ordersDto.CustIdentification);
                cmd.Parameters.AddWithValue("@CustName", ordersDto.CustName);
                cmd.Parameters.AddWithValue("@CustAddress", ordersDto.CustAddress);
                cmd.Parameters.AddWithValue("@IssueDate", ordersDto.IssueDate);
                cmd.Parameters.AddWithValue("@DueDate", ordersDto.DueDate);
                cmd.Parameters.AddWithValue("@SalesPersonId", ordersDto.SalesPersonId);
                cmd.Parameters.AddWithValue("@SalesPersonName", ordersDto.SalesPersonName);
                cmd.Parameters.AddWithValue("@RegionId", ordersDto.RegionId);
                cmd.Parameters.AddWithValue("@RegionName", ordersDto.RegionName);
                cmd.Parameters.AddWithValue("@CreditDays", ordersDto.CreditDays);
                cmd.Parameters.AddWithValue("@BaseTaxable", ordersDto.BaseTaxable);
                cmd.Parameters.AddWithValue("@Base0", ordersDto.Base0);
                cmd.Parameters.AddWithValue("@TaxRate", ordersDto.TaxRate);
                cmd.Parameters.AddWithValue("@TotalTaxes", ordersDto.TotalTaxes);
                cmd.Parameters.AddWithValue("@CurrencyCode", ordersDto.CurrencyCode);
                cmd.Parameters.Add("@OrdersLines", SqlDbType.Structured).Value = ordersLines;
                cmd.Parameters.Add("@OrdersTotals", SqlDbType.Structured).Value = ordersTotals;
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

        public async Task<string> Update(OrdersUpdateDto ordersDto, string userName)
        {
            string value = "";

            try
            {
                List<OrdersTotalsDto> ordersTotal = [ordersDto.OrdersTotals];
                var ordersLines = OrdersLinesRecord.Records(ordersDto.OrdersLines);
                var ordersTotals = OrdersTotalsRecord.Records(ordersTotal);

                using var cnn = new SqlConnection(_cnn.SqlConnection);
                cnn.Open();

                using (var cmdContext = new SqlCommand("EXEC sp_set_session_context @key=N'UserName', @value=@userName;", cnn))
                {
                    cmdContext.Parameters.AddWithValue("@userName", userName);
                    await cmdContext.ExecuteNonQueryAsync();
                }

                SqlCommand cmd = new("sp_UpdateOrders", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@OrderNumber", ordersDto.OrderNumber);
                cmd.Parameters.AddWithValue("@CustAccount", ordersDto.CustAccount);
                cmd.Parameters.AddWithValue("@CustRIF", ordersDto.CustRIF);
                cmd.Parameters.AddWithValue("@CustIdentification", ordersDto.CustIdentification);
                cmd.Parameters.AddWithValue("@CustName", ordersDto.CustName);
                cmd.Parameters.AddWithValue("@CustAddress", ordersDto.CustAddress);
                cmd.Parameters.AddWithValue("@IssueDate", ordersDto.IssueDate);
                cmd.Parameters.AddWithValue("@DueDate", ordersDto.DueDate);
                cmd.Parameters.AddWithValue("@SalesPersonId", ordersDto.SalesPersonId);
                cmd.Parameters.AddWithValue("@SalesPersonName", ordersDto.SalesPersonName);
                cmd.Parameters.AddWithValue("@RegionId", ordersDto.RegionId);
                cmd.Parameters.AddWithValue("@RegionName", ordersDto.RegionName);
                cmd.Parameters.AddWithValue("@CreditDays", ordersDto.CreditDays);
                cmd.Parameters.AddWithValue("@BaseTaxable", ordersDto.BaseTaxable);
                cmd.Parameters.AddWithValue("@Base0", ordersDto.Base0);
                cmd.Parameters.AddWithValue("@TaxRate", ordersDto.TaxRate);
                cmd.Parameters.AddWithValue("@TotalTaxes", ordersDto.TotalTaxes);
                cmd.Parameters.AddWithValue("@CurrencyCode", ordersDto.CurrencyCode);
                cmd.Parameters.Add("@OrdersLines", SqlDbType.Structured).Value = ordersLines;
                cmd.Parameters.Add("@OrdersTotals", SqlDbType.Structured).Value = ordersTotals;
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

        public async Task<string> UpdateControlNumber(string orderNumber, OrdersUpdateControlNumberDto dto, string userName)
        {
            try
            {
                int returnValue = 0;
                using (var cnn = new SqlConnection(_cnn.SqlConnection))
                {
                    cnn.Open();

                    using (var cmdContext = new SqlCommand("EXEC sp_set_session_context @key=N'UserName', @value=@userName;", cnn))
                    {
                        cmdContext.Parameters.AddWithValue("@userName", userName);
                        await cmdContext.ExecuteNonQueryAsync();
                    }

                    SqlCommand cmd = new("sp_UpdateOrdersTable_ControlNumber", cnn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };

                    cmd.Parameters.AddWithValue("@OrderNumber", orderNumber);
                    cmd.Parameters.AddWithValue("@ControlNumber", dto.ControlNumber);
                    cmd.Parameters.Add("@ReturnValue", SqlDbType.Int).Direction = ParameterDirection.Output;

                    var res = await cmd.ExecuteNonQueryAsync();

                    returnValue = (int)cmd.Parameters["@ReturnValue"].Value;
                }


                if (returnValue == 0)
                {
                    return $"No existe la orden {orderNumber}";
                }
                else
                {
                    return "OK";
                }
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
    }
}
