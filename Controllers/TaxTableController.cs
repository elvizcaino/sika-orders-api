using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using OrdersAPI.Data.DTOs;
using OrdersAPI.Data.Interfaces;
using OrdersAPI.Models;
using System.Net;

namespace OrdersAPI.Controllers
{
    [ApiController]
    [Route("api/taxTable")]
    public class TaxTableController(ITaxTableRepository taxTableRepository) : ControllerBase
    {
        protected ApiResponse _response = new();
        private readonly ITaxTableRepository _taxTableRepository = taxTableRepository;

        [HttpPost("upsert")]
        [Authorize(Roles = "admin,user")]
        public async Task<IActionResult> Upsert([FromBody] IEnumerable<TaxTableDto> taxTableDto)
        {
            var userNameClaim = User.Claims.FirstOrDefault(c => c.Type == "userName");
            var res = await _taxTableRepository.Upsert(taxTableDto, userNameClaim?.Value ?? "N/A");

            if (res != null)
            {
                _response.StatusCode = HttpStatusCode.OK;
                _response.IsSuccess = true;
                _response.Result = res;

                return Ok(_response);
            }

            _response.StatusCode = HttpStatusCode.BadRequest;
            _response.IsSuccess = false;
            _response.ErrorMessages.Add("Error al insertar el registro.");

            return BadRequest(_response);
        }
    }
}
