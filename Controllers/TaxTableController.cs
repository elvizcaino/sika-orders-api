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
    public class TaxTableController(ITaxTableRepository repository) : ControllerBase
    {
        protected ApiResponse _response = new();
        private readonly ITaxTableRepository _repository = repository;

        [HttpGet]
        [Authorize(Roles = "admin,user")]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var data = await _repository.GetAll();

                _response.StatusCode = HttpStatusCode.OK;
                _response.IsSuccess = true;
                _response.Result = data!;

                return Ok(_response);
            }
            catch (Exception ex)
            {
                _response.StatusCode = HttpStatusCode.InternalServerError;
                _response.IsSuccess = false;
                _response.ErrorMessages.Add("Error interno del servidor al obtener todos los impuestos: " + ex.Message);
                return StatusCode((int)HttpStatusCode.InternalServerError, _response);
            }
        }

        [HttpGet("{code}")]
        [Authorize(Roles = "admin,user")]
        public async Task<ActionResult<TaxTableDto>> GetByCode(string code)
        {
            try
            {
                var data = await _repository.GetByCode(code);

                if (data == null)
                {
                    _response.StatusCode = HttpStatusCode.NotFound;
                    _response.IsSuccess = true;
                    _response.ErrorMessages.Add($"No se encontró un registro con el código {code}");

                    return NotFound(_response);
                }

                _response.StatusCode = HttpStatusCode.OK;
                _response.IsSuccess = true;
                _response.Result = data;

                return Ok(_response);
            }
            catch (Exception ex)
            {
                _response.StatusCode = HttpStatusCode.InternalServerError;
                _response.IsSuccess = false;
                _response.ErrorMessages.Add($"Error interno del servidor al obtener el impuesto por código ({code}): " + ex.Message);
                return StatusCode((int)HttpStatusCode.InternalServerError, _response);
            }
        }

        [HttpPost("upsert")]
        [Authorize(Roles = "admin,user")]
        public async Task<IActionResult> Upsert([FromBody] IEnumerable<TaxTableDto> taxTableDto)
        {
            var userNameClaim = User.Claims.FirstOrDefault(c => c.Type == "userName");
            var res = await _repository.Upsert(taxTableDto, userNameClaim?.Value ?? "N/A");

            if (res == "OK")
            {
                _response.StatusCode = HttpStatusCode.OK;
                _response.IsSuccess = true;
                _response.Result = res;

                return Ok(_response);
            }

            _response.StatusCode = HttpStatusCode.BadRequest;
            _response.IsSuccess = false;
            _response.ErrorMessages.Add(res);

            return BadRequest(_response);
        }

        [HttpDelete("{code}")]
        [Authorize(Roles = "admin,user")]
        public async Task<IActionResult> Delete(string code)
        {
            if (!string.IsNullOrWhiteSpace(code))
            {
                var userNameClaim = User.Claims.FirstOrDefault(c => c.Type == "userName");
                var res = await _repository.Delete(code, userNameClaim?.Value ?? "N/A");

                if (res == "OK")
                {
                    _response.StatusCode = HttpStatusCode.OK;
                    _response.IsSuccess = true;
                    _response.Result = res;

                    return Ok(_response);
                }
                
                _response.StatusCode = HttpStatusCode.BadRequest;
                _response.IsSuccess = false;
                _response.ErrorMessages.Add(res);
            }

            _response.StatusCode = HttpStatusCode.BadRequest;
            _response.IsSuccess = false;
            _response.ErrorMessages.Add("'Code' no puede ser vacío.");

            return BadRequest(_response);
        }
    }
}
