using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agencia.Common.Models
{
    public  class FacturaDetalleViewModel
    {
        public int Fdet_Id { get; set; }
        public int? Fact_Id { get; set; }
        public int? Paqu_Id { get; set; }
        public int Fact_CantidadPaqu { get; set; }
        public double Fdet_SubTotal { get; set; }
        public double Fdet_Total { get; set; }
        public double? Fdet_Impuesto { get; set; }

    }
}
