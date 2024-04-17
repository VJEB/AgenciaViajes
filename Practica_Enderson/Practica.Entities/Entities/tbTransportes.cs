﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Agencia.Entities.Entities
{
    public partial class tbTransportes
    {
        public tbTransportes()
        {
            tbHorariosTransportes = new HashSet<tbHorariosTransportes>();
        }

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

        public virtual tbTiposTransportes TiTr { get; set; }
        public virtual tbCiudades Tran_PuntoFinalNavigation { get; set; }
        public virtual tbCiudades Tran_PuntoInicioNavigation { get; set; }
        public virtual tbUsuarios Tran_Usua_CreacionNavigation { get; set; }
        public virtual tbUsuarios Tran_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbHorariosTransportes> tbHorariosTransportes { get; set; }
    }
}