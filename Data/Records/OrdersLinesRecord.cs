using Microsoft.Data.SqlClient.Server;
using OrdersAPI.Data.DTOs;
using System.Data;

namespace OrdersAPI.Data.Records
{
    public static class OrdersLinesRecord
    {
        static readonly SqlMetaData[] metadata = [
            new("OrderNumber", SqlDbType.NVarChar, 20),
            new("LineNum", SqlDbType.Int),
            new("ItemId", SqlDbType.NVarChar, 20),
            new("ItemName", SqlDbType.NVarChar, 60),
            new("UnitPrice", SqlDbType.Decimal, 18, 2),
            new("Quantity", SqlDbType.Int),
            new("TotalAmount", SqlDbType.Decimal, 18, 2),
            new("Status", SqlDbType.NVarChar, 20)
        ];

        static SqlDataRecord CreateRecord(OrdersLinesInsertDto dto)
        {
            var record = new SqlDataRecord(metadata);   
            record.SetString(0, dto.OrderNumber);
            record.SetInt32(1, dto.LineNum);
            record.SetString(2, dto.ItemId);
            record.SetString(3, dto.ItemName);
            record.SetDecimal(4, dto.UnitPrice);
            record.SetInt32(5, dto.Quantity);
            record.SetDecimal(6, dto.TotalAmount);
            record.SetString(7, dto.Status);

            return record;
        }

        public static SqlDataRecord[] Records(IEnumerable<OrdersLinesInsertDto> dto)
        {
            return [.. dto.Select(CreateRecord)];
        }
    }
}