using System.ComponentModel.DataAnnotations;

namespace OrdersAPI.Data.DTOs
{
    public class OrdersUpdateDto
    {
        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string OrderNumber { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string CustAccount { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string CustRIF { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        [MaxLength(15, ErrorMessage = "La longitud máxima de {0} es de {1} caracteres")]
        public required string CustIdentification { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string CustName { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string CustAddress { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required DateTime IssueDate { get; set; }

         [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required DateTime DueDate { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string SalesPersonId { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string SalesPersonName { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string RegionId { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string RegionName { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string CreditDays { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public decimal BaseTaxable { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public decimal Base0 { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public decimal TaxRate { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public decimal TotalTaxes { get; set; }

        public string? CurrencyCode { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required IEnumerable<OrdersLinesDto> OrdersLines { get; set; }


        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required OrdersTotalsDto OrdersTotals { get; set; }
    }
}
