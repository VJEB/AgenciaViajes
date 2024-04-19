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
        private readonly EstadoRepositorio _estadoRepositorio;
        private readonly EstadoCivilRepositorio _estadoCivilRepositorio;
        private readonly CiudadRepositorio _ciudadRepositorio;
       
        private readonly PersonaRepositorio _personaRepositorio;

        public GeneralServicio(EstadoRepositorio estadoRepositorio, 
            EstadoCivilRepositorio estadoCivilRepositorio, 
            CiudadRepositorio ciudadRepositorio,
            PersonaRepositorio clienteRepositorio)
        {
            _estadoRepositorio = estadoRepositorio;
            _estadoCivilRepositorio = estadoCivilRepositorio;
            _ciudadRepositorio = ciudadRepositorio;
            _personaRepositorio = clienteRepositorio;
        }
        #region Estados
        public ServiceResult ListEsta(int Pais_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _estadoRepositorio.List(Pais_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        #endregion

        #region Ciudades
        public ServiceResult ListCiud(string Esta_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _ciudadRepositorio.List(Esta_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        #endregion

        #region Personas
        public ServiceResult CargarTarjetas(int Pers_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _personaRepositorio.CargarTarjetas(Pers_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult InsertarPerson(tbPersonas item,out int personId)
        {
            var result = new ServiceResult();
            personId = 0;
            try
            {
                var (lost, idGenerado) = _personaRepositorio.Insertar(item);
                if (lost.CodeStatus > 0)
                {
                    personId = idGenerado;
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

        public IEnumerable<tbPersonas> DetallesPerson(int id)
        {
            return _personaRepositorio.Detalle(id);
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

      
        #endregion
       

        
    }
}
