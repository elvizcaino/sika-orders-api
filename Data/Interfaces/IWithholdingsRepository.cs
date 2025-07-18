using OrdersAPI.Data.DTOs;

namespace OrdersAPI.Data.Interfaces
{
    public interface IWithholdingsRepository
    {
        Task<List<WithholdingsDto>> GetAll();
        Task<WithholdingsDto?> GetByCode(string id);
        Task<string> Upsert(IEnumerable<WithholdingsDto> data, string userName);
        Task<string> Delete(string code, string userName);
    }
}
