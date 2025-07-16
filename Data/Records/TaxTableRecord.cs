using Microsoft.Data.SqlClient.Server;
using OrdersAPI.Data.DTOs;
using System.Data;

namespace OrdersAPI.Data.Records
{
    public static class TaxTableRecord
    {
        static readonly SqlMetaData[] metadata = [
            new("Code", SqlDbType.NVarChar, 10),
            new("Value", SqlDbType.Decimal, 18, 2)
        ];

        static SqlDataRecord CreateRecord(TaxTableDto dto)
        {
            var record = new SqlDataRecord(metadata);
            record.SetString(0, dto.Code ?? string.Empty);
            record.SetDecimal(1, dto.Value ?? 0);

            return record;
        }

        public static SqlDataRecord[] Records(IEnumerable<TaxTableDto> dto)
        {
            return [.. dto.Select(CreateRecord)];
        }
    }
}
