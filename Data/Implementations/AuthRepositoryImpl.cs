using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Options;
using OrdersAPI.Data.Configuration;
using OrdersAPI.Data.DTOs;
using OrdersAPI.Data.Interfaces;
using OrdersAPI.Data.Helpers;
using System.Data;

namespace OrdersAPI.Data.Implementations
{
    public class AuthRepositoryImpl(IConfiguration configuration, IOptions<ConnectionConfiguration> cnn) : IAuthRepository
    {
        private readonly ConnectionConfiguration _cnn = cnn.Value;
        private readonly IConfiguration _configuration = configuration;

        public async Task<UserDto?> Login(LoginDto loginUser)
        {
            UserDto? user = null;
            using var cnn = new SqlConnection(_cnn.SqlConnection);

            cnn.Open();

            var cmd = new SqlCommand("sp_Login", cnn)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@UserName", loginUser.UserName);

            using (var reader = await cmd.ExecuteReaderAsync())
            {
                if (reader.HasRows)
                {
                    await reader.ReadAsync();

                    var hashedPassword = reader["Password"].ToString()!;

                    //var newPassword = Encrypt.EncryptPassword(loginUser.UserName, loginUser.Password);

                    //Console.WriteLine(newPassword);
                    
                    var isValidPassword = Encrypt.VerifyHashedPassword(loginUser.UserName, loginUser.Password, hashedPassword);

                    if (isValidPassword)
                    {
                        user = new UserDto
                        {
                            Id = reader["Id"].ToString()!,
                            UserName = reader["UserName"].ToString()!,
                            Role = reader["Role"].ToString()!
                        };

                        user.Token =  new TokenManager(_configuration).GenerateToken(user!);
                    }
                }
            }

            return user;
        }
    }
}