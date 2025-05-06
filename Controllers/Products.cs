using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using OrdersAPI.Models;

namespace OrdersAPI.Controllers
{
    /* [Route("api/products")]
    [ApiController] 
    public class ProductsController() : ControllerBase
    {
        [HttpGet]
        [Authorize(Roles = "admin")]
        public ActionResult<ApiResponse> GetProducts()
        {
            return Ok(new { Message = "Products retrieved successfully" });
        }

        [HttpGet("{id}")]
        [Authorize(Roles = "admin")]
        public ActionResult<ApiResponse> GetProductById(int id)
        {
            return Ok(new { Message = "Product retrieved successfully" });
        }

        [HttpPost]
        [Authorize(Roles = "admin")]
        public ActionResult<ApiResponse> Insert(string product)
        {
            return Ok(new { Message = "Product created successfully" });
        }

        [HttpPut("{id}")]
        [Authorize(Roles = "admin")]
        public ActionResult<ApiResponse> Update(int id, string product)
        {
            return Ok(new { Message = "Product updated successfully" });
        }
        
    } */
}