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
    public class DepartamentoRepositorio : IRepository<tbDepartamentos>
    {
        public RequestStatus Actualizar(tbDepartamentos item)
        {
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Dept_Id", item.Dept_Id);
                parametro.Add("Dept_Descripcion", item.Dept_Descripcion);
                parametro.Add("Dept_Usua_Modifica", item.Dept_Usua_Modifica);
                parametro.Add("Dept_Fecha_Modifica", DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Dept_Actualizar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }
        public RequestStatus Eliminarr(string? id)
        {

            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Dept_Id", id);
                var result = db.Execute(ScriptBaseDatos.Dept_Eliminar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }
        public RequestStatus Eliminar(int? id)
        {
            throw new NotImplementedException();
        }

        public tbDepartamentos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbDepartamentos item)
        {
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Dept_Id", item.Dept_Id);
                parametro.Add("Dept_Descripcion", item.Dept_Descripcion);
                parametro.Add("Dept_Usua_Creacion", item.Dept_Usua_Creacion);
                parametro.Add("Dept_Fecha_Creacion", DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Dept_Insertar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public IEnumerable<tbDepartamentos> List()
        {
            List<tbDepartamentos> result = new List<tbDepartamentos>();
            using ( var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                result = db.Query<tbDepartamentos>(ScriptBaseDatos.Dept_Mostrar, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public IEnumerable<tbMunicipios> ListMaster(string Dept_Id)
        {

            List<tbMunicipios> result = new List<tbMunicipios>();
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parameters = new { Dept_Id = Dept_Id };
                result = db.Query<tbMunicipios>(ScriptBaseDatos.Dept_VistaMaestra, parameters, commandType: CommandType.Text).ToList();
                return result;
            }
        }
        public IEnumerable<tbDepartamentos> Detalle(string Dept_Id)
        {


            List<tbDepartamentos> result = new List<tbDepartamentos>();
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parameters = new { Dept_Id = Dept_Id };
                result = db.Query<tbDepartamentos>(ScriptBaseDatos.Dept_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
        public IEnumerable<tbMunicipios> ListaMunicipiosID(string id)
        {
 

            List<tbMunicipios> result = new List<tbMunicipios>();
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parameters = new { Dept_Id = id };
                result = db.Query<tbMunicipios>(ScriptBaseDatos.Dept_MuniXDepa, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
    }
}
