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
    public class OrdersController(IOrdersRepository ordersRepository) : ControllerBase
    {
        protected ApiResponse _response = new();
        private readonly IOrdersRepository _ordersRepository = ordersRepository;

        [HttpGet("getByOrderNumber")]
        [Authorize(Roles = "admin,user")]
        public async Task<IActionResult> GetByOrderNumber(string orderNumber)
        {
            var res = await _ordersRepository.GetOrdersTableByOrderNumber(orderNumber);

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
            var res = await _ordersRepository.Insert(ordersDto, userNameClaim?.Value ?? "N/A");

            if (res != null)
            {
                _response.StatusCode = HttpStatusCode.OK;
                _response.IsSuccess = true;
                _response.Result = res;

                return Ok(_response);
            }

            _response.StatusCode = HttpStatusCode.BadRequest;
            _response.IsSuccess = false;
            _response.ErrorMessages.Add("Error al insertar la orden.");

            return BadRequest(_response);
        }

        [HttpPut("update/{orderNumber}")]
        [Authorize(Roles = "admin")]
        public async Task<IActionResult> Update(string orderNumber, [FromBody] OrdersUpdateDto ordersDto)
        {
            var exists = await _ordersRepository.Exists(orderNumber);

            if (exists != "OK" || orderNumber != ordersDto.OrderNumber)
            {
                _response.StatusCode = HttpStatusCode.NotFound;
                _response.IsSuccess = false;
                _response.ErrorMessages.Add(exists);

                return NotFound(_response);
            }

            var userNameClaim = User.Claims.FirstOrDefault(c => c.Type == "userName");
            var res = await _ordersRepository.Update(ordersDto, userNameClaim?.Value ?? "N/A");

            if (res != null)
            {
                _response.StatusCode = HttpStatusCode.OK;
                _response.IsSuccess = true;
                _response.Result = res;

                return Ok(_response);
            }

            _response.StatusCode = HttpStatusCode.BadRequest;
            _response.IsSuccess = false;
            _response.ErrorMessages.Add("Error al actualizar la orden.");

            return BadRequest(_response);
        }

        [HttpPut("updateControlNumber/{orderNumber}")]
        [Authorize(Roles = "admin")]
        public async Task<IActionResult> UpdateControlNumber(string orderNumber, [FromBody] OrdersUpdateControlNumberDto dto)
        {
            var exists = await _ordersRepository.Exists(orderNumber);

            if (exists != "OK")
            {
                _response.StatusCode = HttpStatusCode.NotFound;
                _response.IsSuccess = false;
                _response.ErrorMessages.Add(exists);

                return NotFound(_response);
            }

            var userNameClaim = User.Claims.FirstOrDefault(c => c.Type == "userName");
            var res = await _ordersRepository.UpdateControlNumber(orderNumber, dto, userNameClaim?.Value ?? "N/A");

            if (res != null)
            {
                _response.StatusCode = HttpStatusCode.OK;
                _response.IsSuccess = true;
                _response.Result = res;

                return Ok(_response);
            }

            _response.StatusCode = HttpStatusCode.BadRequest;
            _response.IsSuccess = false;
            _response.ErrorMessages.Add("Error al actualizar el número de control.");

            return BadRequest(_response);
        }
    }
}

