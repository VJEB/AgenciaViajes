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

        [HttpGet("TransporteList/{Ciud_Id}")]
        public IActionResult TransporteList(string Ciud_Id)
        {
            var list = _agenciaServicio.ListTransporte(Ciud_Id);
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
