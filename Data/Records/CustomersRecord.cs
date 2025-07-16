using Microsoft.Data.SqlClient.Server;
using OrdersAPI.Data.DTOs;
using System.Data;

namespace OrdersAPI.Data.Records
{
    public static class CustomersRecord
    {
        static readonly SqlMetaData[] metadata = [
            new("CustAccount", SqlDbType.NVarChar, 20),
            new("RIF", SqlDbType.NVarChar, 12),
            new("FullName", SqlDbType.NVarChar, 60),
            new("Phone", SqlDbType.NVarChar, 15),
            new("Address", SqlDbType.NVarChar, 250),
            new("WithholdingAgent", SqlDbType.Bit),
            new("WithholdingCode", SqlDbType.NVarChar, 50)
        ];

        static SqlDataRecord CreateRecord(CustomersDto dto)
        {
            var record = new SqlDataRecord(metadata);
            record.SetString(0, dto.CustAccount ?? string.Empty);
            record.SetString(1, dto.RIF ?? string.Empty);
            record.SetString(2, dto.FullName ?? string.Empty);
            record.SetString(3, dto.Phone ?? string.Empty);
            record.SetString(4, dto.Address ?? string.Empty);
            record.SetBoolean(5, dto.WithholdingAgent ?? false); 
            record.SetString(6, dto.WithholdingCode ?? string.Empty);

            return record;
        }

        public static SqlDataRecord[] Records(IEnumerable<CustomersDto> dto)
        {
            return [.. dto.Select(CreateRecord)];
        }
    }
}
