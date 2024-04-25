using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agencia.Common.Models
{
    public class ViajesViewModel
    {
        public int Viaj_Id { get; set; }
        public decimal Viaj_Precio { get; set; }
        public int Viaj_Cantidad { get; set; }
        public int? HorT_Id { get; set; }
        public int? Paqu_Id { get; set; }
        public int? Viaj_Usua_Creacion { get; set; }
        public DateTime? Viaj_Fecha_Creacion { get; set; }
        public int? Viaj_Usua_Modifica { get; set; }
        public DateTime? Viaj_Fecha_Modifica { get; set; }
    }
}
