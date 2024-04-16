using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica.Common.Models
{
    public class UsuarioViewModel
    {

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
        public int? Clie_Id { get; set; }
    }
}
