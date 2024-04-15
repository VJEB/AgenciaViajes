using Microsoft.Extensions.DependencyInjection;
using Practica.DataAcces;
using Practica.DataAcces.Context;
using Practica.DataAcces.Repositorio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica.BussinesLogic.Servicios
{
    public static class ServicioConfiguracion
    {
        public static void DataAcces(this IServiceCollection service ,string conn )
        {
            service.AddScoped<DepartamentoRepositorio>();
            service.AddScoped<MunicipioRepositorio>();
            service.AddScoped<EstadoCivilRepositorio>();
            service.AddScoped<UsuarioRepositorio>();
            service.AddScoped<RolRepositorio>();
            service.AddScoped<CargoRepositorio>();
            service.AddScoped<ClienteRepositorio>();
            service.AddScoped<EmpleadoRepositorio>();
            PracticaContext.BuildConnectionString(conn);
        }
        public static void BussinesLogic(this IServiceCollection service)
        {
            service.AddScoped<GeneralServicio>();
            service.AddScoped<AccesoServicio>();
        }

    }

}
