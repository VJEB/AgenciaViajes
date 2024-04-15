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

        #region Departamentos
        public static string Dept_Mostrar = "Gral.SP_Departamentos_Mostrar";
        public static string Dept_Insertar = "Gral.SP_Departamentos_Insertar";
        public static string Dept_Actualizar = "Gral.SP_Departamentos_Actualizar";
        public static string Dept_Eliminar = "Gral.SP_Departamentos_Eliminar";
        public static string Dept_Detalles = "Gral.SP_Departamentos_Llenar";
        public static string Dept_VistaMaestra = "[Gral].[SP_Departamentos_VistaMaster] ";
        public static string Dept_MuniXDepa = "[Gral].[SP_Municipios_MostrarPorDepartamento]";
        #endregion


        #region Municipios
        public static string Muni_Mostrar = "Gral.SP_Municipios_Mostrar";
        public static string Muni_Insertar = "Gral.SP_Municipios_Insertar";
        public static string Muni_Actualizar = "Gral.SP_Municipios_Actualizar";
        public static string Muni_Eliminar = "Gral.SP_Municipios_Eliminar";
        public static string Muni_Detalles = "Gral.SP_Municipios_Detalles";
        #endregion

        #region Clientes
        public static string Clie_Mostrar = "Gral.SP_Clientes_Mostrar";
        public static string Clie_Insertar = "Gral.SP_Clientes_Insertar";
        public static string Clie_Actualizar = "Gral.SP_Clientes_Actualizar";
        public static string Clie_Eliminar = "Gral.SP_Clientes_Eliminar";
        public static string Clie_Detalles = "Gral.SP_Clientes_Llenar";
        #endregion

        #region Empleados
        public static string Empl_Mostrar = "Gral.SP_Empleados_Mostrar";
        public static string Empl_Insertar = "Gral.SP_Empleados_Insertar";
        public static string Empl_Actualizar = "Gral.SP_Empleados_Actualizar";
        public static string Empl_Eliminar = "Gral.SP_Empleados_Eliminar";
        public static string Empl_Detalles = "Gral.SP_Empleados_Llenar";
        #endregion

        #region Estados Civiles
        public static string Esta_Mostrar = "Gral.SP_EstadosCiviles_Mostrar";
        public static string Esta_Insertar = "Gral.SP_EstadosCiviles_Insertar";
        public static string Esta_Actualizar = "Gral.SP_EstadosCiviles_Actualizar";
        public static string Esta_Eliminar = "Gral.SP_EstadosCiviles_Eliminar";
        public static string Esta_Detalles = "Gral.SP_EstadosCiviles_Llenar";
        #endregion

        #region Cargos
        public static string Carg_Mostrar = "Gral.SP_Cargos_Mostrar";
        public static string Carg_Insertar = "Gral.SP_Cargos_Insertar";
        public static string Carg_Actualizar = "Gral.SP_Cargos_Actualizar";
        public static string Carg_Eliminar = "Gral.SP_Cargos_Eliminar";
        public static string Carg_Detalles = "Gral.SP_Cargos_Llenar";
        #endregion
    }

}
