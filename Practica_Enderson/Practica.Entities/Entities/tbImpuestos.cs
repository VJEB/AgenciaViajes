﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Agencia.Entities.Entities
{
    public partial class tbImpuestos
    {
        public tbImpuestos()
        {
            tbPaises = new HashSet<tbPaises>();
        }

        public int Impu_Id { get; set; }
        public string Impu_Descripcion { get; set; }
        public int? Impu_Usua_Creacion { get; set; }
        public DateTime? Impu_Fecha_Creacion { get; set; }
        public int? Impu_Usua_Modifica { get; set; }
        public DateTime? Impu_Fecha_Modifica { get; set; }

        public virtual tbUsuarios Impu_Usua_CreacionNavigation { get; set; }
        public virtual tbUsuarios Impu_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbPaises> tbPaises { get; set; }
    }
}