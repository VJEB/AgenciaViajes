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
    public class CiudadRepositorio : IRepository<tbCiudades>
    {
        public RequestStatus Actualizar(tbCiudades item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Ciud_Id", item.Ciud_Id);
                parametro.Add("Ciud_Descripcion", item.Ciud_Descripcion);
                parametro.Add("Esta_Id", item.Esta_Id);
                parametro.Add("Ciud_Usua_Modifica", item.Ciud_Usua_Modifica);
                parametro.Add("Ciud_Fecha_Modifica", DateTime.Now);

                var resutl = db.Execute(ScriptBaseDatos.Muni_Actualizar,
                   parametro,
                   commandType: CommandType.StoredProcedure
                   );
                string mensaje = (resutl == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = resutl, MessageStatus = mensaje };
            }
        }

        public RequestStatus Eliminar(int? id)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Ciud_Id", id);
                var result = db.Execute(ScriptBaseDatos.Muni_Eliminar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }
        public RequestStatus Eliminarr(string? id)
        {

            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Ciud_Id", id);
                var result = db.Execute(ScriptBaseDatos.Muni_Eliminar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public tbCiudades Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbCiudades item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Ciud_Id", item.Ciud_Id);
                parametro.Add("Ciud_Descripcion", item.Ciud_Descripcion);
                parametro.Add("Esta_Id", item.Esta_Id);
                parametro.Add("Ciud_Usua_Creacion", item.Ciud_Usua_Creacion);
                parametro.Add("Ciud_Fecha_Creacion", DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Muni_Insertar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                return new RequestStatus { CodeStatus = result };
            }
        }

        public IEnumerable<tbCiudades> List()
        {
            List<tbCiudades> result = new List<tbCiudades>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbCiudades>(ScriptBaseDatos.Ciud_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }

        public IEnumerable<tbCiudades> Detalle(string Muni_Id)
        {


            List<tbCiudades> result = new List<tbCiudades>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Muni_Id = Muni_Id };
                result = db.Query<tbCiudades>(ScriptBaseDatos.Muni_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        IEnumerable<tbCiudades> IRepository<tbCiudades>.List()
        {
            throw new NotImplementedException();
        }

       
    }
}
