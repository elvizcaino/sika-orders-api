using Microsoft.Data.SqlClient.Server;
using OrdersAPI.Data.DTOs;
using System.Data;

namespace OrdersAPI.Data.Records
{
    public static class OrdersTotalsRecord
    {
        static readonly SqlMetaData[] metadata = [
            new("OrderNumber", SqlDbType.NVarChar, 20),
            new("TotalKgs", SqlDbType.Decimal, 18, 2),
            new("Subtotal", SqlDbType.Decimal, 18, 2),
            new("DiscPrice", SqlDbType.Decimal, 18, 2),
            new("BaseTaxable", SqlDbType.Decimal, 18, 2),
            new("TotalTax", SqlDbType.Decimal, 18, 2),
            new("TotalToPay", SqlDbType.Decimal, 18, 2),
            new("Observs", SqlDbType.NVarChar, 50)
        ];

        static SqlDataRecord CreateRecord(OrdersTotalsDto dto)
        {
            var record = new SqlDataRecord(metadata);
            record.SetString(0, dto.OrderNumber ?? string.Empty);
            record.SetDecimal(1, dto.TotalKgs ?? 0);
            record.SetDecimal(2, dto.Subtotal ?? 0);
            record.SetDecimal(3, dto.DiscPrice ?? 0);
            record.SetDecimal(4, dto.BaseTaxable ?? 0);
            record.SetDecimal(5, dto.TotalTax ?? 0);
            record.SetDecimal(6, dto.TotalToPay ?? 0);
            record.SetString(7, dto.Observs ?? string.Empty);

            return record;
        }

        public static SqlDataRecord[] Records(IEnumerable<OrdersTotalsDto> dto)
        {
            return [.. dto.Select(CreateRecord)];
        }
    }
}
