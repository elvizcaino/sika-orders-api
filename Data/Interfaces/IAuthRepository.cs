using OrdersAPI.Data.DTOs;

namespace OrdersAPI.Data.Interfaces
{
    public interface IAuthRepository
    {
        Task<UserDto?> Login(LoginDto loginUser);
    }
}