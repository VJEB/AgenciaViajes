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
    public class DetallePorPaqueteRepositorio: IRepository<tbDetallePorPaquete>
    {
        public RequestStatus Actualizar(tbDetallePorPaquete item)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Eliminar(int? id)
        {
            throw new NotImplementedException();
        }

        public tbDetallePorPaquete Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbDetallePorPaquete item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbDetallePorPaquete> List()
        {
            List<tbDetallePorPaquete> result = new List<tbDetallePorPaquete>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbDetallePorPaquete>(ScriptBaseDatos.DePa_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }
    }
}
