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
    public class EmpleadoRepositorio : IRepository<tbEmpleados>
    {
        public RequestStatus Actualizar(tbEmpleados item)
        {
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Empl_Id", item.Empl_Id);
                parametro.Add("Empl_DNI", item.Empl_DNI);
                parametro.Add("Empl_Nombre", item.Empl_Nombre);
                parametro.Add("Empl_Apellido", item.Empl_Apellido);
                parametro.Add("Empl_Sexo", item.Empl_Sexo);
                parametro.Add("Carg_Id", item.Carg_Id);
                parametro.Add("Esta_Id", item.Esta_Id);
                parametro.Add("Muni_Id", item.Muni_Id);
                parametro.Add("Empl_Usua_Modifica", item.Empl_Usua_Modifica);
                parametro.Add("Empl_Fecha_Modifica", DateTime.Now);

                var result = db.Execute(ScriptBaseDatos.Empl_Actualizar,
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
                parametro.Add("Empl_Id", id);
                var result = db.Execute(ScriptBaseDatos.Empl_Eliminar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public tbEmpleados find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbEmpleados item)
        {
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();

                parametro.Add("Empl_DNI", item.Empl_DNI);
                parametro.Add("Empl_Nombre", item.Empl_Nombre);
                parametro.Add("Empl_Apellido", item.Empl_Apellido);
                parametro.Add("Empl_Sexo", item.Empl_Sexo);
                parametro.Add("Carg_Id", item.Carg_Id);
                parametro.Add("Esta_Id", item.Esta_Id);
                parametro.Add("Muni_Id", item.Muni_Id);
                parametro.Add("Empl_Usua_Creacion", item.Empl_Usua_Creacion);
                parametro.Add("Empl_Fecha_Creacion", DateTime.Now);
                var result = db.Execute(ScriptBaseDatos.Empl_Insertar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );


                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public IEnumerable<tbEmpleados> List()
        {
            

            List<tbEmpleados> result = new List<tbEmpleados>();
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                result = db.Query<tbEmpleados>(ScriptBaseDatos.Empl_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }
        public IEnumerable<tbEmpleados> ObtenerEmpleID(int Empl_Id)
        {


            List<tbEmpleados> result = new List<tbEmpleados>();
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parameters = new { Empl_Id = Empl_Id };
                result = db.Query<tbEmpleados>(ScriptBaseDatos.Empl_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
        public IEnumerable<tbEmpleados> Detalle(int Empl_Id)
        {


            List<tbEmpleados> result = new List<tbEmpleados>();
            using (var db = new SqlConnection(PracticaContext.ConnectionString))
            {
                var parameters = new { Empl_Id = Empl_Id };
                result = db.Query<tbEmpleados>(ScriptBaseDatos.Empl_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public tbEmpleados Find(int? id)
        {
            throw new NotImplementedException();
        }
    }
}
