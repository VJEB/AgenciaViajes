using Agencia.DataAcces.Repositorio;
using Practica.DataAcces.Repositorio;
using SistemaAsilos.BussinesLogic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agencia.BussinesLogic.Servicios
{
    public class AgenciaServicio
    {
        private readonly DetallePorPaqueteRepositorio _detallexpaqueteRepositorio;
        private readonly HabitacionRepositorio _habitacionRepositorio;
        private readonly HotelRepositorio _hotelRepositorio;
        private readonly PaqueteRepositorio _paqueteRepositorio;
        private readonly TransporteRepositorio _transporteRepositorio;

        public AgenciaServicio(DetallePorPaqueteRepositorio detallexpaqueteRepositorio, HabitacionRepositorio habitacionRepositorio,
            HotelRepositorio hotelRepositorio
              , PaqueteRepositorio paqueteRepositorio, TransporteRepositorio transporteRepositorio)
        {
            _detallexpaqueteRepositorio = detallexpaqueteRepositorio;
            _habitacionRepositorio = habitacionRepositorio;
            _hotelRepositorio = hotelRepositorio;

            _paqueteRepositorio = paqueteRepositorio;
            _transporteRepositorio = transporteRepositorio;

        }

        #region Paquetes
        public ServiceResult ListPaquetes()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _paqueteRepositorio.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        #endregion

        #region Habitaciones
        public ServiceResult ListFotografias()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _habitacionRepositorio.FotosPorHabitacionList();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult ListHabitacionesXHotel()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _habitacionRepositorio.HabitacionesPorHotelList();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult TiposCamasList()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _habitacionRepositorio.TiposCamasList();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        #endregion

        #region Hoteles
        public ServiceResult ListHoteles()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _hotelRepositorio.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        #endregion

        #region Transportes
        public ServiceResult ListTransporte()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _transporteRepositorio.List();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult ListTipoTransporte()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _transporteRepositorio.TipoTransporteList();
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
