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
    public class HotelRepositorio : IRepository<tbHoteles>
    {
        public RequestStatus Actualizar(tbHoteles item)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Eliminar(int? id)
        {
            throw new NotImplementedException();
        }

        public tbHoteles Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbHoteles item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbHoteles> List()
        {
            List<tbHoteles> result = new List<tbHoteles>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbHoteles>(ScriptBaseDatos.Hote_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }

        
    }
}
