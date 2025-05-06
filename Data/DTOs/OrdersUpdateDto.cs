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
        public decimal TotalAmount { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string Status { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required IEnumerable<OrdersLinesDto> OrdersLines { get; set; }
    }
}
