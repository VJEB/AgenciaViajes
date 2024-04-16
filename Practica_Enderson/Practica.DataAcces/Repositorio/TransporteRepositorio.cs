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
    public class TransporteRepositorio : IRepository<tbTransportes>
    {
        public RequestStatus Actualizar(tbTransportes item)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Eliminar(int? id)
        {
            throw new NotImplementedException();
        }

        public tbTransportes Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbTransportes item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbTransportes> List()
        {
            List<tbTransportes> result = new List<tbTransportes>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbTransportes>(ScriptBaseDatos.Tran_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }

        public IEnumerable<tbTiposTransportes> TipoTransporteList()
        {
            List<tbTiposTransportes> result = new List<tbTiposTransportes>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbTiposTransportes>(ScriptBaseDatos.TiTr_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }
    }
}
