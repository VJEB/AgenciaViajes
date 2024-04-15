using Dapper;
using Microsoft.Data.SqlClient;
using Practica.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica.DataAcces.Repositorio
{
    public class CargoRepositorio : IRepository<tbCargos>
    {
        public RequestStatus Actualizar(tbCargos item)
        {
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Carg_Id", item.Carg_Id);
                parametro.Add("Carg_Descripcion", item.Carg_Descripcion);
                parametro.Add("Carg_Usua_Modifica", item.Carg_Usua_Modifica);
                parametro.Add("Carg_Fecha_Modifica", DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Carg_Actualizar,
                    parametro,
                    commandType: CommandType.StoredProcedure
                    );
                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public RequestStatus Eliminar(int? id)
        {
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Carg_Id", id);
                var result = db.Execute(ScriptBaseDatos.Carg_Eliminar,
                    parametro,
                    commandType: CommandType.StoredProcedure
                    );
                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public tbCargos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbCargos item)
        {
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Carg_Descripcion", item.Carg_Descripcion);
                parametro.Add("Carg_Usua_Creacion", item.Carg_Usua_Creacion);
                parametro.Add("Carg_Fecha_Creacion", DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Carg_Insertar,
                    parametro,
                    commandType: CommandType.StoredProcedure
                    );
                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public IEnumerable<tbCargos> List()
        {
            List<tbCargos> resul = new List<tbCargos>();
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                resul = db.Query<tbCargos>(ScriptBaseDatos.Carg_Mostrar, commandType: CommandType.StoredProcedure).ToList();
                return resul;
            }
        }
        public IEnumerable<tbCargos> Detalle(int Carg_Id)
        {


            List<tbCargos> result = new List<tbCargos>();
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parameters = new { Carg_Id = Carg_Id };
                result = db.Query<tbCargos>(ScriptBaseDatos.Carg_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
    }
}
