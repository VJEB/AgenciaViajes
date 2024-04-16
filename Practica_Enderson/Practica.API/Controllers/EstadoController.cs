using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Practica.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class EstadoController : Controller
    {
        [HttpGet("Index")]

        public IActionResult Index()
        {
            return View();
        }
    }
}
