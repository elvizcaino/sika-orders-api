namespace OrdersAPI.Data.DTOs
{
    public class OrdersTotalsDto
    {
        public int? Id { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? OrderNumber { get; set; }
        public decimal? TotalKgs { get; set; }
        public decimal? Subtotal { get; set; }
        public decimal? DiscPrice { get; set; }
        public decimal? BaseTaxable { get; set; }
        public decimal? TotalTax { get; set; }
        public decimal? TotalToPay { get; set; }
        public string? Observs { get; set; }
    }
}
