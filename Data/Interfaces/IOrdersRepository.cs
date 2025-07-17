using OrdersAPI.Data.DTOs;

namespace OrdersAPI.Data.Interfaces
{
    public interface IOrdersRepository
    {
        Task<OrdersTableDto?> GetOrdersTableByOrderNumber(string orderNumber);
        Task<string> Exists(string orderNumber);
        Task<string> Insert(OrdersInsertDto ordersDto, string userName);
        Task<string> Update(OrdersUpdateDto ordersDto, string userName);
        Task<string> UpdateControlNumber(string orderNumber, OrdersUpdateControlNumberDto dto, string userName);
    }
}
