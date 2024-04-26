using Agencia.BussinesLogic.Servicios;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;

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
            return Ok(list.Data);
        }

        [HttpGet("TiposTransporteList")]
        public IActionResult TiposTransporteList()
        {
            var list = _agenciaServicio.ListTipoTransporte();
            return Ok(list.Data);
        }

        [HttpGet("EstadoViaje")]

        public IActionResult EstadoViaje()
        {
            var result = _agenciaServicio.CiudadDestino();
            return Ok(result);
        }
        [HttpGet("SexoViaje")]

        public IActionResult SexoViaje()
        {
            var result = _agenciaServicio.SexoDestino();
            return Ok(result);
        }

        [HttpGet("CiudadHospedaje")]

        public IActionResult CiudadHospedaje()
        {
            var result = _agenciaServicio.CiudHospedaje();
            return Ok(result);
        }
    }
}
