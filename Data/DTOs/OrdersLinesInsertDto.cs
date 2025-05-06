using System.ComponentModel.DataAnnotations;

namespace OrdersAPI.Data.DTOs
{
    public class OrdersLinesInsertDto
    {
        [Required]
        public required string OrderNumber { get; set; }
        [Required]
        public int LineNum { get; set; }
        [Required]
        public required string ItemId { get; set; }
        [Required]
        public required string ItemName { get; set; }
        [Required]
        public decimal UnitPrice { get; set; }
        [Required]
        public int Quantity { get; set; }
        [Required]
        public decimal TotalAmount { get; set; }
        [Required]
        public required string Status { get; set; }
    }

}
