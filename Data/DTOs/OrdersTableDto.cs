namespace OrdersAPI.Data.DTOs
{
    public class OrdersTableDto
    {
        public required int Id { get; set; }
        public required DateTime CreatedAt { get; set; }
        public required DateTime UpdatedAt { get; set; }
        public required string OrderNumber { get; set; }
        public required string CustAccount { get; set; }
        public required string CustRIF { get; set; }
        public required string CustIdentification { get; set; }
        public required string CustName { get; set; }
        public required decimal TotalAmount { get; set; }
        public required string Status { get; set; }

        public required List<OrdersLinesDto> OrdersLines { get; set; }
    }
}
