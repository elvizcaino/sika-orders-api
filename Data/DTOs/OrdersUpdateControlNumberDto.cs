using System.ComponentModel.DataAnnotations;

namespace OrdersAPI.Data.DTOs
{
    public class OrdersUpdateControlNumberDto
    {
        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string OrderNumber { get; set; }

        [Required(ErrorMessage = "El campo {0} es obligatorio")]
        public required string ControlNumber { get; set; }

    }
}
