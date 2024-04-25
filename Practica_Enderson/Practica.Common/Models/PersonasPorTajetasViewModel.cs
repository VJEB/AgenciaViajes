using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica.Common.Models
{
    public class PersonasPorTajetasViewModel
    {
        public int PeTa_Id { get; set; }
        public int? Pers_Id { get; set; }
        public int? PaTa_Id { get; set; }
        [NotMapped]
        public string PaTa_Descripcion { get; set; }

        [NotMapped]
        public string PaTa_NumeroTarjeta { get; set; }
    }
}
