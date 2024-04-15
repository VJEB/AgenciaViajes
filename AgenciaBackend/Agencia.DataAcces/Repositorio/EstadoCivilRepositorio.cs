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
    public class EstadoCivilRepositorio : IRepository<tbEstadosCiviles>
    {
        public RequestStatus Actualizar(tbEstadosCiviles item)
        {
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Esta_Id", item.Esta_Id);
                parametro.Add("Esta_Descripcion", item.Esta_Descripcion);
                parametro.Add("Esta_Usua_Modifica", item.Esta_Usua_Modifica);
                parametro.Add("Esta_Fecha_Modifica", DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Esta_Actualizar,
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
                parametro.Add("Esta_Id", id);
                var result = db.Execute(ScriptBaseDatos.Esta_Eliminar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public tbEstadosCiviles Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbEstadosCiviles item)
        {
           using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Esta_Descripcion", item.Esta_Descripcion);
                parametro.Add("Esta_Usua_Creacion", item.Esta_Usua_Creacion);
                parametro.Add("Esta_Fecha_Creacion",DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Esta_Insertar,
                    parametro,
                    commandType: CommandType.StoredProcedure
                    );
                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public IEnumerable<tbEstadosCiviles> List()
        {
            List<tbEstadosCiviles> result = new List<tbEstadosCiviles>();
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                result = db.Query<tbEstadosCiviles>(ScriptBaseDatos.Esta_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }
        public IEnumerable<tbEstadosCiviles> Detalle(int Esta_Id)
        {


            List<tbEstadosCiviles> result = new List<tbEstadosCiviles>();
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parameters = new { Esta_Id = Esta_Id };
                result = db.Query<tbEstadosCiviles>(ScriptBaseDatos.Esta_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
    }
}
