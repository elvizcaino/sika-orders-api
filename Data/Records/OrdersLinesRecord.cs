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
            new("Kgs", SqlDbType.Decimal, 18, 2),
            new("TotalKgs", SqlDbType.Decimal, 18, 2),
            new("TotalAmount", SqlDbType.Decimal, 18, 2),
            new("Status", SqlDbType.NVarChar, 20)
        ];

        static SqlDataRecord CreateRecord(OrdersLinesDto dto)
        {
            var record = new SqlDataRecord(metadata);   
            record.SetString(0, dto.OrderNumber ?? string.Empty);
            record.SetInt32(1, dto.LineNum ?? 0);
            record.SetString(2, dto.ItemId ?? string.Empty);
            record.SetString(3, dto.ItemName ?? string.Empty);
            record.SetDecimal(4, dto.UnitPrice ?? 0);
            record.SetInt32(5, dto.Quantity ?? 0);
            record.SetDecimal(6, dto.Kgs ?? 0);
            record.SetDecimal(7, dto.TotalKgs ?? 0);
            record.SetDecimal(8, dto.TotalAmount ?? 0);
            record.SetString(9, dto.Status ?? string.Empty);

            return record;
        }

        public static SqlDataRecord[] Records(IEnumerable<OrdersLinesDto> dto)
        {
            return [.. dto.Select(CreateRecord)];
        }
    }
}