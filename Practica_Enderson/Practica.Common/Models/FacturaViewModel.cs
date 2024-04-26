using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agencia.Common.Models
{
    public class FacturaViewModel
    {
        public int Fact_Id { get; set; }
        public DateTime? Fact_Fecha { get; set; }
        public int? Meto_Id { get; set; }
        public int? Pago_Id { get; set; }
        public int Pers_Id { get; set; }
        public int? Fact_Usua_Creacion { get; set; }
        public DateTime? Fact_Fecha_Creacion { get; set; }
        public int? Fact_Usua_Modifica { get; set; }
        public DateTime? Fact_Fecha_Modifica { get; set; }
        public bool Fact_Emitida { get; set; }
        [NotMapped]
        public string Meto_Descripcion { get; set; }
        [NotMapped]
        public string Fact_CantidadPaqu { get; set; }
        [NotMapped]
        public string Fdet_Impuesto { get; set; }
        [NotMapped]
        public string Fdet_SubTotal { get; set; }

        [NotMapped]
        public string Fdet_Total { get; set; }
        [NotMapped]
        public string Paqu_Nombre { get; set; }
        [NotMapped]
        public string Paqu_Precio { get; set; }
    }
}
