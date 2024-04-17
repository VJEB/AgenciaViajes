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

        public ServiceResult ListFact(int Pers_Id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _facturaRepositorio.List(Pers_Id);
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error("Error al cargar las facturas");
            }
        }
        public ServiceResult FindFact(int Fact_Id)
        {
            var result = new ServiceResult();
            try
            {
                var list = _facturaRepositorio.Find(Fact_Id);
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error("Error al cargar las facturas");
            }
        }
        public ServiceResult ListMetodosPagos()
        {
            var result = new ServiceResult();
            try
            {
                var list = _facturaRepositorio.ListMetodosPagos();
                return result.Ok(list);
            }
            catch (Exception ex)
            {
                return result.Error("Error al cargar los metodos de pago");
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

                return result.Error("Error al crear la factura");
            }
        }
        public ServiceResult ActualizarFact(tbFacturas item)
        {
            var result = new ServiceResult();
            try
            {
                var response = _facturaRepositorio.Actualizar(item);
                if (response.CodeStatus == 1)
                {
                    return result.Ok("Factura actualizada!");
                }
                else
                {
                    return result.Error("Error al actualizar la factura");
                }
            }
            catch (Exception ex)
            {

                return result.Error("Error al actualizar la factura");
            }
        }
        #endregion
    }
}
