using Practica.DataAcces.Repositorio;
using Practica.Entities.Entities;
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
        private readonly DepartamentoRepositorio _departamentoRepositorio;
        private readonly EstadoCivilRepositorio _estadoCivilRepositorio;
        private readonly MunicipioRepositorio _municipioRepositorio;
        private readonly CargoRepositorio _cargoRepositorio;
        private readonly ClienteRepositorio _clienteRepositorio;
        private readonly EmpleadoRepositorio _empleadoRepositorio;
        public GeneralServicio(DepartamentoRepositorio departamentoRepositorio, EstadoCivilRepositorio estadoCivilRepositorio, MunicipioRepositorio municipioRepositorio
            , CargoRepositorio cargoRepositorio, ClienteRepositorio clienteRepositorio, EmpleadoRepositorio empleadoRepositorio)
        {
            _departamentoRepositorio = departamentoRepositorio;
            _estadoCivilRepositorio = estadoCivilRepositorio;
            _municipioRepositorio = municipioRepositorio;
            _cargoRepositorio = cargoRepositorio;
            _clienteRepositorio = clienteRepositorio;
            _empleadoRepositorio = empleadoRepositorio;

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
        public IEnumerable<tbMunicipios> ListMaster(string id)
        {
            return _departamentoRepositorio.ListMaster(id);
        }

        public ServiceResult InsertarDepto(tbDepartamentos item)
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
        public ServiceResult ActualizarDepto(tbDepartamentos item)
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
       
        public IEnumerable<tbDepartamentos> Detalles(string id)
        {
            return _departamentoRepositorio.Detalle(id);
        }
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

        public ServiceResult InsertarMuni(tbMunicipios item)
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
        public ServiceResult ActualizarMuni(tbMunicipios item)
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
        
        public IEnumerable<tbMunicipios> DetallesMuni(string id)
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

        public ServiceResult InsertarClie(tbClientes item)
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
        public ServiceResult ActualizarClie(tbClientes item)
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
       
       
        public IEnumerable<tbClientes> DetallesClien(int id)
        {
            return _clienteRepositorio.Detalle(id);
        }
        #endregion

        #region Empleados

        public ServiceResult ListEmpl()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _empleadoRepositorio.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult InsertarEmpl(tbEmpleados item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _empleadoRepositorio.Insertar(item);
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
        public ServiceResult ActualizarEmpl(tbEmpleados item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _empleadoRepositorio.Actualizar(item);
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
        public ServiceResult EliminarEmpl(int id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _empleadoRepositorio.Eliminar(id);
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

       
        public IEnumerable<tbEmpleados> DetallesEmple(int id)
        {
            return _empleadoRepositorio.Detalle(id);
        }
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

        public ServiceResult ListaMunicipiosID(string id)
        {
            var result = new ServiceResult();
            try
            {
                //var lost = _coloniasRepositorio.List();
                var lost = _departamentoRepositorio.ListaMunicipiosID(id);

                return result.Ok(lost);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }
        #endregion
       

        #region Cargos

        public ServiceResult ListCarg()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _cargoRepositorio.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult InsertarCarg(tbCargos item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _cargoRepositorio.Insertar(item);
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
        public ServiceResult ActualizarCarg(tbCargos item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _cargoRepositorio.Actualizar(item);
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
        public ServiceResult EliminarCarg(int id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _cargoRepositorio.Eliminar(id);
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
      
        public IEnumerable<tbCargos> DetallesCargo(int id)
        {
            return _cargoRepositorio.Detalle(id);
        }

        #endregion
    }
}
