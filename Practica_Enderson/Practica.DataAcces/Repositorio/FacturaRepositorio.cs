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

                var result = db.QueryFirst(ScriptBaseDatos.Fact_Insertar, parametro, commandType: CommandType.StoredProcedure);

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

        public tbFacturas Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbFacturas item)
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

                int factId = parametro.Get<int>("Fact_Id");

                return new RequestStatus { CodeStatus = result.Resultado, MessageStatus = factId.ToString() };
            }
        }


        public IEnumerable<tbFacturas> List()
        {

            List<tbFacturas> result = new List<tbFacturas>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbFacturas>(ScriptBaseDatos.Usua_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }

        public IEnumerable<tbFacturas> Detalle(int Usua_Id)
        {

            List<tbFacturas> result = new List<tbFacturas>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Usua_Id = Usua_Id };
                result = db.Query<tbFacturas>(ScriptBaseDatos.Usua_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
    }
}
