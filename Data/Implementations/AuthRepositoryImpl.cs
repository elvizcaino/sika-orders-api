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
            string userName = loginUser.UserName.ToLower();
            using var cnn = new SqlConnection(_cnn.SqlConnection);
            
            cnn.Open();

            var cmd = new SqlCommand("sp_Login", cnn)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@UserName", userName);

            using (var reader = await cmd.ExecuteReaderAsync())
            {
                if (reader.HasRows)
                {
                    await reader.ReadAsync();

                    var hashedPassword = reader["Password"].ToString()!;

                    //var newPassword = Encrypt.EncryptPassword(userName, loginUser.Password);

                    //Console.WriteLine(newPassword);

                    var isValidPassword = Encrypt.VerifyHashedPassword(userName, loginUser.Password, hashedPassword);

                    if (isValidPassword)
                    {
                        user = new UserDto
                        {
                            Id = reader["Id"].ToString()!,
                            UserName = reader["UserName"].ToString()!,
                            Role = reader["Role"].ToString()!
                        };

                        user.Token = new TokenManager(_configuration).GenerateToken(user!);
                    }
                }
            }

            return user;
        }

        public async Task<string?> Register(LoginDto user)
        {
            using var cnn = new SqlConnection(_cnn.SqlConnection);

            cnn.Open();

            var cmd = new SqlCommand("sp_RegisterUser", cnn)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@UserName", user.UserName.ToLower());
            cmd.Parameters.AddWithValue("@Password", Encrypt.EncryptPassword(user.UserName, user.Password));
            cmd.Parameters.Add("@ReturnValue", SqlDbType.Int).Direction = ParameterDirection.Output;

            await cmd.ExecuteNonQueryAsync();
            var returnValue = (int)cmd.Parameters["@ReturnValue"].Value;

            return returnValue > 0 ? "OK" : null;
        }

        public async Task<string?> EnableUser(string userName)
        {
            using var cnn = new SqlConnection(_cnn.SqlConnection);

            cnn.Open();

            var cmd = new SqlCommand("sp_EnableUser", cnn)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@UserName", userName);
            cmd.Parameters.Add("@ReturnValue", SqlDbType.Int).Direction = ParameterDirection.Output;

            await cmd.ExecuteNonQueryAsync();
            var returnValue = (int)cmd.Parameters["@ReturnValue"].Value;

            return returnValue > 0 ? "OK" : null;
        }

        public async Task<string?> ChangeUserRole(ChangeUserRoleDto userRole)
        {
            using var cnn = new SqlConnection(_cnn.SqlConnection);

            cnn.Open();

            var cmd = new SqlCommand("sp_ChangeUserRole", cnn)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@UserName", userRole.UserName);
            cmd.Parameters.AddWithValue("@Role", userRole.Role);
            cmd.Parameters.Add("@ReturnValue", SqlDbType.Int).Direction = ParameterDirection.Output;

            await cmd.ExecuteNonQueryAsync();
            var returnValue = (int)cmd.Parameters["@ReturnValue"].Value;

            return returnValue > 0 ? "OK" : null;
        }
    }
}