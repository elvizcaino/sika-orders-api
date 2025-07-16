using Microsoft.Data.SqlClient.Server;
using OrdersAPI.Data.DTOs;
using System.Data;

namespace OrdersAPI.Data.Records
{
    public static class WithholdingsRecord
    {
        static readonly SqlMetaData[] metadata = [
            new("Code", SqlDbType.NVarChar, 10),
            new("Name", SqlDbType.NVarChar, 30),
            new("Type", SqlDbType.NVarChar, 10),
            new("ContributorType", SqlDbType.NVarChar, 15),
            new("Percent", SqlDbType.Decimal, 18, 2),
            new("BaseMin", SqlDbType.Decimal, 18, 2),
            new("Subtrahend", SqlDbType.Decimal, 18, 2),
            new("TaxBasePercent", SqlDbType.Decimal, 18, 2)
        ];

        static SqlDataRecord CreateRecord(WithholdingsDto dto)
        {
            var record = new SqlDataRecord(metadata);
            record.SetString(0, dto.Code ?? string.Empty);
            record.SetString(1, dto.Name ?? string.Empty);
            record.SetString(2, dto.Type ?? string.Empty);
            record.SetString(3, dto.ContributorType ?? string.Empty);
            record.SetDecimal(4, dto.Percent ?? 0);
            record.SetDecimal(5, dto.BaseMin ?? 0);
            record.SetDecimal(6, dto.Subtrahend ?? 0);
            record.SetDecimal(7, dto.TaxBasePercent ?? 0);

            return record;
        }

        public static SqlDataRecord[] Records(IEnumerable<WithholdingsDto> dto)
        {
            return [.. dto.Select(CreateRecord)];
        }
    }
}
