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
        public RequestStatus Actualizar(tbPaquetes item)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Eliminar(int? id)
        {
            throw new NotImplementedException();
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
                parametro.Add("Paque_Nombre", item.Paqu_Nombre);
                parametro.Add("Pers_Id",item.Pers_Id);
                parametro.Add("Paqu_Usua_Creacion", 1);
                parametro.Add("Paqu_Fecha_Creacion", DateTime.Now);
                parametro.Add("Paqu_Id", dbType: DbType.Int32, direction: ParameterDirection.Output);
                var result = db.Execute(ScriptBaseDatos.Esta_Insertar,
                    parametro,
                    commandType: CommandType.StoredProcedure
                    );


                int paque = 0;
                if (result > 0)
                {
                    paque = parametro.Get<int>("Paqu_Id");
                }

                string mensaje = (result == 1) ? "Exito" : "Error";
                return (new RequestStatus { CodeStatus = result, MessageStatus = mensaje }, paque);
            }
        }

        public IEnumerable<tbPaquetes> List()
        {
            List<tbPaquetes> result = new List<tbPaquetes>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbPaquetes>(ScriptBaseDatos.Paque_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }
    }
}
