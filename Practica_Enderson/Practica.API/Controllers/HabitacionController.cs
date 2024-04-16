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
    public class HabitacionController : Controller
    {
        private readonly AgenciaServicio _agenciaServicio;
        private readonly IMapper _mapper;


        public HabitacionController(AgenciaServicio agenciaServicio, IMapper mapper)
        {

            _mapper = mapper;
            _agenciaServicio = agenciaServicio;


        }

        [HttpGet("FotoXHabitacionList")]
        public IActionResult FotoXHabitacion()
        {
            var list = _agenciaServicio.ListFotografias();
            return Ok(list);
        }

        [HttpGet("HabitacionXHotelList/{Hote_Id}")]
        public IActionResult HabitacionXHotel()
        {
            var list = _agenciaServicio.ListHabitacionesXHotel();
            return Ok(list);
        }

        [HttpGet("TiposCamasList")]
        public IActionResult TiposCamas()
        {
            var list = _agenciaServicio.TiposCamasList();
            return Ok(list);
        }

    }
}
