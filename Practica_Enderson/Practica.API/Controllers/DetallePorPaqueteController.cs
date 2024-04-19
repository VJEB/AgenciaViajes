using Agencia.BussinesLogic.Servicios;
using Agencia.Common.Models;
using Agencia.Entities.Entities;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using System.Linq;

namespace Agencia.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class DetallePorPaqueteController : Controller
    {

        private readonly AgenciaServicio _agenciaServicio;
        private readonly IMapper _mapper;


        public DetallePorPaqueteController(AgenciaServicio agenciaServicio, IMapper mapper)
        {

            _mapper = mapper;
            _agenciaServicio = agenciaServicio;


        }


        [HttpGet("LlenarDetallePaquete/{DePa_Id}")]
        public IActionResult LlenarDetalles(int DePa_Id)
        {
            var list = _agenciaServicio.DetallesDetallePaquete(DePa_Id);
            var prueba = list.First();
            return Ok(prueba);
        }

        [HttpPost("Create")]
        public IActionResult Create(DetallePorPaqueteViewModel item)
        {

            //var model = _mapper.Map<tbPlanes>(item);
            var modelo = new tbDetallePorPaquete()
            {
                HaHo_Tran_Id = item.HaHo_Tran_Id,
                DePa_Precio = item.DePa_Precio,
                Paqu_Id = item.Paqu_Id,
                DePa_Cantidad = item.DePa_Cantidad,
                DePa_NumNoches = item.DePa_NumNoches,
                DePa_PrecioTodoIncluido = item.DePa_PrecioTodoIncluido
            };

            var prueba = _agenciaServicio.InsertarDetallePaquete(modelo);
            return Ok(prueba);

        }


        [HttpPut("Edit/{id}")]
        public IActionResult Edit(int id, DetallePorPaqueteViewModel item)
        {
            var modelo = new tbDetallePorPaquete()
            {
                DePa_Id = id,
                HaHo_Tran_Id = item.HaHo_Tran_Id,
                DePa_Precio = item.DePa_Precio,
                Paqu_Id = item.Paqu_Id,
                DePa_Cantidad = item.DePa_Cantidad,
                DePa_NumNoches = item.DePa_NumNoches,
                DePa_PrecioTodoIncluido = item.DePa_PrecioTodoIncluido
            };


            var prueba = _agenciaServicio.ActualizarDetallePaquete(id, modelo);
            if (prueba.Code == 200)
            {
                return Ok(prueba);
            }
            else
            {
                return BadRequest(prueba);
            }
        }

        [HttpDelete("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            if (id > 0)
            {


                var prueba = _agenciaServicio.EliminarDetallePaquete(id);
                return Ok(prueba);
            }
            else
            {
                return BadRequest();
            }
        }
    }
}
