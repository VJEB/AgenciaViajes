using AutoMapper;
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
    public class PersonaController : Controller
    {
        private readonly GeneralServicio _generalServicio;
        private readonly IMapper _mapper;


        public PersonaController(GeneralServicio generalServicio, IMapper mapper)
        {

            _mapper = mapper;
            _generalServicio = generalServicio;


        }

        [HttpGet("List")]
        public IActionResult List()
        {
            var list = _generalServicio.ListClie();
            return Ok(list);
        }
    }
}
