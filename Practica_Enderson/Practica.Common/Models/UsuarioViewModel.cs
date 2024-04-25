using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica.Common.Models
{
    public class UsuarioViewModel
    {
        [NotMapped]
        public string Rol_Descripcion { get; set; }
        [NotMapped]
        public string Pers_DNI { get; set; }
        [NotMapped]
        public string Persona { get; set; }
        [NotMapped]
        public string Pers_Sexo { get; set; }
        [NotMapped]
        public int Pers_Telefono { get; set; }
        [NotMapped]
        public string Pers_Pasaporte { get; set; }
        [NotMapped]
        public string Pers_Email { get; set; }
        [NotMapped]
        public int Ciud_Id { get; set; }
        [NotMapped]
        public string Ciud_Descripcion { get; set; }
        [NotMapped]
        public int EsCi_Id { get; set; }
        [NotMapped]
        public string EsCi_Descripcion { get; set; }
        [NotMapped]
        public int Carg_Id { get; set; }
        [NotMapped]
        public string Carg_Descripcion { get; set; }
        [NotMapped]
        public int Esta_Id { get; set; }

        [NotMapped]
        public string Esta_Descripcion { get; set; }
        [NotMapped]
        public int Pais_Id { get; set; }
        [NotMapped]
        public string Pais_Descripcion { get; set; }
        public int Usua_Id { get; set; }
        public string Usua_Usuario { get; set; }
        public string Usua_Contra { get; set; }
        public bool? Usua_Admin { get; set; }
        public int? Rol_Id { get; set; }
        public int? Usua_Usua_Creacion { get; set; }
        public DateTime? Usua_Fecha_Creacion { get; set; }
        public int? Usua_Usua_Modifica { get; set; }
        public DateTime? Usua_Fecha_Modifica { get; set; }
        public bool? Usua_Estado { get; set; }
        public int? Pers_Id { get; set; }
        
    }
}
