using Agencia.BussinesLogic.Servicios;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;

namespace Agencia.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class HotelController : Controller
    {
        private readonly AgenciaServicio _agenciaServicio;
        private readonly IMapper _mapper;


        public HotelController(AgenciaServicio agenciaServicio, IMapper mapper)
        {

            _mapper = mapper;
            _agenciaServicio = agenciaServicio;


        }

        [HttpGet("HotelesList/{Ciud_Id}")]
        public IActionResult HotelesList(string Ciud_Id)
        {
            var list = _agenciaServicio.ListHoteles(Ciud_Id);
            return Ok(list.Data);
        }
    }
}
