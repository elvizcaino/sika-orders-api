using System.ComponentModel.DataAnnotations;

namespace OrdersAPI.Data.DTOs
{
    public class LoginDto
    {
        [Required(ErrorMessage = "El nombre de usuario es requerido")]
        public required string UserName { get; set; }

        [Required(ErrorMessage = "La contraseña es requerida")]
        [DataType(DataType.Password)]
        [MinLength(3, ErrorMessage = "La contraseña debe tener al menos {1} caracteres")]
        public required string Password { get; set; }
    }
}