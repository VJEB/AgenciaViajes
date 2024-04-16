using Agencia.Entities.Entities;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Practica.BussinesLogic.Servicios;
using Practica.Common.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Practica.API.Controllers
{
    [ApiController]
    [Route("API/[Controller]")]
    public class UsuarioController : Controller
    {
        private readonly AccesoServicio _accesoServicio;
        private readonly IMapper _mapper;


        public UsuarioController(AccesoServicio accesoServicio, IMapper mapper)
        {

            _mapper = mapper;
            _accesoServicio = accesoServicio;


        }

        [HttpGet("List")]
        public IActionResult List()
        {
            var list = _accesoServicio.ListUsua();
            return Ok(list);
        }

        [HttpGet("Login/{usuario},{contraseña}")]
        public IActionResult loginUsuario(string usuario, string contraseña)
        {
            var estado = _accesoServicio.Login(usuario, contraseña);
            return Ok(estado);

        }

        [HttpPut("restablecer/{id}")]
        public IActionResult restablecer(int id, UsuarioViewModel item)
        {
            if (id > 0)
            {
                var model = _mapper.Map<tbUsuarios>(item);
                var modelo = new tbUsuarios()
                {
                    Usua_Id = id,
                    Usua_Contra = item.Usua_Contra,


                };
                var listado = _accesoServicio.ListUsua();

                _accesoServicio.restablecer(modelo);
                return Ok(listado);
            }
            else
            {
                return View("Error");
            }
        }

    }
}
