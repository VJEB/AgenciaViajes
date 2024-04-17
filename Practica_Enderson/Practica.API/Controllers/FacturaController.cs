//using Agencia.BussinesLogic.Servicios;
using Agencia.Common.Models;
using Agencia.Entities.Entities;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Practica.BussinesLogic.Servicios;
//using Practica.Common.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

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

        //[HttpGet("List")]
        //public IActionResult List()
        //{
        //    var list = _ventaServicio.ListFact();
        //    return Ok(list);
        //}

        [HttpGet("Details/{id}")]
        public IActionResult Details(int id)
        {
            var modelo = _ventaServicio.DetallesFact(id);
            var detail = modelo.First();
            return Ok(detail);
        }


        [HttpGet("Edit/{id}")]
        public IActionResult Edit(int id)
        {
            var modelo = _ventaServicio.ObtenerUsuaID(id);
            return Json(modelo.Data);
        }

        [HttpPost("Create")]
        public IActionResult Create(FacturaViewModel item)
        {
            var model = _mapper.Map<tbFacturas>(item);
            var modelo = new tbFacturas()
            {
                Fact_Fecha = item.Fact_Fecha,
                Pers_Id = item.Pers_Id,
                Meto_Id = item.Meto_Id,
                Pago_Id = item.Pago_Id,
                Fact_Usua_Creacion = item.Fact_Usua_Creacion,
                Fact_Fecha_Creacion = item.Fact_Fecha_Creacion
            };
            var listado = _ventaServicio.ListFact();

            _ventaServicio.InsertarFact(modelo);
            return Ok(listado);
        }

        [HttpPut("Edit/{id}")]
        public IActionResult Edit(int id, UsuarioViewModel item)
        {
            if (id > 0)
            {
                var model = _mapper.Map<tbFacturas>(item);
                var modelo = new tbFacturas()
                {
                    Usua_Id = id,
                    Usua_Usuario = item.Usua_Usuario,
                    Usua_Admin = item.Usua_Admin,
                    Pers_Id = item.Pers_Id,
                    Rol_Id = item.Rol_Id,
                };
                var listado = _ventaServicio.ListUsua();

                _ventaServicio.ActualizarUsua(modelo);
                return Ok(listado);
            }
            else
            {
                return View("Error");
            }
        }
    }
}
