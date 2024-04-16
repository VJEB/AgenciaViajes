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
    public class HabitacionRepositorio : IRepository<tbHabitaciones>
    {
        public RequestStatus Actualizar(tbHabitaciones item)
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

        public RequestStatus Insertar(tbHabitaciones item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbHabitaciones> List()
        {
            List<tbHabitaciones> result = new List<tbHabitaciones>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbHabitaciones>(ScriptBaseDatos.Habi_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }
        public IEnumerable<tbHabitacionesPorHotel> HabitacionesPorHotelList()
        {
            List<tbHabitacionesPorHotel> result = new List<tbHabitacionesPorHotel>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbHabitacionesPorHotel>(ScriptBaseDatos.HaHo_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }

        public IEnumerable<tbFotografiasPorHabitacion> FotosPorHabitacionList()
        {
            List<tbFotografiasPorHabitacion> result = new List<tbFotografiasPorHabitacion>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbFotografiasPorHabitacion>(ScriptBaseDatos.FoHa_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }

        public IEnumerable<tbTiposDeCamas> TiposCamasList()
        {
            List<tbTiposDeCamas> result = new List<tbTiposDeCamas>();
            using (var db = new SqlConnection(AgenciaContext.ConnectionString))
            {
                result = db.Query<tbTiposDeCamas>(ScriptBaseDatos.TiCa_Mostrar, commandType: CommandType.Text).ToList();
                return result;
            }
        }
    }
}
