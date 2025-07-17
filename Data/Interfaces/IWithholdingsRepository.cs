using OrdersAPI.Data.DTOs;

namespace OrdersAPI.Data.Interfaces
{
    public interface IWithholdingsRepository
    {
        Task<string> Upsert(IEnumerable<WithholdingsDto> data, string userName);
        Task<string> Delete(string code, string userName);
    }
}
