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
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse))]
        [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse))]
        [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse))]
        [AllowAnonymous]
        public async Task<ActionResult<ApiResponse>> Login([FromBody] LoginDto loginUser)
        {
            Console.WriteLine($"Login attempt for user: {loginUser.UserName}");
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

        [HttpPost("register")]
        [ProducesResponseType(StatusCodes.Status201Created, Type = typeof(ApiResponse))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse))]
        [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse))]
        [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse))]
        [AllowAnonymous]
        public async Task<ActionResult<ApiResponse>> Register([FromBody] LoginDto user)
        {
            var result = await _authRepository.Register(user);

            if (result == null)
            {
                _apiResponse.StatusCode = System.Net.HttpStatusCode.BadRequest;
                _apiResponse.IsSuccess = false;
                _apiResponse.ErrorMessages.Add("Error al registrar el usuario");

                return BadRequest(_apiResponse);
            }

            _apiResponse.StatusCode = System.Net.HttpStatusCode.Created;
            _apiResponse.IsSuccess = true;
            _apiResponse.Result = new { Message = "Usuario registrado exitosamente" };

            return CreatedAtAction(nameof(Register), _apiResponse);
        }

        [HttpPost("enable-user")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse))]
        [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse))]
        [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse))]
        [Authorize(Roles = "admin")]
        public async Task<ActionResult<ApiResponse>> EnableUser([FromBody] EnableUserDto user)
        {
            var result = await _authRepository.EnableUser(user.UserName);

            if (result == null)
            {
                _apiResponse.StatusCode = System.Net.HttpStatusCode.BadRequest;
                _apiResponse.IsSuccess = false;
                _apiResponse.ErrorMessages.Add("Error al habilitar el usuario");

                return BadRequest(_apiResponse);
            }

            _apiResponse.StatusCode = System.Net.HttpStatusCode.OK;
            _apiResponse.IsSuccess = true;
            _apiResponse.Result = new { Message = "Usuario habilitado exitosamente" };

            return Ok(_apiResponse);
        }

        [HttpPost("change-user-role")]
        [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(ApiResponse))]
        [ProducesResponseType(StatusCodes.Status400BadRequest, Type = typeof(ApiResponse))]
        [ProducesResponseType(StatusCodes.Status401Unauthorized, Type = typeof(ApiResponse))]
        [ProducesResponseType(StatusCodes.Status403Forbidden, Type = typeof(ApiResponse))]
        [Authorize(Roles = "admin")]
        public async Task<ActionResult<ApiResponse>> ChangeUserRole([FromBody] ChangeUserRoleDto userRole)
        {
            var userNameClaim = User.Claims.FirstOrDefault(c => c.Type == "userName");

            if(userNameClaim?.Value == userRole.UserName.ToLower())
            {
                _apiResponse.StatusCode = System.Net.HttpStatusCode.BadRequest;
                _apiResponse.IsSuccess = false;
                _apiResponse.ErrorMessages.Add("No puedes cambiar tu propio rol");

                return BadRequest(_apiResponse);
            }

            var result = await _authRepository.ChangeUserRole(userRole);

            if (result == null)
            {
                _apiResponse.StatusCode = System.Net.HttpStatusCode.BadRequest;
                _apiResponse.IsSuccess = false;
                _apiResponse.ErrorMessages.Add("Error al cambiar el rol del usuario");

                return BadRequest(_apiResponse);
            }

            _apiResponse.StatusCode = System.Net.HttpStatusCode.OK;
            _apiResponse.IsSuccess = true;
            _apiResponse.Result = new { Message = "Rol del usuario cambiado exitosamente" };

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

                userDto.Token = newToken;

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