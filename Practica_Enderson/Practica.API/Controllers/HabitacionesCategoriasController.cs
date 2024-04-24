using Agencia.BussinesLogic.Servicios;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;

namespace Agencia.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class HabitacionesCategoriasController : Controller
    {
        private readonly AgenciaServicio _agenciaServicio;
        private readonly IMapper _mapper;


        public HabitacionesCategoriasController(AgenciaServicio agenciaServicio, IMapper mapper)
        {

            _mapper = mapper;
            _agenciaServicio = agenciaServicio;


        }

        [HttpGet("FotoPorHabitacionList/{HaHo_Id}")]
        public IActionResult FotoPorHabitacion(int HaHo_Id)
        {
            var list = _agenciaServicio.FotosPorHabitacion(HaHo_Id);
            return Ok(list.Data);
        }

        [HttpGet("FotoPorHotelList/{Hote_Id}")]
        public IActionResult FotoPorHoteles(int Hote_Id)
        {
            var list = _agenciaServicio.FotosPorHotel(Hote_Id);
            return Ok(list.Data);
        }

        [HttpGet("HabitacionPorHotelList/{Hote_Id}")]
        public IActionResult HabitacionPorHotel(int Hote_Id)
        {
            var list = _agenciaServicio.ListHabitacionesCategoriasXHotel(Hote_Id);
            return Ok(list.Data);
        }
    }
}
