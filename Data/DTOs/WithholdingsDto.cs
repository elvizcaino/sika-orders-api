namespace OrdersAPI.Data.DTOs
{
    public class WithholdingsDto
    {
        public string? Code { get; set; }
        public string? Name { get; set; }
        public string? Type { get; set; }
        public string? ContributorType { get; set; }
        public decimal? Percent { get; set; }
        public decimal? BaseMin { get; set; }
        public decimal? Subtrahend { get; set; }
        public decimal? TaxBasePercent { get; set; }
    }
}
