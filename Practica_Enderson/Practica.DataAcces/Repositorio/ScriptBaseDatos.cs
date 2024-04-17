using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica.DataAcces.Repositorio
{
    public class ScriptBaseDatos
    {
        #region Usuarios
        public static string Usua_Mostrar = "Acce.SP_Usuarios_Mostrar";
        public static string Usua_Insertar = "Acce.SP_Usuarios_Insertar";
        public static string Usua_Actualizar = "Acce.SP_Usuarios_Actualizar";
        public static string Usua_Codigo = "[Acce].[SP_Usuarios_ActualizarCodigoVerificacion]";
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

        #region Estados
        public static string Esta_Mostrar = "Gral.SP_Estados_Mostrar";
        public static string Dept_Insertar = "Gral.SP_Departamentos_Insertar";
        public static string Dept_Actualizar = "Gral.SP_Departamentos_Actualizar";
        public static string Dept_Eliminar = "Gral.SP_Departamentos_Eliminar";
        public static string Dept_Detalles = "Gral.SP_Departamentos_Llenar";
        public static string Dept_VistaMaestra = "[Gral].[SP_Departamentos_VistaMaster] ";
        public static string Dept_MuniXDepa = "[Gral].[SP_Municipios_MostrarPorDepartamento]";
        #endregion


        #region Ciudades
        public static string Ciud_Mostrar = "Gral.SP_Ciudades_Mostrar";
        public static string Muni_Insertar = "Gral.SP_Municipios_Insertar";
        public static string Muni_Actualizar = "Gral.SP_Municipios_Actualizar";
        public static string Muni_Eliminar = "Gral.SP_Municipios_Eliminar";
        public static string Muni_Detalles = "Gral.SP_Municipios_Detalles";
        #endregion

        #region Clientes
       
        public static string Pers_Insertar = "Gral.SP_Personas_Insertar";
        public static string Pers_Detalles = "Gral.SP_Personas_Llenar";
        public static string Pers_Tarjetas = "[Vent].[SP_PersonasPorTarjetas_Mostrar]";
        #endregion

        #region Paquetes
        public static string Paque_Mostrar = "[Agen].[SP_Paquetes_Mostrar]";
        public static string Paque_Insertar = "[Agen].[SP_Paquetes_Insertar]";
        public static string Paque_Actualizar = "[Agen].[SP_Paquetes_Actualizar]";
        public static string Paque_Eliminar = "[Agen].[SP_Paquetes_Eliminar]";
        public static string Paque_Llenar = "[Agen].[SP_Paquetes_Llenar]";
        #endregion

        #region Detalles Paquetes
        public static string DePa_Insertar = "[Agen].[SP_DetallePorPaquete_Insertar]";
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
        public static string Esta_Insertar = "Gral.SP_EstadosCiviles_Insertar";
        public static string Esta_Actualizar = "Gral.SP_EstadosCiviles_Actualizar";
        public static string Esta_Eliminar = "Gral.SP_EstadosCiviles_Eliminar";
        public static string Esta_Detalles = "Gral.SP_EstadosCiviles_Llenar";
        #endregion

     
    }

}
