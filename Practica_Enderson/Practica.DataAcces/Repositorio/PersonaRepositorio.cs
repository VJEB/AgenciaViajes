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
    public class PersonaRepositorio : IRepository<tbPersonas>
    {
        public RequestStatus Actualizar(tbPersonas item)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Eliminar(int? id)
        {
            throw new NotImplementedException();
        }

        //public RequestStatus Actualizar(tbPersonas item)
        //{
        //    //using (var db = new SqlConnection(AgenciaContext.ConnectionString))
        //    //{
        //    //    var parametro = new DynamicParameters();
        //    //    parametro.Add("Clie_Id", item.Clie_Id);
        //    //    parametro.Add("Clie_DNI", item.Clie_DNI);
        //    //    parametro.Add("Clie_Nombre", item.Clie_Nombre);
        //    //    parametro.Add("Clie_Apellido", item.Clie_Apellido);
        //    //    parametro.Add("Clie_Sexo", item.Clie_Sexo);
        //    //    parametro.Add("Clie_Telefono", item.Clie_Telefono);
        //    //    parametro.Add("EsCi_Id", item.EsCi_Id);
        //    //    parametro.Add("Ciud_Id", item.Ciud_Id);
        //    //    parametro.Add("Clie_Usua_Modifica", item.Clie_Usua_Modifica);
        //    //    parametro.Add("Clie_Fecha_Modifica", DateTime.Now);

        //    //    var resutl = db.Execute(ScriptBaseDatos.Clie_Actualizar,
        //    //        parametro,
        //    //        commandType: CommandType.StoredProcedure
        //    //        );
        //    //    string mensaje = (resutl == 1) ? "Exito" : "Error";
        //    //    return new RequestStatus { CodeStatus = resutl, MessageStatus = mensaje };
        //    //}
        //}

        //public RequestStatus Eliminar(int? id)
        //{
        //    //using (var db = new SqlConnection(AgenciaContext.ConnectionString))
        //    //{
        //    //    var parametro = new DynamicParameters();
        //    //    parametro.Add("Clie_Id", id);
        //    //    var result = db.Execute(ScriptBaseDatos.Clie_Eliminar,
        //    //        parametro,
        //    //        commandType: CommandType.StoredProcedure
        //    //        );
        //    //    string mensaje = (result == 1) ? "Exito" : "Error";
        //    //    return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
        //    //}
        //}

        public tbPersonas Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbPersonas item)
        {
            throw new NotImplementedException();
        }

        //public RequestStatus Insertar(tbPersonas item)
        //{
        //    //using (var db = new SqlConnection(AgenciaContext.ConnectionString))
        //    //{
        //    //    var parametro = new DynamicParameters();

        //    //    parametro.Add("Clie_DNI", item.Clie_DNI);
        //    //    parametro.Add("Clie_Nombre", item.Clie_Nombre);
        //    //    parametro.Add("Clie_Apellido", item.Clie_Apellido);
        //    //    parametro.Add("Clie_Sexo", item.Clie_Sexo);
        //    //    parametro.Add("Clie_Telefono", item.Clie_Telefono);
        //    //    parametro.Add("EsCi_Id", item.EsCi_Id);
        //    //    parametro.Add("Ciud_Id", item.Ciud_Id);

        //    //    parametro.Add("Clie_Usua_Creacion", item.Clie_Usua_Creacion);
        //    //    parametro.Add("Clie_Fecha_Creacion", DateTime.Now);


        //    //    var result = db.QueryFirst(ScriptBaseDatos.Clie_Insertar,
        //    //        parametro,
        //    //         commandType: CommandType.StoredProcedure
        //    //        );

        //    //    return result;
        //    //}
        //}

        public IEnumerable<tbPersonas> List()
        {
            List<tbPersonas> result = new List<tbPersonas>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbPersonas>(ScriptBaseDatos.Clie_Mostrar, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
        //public IEnumerable<tbPersonas> Detalle(int Clie_Id)
        //{

        //    List<tbPersonas> result = new List<tbPersonas>();
        //    using (var db = new SqlConnection(AgenciaContext.ConnectionString))
        //    {
        //        var parameters = new { Clie_Id = Clie_Id };
        //        result = db.Query<tbPersonas>(ScriptBaseDatos.Clie_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
        //        return result;
        //    }
        //}
    }
}
