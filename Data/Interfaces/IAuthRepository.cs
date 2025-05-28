using OrdersAPI.Data.DTOs;

namespace OrdersAPI.Data.Interfaces
{
    public interface IAuthRepository
    {
        Task<UserDto?> Login(LoginDto loginUser);
        Task<string?> Register(LoginDto user);
        Task<string?> EnableUser(string userName);
        Task<string?> ChangeUserRole(ChangeUserRoleDto userRole);
    }
}