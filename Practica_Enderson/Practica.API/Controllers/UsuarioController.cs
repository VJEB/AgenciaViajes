using Agencia.BussinesLogic.Servicios;
using Agencia.Common.Models;
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
    public class UsuarioController : Controller
    {
        private readonly AccesoServicio _accesoServicio;
        private readonly IMapper _mapper;
        private readonly IMailService _mailService;

        public UsuarioController(AccesoServicio accesoServicio, IMapper mapper, IMailService mailService)
        {

            _mailService = mailService;
            _mapper = mapper;
            _accesoServicio = accesoServicio;
        }

        [HttpGet("List")]
        public IActionResult List()
        {
            var list = _accesoServicio.ListUsua();
            return Ok(list.Data);
        }

        [HttpGet("List2/{Usua_Id}")]
        public IActionResult List2(int Usua_Id)
        {
            var list = _accesoServicio.ListUsua2(Usua_Id);
            return Ok(list.Data);
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

        [HttpGet("Login/{usuario}/{contraseña}")]
        public IActionResult Login(string usuario, string contraseña)
        {
            var estado = _accesoServicio.Login(usuario, contraseña);
            if (estado.Code == 200)
            {
                return Ok(estado);
            }
            else
            {
                return BadRequest();
            }
        }


        [HttpPost("Create")]
        public IActionResult Create(UsuarioViewModel item)
        {
            var model = _mapper.Map<tbUsuarios>(item);
            var modelo = new tbUsuarios()
            {
                Usua_Usuario = item.Usua_Usuario,
                Usua_Contra = item.Usua_Contra,
                Pers_Id = item.Pers_Id,
                Pers_Email = item.Pers_Email,
                Usua_Usua_Creacion = item.Usua_Usua_Creacion,
                Usua_Fecha_Creacion = item.Usua_Fecha_Creacion
            };
            var response  = _accesoServicio.Insertarusua(modelo);
            return Ok(response);
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
        [HttpPost("ValidarPin")]
        public IActionResult ValidarPin(string PIN)
        {
            bool validado = _accesoServicio.ValidarPin(PIN);
            return validado ? Ok(PIN) : BadRequest("Código de verificación incorrecto");
        }
        [HttpPost("EnviarCodigo")]
        public IActionResult EnviarCodigo(string Usuario)
        {
            tbUsuarios usuario = _accesoServicio.MostrarPorUsua_Usuario(Usuario);
            if (usuario.Usua_Id == 0)
            {
                return BadRequest("No existe ese usuario");
            }
            MailData mailData = new MailData();
            mailData.EmailToId = usuario.Pers_Email;
            mailData.EmailToName = usuario.Persona;
            mailData.EmailSubject = usuario.Usua_Id.ToString();
            var enviarCorreo = _mailService.SendMail(mailData);
            return Ok(enviarCorreo);
        }
        [HttpPut("restablecer/{PIN}")]
        public IActionResult restablecer(string PIN, UsuarioViewModel item)
        {
            //var model = _mapper.Map<tbUsuarios>(item);
            var modelo = new tbUsuarios()
            {
                Usua_CodigoVerificacion = PIN,
                Usua_Contra = item.Usua_Contra,
            };

            var result = _accesoServicio.restablecer(modelo);
            return Ok(result);
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
