using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agencia.Common.Models
{
    public class PaqueteViewModel
    {
        public int Paqu_Id { get; set; }
        public string Paqu_Nombre { get; set; }
        public int Pers_Id { get; set; }
        public int Paqu_Usua_Creacion { get; set; }
        public DateTime Paqu_Fecha_Creacion { get; set; }
        public int Paqu_Usua_Modifica { get; set; }
        public DateTime Paqu_Fecha_Modifica { get; set; }
        public int Paqu_Estado { get; set; }
        public decimal Paqu_Precio { get; set; }
    }
}
