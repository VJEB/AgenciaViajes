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
    public class GeneralServicio
    {
        private readonly EstadoRepositorio _departamentoRepositorio;
        private readonly EstadoCivilRepositorio _estadoCivilRepositorio;
        private readonly CiudadRepositorio _municipioRepositorio;
       
        private readonly PersonaRepositorio _clienteRepositorio;

        public GeneralServicio(EstadoRepositorio departamentoRepositorio, EstadoCivilRepositorio estadoCivilRepositorio, CiudadRepositorio municipioRepositorio
              ,PersonaRepositorio clienteRepositorio)
        {
            _departamentoRepositorio = departamentoRepositorio;
            _estadoCivilRepositorio = estadoCivilRepositorio;
            _municipioRepositorio = municipioRepositorio;
            
            _clienteRepositorio = clienteRepositorio;
            

        }
        #region Departamentos
        public ServiceResult ListDepto()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _departamentoRepositorio.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        //public IEnumerable<tbCiudades> ListMaster(string id)
        //{
        //    return _departamentoRepositorio.ListMaster(id);
        //}

        public ServiceResult InsertarDepto(tbEstados item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _departamentoRepositorio.Insertar(item);
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
        public ServiceResult ActualizarDepto(tbEstados item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _departamentoRepositorio.Actualizar(item);
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
        public ServiceResult EliminarDepto(string id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _departamentoRepositorio.Eliminarr(id);
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
       
        //public IEnumerable<tbEstados> Detalles(string id)
        //{
        //    return _departamentoRepositorio.Detalles(id);
        //}
        #endregion

        #region Municipios
        public ServiceResult ListMuni()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _municipioRepositorio.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult InsertarMuni(tbCiudades item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _municipioRepositorio.Insertar(item);
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
        public ServiceResult ActualizarMuni(tbCiudades item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _municipioRepositorio.Actualizar(item);
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
        public ServiceResult EliminarMuni(int id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _municipioRepositorio.Eliminar(id);
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
        
        public IEnumerable<tbCiudades> DetallesMuni(string id)
        {
            return _municipioRepositorio.Detalle(id);
        }

        #endregion

        #region Clientes
        public ServiceResult ListClie()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _clienteRepositorio.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult InsertarClie(tbPersonas item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _clienteRepositorio.Insertar(item);
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
        public ServiceResult ActualizarClie(tbPersonas item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _clienteRepositorio.Actualizar(item);
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
        public ServiceResult EliminarClie(int id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _clienteRepositorio.Eliminar(id);
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
       
       
        //public IEnumerable<tbPersonas> DetallesClien(int id)
        //{
        //    return _clienteRepositorio.Detalle(id);
        //}
        #endregion

       

        #region Estados Civiles
       

        public ServiceResult EstadoList()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _estadoCivilRepositorio.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult InsertarEstado(tbEstadosCiviles item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _estadoCivilRepositorio.Insertar(item);
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
        public ServiceResult ActualizarEstado(tbEstadosCiviles item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _estadoCivilRepositorio.Actualizar(item);
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
        public ServiceResult EliminarEstado(int id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _estadoCivilRepositorio.Eliminar(id);
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
      
        public IEnumerable<tbEstadosCiviles> Detalles(int id)
        {
            return _estadoCivilRepositorio.Detalle(id);
        }

      
        #endregion
       

        
    }
}
