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

        public async Task<PagedResponseDto<OrdersTableDto>> GetAll(int pageNumber = 1, int pageSize = 10)
        {
            List<OrdersTableDto> ordersTableData = [];
            Dictionary<string, OrdersTableDto> ordersMap = [];
            int totalCount = 0;

            try
            {
                using var cnn = new SqlConnection(_cnn.SqlConnection);
                await cnn.OpenAsync();

                SqlCommand cmd = new("sp_GetOrders", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@PageNumber", pageNumber);
                cmd.Parameters.AddWithValue("@PageSize", pageSize);

                using (SqlDataReader reader = await cmd.ExecuteReaderAsync())
                {
                    // 1. Leer los encabezados de las órdenes paginadas (PRIMER result set del SP)
                    while (await reader.ReadAsync())
                    {
                        var order = new OrdersTableDto
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
                            OrdersLines = [], 
                            OrdersTotals = null 
                        };
                        ordersTableData.Add(order);
                        ordersMap.Add(order.OrderNumber, order);
                    }

                    // 2. Mover al siguiente conjunto de resultados (OrdersLines)
                    await reader.NextResultAsync();

                    // Leer las líneas de órdenes y asignarlas a sus respectivos encabezados
                    while (await reader.ReadAsync())
                    {
                        string currentOrderNumber = reader.GetString(3); // El OrderNumber de la línea

                        if (ordersMap.TryGetValue(currentOrderNumber, out var orderHeader))
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
                            orderHeader.OrdersLines.Add(orderLine);
                        }
                    }

                    // 3. Mover al siguiente conjunto de resultados (OrdersTotals)
                    await reader.NextResultAsync();

                    // Leer los totales de órdenes y asignarlos a sus respectivos encabezados
                    while (await reader.ReadAsync())
                    {
                        string currentOrderNumber = reader.GetString(3); // El OrderNumber del total

                        if (ordersMap.TryGetValue(currentOrderNumber, out var orderHeader))
                        {
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
                            orderHeader.OrdersTotals = orderTotals; // Asignar el objeto de totales
                        }
                    }

                    // 4. Mover al cuarto conjunto de resultados (TotalCount)
                    // Se espera que este result set siempre exista y contenga una única fila con el TotalCount.
                    await reader.NextResultAsync();
                    if (await reader.ReadAsync())
                    {
                        totalCount = reader.GetInt32(0); // El conteo total estará en la primera columna
                    }
                }

                // Devolver la respuesta paginada
                return new PagedResponseDto<OrdersTableDto>
                {
                    Data = ordersTableData,
                    TotalCount = totalCount,
                    PageNumber = pageNumber,
                    PageSize = pageSize
                };
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los datos de órdenes (paginación): " + ex.Message, ex);
            }
        }

        public async Task<OrdersTableDto?> GetByOrderNumber(string orderNumber)
        {
            try
            {
                OrdersTableDto? ordersTable = null;
                using var cnn = new SqlConnection(_cnn.SqlConnection);

                await cnn.OpenAsync();

                SqlCommand cmd = new("sp_GetOrdersTableByOrderNumber", cnn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@OrderNumber", orderNumber);

                var reader = await cmd.ExecuteReaderAsync();

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
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los datos: " + ex.Message, ex);
            }
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
