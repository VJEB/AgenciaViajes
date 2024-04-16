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

        public RequestStatus Insertar(tbPaquetes item)
        {
            throw new NotImplementedException();
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
