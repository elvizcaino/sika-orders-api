using OrdersAPI.Data.DTOs;

namespace OrdersAPI.Data.Interfaces
{
    public interface ITaxTableRepository
    {
        Task<List<TaxTableDto>> GetAll();
        Task<TaxTableDto?> GetByCode(string id);
        Task<string> Upsert(IEnumerable<TaxTableDto> taxTable, string userName);
        Task<string> Delete(string code, string userName);
    }
}
