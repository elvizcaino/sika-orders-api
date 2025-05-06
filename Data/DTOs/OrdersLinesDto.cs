namespace OrdersAPI.Data.DTOs
{
    public class OrdersLinesDto
    {
        public int? Id { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? OrderNumber { get; set; }
        public int? LineNum { get; set; }
        public string? ItemId { get; set; }
        public string? ItemName { get; set; }
        public decimal? UnitPrice { get; set; }
        public int? Quantity { get; set; }
        public decimal? TotalAmount { get; set; }
        public string? Status { get; set; }
    }

}
