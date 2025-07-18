using OrdersAPI.Data.DTOs;

namespace OrdersAPI.Data.Interfaces
{
    public interface IOrdersRepository
    {
        Task<PagedResponseDto<OrdersTableDto>> GetAll(int pageNumber = 1, int pageSize = 10);
        Task<OrdersTableDto?> GetByOrderNumber(string orderNumber);
        Task<string> Exists(string orderNumber);
        Task<string> Insert(OrdersInsertDto ordersDto, string userName);
        Task<string> Update(OrdersUpdateDto ordersDto, string userName);
        Task<string> UpdateControlNumber(string orderNumber, OrdersUpdateControlNumberDto dto, string userName);
    }
}
