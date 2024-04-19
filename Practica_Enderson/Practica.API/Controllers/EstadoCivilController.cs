using Microsoft.AspNetCore.Mvc;
using Practica.BussinesLogic.Servicios;

namespace Practica.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class EstadoCivilController : Controller
    {
        private readonly GeneralServicio _generalServicio;


        public EstadoCivilController(GeneralServicio generalServicio)
        {
            _generalServicio = generalServicio;
        }

        [HttpGet]
        public IActionResult EstadosCivilesList()
        {
            //var list = _generalServicio.ListEstadosCiviles();
            return Ok("list");
        }
    }
}
