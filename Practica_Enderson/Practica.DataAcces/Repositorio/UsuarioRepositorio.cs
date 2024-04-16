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
    public class UsuarioRepositorio : IRepository<tbUsuarios>
    {
        public RequestStatus Actualizar(tbUsuarios item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Usua_Id", item.Usua_Id);
                parametro.Add("Usua_Usuario", item.Usua_Usuario);
                parametro.Add("Usua_Admin", item.Usua_Admin);
              
                parametro.Add("Rol_Id", item.Rol_Id);
                parametro.Add("Usua_Usua_Modifica", item.Usua_Usua_Modifica);
                parametro.Add("Usua_Fecha_Modifica", DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Usua_Actualizar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public RequestStatus Eliminar(int? id)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Usua_Id", id);
                var result = db.Execute(ScriptBaseDatos.Usua_Eliminar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public tbUsuarios Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbUsuarios item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();

                parametro.Add("Usua_Usuario", item.Usua_Usuario);
                parametro.Add("Usua_Contra", item.Usua_Contra);
                parametro.Add("Usua_Admin", item.Usua_Admin);
             
                parametro.Add("Rol_Id", item.Rol_Id);
                parametro.Add("Usua_Estado", item.Usua_Estado);

                parametro.Add("Usua_Usua_Creacion", item.Usua_Usua_Modifica);
                parametro.Add("Usua_Fecha_Creacion", DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Usua_Insertar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public IEnumerable<tbUsuarios> List()
        {

            List<tbUsuarios> result = new List<tbUsuarios>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbUsuarios>(ScriptBaseDatos.Usua_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }

        public IEnumerable<tbUsuarios> Detalle(int Usua_Id)
        {


            List<tbUsuarios> result = new List<tbUsuarios>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Usua_Id = Usua_Id };
                result = db.Query<tbUsuarios>(ScriptBaseDatos.Usua_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }


        public RequestStatus RestablecerContra(tbUsuarios item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Usua_Id", item.Usua_Id);
                parametro.Add("Usua_Contra", item.Usua_Contra);
                parametro.Add("Usua_Usua_Modifica", item.Usua_Fecha_Modifica);
                parametro.Add("Usua_Fecha_Modifica", DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Usua_Reestablecer,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public IEnumerable<tbUsuarios> Login(string usuario, string contra)
        {
            string sql = "EXEC [Acce].[SP_Usuarios_InicioSesion] @Usuario  , @Contra  ;";

            List<tbUsuarios> result = new List<tbUsuarios>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {

                result = db.Query<tbUsuarios>(sql, new { Usuario = usuario, Contra = contra }, commandType: CommandType.Text).ToList();
                return result;
            }
        }
    }
}
