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
        public required string CustAddress { get; set; }
        public required DateTime IssueDate { get; set; }
        public required DateTime DueDate { get; set; }
        public required string SalesPersonId { get; set; }
        public required string SalesPersonName { get; set; }
        public required string RegionId { get; set; }
        public required string RegionName { get; set; }
        public required string CreditDays { get; set; }
        public required decimal BaseTaxable { get; set; }
        public required decimal Base0 { get; set; }
        public required decimal TaxRate { get; set; }
        public required decimal TotalTaxes { get; set; }
        public string? CurrencyCode { get; set; }
        public string? ControlNumber { get; set; }
        public required string Status { get; set; }

        public required List<OrdersLinesDto> OrdersLines { get; set; }
        public OrdersTotalsDto? OrdersTotals { get; set; }
    }
}
