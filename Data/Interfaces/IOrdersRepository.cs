using OrdersAPI.Data.DTOs;

namespace OrdersAPI.Data.Interfaces
{
    public interface IOrdersRepository
    {
        Task<OrdersTableDto?> GetOrdersTableByOrderNumber(string orderNumber);
        Task<string?> Insert(OrdersInsertDto ordersDto);
        Task<string?> Update(OrdersUpdateDto ordersDto);

    }
}
