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

        [HttpGet("Details/{id}")]
        public IActionResult Details(int id)
        {
            var modelo = _accesoServicio.DetallesUsua(id);
            var detail = modelo.First();
            return Ok(detail);
        }


        [HttpGet("Edit/{id}")]
        public IActionResult Edit(int id)
        {
            var modelo = _accesoServicio.ObtenerUsuaID(id);
            return Json(modelo.Data);
        }
     
        [HttpGet("Login/{usuario},{contraseña}")]
        public IActionResult loginUsuario(string usuario, string contraseña)
        {
            var estado = _accesoServicio.Login(usuario, contraseña);
            return Ok(estado);

        }


        [HttpPost("Create")]
        public IActionResult Create(UsuarioViewModel item)
        {
            var model = _mapper.Map<tbUsuarios>(item);
            var modelo = new tbUsuarios()
            {
                Usua_Usuario = item.Usua_Usuario,
                Usua_Contra = item.Usua_Contra,
                Usua_Admin = item.Usua_Admin,
                Pers_Id = item.Pers_Id,
                Rol_Id = item.Rol_Id,
               
            };
            var listado = _accesoServicio.ListUsua();

            _accesoServicio.Insertarusua(modelo);
            return Ok(listado);
        }

        [HttpPut("Edit/{id}")]
        public IActionResult Edit(int id, UsuarioViewModel item)
        {
            if (id > 0)
            {
                var model = _mapper.Map<tbUsuarios>(item);
                var modelo = new tbUsuarios()
                {
                    Usua_Id = id,
                    Usua_Usuario = item.Usua_Usuario,
                    Usua_Admin = item.Usua_Admin,
                    Pers_Id = item.Pers_Id,
                    Rol_Id = item.Rol_Id,
                    Usua_Usua_Modifica = item.Usua_Usua_Modifica

                };
                var listado = _accesoServicio.ListUsua();

                _accesoServicio.ActualizarUsua(modelo);
                return Ok(listado);
            }
            else
            {
                return View("Error");
            }
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
        [HttpDelete("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            if (id > 0)
            {
                var listado = _accesoServicio.ListUsua();

                _accesoServicio.Eliminarusua(id);
                return Ok(listado);
            }
            else
            {
                return View("Error");
            }
        }

    }
}
