﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Agencia.Entities.Entities
{
    public partial class tbPagosTarjetas
    {
        public tbPagosTarjetas()
        {
            tbPersonasPorTarjetas = new HashSet<tbPersonasPorTarjetas>();
        }

        public int PaTa_Id { get; set; }
        public string PaTa_NumeroTarjeta { get; set; }
        public string PaTa_Descripcion { get; set; }
        public string PaTa_NombrePropietario { get; set; }
        public string PaTa_MesVencimiento { get; set; }
        public string PaTa_AnhioVencimiento { get; set; }
        public int? PaTa_Usua_Creacion { get; set; }
        public DateTime? PaTa_Fecha_Creacion { get; set; }
        public int? PaTa_Usua_Modifica { get; set; }
        public DateTime? PaTa_Fecha_Modifica { get; set; }

        public virtual tbUsuarios PaTa_Usua_CreacionNavigation { get; set; }
        public virtual tbUsuarios PaTa_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbPersonasPorTarjetas> tbPersonasPorTarjetas { get; set; }
    }
}