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

        public RequestStatus Insertar(tbEstados item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbEstados> List(int Pais_Id)
        {
            List<tbEstados> result = new List<tbEstados>();
            using ( var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Pais_Id };
                result = db.Query<tbEstados>(ScriptBaseDatos.Esta_Mostrar, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public IEnumerable<tbEstados> List()
        {
            throw new NotImplementedException();
        }

        tbEstados IRepository<tbEstados>.Find(int? id)
        {
            throw new NotImplementedException();
        }
    }
}
