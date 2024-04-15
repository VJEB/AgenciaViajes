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
    public class MunicipioRepositorio : IRepository<tbMunicipios>
    {
        public RequestStatus Actualizar(tbMunicipios item)
        {
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Muni_Id", item.Muni_Id);
                parametro.Add("Muni_Descripcion", item.Muni_Descripcion);
                parametro.Add("Dept_Id", item.Dept_Id);
                parametro.Add("Muni_Usua_Modifica", item.Muni_Usua_Modifica);
                parametro.Add("Muni_Fecha_Modifica", DateTime.Now);

                var result = db.QueryFirst(ScriptBaseDatos.Muni_Actualizar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                return result;
            }
        }

        public RequestStatus Eliminar(int? id)
        {
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Muni_Id", id);
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

            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Muni_Id", id);
                var result = db.Execute(ScriptBaseDatos.Muni_Eliminar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public tbMunicipios Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbMunicipios item)
        {
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Muni_Id", item.Muni_Id);
                parametro.Add("Muni_Descripcion", item.Muni_Descripcion);
                parametro.Add("Dept_Id", item.Dept_Id);
                parametro.Add("Muni_Usua_Creacion", item.Muni_Usua_Creacion);
                parametro.Add("Muni_Fecha_Creacion", DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Muni_Insertar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                return new RequestStatus { CodeStatus = result };
            }
        }

        public IEnumerable<tbMunicipios> List()
        {
            List<tbMunicipios> result = new List<tbMunicipios>();
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                result = db.Query<tbMunicipios>(ScriptBaseDatos.Muni_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }

        public IEnumerable<tbMunicipios> Detalle(string Muni_Id)
        {


            List<tbMunicipios> result = new List<tbMunicipios>();
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parameters = new { Muni_Id = Muni_Id };
                result = db.Query<tbMunicipios>(ScriptBaseDatos.Muni_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
    }
}
