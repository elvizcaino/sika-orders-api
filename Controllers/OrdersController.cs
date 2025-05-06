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
        [Authorize(Roles = "admin")]
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
        [Authorize(Roles = "admin")]
        public async Task<IActionResult> Insert([FromBody] OrdersInsertDto ordersDto)
        {
            var res = await _ordersRepository.Insert(ordersDto);

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
    }
}

