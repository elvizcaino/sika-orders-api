using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;

namespace OrdersAPI.Helpers
{
    public class ExpiredTokenMiddleware(RequestDelegate next, IConfiguration configuration)
    {
        private readonly RequestDelegate _next = next;
        private readonly IConfiguration _configuration = configuration;

        public async Task InvokeAsync(HttpContext context)
        {
            if (context.Request.Path.StartsWithSegments("/api/auth/refresh-token"))
            {
                var token = context.Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();
                if (token != null)
                {
                    var tokenHandler = new JwtSecurityTokenHandler();
                    var key = Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]!);

                    try
                    {
                        // Configuración especial que ignora la expiración del token
                        tokenHandler.ValidateToken(token, new TokenValidationParameters
                        {
                            ValidateIssuerSigningKey = true,
                            IssuerSigningKey = new SymmetricSecurityKey(key),
                            ValidateIssuer = true,
                            ValidateAudience = true,
                            ValidIssuer = _configuration["Jwt:Issuer"],
                            ValidAudience = _configuration["Jwt:Audience"],
                            ValidateLifetime = false // Esto es clave - no validamos la expiración
                        }, out SecurityToken validatedToken);

                        var jwtToken = (JwtSecurityToken)validatedToken;

                        // Agregar los claims al contexto
                        var claims = jwtToken.Claims.ToList();
                        var identity = new ClaimsIdentity(claims, "Bearer");
                        context.User = new ClaimsPrincipal(identity);
                    }
                    catch
                    {
                        // Si hay algún error en la validación, continuamos al siguiente middleware
                        // que manejará el error apropiadamente
                    }
                }
            }

            await _next(context);
        }
    }
}