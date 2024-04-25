using Dapper;
using Microsoft.Data.SqlClient;
using Agencia.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica.DataAcces.Repositorio
{
    public class FacturaRepositorio : IRepository<tbFacturas>
    {
        public RequestStatus Actualizar(tbFacturas item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();

                parametro.Add("Fact_Id", item.Fact_Id);
                parametro.Add("Fact_Fecha", item.Fact_Fecha);
                parametro.Add("Meto_Id", item.Meto_Id);
                parametro.Add("Pago_Id", item.Pago_Id);
                parametro.Add("Pers_Id", item.Pers_Id);
                parametro.Add("Fact_Usua_Modifica", item.Fact_Usua_Modifica);
                parametro.Add("Fact_Fecha_Modifica", item.Fact_Fecha_Modifica);

                var result = db.QueryFirst(ScriptBaseDatos.Fact_Actualizar, parametro, commandType: CommandType.StoredProcedure);

                return new RequestStatus { CodeStatus = result.Resultado};
            }
        }
        //public RequestStatus Eliminar(int? id)
        //{
        //    using (var db = new SqlConnection(AgenciaContext.ConnectionString))
        //    {
        //        var parametro = new DynamicParameters();
        //        parametro.Add("Usua_Id", id);
        //        var result = db.Execute(ScriptBaseDatos.Usua_Eliminar,
        //            parametro,
        //             commandType: CommandType.StoredProcedure
        //            );

        //        string mensaje = (result == 1) ? "Exito" : "Error";
        //        return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
        //    }
        //}

        public tbFacturas Find(int? Fact_Id)
        {
            tbFacturas result = new tbFacturas();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Fact_Id };
                result = db.QueryFirst<tbFacturas>(ScriptBaseDatos.Fact_Mostrar, parameters, commandType: CommandType.StoredProcedure);
                return result;
            }
        }

        public (RequestStatus, int) Insertar(tbFacturas item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();

                parametro.Add("Fact_Fecha", item.Fact_Fecha);
                parametro.Add("Meto_Id", item.Meto_Id);
                parametro.Add("Pago_Id", item.Pago_Id);
                parametro.Add("Pers_Id", item.Pers_Id);
                parametro.Add("Fact_Usua_Creacion", item.Fact_Usua_Creacion);
                parametro.Add("Fact_Fecha_Creacion", item.Fact_Fecha_Creacion);
                parametro.Add("Fact_Id", dbType: DbType.Int32, direction: ParameterDirection.Output);

                var result = db.QueryFirst(ScriptBaseDatos.Fact_Insertar, parametro, commandType: CommandType.StoredProcedure);

                int fact = 0;
                if (result.Resultado == 1)
                {
                    fact = parametro.Get<int>("Fact_Id");
                }

                return (new RequestStatus { CodeStatus = result.Resultado }, fact);
            }
        }

        public RequestStatus InsertarDetalle(tbFacturasDetalles item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();

                parametro.Add("Fact_Id", item.Fact_Id);
                parametro.Add("Paqu_Id", item.Paqu_Id);
                parametro.Add("Fact_CantidadPaqu", item.Fact_CantidadPaqu);
                parametro.Add("Fdet_SubTotal", item.Fdet_SubTotal);
                parametro.Add("Fdet_Total", item.Fdet_Total);
                parametro.Add("Fdet_Impuesto", item.Fdet_Impuesto);
 
                var result = db.QueryFirst(ScriptBaseDatos.Fact_InsertarDetalle, parametro, commandType: CommandType.StoredProcedure);

                return (new RequestStatus { CodeStatus = result.Resultado });
            }
        }

        public IEnumerable<tbFacturas> List(int Pers_Id)
        {
            List<tbFacturas> result = new List<tbFacturas>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Pers_Id };
                result = db.Query<tbFacturas>(ScriptBaseDatos.Fact_Mostrar, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public IEnumerable<tbMetodosPagos> ListMetodosPagos()
        {
            List<tbMetodosPagos> result = new List<tbMetodosPagos>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbMetodosPagos>(ScriptBaseDatos.Meto_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }

        public RequestStatus Eliminar(int? id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbFacturas> List()
        {
            throw new NotImplementedException();
        }

        RequestStatus IRepository<tbFacturas>.Insertar(tbFacturas item)
        {
            throw new NotImplementedException();
        }
    }
}
