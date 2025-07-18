using OrdersAPI.Data.DTOs;

namespace OrdersAPI.Data.Interfaces
{
    public interface ICustomersRepository
    {
        Task<List<CustomersDto>> GetAll();
        Task<CustomersDto?> GetByIdentification(string id);
        Task<string> Upsert(IEnumerable<CustomersDto> data, string userName);
        Task<string> Delete(string code, string userName);
    }
}
