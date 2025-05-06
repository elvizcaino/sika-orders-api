using System.ComponentModel.DataAnnotations;

namespace OrdersAPI.Data.DTOs
{
    public class OrdersLinesDto
    {
        public required int Id { get; set; }
        public required DateTime CreatedAt { get; set; }
        public required DateTime UpdatedAt { get; set; }
        public required string OrderNumber { get; set; }
        public required int LineNum { get; set; }
        public required string ItemId { get; set; }
        public required string ItemName { get; set; }
        public required decimal UnitPrice { get; set; }
        public required int Quantity { get; set; }
        public required decimal TotalAmount { get; set; }
        public required string Status { get; set; }
    }

}
