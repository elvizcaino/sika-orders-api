using OrdersAPI.Data.DTOs;

namespace OrdersAPI.Data.Interfaces
{
    public interface ITaxTableRepository
    {
        Task<string?> Upsert(IEnumerable<TaxTableDto> taxTable, string userName);
    }
}
