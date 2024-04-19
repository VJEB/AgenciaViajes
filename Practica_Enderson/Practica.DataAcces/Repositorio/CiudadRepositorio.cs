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
    public class CiudadRepositorio : IRepository<tbCiudades>
    {
        public RequestStatus Actualizar(tbCiudades item)
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

        public RequestStatus Insertar(tbCiudades item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbCiudades> List(string Esta_Id)
        {
            List<tbCiudades> result = new List<tbCiudades>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Esta_Id };

                result = db.Query<tbCiudades>(ScriptBaseDatos.Ciud_Mostrar,parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        IEnumerable<tbCiudades> IRepository<tbCiudades>.List()
        {
            throw new NotImplementedException();
        }
       
    }
}
