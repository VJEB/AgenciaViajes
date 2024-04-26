﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica.DataAcces.Repositorio
{
    public class ScriptBaseDatos
    {

        public static string Viaj_Mostrar = "[Agen].[SP_Viajes_Mostrar]";

        public static string Rese_Mostrar = "[Agen].[SP_Reservaciones_Mostrar]";


        #region Usuarios
        public static string Usua_Mostrar = "Acce.SP_Usuarios_Mostrar";
        public static string Usua_Mostrar2 = "Acce.SP_Usuarios_Mostrar2";
        public static string Usua_MostrarPorUsuario = "Acce.SP_Usuarios_MostrarPorUsuario";
        public static string Usua_Insertar = "Acce.SP_Usuarios_Insertar";
        public static string Usua_Actualizar = "Acce.SP_Usuarios_Actualizar";
        public static string Usua_Codigo = "[Acce].[SP_Usuarios_ActualizarCodigoVerificacion]";
        public static string Usua_ValidarPin = "[Acce].[SP_Usuarios_ValidarPin]";
        public static string Usua_Eliminar = "Acce.SP_Usuarios_Eliminar";
        public static string Usua_Detalles = "Acce.SP_Usuarios_Llenar";
        public static string Usua_Reestablecer = "[Acce].[SP_Usuarios_Reestablecer]";
        public static string Usua_Inicio = "Acce.SP_Usuarios_InicioSesion";
        #endregion

        #region Roles
        public static string Rol_Mostrar = "Acce.SP_Roles_Mostrar";
        public static string Rol_Insertar = "Acce.SP_Roles_Insertar";
        public static string Rol_Actualizar = "Acce.SP_Roles_Actualizar";
        public static string Rol_Eliminar = "Acce.SP_Roles_Eliminar";
        public static string Rol_Detalles = "Acce.SP_Roles_Llenar";
        #endregion

        #region Paises
        public static string Pais_Mostrar = "Gral.SP_Paises_Mostrar";
        #endregion
        
        #region Estados
        public static string Esta_Mostrar = "Gral.SP_Estados_Mostrar";
        #endregion


        #region Ciudades
        public static string Ciud_Mostrar = "Gral.SP_Ciudades_Mostrar";
        #endregion

        #region Clientes
       
        public static string Pers_Insertar = "Gral.SP_Personas_Insertar";
        public static string Pers_Detalles = "Gral.SP_Personas_Llenar";
        public static string Pers_Tarjetas = "[Vent].[SP_PersonasPorTarjetas_Mostrar]";
        #endregion

        #region Paquetes
        public static string Paque_Mostrar = "[Agen].[SP_Paquetes_Mostrar]";
        public static string Paque_MostrarDefault = "[Agen].[SP_Paquetes_MostrarDefault]";
        public static string Paque_Insertar = "[Agen].[SP_Paquetes_Insertar]";
        public static string Paque_Actualizar = "[Agen].[SP_Paquetes_Actualizar]";
        public static string Paque_Eliminar = "[Agen].[SP_Paquetes_Eliminar]";
        public static string Paque_Llenar = "[Agen].[SP_Paquetes_Llenar]";
        #endregion

        #region Detalles Paquetes
        public static string DePa_Insertar = "[Agen].[SP_DetallePorPaquete_Insertar]";
        public static string Rese_Insertar = "[Agen].[SP_Reservaciones_Insertar]";
        public static string Viaj_Insertar = "[Agen].[SP_Viajes_Insertar]";
        public static string DePa_Actualizar = "[Agen].[SP_DetallePorPaquete_Actualizar]";
        public static string DePa_Eliminar = "[Agen].[SP_DetallePorPaquete_Eliminar]";
        public static string DePa_Llenar = "[Agen].[SP_DetallePorPaquete_Llenar]";
        #endregion

        #region Habitaciones
        public static string Habi_Mostrar = "";
        public static string FoHa_Mostrar = "[Agen].[SP_FotografiasPorHabitacion_Mostrar]";
        public static string HaHo_Mostrar = "[Agen].[SP_HabitacionesPorHotel_Mostrar]";
        public static string TiCa_Mostrar = "[Gral].[SP_TiposDeCamas_Mostrar]";
        #endregion

        public static string HaCa_Mostrar = "[Agen].[SP_HabitacionesCategorias_Mostrar]";

        #region Hoteles
        public static string Hote_Mostrar = "[Agen].[SP_Hoteles_Mostrar]";
        public static string Hote_Fotografias = "[Agen].[SP_FotografiasPorHotel_Mostrar]";
        #endregion

        #region Transportes
        public static string Tran_Mostrar = "[Agen].[SP_Transportes_Mostrar]";
        public static string TiTr_Mostrar = "[Gral].[SP_TiposDeTransportes_Mostrar]";
        #endregion
 
        #region Estados Civiles
        public static string EsCi_Mostrar = "Gral.SP_EstadosCiviles_Mostrar";
        #endregion


        #region Facturas
        public static string Fact_Insertar = "Vent.SP_Facturas_Insertar";
        public static string Fact_InsertarDetalle = "[Vent].[SP_FacturasDetalle_Insertar]";

        public static string Fact_Mostrar = "Vent.SP_Facturas_Mostrar";

        public static string Fact_Actualizar = "Vent.SP_Facturas_Actualizar";
        #endregion
        public static string Meto_Mostrar = "[Gral].[SP_MetodosPagos_Mostrar]";

        #region Dashboards
        public static string Dash_CiudDestino = "[Agen].[SP_EstadosCivilesQueMasViajan_Dashboard]";
        public static string Dash_CiudHospedaje = "[Agen].[SP_CiudadMasTransitada_Dashboard]";
        public static string Dash_SexoDestino = "[Agen].[SP_SexoQueMasViaja_Dashboard]";
        public static string Dash_HotelesReservados = "[Agen].[SP_HotelesMasReservados_Dashboard]";
        #endregion
    }

}
