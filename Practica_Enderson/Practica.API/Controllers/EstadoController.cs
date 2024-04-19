using Microsoft.AspNetCore.Mvc;
using Practica.BussinesLogic.Servicios;

namespace Practica.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class EstadoController : Controller
    {

        private readonly GeneralServicio _generalServicio;
        public EstadoController(GeneralServicio generalServicio)
        {
            _generalServicio = generalServicio;
        }

        [HttpGet("List/{Pais_Id}")]

        public IActionResult Index(int Pais_Id)
        {
            var result = _generalServicio.ListEsta(Pais_Id);
            return Ok(result.Data);
        }
    }
}
