using Microsoft.AspNetCore.Mvc;
using Practica.BussinesLogic.Servicios;

namespace Practica.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class PaisController : Controller
    {

        private readonly GeneralServicio _generalServicio;
        public PaisController(GeneralServicio generalServicio)
        {
            _generalServicio = generalServicio;
        }

        [HttpGet("List")]

        public IActionResult Index()
        {
            var result = _generalServicio.ListPais();
            return Ok(result.Data);
        }
    }
}
