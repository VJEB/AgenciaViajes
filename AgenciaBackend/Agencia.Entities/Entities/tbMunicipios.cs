﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Practica.Entities.Entities
{
    public partial class tbMunicipios
    {
        public tbMunicipios()
        {
            tbClientes = new HashSet<tbClientes>();
            tbEmpleados = new HashSet<tbEmpleados>();
        }

        public string Muni_Id { get; set; }
        public string Muni_Descripcion { get; set; }
        public string Dept_Id { get; set; }
        public int? Muni_Usua_Creacion { get; set; }
        public DateTime? Muni_Fecha_Creacion { get; set; }
        public int? Muni_Usua_Modifica { get; set; }
        public DateTime? Muni_Fecha_Modifica { get; set; }

        public virtual tbDepartamentos Dept { get; set; }
        public virtual tbUsuarios Muni_Usua_CreacionNavigation { get; set; }
        public virtual tbUsuarios Muni_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbClientes> tbClientes { get; set; }
        public virtual ICollection<tbEmpleados> tbEmpleados { get; set; }
    }
}