using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
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
        [NotMapped]
        public string HorT_FechaYhora { get; set; }
        public int? Paqu_Id { get; set; }
        public int? Viaj_Usua_Creacion { get; set; }
        public DateTime? Viaj_Fecha_Creacion { get; set; }
        public int? Viaj_Usua_Modifica { get; set; }
        public DateTime? Viaj_Fecha_Modifica { get; set; }
        [NotMapped]
        public string PuntoInicio { get; set; }
        [NotMapped]
        public string PuntoFinal { get; set; }
        [NotMapped]
        public string EstadoInicio { get; set; }
        [NotMapped]
        public string EstadoFinal { get; set; }
        [NotMapped]
        public string PaisInicio { get; set; }
        [NotMapped]
        public string PaisFinal { get; set; }
        [NotMapped]
        public double Pais_PorcentajeImpuesto { get; set; }
        [NotMapped]
        public string Impu_Descripcion { get; set; }
    }
}
