using Agencia.Entities.Entities;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Practica.BussinesLogic.Servicios;
using Practica.Common.Models;
using System.Linq;

namespace Practica.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class PersonaController : Controller
    {
        private readonly GeneralServicio _generalServicio;
        private readonly IMapper _mapper;


        public PersonaController(GeneralServicio generalServicio, IMapper mapper)
        {

            _mapper = mapper;
            _generalServicio = generalServicio;


        }

        [HttpGet("LlenarPersona/{Pers_Id}")]
        public IActionResult LlenarDetalles(int Pers_Id)
        {
            var list = _generalServicio.DetallesPerson(Pers_Id);
            var prueba = list.First();
            return Ok(prueba);
        }

        [HttpGet("CargarTarjetas/{Pers_Id}")]
        public IActionResult MostrarTarjetas(int Pers_Id)
        {
            var list = _generalServicio.CargarTarjetas(Pers_Id);
            return Json(list.Data);
        }

        [HttpPost("Create")]
        public IActionResult Create(PersonaViewModel item)
        {

            var modelo = new tbPersonas()
            {
                Pers_DNI = item.Pers_DNI,
                Pers_Pasaporte = item.Pers_Pasaporte,
                Pers_Email = item.Pers_Email,
                Pers_Nombre = item.Pers_Nombre,
                Pers_Apellido = item.Pers_Apellido,
                Pers_Sexo = item.Pers_Sexo,
                Pers_Telefono = item.Pers_Telefono,
                EsCi_Id = item.EsCi_Id,
                Carg_Id = item.Carg_Id,
                Ciud_Id = item.Ciud_Id,
            };
            int personId;
            var prueba = _generalServicio.InsertarPerson(modelo, out personId);
            var hola = prueba;
            if (personId > 0)
            {
                hola.Message = personId.ToString();
                return Ok(prueba);
            }
            else
            {
                return BadRequest(prueba);
            }
        }
    }
}
