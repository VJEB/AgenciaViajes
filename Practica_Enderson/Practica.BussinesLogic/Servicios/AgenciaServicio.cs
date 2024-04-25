using Agencia.DataAcces.Repositorio;
using Agencia.Entities.Entities;
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
        private readonly HabitacionesCategoriasRepositorio _habitacionesCategoriasRepositorio;
        private readonly HotelRepositorio _hotelRepositorio;
        private readonly PaqueteRepositorio _paqueteRepositorio;
        private readonly TransporteRepositorio _transporteRepositorio;

        public AgenciaServicio(DetallePorPaqueteRepositorio detallexpaqueteRepositorio, 
            HabitacionRepositorio habitacionRepositorio,
            HabitacionesCategoriasRepositorio habitacionesCategoriasRepositorio,
            HotelRepositorio hotelRepositorio, 
            PaqueteRepositorio paqueteRepositorio, 
            TransporteRepositorio transporteRepositorio)
        {
            _detallexpaqueteRepositorio = detallexpaqueteRepositorio;
            _habitacionRepositorio = habitacionRepositorio;
            _habitacionesCategoriasRepositorio = habitacionesCategoriasRepositorio;
            _hotelRepositorio = hotelRepositorio;

            _paqueteRepositorio = paqueteRepositorio;
            _transporteRepositorio = transporteRepositorio;

        }

        #region Paquetes
        public ServiceResult ListPaquetes(int Pers_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _paqueteRepositorio.MostrarPaquetes(Pers_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult ListPaquetesDefault()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _paqueteRepositorio.MostrarPaquetesDefault();
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult InsertarPaquete(tbPaquetes item, out int paqueteId)
        {
            var result = new ServiceResult();
            paqueteId = 0;
            try
            {
                var (response, idGenerado) = _paqueteRepositorio.Insertar(item);
                if (response.CodeStatus == 1)
                {
                    paqueteId = idGenerado;
                    return result.Ok(response);
                }
                else
                {
                    return result.Error("Ya existe un paquete con ese nombre");
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult ActualizarPaquete(int id,tbPaquetes item)
        {
            var result = new ServiceResult();
            try
            {
                var response = _paqueteRepositorio.Actualizar(id,item);
                if (response.CodeStatus == 1)
                {
                    return result.Ok(response);
                }
                else
                {
                    return result.Error("Error al actualizar la información del paquete.");
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult EliminarPaquete(int id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _paqueteRepositorio.Eliminar(id);
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

        public IEnumerable<tbPaquetes> DetallesPaquete(int id)
        {
            return _paqueteRepositorio.Detalle(id);
        }

        #endregion

        #region Detalle Paquetes
        public ServiceResult InsertarDetallePaquete(tbDetallePorPaquete item)
        {
            var result = new ServiceResult();
            try
            {
                var response = _detallexpaqueteRepositorio.Insertar(item);
                if (response.CodeStatus == 1)
                {
                    
                    return result.Ok(response);
                }
                else
                {
                    return result.Error("Error al guardar la información.");
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult InsertarReservaciones(tbReservaciones item)
        {
            var result = new ServiceResult();
            try
            {
                var response = _detallexpaqueteRepositorio.InsertarReservaciones(item);
                if (response.CodeStatus == 1)
                {
                    return result.Ok(response);
                }
                else
                {
                    return result.Error(response.MessageStatus);
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult InsertarViajes(tbViajes item)
        {
            var result = new ServiceResult();
            try
            {
                var response = _detallexpaqueteRepositorio.InsertarViajes(item);
                if (response.CodeStatus == 1)
                {
                    return result.Ok(response);
                }
                else
                {
                    return result.Error(response.MessageStatus);
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult ActualizarDetallePaquete(int id, tbDetallePorPaquete item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _detallexpaqueteRepositorio.Actualizar(id, item);
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
        public ServiceResult EliminarDetallePaquete(int id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _detallexpaqueteRepositorio.Eliminar(id);
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

        public IEnumerable<tbDetallePorPaquete> DetallesDetallePaquete(int id)
        {
            return _detallexpaqueteRepositorio.Detalle(id);
        }

        #endregion

        #region HabitacionesCategorias
        public ServiceResult ListHabitacionesCategoriasXHotel(int Hote_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _habitacionesCategoriasRepositorio.HabitacionesCategoriasPorHotel(Hote_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        #endregion

        #region Habitaciones
        public ServiceResult FotosPorHabitacion(int HaHo_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _habitacionRepositorio.FotosPorHabitacion(HaHo_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        public ServiceResult FotosPorHotel(int Hote_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _habitacionRepositorio.FotosPorHotel(Hote_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }


        public ServiceResult ListHabitacionesXHotel(int Hote_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _habitacionRepositorio.HabitacionPorHotel(Hote_Id);
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

        public ServiceResult ListReservaciones(int Paqu_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _detallexpaqueteRepositorio.ListReservaciones(Paqu_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult ListViajes(int Paqu_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _detallexpaqueteRepositorio.ListViajes(Paqu_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }

        #region Hoteles
        public ServiceResult ListHoteles(string Ciud_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _hotelRepositorio.List(Ciud_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        #endregion

        #region Transportes
        public ServiceResult ListTransporte(string Ciud_Id)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _transporteRepositorio.MostrarTransporte(Ciud_Id);
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
