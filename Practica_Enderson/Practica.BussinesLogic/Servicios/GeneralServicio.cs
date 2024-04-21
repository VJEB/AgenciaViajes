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
        private readonly PaisRepositorio _paisRepositorio;
        private readonly EstadoCivilRepositorio _estadoCivilRepositorio;
        private readonly CiudadRepositorio _ciudadRepositorio;
       
        private readonly PersonaRepositorio _personaRepositorio;

        public GeneralServicio(PaisRepositorio paisRepositorio,
            EstadoRepositorio estadoRepositorio, 
            EstadoCivilRepositorio estadoCivilRepositorio, 
            CiudadRepositorio ciudadRepositorio,
            PersonaRepositorio clienteRepositorio)
        {
            _paisRepositorio = paisRepositorio;
            _estadoRepositorio = estadoRepositorio;
            _estadoCivilRepositorio = estadoCivilRepositorio;
            _ciudadRepositorio = ciudadRepositorio;
            _personaRepositorio = clienteRepositorio;
        }
        #region Paises
        public ServiceResult ListPais()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _paisRepositorio.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        #endregion

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
                var (list, idGenerado) = _personaRepositorio.Insertar(item);
                if (list.CodeStatus > 0)
                {
                    personId = idGenerado;
                    return result.Ok("Datos de la persona guardados con exito!", list);
                }
                else
                {
                    return result.Error("Ya hay una persona con esa informacion");
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
        public ServiceResult ListEsCi()
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
        #endregion
    }
}
