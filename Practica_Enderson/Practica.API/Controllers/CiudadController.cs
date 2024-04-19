using Microsoft.AspNetCore.Mvc;
using Practica.BussinesLogic.Servicios;

namespace Practica.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class CiudadController : Controller
    {
        private readonly GeneralServicio _generalServicio;
        public CiudadController(GeneralServicio generalServicio)
        {
            _generalServicio = generalServicio;
        }

        [HttpGet("List/{Esta_Id}")]
        public IActionResult Index(string Esta_Id)
        {
            var result = _generalServicio.ListCiud(Esta_Id);
            return Ok(result.Data);
        }
    }
}
