using Practica.DataAcces.Repositorio;
using Agencia.Entities.Entities;
using SistemaAsilos.BussinesLogic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica.BussinesLogic.Servicios
{
    public class AccesoServicio
    {
        private readonly UsuarioRepositorio _usuarioRepositorio;
        private readonly RolRepositorio _roleRepositorio;
        //private readonly PantallaRepositorio _pantallaRepositorio;

        public AccesoServicio(UsuarioRepositorio usuarioRepositorio, RolRepositorio roleRepositorio /*PantallaRepositorio pantallaRepositorio*/)
        {
            _usuarioRepositorio = usuarioRepositorio;
            _roleRepositorio = roleRepositorio;
            //_pantallaRepositorio = pantallaRepositorio;
        }


        #region Usuario

        public ServiceResult ListUsua2(int Usua_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepositorio.List2(Usua_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult ListUsua()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepositorio.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult ListUsua2(int Usua_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepositorio.List2(Usua_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult ObtenerUsuaID(int Usua_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepositorio.ObtenerUsuaID(Usua_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }

        }
        public ServiceResult Insertarusua(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepositorio.Insertar(item);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    lost.MessageStatus = (lost.CodeStatus == 0) ? "401 Error de Consulta" : lost.MessageStatus;
                    return result.Error(lost);
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult ActualizarUsua(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepositorio.Actualizar(item);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    lost.MessageStatus = (lost.CodeStatus == 0) ? "401 Error de Consulta" : lost.MessageStatus;
                    return result.Error(lost);
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult ActualizarCodigo(string Usua_Id, string codigo)
        {
            var result = new ServiceResult();
            try
            {
                var response = _usuarioRepositorio.ActualizarCodigoVerificacion(Usua_Id,codigo);
                if (response.CodeStatus == 1)
                {
                    return result.Ok("Codigo actualizado exitosamente");
                }
                else
                {
                   
                    return result.Error("Error al acutalizar el codigo de verificacion");
                }

            }
            catch (Exception ex)
            {

                return result.Error("Error al acutalizar el codigo de verificacion");
            }
        }
        public ServiceResult restablecer(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepositorio.RestablecerContra(item);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    lost.MessageStatus = (lost.CodeStatus == 0) ? "401 Error de Consulta" : lost.MessageStatus;
                    return result.Error(lost);
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult Eliminarusua(int id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepositorio.Eliminar(id);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    lost.MessageStatus = (lost.CodeStatus == 0) ? "401 Error de Consulta" : lost.MessageStatus;
                    return result.Error(lost);
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
     
        public ServiceResult Login(string usuario, string contra)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _usuarioRepositorio.Login(usuario, contra);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }

        }
        public IEnumerable<tbUsuarios> DetallesUsua(int id)
        {
            return _usuarioRepositorio.Detalle(id);
        }
        #endregion
        #region Role

        public ServiceResult ListRole()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _roleRepositorio.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult InsertarRol(tbRoles item, out int ingrId)
        {
            var result = new ServiceResult();
            ingrId = 0;
            try
            {
                var (lost, idGenerado) = _roleRepositorio.Insertar(item);
                if (lost.CodeStatus > 0)
                {
                    ingrId = idGenerado;
                    return result.Ok(lost);
                }
                else
                {
                    lost.MessageStatus = (lost.CodeStatus == 0) ? "401 Error de Consulta" : lost.MessageStatus;
                    return result.Error(lost);
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult ActualizarRole(tbRoles item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _roleRepositorio.Actualizar(item);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    lost.MessageStatus = (lost.CodeStatus == 0) ? "401 Error de Consulta" : lost.MessageStatus;
                    return result.Error(lost);
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult EliminarRole(int id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _roleRepositorio.Eliminar(id);
                if (lost.CodeStatus > 0)
                {
                    return result.Ok(lost);
                }
                else
                {
                    lost.MessageStatus = (lost.CodeStatus == 0) ? "401 Error de Consulta" : lost.MessageStatus;
                    return result.Error(lost);
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
     
        public ServiceResult DetallesRol(int id)
        {
            var resul = new ServiceResult();
            try
            {
                var lost = _roleRepositorio.Detalle(id);
                  return resul.Ok(lost);


            }
             catch (Exception ex)
             {
                 return resul.Error(ex.Message);
             }
        }
        #endregion

    }
}
