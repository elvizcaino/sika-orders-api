namespace OrdersAPI.Data.DTOs
{
    public class CustomersDto
    {
        public string? CustAccount { get; set; }
        public string? RIF { get; set; }
        public string? FullName { get; set; }
        public string? Phone { get; set; }
        public string? Address { get; set; }
        public bool? WithholdingAgent { get; set; }
        public string? WithholdingCode { get; set; }
    }
}
