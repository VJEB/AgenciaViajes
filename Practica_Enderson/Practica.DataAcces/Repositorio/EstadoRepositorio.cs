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
    public class EstadoRepositorio : IRepository<tbEstados>
    {
        public RequestStatus Actualizar(tbEstados item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Dept_Id", item.Esta_Id);
                parametro.Add("Dept_Descripcion", item.Esta_Descripcion);
                parametro.Add("Dept_Usua_Modifica", item.Esta_Usua_Modifica);
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

            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
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

        public tbCiudades Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbEstados item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Dept_Id", item.Esta_Id);
                parametro.Add("Dept_Descripcion", item.Esta_Descripcion);
                parametro.Add("Dept_Usua_Creacion", item.Esta_Usua_Creacion);
                parametro.Add("Dept_Fecha_Creacion", DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Dept_Insertar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public IEnumerable<tbEstados> List()
        {
            List<tbEstados> result = new List<tbEstados>();
            using ( var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbEstados>(ScriptBaseDatos.Esta_Mostrar, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        //public IEnumerable<tbMunicipios> ListMaster(string Dept_Id)
        //{

        //    List<tbMunicipios> result = new List<tbMunicipios>();
        //    using (var db = new SqlConnection(AgenciaContext.ConnectionString))
        //    {
        //        var parameters = new { Dept_Id = Dept_Id };
        //        result = db.Query<tbMunicipios>(ScriptBaseDatos.Dept_VistaMaestra, parameters, commandType: CommandType.Text).ToList();
        //        return result;
        //    }
        //}
        //public IEnumerable<tbDepartamentos> Detalle(string Dept_Id)
        //{


        //    List<tbDepartamentos> result = new List<tbDepartamentos>();
        //    using (var db = new SqlConnection(AgenciaContext.ConnectionString))
        //    {
        //        var parameters = new { Dept_Id = Dept_Id };
        //        result = db.Query<tbDepartamentos>(ScriptBaseDatos.Dept_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
        //        return result;
        //    }
        //}
        //public IEnumerable<tbMunicipios> ListaMunicipiosID(string id)
        //{
 

        //    List<tbMunicipios> result = new List<tbMunicipios>();
        //    using (var db = new SqlConnection(AgenciaContext.ConnectionString))
        //    {
        //        var parameters = new { Dept_Id = id };
        //        result = db.Query<tbMunicipios>(ScriptBaseDatos.Dept_MuniXDepa, parameters, commandType: CommandType.StoredProcedure).ToList();
        //        return result;
        //    }
        //}

      
        

        tbEstados IRepository<tbEstados>.Find(int? id)
        {
            throw new NotImplementedException();
        }
    }
}
