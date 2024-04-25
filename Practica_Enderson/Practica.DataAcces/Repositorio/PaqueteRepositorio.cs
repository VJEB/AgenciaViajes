using Agencia.Entities.Entities;
using Dapper;
using Microsoft.Data.SqlClient;
using Practica.DataAcces;
using Practica.DataAcces.Repositorio;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agencia.DataAcces.Repositorio
{
    public class PaqueteRepositorio : IRepository<tbPaquetes>
    {
        public RequestStatus Actualizar(int id,tbPaquetes item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Paqu_Id", id);
                parametro.Add("Paqu_Nombre", item.Paqu_Nombre);
                parametro.Add("Paqu_Precio", item.Paqu_Precio);
                parametro.Add("Paqu_Usua_Modifica", item.Paqu_Usua_Modifica);
                parametro.Add("Paqu_Fecha_Modifica", item.Paqu_Fecha_Modifica);
                
                var result = db.QueryFirst(ScriptBaseDatos.Paque_Actualizar,
                    parametro,
                    commandType: CommandType.StoredProcedure
                    );

                return (new RequestStatus { CodeStatus = result.Resultado });
            }
        }

        public RequestStatus Eliminar(int? id)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Paqu_Id", id);
                var result = db.Execute(ScriptBaseDatos.Paque_Eliminar,
                    parametro,
                     commandType: CommandType.StoredProcedure
                    );

                string mensaje = (result == 1) ? "Exito" : "Error";
                return new RequestStatus { CodeStatus = result, MessageStatus = mensaje };
            }
        }

        public tbPaquetes Find(int? id)
        {
            throw new NotImplementedException();
        }

        public (RequestStatus, int) Insertar(tbPaquetes item)
        {
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parametro = new DynamicParameters();
                parametro.Add("Paqu_Nombre", item.Paqu_Nombre);
                parametro.Add("Pers_Id",item.Pers_Id);
                parametro.Add("Paqu_Usua_Creacion", item.Paqu_Usua_Creacion);
                parametro.Add("Paqu_Fecha_Creacion", item.Paqu_Fecha_Creacion);
                parametro.Add("Paqu_Id", dbType: DbType.Int32, direction: ParameterDirection.Output);
                
                var result = db.QueryFirst(ScriptBaseDatos.Paque_Insertar,
                    parametro,
                    commandType: CommandType.StoredProcedure
                    );


                int paque = 0;
                if (result.Resultado == 1)
                {
                    paque = parametro.Get<int>("Paqu_Id");
                }
                return (new RequestStatus { CodeStatus = result.Resultado }, paque);
            }
        }

        public IEnumerable<tbPaquetes> MostrarPaquetes(int Pers_Id)
        {
            List<tbPaquetes> result = new List<tbPaquetes>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Pers_Id = Pers_Id };
                result = db.Query<tbPaquetes>(ScriptBaseDatos.Paque_Mostrar, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
        public IEnumerable<tbPaquetes> MostrarPaquetesDefault()
        {
            List<tbPaquetes> result = new List<tbPaquetes>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {   
                result = db.Query<tbPaquetes>(ScriptBaseDatos.Paque_MostrarDefault, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
        public IEnumerable<tbPaquetes> Detalle(int Paqu_Id)
        {
            List<tbPaquetes> result = new List<tbPaquetes>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Paqu_Id = Paqu_Id };
                result = db.Query<tbPaquetes>(ScriptBaseDatos.Paque_Llenar, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
        RequestStatus IRepository<tbPaquetes>.Insertar(tbPaquetes item)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Actualizar(tbPaquetes item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbPaquetes> List()
        {
            throw new NotImplementedException();
        }
    }
}
