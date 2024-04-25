using Microsoft.Extensions.DependencyInjection;
using Practica.DataAcces;
using Agencia.DataAcces.Context;
using Practica.DataAcces.Repositorio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Practica.BussinesLogic.Servicios;
using Agencia.DataAcces.Repositorio;

namespace Agencia.BussinesLogic.Servicios
{
    public static class ServicioConfiguracion
    {
        public static void DataAcces(this IServiceCollection service ,string conn )
        {
            service.AddScoped<PaisRepositorio>();
            service.AddScoped<EstadoRepositorio>();
            service.AddScoped<CiudadRepositorio>();
            service.AddScoped<EstadoCivilRepositorio>();
            service.AddScoped<UsuarioRepositorio>();
            service.AddScoped<RolRepositorio>();
            service.AddScoped<DetallePorPaqueteRepositorio>();
            service.AddScoped<HabitacionRepositorio>();
            service.AddScoped<HabitacionesCategoriasRepositorio>();
            service.AddScoped<HotelRepositorio>();
            service.AddScoped<PaqueteRepositorio>();
            service.AddScoped<TransporteRepositorio>();
            service.AddScoped<PersonaRepositorio>();
            service.AddScoped<FacturaRepositorio>(); 

            AgenciaContext.BuildConnectionString(conn);
        }
        public static void BussinesLogic(this IServiceCollection service)
        {
            service.AddScoped<GeneralServicio>();
            service.AddScoped<AccesoServicio>();
            service.AddScoped<AgenciaServicio>();
            service.AddScoped<VentaServicio>();
        }

    }

}
