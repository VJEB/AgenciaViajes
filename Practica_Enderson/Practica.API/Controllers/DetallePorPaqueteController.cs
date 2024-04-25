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
                Paqu_Id = item.Paqu_Id,
                HaHo_Tran_Id = item.HaHo_Tran_Id,
                DePa_NumNoches = item.DePa_NumNoches,
                DePa_PrecioTodoIncluido = item.DePa_PrecioTodoIncluido,
                DePa_Usua_Creacion = item.DePa_Usua_Creacion,
                DePa_Fecha_Creacion = item.DePa_Fecha_Creacion
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
        [HttpPost("Reservaciones/Create")]
        public IActionResult Create(ReservacionesViewModel item)
        {

            //var model = _mapper.Map<tbPlanes>(item);
            var modelo = new tbReservaciones()
            {
                HaCa_Id = item.HaCa_Id,
                Rese_FechaEntrada = item.Rese_FechaEntrada,
                Rese_FechaSalida = item.Rese_FechaSalida,
                HabitacionesNecesarias = item.HabitacionesNecesarias,
                Rese_PrecioTodoIncluido = item.Rese_PrecioTodoIncluido,
                Rese_NumPersonas = item.Rese_NumPersonas,
                Habi_NumPersonas = item.Habi_NumPersonas,
                Rese_Observacion = item.Rese_Observacion,
                Paqu_Id = item.Paqu_Id,
                Rese_Usua_Creacion = item.Rese_Usua_Creacion,
                Rese_Fecha_Creacion = item.Rese_Fecha_Creacion
            };

            var response = _agenciaServicio.InsertarReservaciones(modelo);
            return Ok(response);
        }
    }
}
