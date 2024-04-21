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
    public class PaqueteController : Controller
    {
        private readonly AgenciaServicio _agenciaServicio;
        private readonly IMapper _mapper;


        public PaqueteController(AgenciaServicio agenciaServicio, IMapper mapper)
        {

            _mapper = mapper;
            _agenciaServicio = agenciaServicio;


        }

        [HttpGet("ListPaquetes/{Pers_Id}")]
        public IActionResult List(int Pers_Id)
        {
            var list = _agenciaServicio.ListPaquetes(Pers_Id);
            return Ok(list);
        }

        [HttpGet("LlenarPaquete/{Paqu_Id}")]
        public IActionResult LlenarDetalles(int Paqu_Id)
        {
            var list = _agenciaServicio.DetallesPaquete(Paqu_Id);
            var prueba = list.First();
            return Ok(prueba);
        }

        [HttpPost("Create")]
        public IActionResult Create(PaqueteViewModel item)
        {

            //var model = _mapper.Map<tbPlanes>(item);
            var modelo = new tbPaquetes()
            {
                Paqu_Nombre = item.Paqu_Nombre,
                Paqu_Precio = item.Paqu_Precio,
                Pers_Id = item.Pers_Id,
                Paqu_Usua_Creacion = item.Paqu_Usua_Creacion,
                Paqu_Fecha_Creacion = item.Paqu_Fecha_Creacion
            };

            int paqueId;
            var response = _agenciaServicio.InsertarPaquete(modelo, out paqueId);
            if (paqueId > 0)
            {
                response.Message = paqueId.ToString();
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }

        }


        [HttpPut("Edit/{id}")]
        public IActionResult Edit(int id, PaqueteViewModel item)
        {
            var modelo = new tbPaquetes()
            {
                Paqu_Id = id,
                Paqu_Nombre = item.Paqu_Nombre,
                Paqu_Precio = item.Paqu_Precio,
                Paqu_Usua_Modifica = item.Paqu_Usua_Modifica,
                Paqu_Fecha_Modifica = item.Paqu_Fecha_Modifica
            };


            var response = _agenciaServicio.ActualizarPaquete(id, modelo);
            if (response.Code >= 200 && response.Code <= 300)
            {
                return Ok(response);
            }
            else
            {
                return BadRequest(response);
            }
        }

        [HttpDelete("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            if (id > 0)
            {


                var prueba = _agenciaServicio.EliminarPaquete(id);
                return Ok(prueba);
            }
            else
            {
                return BadRequest();
            }
        }

    }
}
