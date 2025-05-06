using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using OrdersAPI.Data.DTOs;
using OrdersAPI.Data.Helpers;
using OrdersAPI.Data.Interfaces;
using OrdersAPI.Models;
using System.IdentityModel.Tokens.Jwt;

namespace OrdersAPI.Controllers
{
    [Route("api/auth")]
    [ApiController]
    public class AuthController(IAuthRepository authRepository, IConfiguration configuration) : ControllerBase
    {
        private readonly IAuthRepository _authRepository = authRepository;
        private readonly IConfiguration _configuration = configuration;
        protected ApiResponse _apiResponse = new();

        [HttpPost("login")]
        [AllowAnonymous]
        public async Task<ActionResult<ApiResponse>> Login([FromBody] LoginDto loginUser)
        {
            var user = await _authRepository.Login(loginUser);

            if (user == null)
            {
                _apiResponse.StatusCode = System.Net.HttpStatusCode.BadRequest;
                _apiResponse.IsSuccess = false;
                _apiResponse.ErrorMessages.Add("Usuario o contraseña incorrecta");

                return BadRequest(_apiResponse);
            }

            _apiResponse.StatusCode = System.Net.HttpStatusCode.OK;
            _apiResponse.IsSuccess = true;
            _apiResponse.Result = new { User = user };

            return Ok(_apiResponse);
        }

        [HttpPost("refresh-token")]
        public ActionResult<ApiResponse> RefreshToken()
        {
            try
            {
                var token = Request.Headers.Authorization.FirstOrDefault()?.Split(" ").Last();
                if (string.IsNullOrEmpty(token))
                {
                    _apiResponse.StatusCode = System.Net.HttpStatusCode.Unauthorized;
                    _apiResponse.IsSuccess = false;
                    _apiResponse.ErrorMessages.Add("Token no proporcionado");
                    return Unauthorized(_apiResponse);
                }

                var tokenHandler = new JwtSecurityTokenHandler();
                var jwtToken = tokenHandler.ReadJwtToken(token);

                // Obtener los claims del token
                var userNameClaim = jwtToken.Claims.FirstOrDefault(x => x.Type == "userName")?.Value;
                var roleClaim = jwtToken.Claims.FirstOrDefault(x => x.Type == "role")?.Value;
                var idClaim = jwtToken.Claims.FirstOrDefault(x => x.Type == "id")?.Value;

                if (string.IsNullOrEmpty(userNameClaim) || string.IsNullOrEmpty(roleClaim) || string.IsNullOrEmpty(idClaim))
                {
                    _apiResponse.StatusCode = System.Net.HttpStatusCode.Unauthorized;
                    _apiResponse.IsSuccess = false;
                    _apiResponse.ErrorMessages.Add("Token inválido");
                    return Unauthorized(_apiResponse);
                }

                var userDto = new UserDto
                {
                    Id = idClaim,
                    UserName = userNameClaim,
                    Role = roleClaim
                };

                // Generar nuevo token
                var tokenManager = new TokenManager(_configuration);
                var newToken = tokenManager.GenerateToken(userDto);

                _apiResponse.StatusCode = System.Net.HttpStatusCode.OK;
                _apiResponse.IsSuccess = true;
                _apiResponse.Result = new { Token = newToken };

                return Ok(_apiResponse);
            }
            catch (Exception ex)
            {
                _apiResponse.StatusCode = System.Net.HttpStatusCode.InternalServerError;
                _apiResponse.IsSuccess = false;
                _apiResponse.ErrorMessages.Add(ex.Message);
                return StatusCode(500, _apiResponse);
            }
        }
    }
}