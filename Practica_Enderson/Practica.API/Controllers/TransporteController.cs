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
    public class TransporteController : Controller
    {
        private readonly AgenciaServicio _agenciaServicio;
        private readonly IMapper _mapper;


        public TransporteController(AgenciaServicio agenciaServicio, IMapper mapper)
        {

            _mapper = mapper;
            _agenciaServicio = agenciaServicio;


        }

        [HttpGet("TransporteList")]
        public IActionResult TransporteList()
        {
            var list = _agenciaServicio.ListTransporte();
            return Ok(list);
        }

        [HttpGet("TiposTransporteList")]
        public IActionResult TiposTransporteList()
        {
            var list = _agenciaServicio.ListTipoTransporte();
            return Ok(list);
        }
    }
}
