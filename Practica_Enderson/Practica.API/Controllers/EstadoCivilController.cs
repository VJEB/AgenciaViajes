using Microsoft.AspNetCore.Mvc;
using Practica.BussinesLogic.Servicios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Practica.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class EstadoCivilController : Controller
    {
        private readonly GeneralServicio _generalServicio;
        //private readonly IMapper _mapper;


        public EstadoCivilController(GeneralServicio generalServicio/*, IMapper mapper*/)
        {

            //_mapper = mapper;
            _generalServicio = generalServicio;
        }

        [HttpGet]
        public IActionResult EstadosCivilesList()
        {
            var list = _generalServicio.ListEstadosCiviles();
            return Ok(list);
        }
    }
}
