using Microsoft.Data.SqlClient.Server;
using OrdersAPI.Data.DTOs;
using System.Data;

namespace OrdersAPI.Data.Records
{
    public static class ItemsRecord
    {
        static readonly SqlMetaData[] metadata = [
            new("ItemId", SqlDbType.NVarChar, 60),
            new("ItemName", SqlDbType.NVarChar, 60),
            new("GroupId", SqlDbType.NVarChar, 15),
            new("TaxCode", SqlDbType.NVarChar, 10),
            new("PriceUSD", SqlDbType.Decimal, 18, 2)
        ];

        static SqlDataRecord CreateRecord(ItemsDto dto)
        {
            var record = new SqlDataRecord(metadata);
            record.SetString(0, dto.ItemId ?? string.Empty);
            record.SetString(1, dto.ItemName ?? string.Empty);
            record.SetString(2, dto.GroupId ?? string.Empty);
            record.SetString(3, dto.TaxCode ?? string.Empty);
            record.SetDecimal(4, dto.PriceUSD ?? 0);

            return record;
        }

        public static SqlDataRecord[] Records(IEnumerable<ItemsDto> dto)
        {
            return [.. dto.Select(CreateRecord)];
        }
    }
}
