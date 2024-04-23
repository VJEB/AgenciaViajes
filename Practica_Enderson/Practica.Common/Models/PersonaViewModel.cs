using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica.Common.Models
{
    public class PersonaViewModel
    {

        public int Pers_Id { get; set; }
        public string Pers_DNI { get; set; }
        public string Pers_Nombre { get; set; }
        public string Pers_Apellido { get; set; }
        public string Pers_Sexo { get; set; }
        public int? Pers_Telefono { get; set; }
        public int? EsCi_Id { get; set; }
        public string Ciud_Id { get; set; }
        public int? Pers_Usua_Creacion { get; set; }
        public DateTime? Pers_Fecha_Creacion { get; set; }
        public int? Pers_Usua_Modifica { get; set; }
        public DateTime? Pers_Fecha_Modifica { get; set; }
        public bool? Pers_Habilitado { get; set; }
        public string Pers_Pasaporte { get; set; }
        public string? Pers_Email { get; set; }
        public int? Carg_Id { get; set; }
    }
}
