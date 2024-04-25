using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agencia.Common.Models
{
    public class ReservacionesViewModel
    {
        public int Rese_Id { get; set; }
        public decimal Rese_Precio { get; set; }
        public int Rese_Cantidad { get; set; }
        public decimal Rese_PrecioTodoIncluido { get; set; }
        public DateTime Rese_FechaEntrada { get; set; }
        public DateTime Rese_FechaSalida { get; set; }
        public int? Rese_NumPersonas { get; set; }
        public string Rese_Observacion { get; set; }
        public int? Paqu_Id { get; set; }
        public int? HaHo_Id { get; set; }
        [NotMapped]
        public int? HaCa_Id { get; set; }
        [NotMapped]
        public int? HabitacionesNecesarias { get; set; }
        [NotMapped]
        public int? Habi_NumPersonas { get; set; }
        public int? Rese_Usua_Creacion { get; set; }
        public DateTime? Rese_Fecha_Creacion { get; set; }
        public int? Rese_Usua_Modifica { get; set; }
        public DateTime? Rese_Fecha_Modifica { get; set; }
    }
}
