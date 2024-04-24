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


        public (RequestStatus,int) Insertar(tbPersonas item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();

                parametro.Add("Pers_DNI", item.Pers_DNI);
                parametro.Add("Pers_Pasaporte", item.Pers_Pasaporte);
                parametro.Add("Pers_Nombre", item.Pers_Nombre);
                parametro.Add("Pers_Apellido", item.Pers_Apellido);
                parametro.Add("Pers_Sexo", item.Pers_Sexo);
                parametro.Add("Pers_Telefono", item.Pers_Telefono);
                parametro.Add("EsCi_Id", item.EsCi_Id);
                parametro.Add("Ciud_Id", item.Ciud_Id);
                parametro.Add("Pers_Usua_Creacion", item.Pers_Usua_Creacion);
                parametro.Add("Pers_Fecha_Creacion", item.Pers_Fecha_Creacion);
                parametro.Add("Pers_Id", dbType: DbType.Int32, direction: ParameterDirection.Output);

                 var result = db.QueryFirst(ScriptBaseDatos.Pers_Insertar,
                    parametro,
                    commandType: CommandType.StoredProcedure
                    );

                int perso = 0;
                if (result.Resultado == 1)
                {
                    perso = parametro.Get<int>("Pers_Id");
                }

                return (new RequestStatus { CodeStatus = result.Resultado }, perso);
            }
        }

        //public IEnumerable<tbPersonas> List()
        //{
        //    List<tbPersonas> result = new List<tbPersonas>();
        //    using (var db = new SqlConnection(AgenciaContext.ConnectionString))
        //    {
        //        result = db.Query<tbPersonas>(ScriptBaseDatos.Clie_Mostrar, commandType: CommandType.StoredProcedure).ToList();
        //        return result;
        //    }
        //}

        public IEnumerable<tbPersonasPorTarjetas> CargarTarjetas(int Pers_Id)
        {


            List<tbPersonasPorTarjetas> result = new List<tbPersonasPorTarjetas>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Pers_Id = Pers_Id };
                result = db.Query<tbPersonasPorTarjetas>(ScriptBaseDatos.Pers_Tarjetas, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
        public IEnumerable<tbPersonas> Detalle(int Pers_Id)
        {

            List<tbPersonas> result = new List<tbPersonas>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Pers_Id = Pers_Id };
                result = db.Query<tbPersonas>(ScriptBaseDatos.Pers_Detalles, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public IEnumerable<tbPersonas> List()
        {
            throw new NotImplementedException();
        }

        RequestStatus IRepository<tbPersonas>.Insertar(tbPersonas item)
        {
            throw new NotImplementedException();
        }
    }
}
