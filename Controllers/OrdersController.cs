using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using OrdersAPI.Data.DTOs;
using OrdersAPI.Data.Interfaces;
using OrdersAPI.Models;
using System.Net;
namespace OrdersAPI.Controllers
{
    [ApiController]
    [Route("api/orders")]
    public class OrdersController(IOrdersRepository repository) : ControllerBase
    {
        protected ApiResponse _response = new();
        private readonly IOrdersRepository _repository = repository;

        [HttpGet] // Ruta base: /api/Orders. Los parámetros de paginación van en la query string.
        [Authorize(Roles = "admin,user")]
        public async Task<IActionResult> GetAll(
        [FromQuery] int pageNumber = 1, // Parámetro para el número de página (por defecto 1)
        [FromQuery] int pageSize = 10)  // Parámetro para el tamaño de la página (por defecto 10)
        {
            try
            {
                var pagedOrders = await _repository.GetAll(pageNumber, pageSize);

                _response.StatusCode = HttpStatusCode.OK;
                _response.IsSuccess = true;
                _response.Result = pagedOrders;

                return Ok(_response); 
            }
            catch (Exception ex)
            {
                _response.StatusCode = HttpStatusCode.InternalServerError;
                _response.IsSuccess = false;
                _response.ErrorMessages.Add("Error interno del servidor al obtener las órdenes paginadas: " + ex.Message);
                return StatusCode((int)HttpStatusCode.InternalServerError, _response);
            }
        }

        [HttpGet("getByOrderNumber")]
        [Authorize(Roles = "admin,user")]
        public async Task<IActionResult> GetByOrderNumber(string orderNumber)
        {
            var res = await _repository.GetByOrderNumber(orderNumber);

            if (res != null)
            {
                _response.StatusCode = HttpStatusCode.OK;
                _response.IsSuccess = true;
                _response.Result = res;

                return Ok(_response);
            }

            _response.StatusCode = HttpStatusCode.NotFound;
            _response.IsSuccess = false;
            _response.ErrorMessages.Add("No se encontró la orden.");

            return NotFound(_response);
        }


        [HttpPost("insert")]
        [Authorize(Roles = "admin,user")]
        public async Task<IActionResult> Insert([FromBody] OrdersInsertDto ordersDto)
        {
            var userNameClaim = User.Claims.FirstOrDefault(c => c.Type == "userName");
            var res = await _repository.Insert(ordersDto, userNameClaim?.Value ?? "N/A");

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

        [HttpPut("update/{orderNumber}")]
        [Authorize(Roles = "admin")]
        public async Task<IActionResult> Update(string orderNumber, [FromBody] OrdersUpdateDto ordersDto)
        {
            var exists = await _repository.Exists(orderNumber);

            if (exists != "OK" || orderNumber != ordersDto.OrderNumber)
            {
                _response.StatusCode = HttpStatusCode.NotFound;
                _response.IsSuccess = false;
                _response.ErrorMessages.Add(exists);

                return NotFound(_response);
            }

            var userNameClaim = User.Claims.FirstOrDefault(c => c.Type == "userName");
            var res = await _repository.Update(ordersDto, userNameClaim?.Value ?? "N/A");

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

        [HttpPut("updateControlNumber/{orderNumber}")]
        [Authorize(Roles = "admin")]
        public async Task<IActionResult> UpdateControlNumber(string orderNumber, [FromBody] OrdersUpdateControlNumberDto dto)
        {
            var exists = await _repository.Exists(orderNumber);

            if (exists != "OK")
            {
                _response.StatusCode = HttpStatusCode.NotFound;
                _response.IsSuccess = false;
                _response.ErrorMessages.Add(exists);

                return NotFound(_response);
            }

            var userNameClaim = User.Claims.FirstOrDefault(c => c.Type == "userName");
            var res = await _repository.UpdateControlNumber(orderNumber, dto, userNameClaim?.Value ?? "N/A");

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
    }
}

