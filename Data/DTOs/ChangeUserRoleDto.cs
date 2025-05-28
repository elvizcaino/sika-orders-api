namespace OrdersAPI.Data.DTOs
{
    public class ChangeUserRoleDto
    {
        public string UserName { get; set; } = string.Empty;
        public string Role { get; set; } = string.Empty;
    }
}