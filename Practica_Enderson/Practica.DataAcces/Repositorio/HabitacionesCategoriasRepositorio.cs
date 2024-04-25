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
    public class HabitacionesCategoriasRepositorio : IRepository<tbHabitacionesCategorias>
    {
        public RequestStatus Actualizar(tbHabitacionesCategorias item)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Eliminar(int? id)
        {
            throw new NotImplementedException();
        }

        public tbHabitaciones Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insertar(tbHabitacionesCategorias item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbHabitacionesCategorias> List()
        {
            throw new NotImplementedException();
        }
        public IEnumerable<tbHabitacionesCategorias> HabitacionesCategoriasPorHotel(int Hote_Id)
        {
            List<tbHabitacionesCategorias> result = new List<tbHabitacionesCategorias>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Hote_Id = Hote_Id };
                result = db.Query<tbHabitacionesCategorias>(ScriptBaseDatos.HaCa_Mostrar, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        public IEnumerable<tbFotografiasPorHabitacion> FotosPorHabitacion(int HaHo_Id)
        {
            List<tbFotografiasPorHabitacion> result = new List<tbFotografiasPorHabitacion>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { HaHo_Id = HaHo_Id };
                result = db.Query<tbFotografiasPorHabitacion>(ScriptBaseDatos.FoHa_Mostrar, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }
        public IEnumerable<tbFotografiasPorHabitacion> FotosPorHotel(int Hote_Id)
        {
            List<tbFotografiasPorHabitacion> result = new List<tbFotografiasPorHabitacion>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                var parameters = new { Hote_Id = Hote_Id };
                result = db.Query<tbFotografiasPorHabitacion>(ScriptBaseDatos.Hote_Fotografias, parameters, commandType: CommandType.StoredProcedure).ToList();
                return result;
            }
        }

        tbHabitacionesCategorias IRepository<tbHabitacionesCategorias>.Find(int? id)
        {
            throw new NotImplementedException();
        }
    }
}
