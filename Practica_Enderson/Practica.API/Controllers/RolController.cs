using Microsoft.AspNetCore.Mvc;

namespace Practica.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class RolController : Controller
    {
        [HttpGet("Index")]

        public IActionResult Index()
        {
            return View();
        }
    }
}
