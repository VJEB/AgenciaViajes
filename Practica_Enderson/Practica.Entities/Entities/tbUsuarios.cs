﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

#nullable disable

namespace Agencia.Entities.Entities
{
    public partial class tbUsuarios
    {
        public tbUsuarios()
        {
            InverseUsua_Usua_CreacionNavigation = new HashSet<tbUsuarios>();
            InverseUsua_Usua_ModificaNavigation = new HashSet<tbUsuarios>();
            tbAirbnbsAirb_Usua_CreacionNavigation = new HashSet<tbAirbnbs>();
            tbAirbnbsAirb_Usua_ModificaNavigation = new HashSet<tbAirbnbs>();
            tbCargosCarg_Usua_CreacionNavigation = new HashSet<tbCargos>();
            tbCargosCarg_Usua_ModificaNavigation = new HashSet<tbCargos>();
            tbDetallePorPaqueteDePa_Usua_CreacionNavigation = new HashSet<tbDetallePorPaquete>();
            tbDetallePorPaqueteDePa_Usua_ModificaNavigation = new HashSet<tbDetallePorPaquete>();
            tbEstadosCivilesEsCi_Usua_CreacionNavigation = new HashSet<tbEstadosCiviles>();
            tbEstadosCivilesEsCi_Usua_ModificaNavigation = new HashSet<tbEstadosCiviles>();
            tbEstadosEsta_Usua_CreacionNavigation = new HashSet<tbEstados>();
            tbEstadosEsta_Usua_ModificaNavigation = new HashSet<tbEstados>();
            tbFacturasFact_Usua_CreacionNavigation = new HashSet<tbFacturas>();
            tbFacturasFact_Usua_ModificaNavigation = new HashSet<tbFacturas>();
            tbHabitacionesHabi_Usua_CreacionNavigation = new HashSet<tbHabitaciones>();
            tbHabitacionesHabi_Usua_ModificaNavigation = new HashSet<tbHabitaciones>();
            tbHotelesHote_Usua_CreacionNavigation = new HashSet<tbHoteles>();
            tbHotelesHote_Usua_ModificaNavigation = new HashSet<tbHoteles>();
            tbImpuestosImpu_Usua_CreacionNavigation = new HashSet<tbImpuestos>();
            tbImpuestosImpu_Usua_ModificaNavigation = new HashSet<tbImpuestos>();
            tbMetodosPagosMeto_Usua_CreacionNavigation = new HashSet<tbMetodosPagos>();
            tbMetodosPagosMeto_Usua_ModificaNavigation = new HashSet<tbMetodosPagos>();
            tbPagosTarjetasPaTa_Usua_CreacionNavigation = new HashSet<tbPagosTarjetas>();
            tbPagosTarjetasPaTa_Usua_ModificaNavigation = new HashSet<tbPagosTarjetas>();
            tbPaisesPais_Usua_CreacionNavigation = new HashSet<tbPaises>();
            tbPaisesPais_Usua_ModificaNavigation = new HashSet<tbPaises>();
            tbPantallasPant_Usua_CreacionNavigation = new HashSet<tbPantallas>();
            tbPantallasPant_Usua_ModificaNavigation = new HashSet<tbPantallas>();
            tbPantallasPorRolesParo_Usua_CreacionNavigation = new HashSet<tbPantallasPorRoles>();
            tbPantallasPorRolesParo_Usua_ModificaNavigation = new HashSet<tbPantallasPorRoles>();
            tbPersonasPers_Usua_CreacionNavigation = new HashSet<tbPersonas>();
            tbPersonasPers_Usua_ModificaNavigation = new HashSet<tbPersonas>();
            tbReservacionesRese_Usua_CreacionNavigation = new HashSet<tbReservaciones>();
            tbReservacionesRese_Usua_ModificaNavigation = new HashSet<tbReservaciones>();
            tbRolesRol_Usua_CreacionNavigation = new HashSet<tbRoles>();
            tbRolesRol_Usua_ModificaNavigation = new HashSet<tbRoles>();
            tbTiposTransportesTiTr_Usua_CreacionNavigation = new HashSet<tbTiposTransportes>();
            tbTiposTransportesTiTr_Usua_ModificaNavigation = new HashSet<tbTiposTransportes>();
            tbTransportesTran_Usua_CreacionNavigation = new HashSet<tbTransportes>();
            tbTransportesTran_Usua_ModificaNavigation = new HashSet<tbTransportes>();
            tbViajesViaj_Usua_CreacionNavigation = new HashSet<tbViajes>();
            tbViajesViaj_Usua_ModificaNavigation = new HashSet<tbViajes>();
        }

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
        [NotMapped]
        public string Persona { get; set; }
        [NotMapped]
        public string Rol_Descripcion { get; set; }
        public string Usua_UrlImagen { get; set; }

        public string Usua_CodigoVerificacion { get; set; }
        [NotMapped]
        public string Pers_Email { get; set; }
        [NotMapped]
        public string Pers_DNI { get; set; }
        [NotMapped]
        public string Pers_Sexo { get; set; }
        [NotMapped]
        public int Pers_Telefono { get; set; }
        [NotMapped]
        public string Pers_Pasaporte { get; set; }
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

        public virtual tbPersonas Pers { get; set; }
        public virtual tbRoles Rol { get; set; }
        public virtual tbUsuarios Usua_Usua_CreacionNavigation { get; set; }
        public virtual tbUsuarios Usua_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbUsuarios> InverseUsua_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbUsuarios> InverseUsua_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbAirbnbs> tbAirbnbsAirb_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbAirbnbs> tbAirbnbsAirb_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbCargos> tbCargosCarg_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbCargos> tbCargosCarg_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbDetallePorPaquete> tbDetallePorPaqueteDePa_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbDetallePorPaquete> tbDetallePorPaqueteDePa_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbEstadosCiviles> tbEstadosCivilesEsCi_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbEstadosCiviles> tbEstadosCivilesEsCi_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbEstados> tbEstadosEsta_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbEstados> tbEstadosEsta_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbFacturas> tbFacturasFact_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbFacturas> tbFacturasFact_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbHabitaciones> tbHabitacionesHabi_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbHabitaciones> tbHabitacionesHabi_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbHoteles> tbHotelesHote_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbHoteles> tbHotelesHote_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbImpuestos> tbImpuestosImpu_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbImpuestos> tbImpuestosImpu_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbMetodosPagos> tbMetodosPagosMeto_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbMetodosPagos> tbMetodosPagosMeto_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbPagosTarjetas> tbPagosTarjetasPaTa_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbPagosTarjetas> tbPagosTarjetasPaTa_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbPaises> tbPaisesPais_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbPaises> tbPaisesPais_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbPantallas> tbPantallasPant_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbPantallas> tbPantallasPant_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbPantallasPorRoles> tbPantallasPorRolesParo_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbPantallasPorRoles> tbPantallasPorRolesParo_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbPersonas> tbPersonasPers_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbPersonas> tbPersonasPers_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbReservaciones> tbReservacionesRese_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbReservaciones> tbReservacionesRese_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbRoles> tbRolesRol_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbRoles> tbRolesRol_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbTiposTransportes> tbTiposTransportesTiTr_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbTiposTransportes> tbTiposTransportesTiTr_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbTransportes> tbTransportesTran_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbTransportes> tbTransportesTran_Usua_ModificaNavigation { get; set; }
        public virtual ICollection<tbViajes> tbViajesViaj_Usua_CreacionNavigation { get; set; }
        public virtual ICollection<tbViajes> tbViajesViaj_Usua_ModificaNavigation { get; set; }
    }
}