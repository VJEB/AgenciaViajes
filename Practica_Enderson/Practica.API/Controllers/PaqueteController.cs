using Agencia.BussinesLogic.Servicios;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Agencia.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class PaqueteController : Controller
    {
        private readonly AgenciaServicio _agenciaServicio;
        private readonly IMapper _mapper;


        public PaqueteController(AgenciaServicio agenciaServicio, IMapper mapper)
        {

            _mapper = mapper;
            _agenciaServicio = agenciaServicio;


        }

        [HttpGet("ListPaquetes/{Clie_Id}")]
        public IActionResult List()
        {
            var list = _agenciaServicio.ListPaquetes();
            return Ok(list);
        }


    }
}
