using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agencia.Common.Models
{
    public class DetallePorPaqueteViewModel
    {
        public int DePa_Id { get; set; }
        public int HaHo_Tran_Id { get; set; }
        public decimal DePa_Precio { get; set; }
        public int Paqu_Id { get; set; }
        public int DePa_Usua_Creacion { get; set; }
        public DateTime DePa_Fecha_Creacion { get; set; }
        public int DePa_Usua_Modifica { get; set; }
        public DateTime DePa_Fecha_Modifica { get; set; }
        public int? DePa_Cantidad { get; set; }
        public int? DePa_NumNoches { get; set; }
        public decimal DePa_PrecioTodoIncluido { get; set; }
    }
}
