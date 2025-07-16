namespace OrdersAPI.Data.DTOs
{
    public class ItemsDto
    {
        public string? ItemId { get; set; }
        public string? ItemName { get; set; }
        public string? GroupId { get; set; }
        public string? TaxCode { get; set; }
        public decimal? PriceUSD { get; set; }
    }
}
