//using Agencia.BussinesLogic.Servicios;
using Agencia.Common.Models;
using Agencia.Entities.Entities;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Practica.BussinesLogic.Servicios;
//using Practica.Common.Models;

namespace Agencia.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class FacturaController : Controller
    {
        private readonly VentaServicio _ventaServicio;
        private readonly IMapper _mapper;

        public FacturaController(VentaServicio ventaServicio, IMapper mapper)
        {
            _ventaServicio = ventaServicio;
            _mapper = mapper;
        }

        [HttpGet("List/{Pers_Id}")]
        public IActionResult List(int Pers_Id)
        {
            var result = _ventaServicio.ListFact(Pers_Id);
            return Ok(result);
        }


        [HttpGet("Edit/{id}")]
        public IActionResult Edit(int Fact_Id)
        {
            var result = _ventaServicio.FindFact(Fact_Id);
            return Ok(result);
        }

        [HttpPost("Create")]
        public IActionResult Create(FacturaViewModel item)
        {
            //var model = _mapper.Map<tbFacturas>(item);
            var modelo = new tbFacturas()
            {
                Fact_Fecha = item.Fact_Fecha,
                Pers_Id = item.Pers_Id,
                Meto_Id = item.Meto_Id,
                Pago_Id = item.Pago_Id,
                Fact_Usua_Creacion = item.Fact_Usua_Creacion,
                Fact_Fecha_Creacion = item.Fact_Fecha_Creacion
            };
            //var listado = _ventaServicio.ListFact();

            var result = _ventaServicio.InsertarFact(modelo);
            return Ok(result);
        }

        [HttpPut("Edit")]
        public IActionResult Edit(FacturaViewModel item)
        {
            //var model = _mapper.Map<tbFacturas>(item);
            var modelo = new tbFacturas()
            {
                Fact_Id = item.Fact_Id,
                Fact_Fecha = item.Fact_Fecha,
                Pers_Id = item.Pers_Id,
                Meto_Id = item.Meto_Id,
                Pago_Id = item.Pago_Id,
                Fact_Usua_Creacion = item.Fact_Usua_Creacion,
                Fact_Fecha_Creacion = item.Fact_Fecha_Creacion
            };
            //var listado = _ventaServicio.ListFact();

            var result = _ventaServicio.ActualizarFact(modelo);
            return Ok(result);
        }
    }
}
