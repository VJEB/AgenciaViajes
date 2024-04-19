using Agencia.Common.Models;
using Agencia.Entities.Entities;
using AutoMapper;
using Practica.Common.Models;

namespace Practica.API.Extensiones
{
    public class MappingProfileExtensions : Profile
    {
        public MappingProfileExtensions()
        {
            CreateMap<EstadoViewModel, tbEstados>().ReverseMap();

            CreateMap<PersonaViewModel, tbPersonas>().ReverseMap();
            CreateMap<HabitacionViewModel, tbHabitaciones>().ReverseMap();
            CreateMap<HabitacionPorHotelViewModel, tbHabitacionesPorHotel>().ReverseMap();
            CreateMap<FotografiaPorHabitacionViewModel, tbFotografiasPorHabitacion>().ReverseMap();
            CreateMap<DetallePorPaqueteViewModel, tbDetallePorPaquete>().ReverseMap();
            CreateMap<HotelViewModel, tbHoteles>().ReverseMap();
            CreateMap<TipoCamaViewModel, tbTiposDeCamas>().ReverseMap();
            CreateMap<PaqueteViewModel, tbPaquetes>().ReverseMap();
            CreateMap<TipoTransporteViewModel, tbTiposTransportes>().ReverseMap();
            CreateMap<TransporteViewModel, tbTransportes>().ReverseMap();
            CreateMap<UsuarioViewModel, tbUsuarios>().ReverseMap();
            CreateMap<RolViewModel, tbRoles>().ReverseMap();
            CreateMap<CiudadesViewModel, tbCiudades>().ReverseMap();
            CreateMap<EstadoCivilViewModel, tbEstadosCiviles>().ReverseMap();
        }
    }
}
