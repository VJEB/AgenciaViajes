using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agencia.Common.Models
{
    public class TransporteViewModel
    {
        public int Tran_Id { get; set; }
        public decimal? Tran_Precio { get; set; }
        public int? TiTr_Id { get; set; }
        public string Tran_PuntoInicio { get; set; }
        public string Tran_PuntoFinal { get; set; }
        public int Tran_Usua_Creacion { get; set; }
        public DateTime Tran_Fecha_Creacion { get; set; }
        public int Tran_Usua_Modifica { get; set; }
        public DateTime Tran_Fecha_Modifica { get; set; }
        public bool? Tran_Estado { get; set; }
        [NotMapped]
        public string PuntoInicio { get; set; }
        [NotMapped]
        public string HorT_FechaYhora { get; set; }
        [NotMapped]
        public string PuntoFinal { get; set; }
        [NotMapped]
        public string TiTr_Descripcion { get; set; }
        [NotMapped]
        public string Ciud_UrlImagen { get; set; }
        [NotMapped]
        public double Pais_PorcentajeImpuesto { get; set; }
        [NotMapped]
        public string Impu_Descripcion { get; set; }
        [NotMapped]
        public int Impu_Id { get; set; }
        [NotMapped]
        public int? HorT_Id { get; set; }

    }
}
