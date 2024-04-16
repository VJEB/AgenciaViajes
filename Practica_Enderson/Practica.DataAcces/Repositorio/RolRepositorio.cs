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
    public class RolRepositorio : IRepository<tbRoles>
    {
        public RequestStatus Actualizar(tbRoles item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Rol_Id", item.Rol_Id);
                parametro.Add("Rol_Descripcion", item.Rol_Descripcion);

                parametro.Add("Rol_Usua_Modifica", item.Rol_Usua_Modifica);
                parametro.Add("Rol_Fecha_Modifica", DateTime.Now);

                var result = db.QueryFirst(ScriptBaseDatos.Rol_Actualizar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                return result;
            }
        }

        public RequestStatus Eliminar(int? id)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Rol_Id", id);
                var result = db.Execute(ScriptBaseDatos.Rol_Eliminar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public tbRoles Find(int? id)
        {
            throw new NotImplementedException();
        }

        public (RequestStatus,int) Insertar(tbRoles item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();

                parametro.Add("Rol_Descripcion", item.Rol_Descripcion);

                parametro.Add("Rol_Usua_Creacion", item.Rol_Usua_Creacion);
                parametro.Add("Rol_Fecha_Creacion", DateTime.Now);
               
                parametro.Add("role_id", dbType: DbType.Int32, direction: ParameterDirection.Output);

                var result = db.Execute(ScriptBaseDatos.Rol_Insertar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                int proyId = 0;
                if (result > 0)
                {
                    proyId = parametro.Get<int>("role_id");
                }

                string mensaje = (result == 1) ? "Exito" : "Error";
                return (new RequestStatus { CodeStatus = result, MessageStatus = mensaje },proyId);
            }
        }
        public IEnumerable<tbRoles> Detalle(int Rol_Id)
        {


            List<tbRoles> result = new List<tbRoles>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Rol_Id = Rol_Id };
                result = db.Query<tbRoles>(ScriptBaseDatos.Rol_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
        public IEnumerable<tbRoles> List()
        {

            List<tbRoles> result = new List<tbRoles>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbRoles>(ScriptBaseDatos.Rol_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }

        RequestStatus IRepository<tbRoles>.Insertar(tbRoles item)
        {
            throw new NotImplementedException();
        }
    }
}
