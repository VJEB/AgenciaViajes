using Agencia.Entities.Entities;
using Dapper;
using Microsoft.Data.SqlClient;
using Practica.DataAcces;
using Practica.DataAcces.Repositorio;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agencia.DataAcces.Repositorio
{
    public class DetallePorPaqueteRepositorio: IRepository<tbDetallePorPaquete>
    {
        public RequestStatus Actualizar(int id,tbDetallePorPaquete item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("DePa_Id", id);
                parametro.Add("HaHo_Tran_Id", item.HaHo_Tran_Id);
                parametro.Add("DePa_Precio", item.DePa_Precio);
                parametro.Add("Paqu_Id", item.Paqu_Id);
                parametro.Add("DePa_Cantidad", item.DePa_Cantidad);
                parametro.Add("DePa_NumNoches", item.DePa_NumNoches);
                parametro.Add("DePa_PrecioTodoIncluido", item.DePa_PrecioTodoIncluido);
                parametro.Add("DePa_Usua_Modifica", 1);
                parametro.Add("DePa_Fecha_Modifica", DateTime.Now);
                var result = db.Execute(ScriptBaseDatos.DePa_Actualizar,
                    parametro,
                    commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return (new RequestStatus { CodeStatus = result, MessageStatus = mensaje });
            }
        }

        public RequestStatus Actualizar(tbDetallePorPaquete item)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Eliminar(int? id)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("DePa_Id", id);
                var result = db.Execute(ScriptBaseDatos.DePa_Eliminar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public tbDetallePorPaquete Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbDetallePorPaquete item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("HaHo_Tran_Id", item.HaHo_Tran_Id);
                parametro.Add("Paqu_Id", item.Paqu_Id);
                parametro.Add("DePa_NumNoches", item.DePa_NumNoches);
                parametro.Add("DePa_PrecioTodoIncluido", item.DePa_PrecioTodoIncluido);
                parametro.Add("DePa_Usua_Creacion", item.DePa_Usua_Creacion);
                parametro.Add("DePa_Fecha_Creacion", item.DePa_Fecha_Creacion);
                var result = db.QueryFirst(ScriptBaseDatos.DePa_Insertar,
                    parametro,
                    commandType: CommandType.StoredProcedure
                    );
                return (new RequestStatus { CodeStatus = result.Resultado });
            }
        }

        public IEnumerable<tbDetallePorPaquete> List()
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbDetallePorPaquete> Detalle(int DePa_Id)
        {
            List<tbDetallePorPaquete> result = new List<tbDetallePorPaquete>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { DePa_Id = DePa_Id };
                result = db.Query<tbDetallePorPaquete>(ScriptBaseDatos.DePa_Llenar, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public RequestStatus InsertarReservaciones(tbReservaciones item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("HaCa_Id", item.HaCa_Id);
                parametro.Add("Rese_FechaEntrada", item.Rese_FechaEntrada);
                parametro.Add("Rese_FechaSalida", item.Rese_FechaSalida);
                parametro.Add("HabitacionesNecesarias", item.HabitacionesNecesarias);
                parametro.Add("Rese_PrecioTodoIncluido", item.Rese_PrecioTodoIncluido);
                parametro.Add("Rese_NumPersonas", item.Rese_NumPersonas);
                parametro.Add("Habi_NumPersonas", item.Habi_NumPersonas);
                parametro.Add("Rese_Observacion", item.Rese_Observacion);
                parametro.Add("Paqu_Id", item.Paqu_Id);
                parametro.Add("Rese_Usua_Creacion", item.Rese_Usua_Creacion);
                parametro.Add("Rese_Fecha_Creacion", item.Rese_Fecha_Creacion);
                var result = db.QueryFirst(ScriptBaseDatos.Rese_Insertar,
                    parametro,
                    commandType: CommandType.StoredProcedure
                    );
                string mensaje = "";
                if (result.HabitacionesDisponibles != null)
                {
                    if (result.HabitacionesDisponibles == 0)
                    {
                        mensaje = "No hay habitaciones disponibles";
                    }
                    else
                    {
                        mensaje = $"Habitaciones disponibles: {result.HabitacionesDisponibles}";
                    }
                }
                return new RequestStatus { CodeStatus = result.Resultado, MessageStatus = mensaje };
            }
        }
        //public IEnumerable<tbDetallePorPaquete> List()
        //{
        //    List<tbDetallePorPaquete> result = new List<tbDetallePorPaquete>();
        //    using (var db = new SqlConnection(AgenciaContext.ConnectionString))
        //    {
        //        result = db.Query<tbDetallePorPaquete>(ScriptBaseDatos.DePa_Mostrar, commandType: CommandType.Text).ToList();
        //        return result;
        //    }
        //}
    }
}
