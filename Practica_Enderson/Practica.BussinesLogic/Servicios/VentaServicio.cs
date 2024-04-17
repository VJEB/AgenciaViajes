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
    public class VentaServicio
    {
        private readonly FacturaRepositorio _facturaRepositorio;

        public VentaServicio(FacturaRepositorio facturaRepositorio)
        {
            _facturaRepositorio = facturaRepositorio;
        }


        #region Usuario

        public ServiceResult ListFact()
        {
            var result = new ServiceResult();
            try
            {
                var lost = _facturaRepositorio.List();
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
                var lost = _facturaRepositorio.ObtenerUsuaID(Usua_Id);
                return result.Ok(lost);
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }

        }
        public ServiceResult InsertarFact(tbFacturas item)
        {
            var result = new ServiceResult();
            try
            {
                var response = _facturaRepositorio.Insertar(item);
                if (response.CodeStatus == 1)
                {
                    return result.Ok(response.MessageStatus); //response.MessageStatus = Fact_Id
                }
                else
                {
                    return result.Error("Error al crear la factura");
                }
            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public ServiceResult ActualizarUsua(tbFacturas item)
        {
            var result = new ServiceResult();
            try
            {
                var lost = _facturaRepositorio.Actualizar(item);
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
        public ServiceResult ActualizarCodigoVerificacionUsua(string Usua_Id, string CodigoVerificacion)
        {
            var result = new ServiceResult();
            try
            {
                var response = _facturaRepositorio.ActualizarCodigoVerificacion(Usua_Id, CodigoVerificacion);
                if (response.CodeStatus == 1)
                {
                    return result.Ok("Codigo de verificacion actualizado!");
                }
                else
                {
                    return result.Error("Error al actualizar el codigo de verficacion.");
                }

            }
            catch (Exception ex)
            {

                return result.Error(ex.Message);
            }
        }
        public IEnumerable<tbFacturas> DetallesUsua(int id)
        {
            return _facturaRepositorio.Detalle(id);
        }
        #endregion
    }
}
