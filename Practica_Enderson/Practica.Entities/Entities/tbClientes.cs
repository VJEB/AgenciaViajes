﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Agencia.Entities.Entities
{
    public partial class tbClientes
    {
        public tbClientes()
        {
            tbPaquetes = new HashSet<tbPaquetes>();
            tbUsuarios = new HashSet<tbUsuarios>();
        }

        public int Clie_Id { get; set; }
        public int? Clie_DNI { get; set; }
        public string Clie_Nombre { get; set; }
        public string Clie_Apellido { get; set; }
        public string Clie_Sexo { get; set; }
        public int? Clie_Telefono { get; set; }
        public int? EsCi_Id { get; set; }
        public string Ciud_Id { get; set; }
        public int? Clie_Usua_Creacion { get; set; }
        public DateTime? Clie_Fecha_Creacion { get; set; }
        public int? Clie_Usua_Modifica { get; set; }
        public DateTime? Clie_Fecha_Modifica { get; set; }
        public bool? Clie_Estado { get; set; }

        public virtual tbCiudades Ciud { get; set; }
        public virtual tbUsuarios Clie_Usua_CreacionNavigation { get; set; }
        public virtual tbUsuarios Clie_Usua_ModificaNavigation { get; set; }
        public virtual tbEstadosCiviles EsCi { get; set; }
        public virtual ICollection<tbPaquetes> tbPaquetes { get; set; }
        public virtual ICollection<tbUsuarios> tbUsuarios { get; set; }
    }
}