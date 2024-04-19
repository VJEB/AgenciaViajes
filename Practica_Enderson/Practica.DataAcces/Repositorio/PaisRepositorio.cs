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
    public class PaisRepositorio : IRepository<tbPaises>
    {
        public RequestStatus Actualizar(tbPaises item)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Eliminar(int? id)
        {
            throw new NotImplementedException();
        }

        public tbCiudades Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbPaises item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbPaises> List()
        {
            List<tbPaises> result = new List<tbPaises>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbPaises>(ScriptBaseDatos.Pais_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }

        tbPaises IRepository<tbPaises>.Find(int? id)
        {
            throw new NotImplementedException();
        }
    }
}
