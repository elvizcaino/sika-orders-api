using OrdersAPI.Data.DTOs;

namespace OrdersAPI.Data.Interfaces
{
    public interface IItemsRepository
    {
        Task<List<ItemsDto>> GetAll();
        Task<ItemsDto?> GetById(string id);
        Task<string> Upsert(IEnumerable<ItemsDto> data, string userName);
        Task<string> Delete(string itemId, string userName);
    }
}
