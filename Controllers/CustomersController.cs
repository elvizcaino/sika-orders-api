using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using OrdersAPI.Data.DTOs;
using OrdersAPI.Models;

namespace OrdersAPI.Controllers
{
    /* [Route("api/customers")]
    [ApiController]
    public class CustomersController() : ControllerBase
    {

        [HttpGet]
        [Authorize(Roles = "admin")]
        public ActionResult<ApiResponse> GetCustomers()
        {
            return Ok(new { Message = "Customers retrieved successfully" });
        }

        [HttpGet("{id}")]
        [Authorize(Roles = "admin")]
        public ActionResult<ApiResponse> GetCustomerById(int id)
        {
            return Ok(new { Message = "Customer retrieved successfully" });
        }

        [HttpPost]
        [Authorize(Roles = "admin")]
        public ActionResult<ApiResponse> Insert(string customer)
        {
            return Ok(new { Message = "Customer created successfully" });
        }

        [HttpPut("{id}")]
        [Authorize(Roles = "admin")]
        public ActionResult<ApiResponse> Update(int id, string customer)
        {
            return Ok(new { Message = "Customer updated successfully" });
        }
    } */
}
