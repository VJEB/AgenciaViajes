﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Agencia.Entities.Entities
{
    public partial class tbFotografiasPorHabitacion
    {
        public int FoHa_Id { get; set; }
        public string FoHa_UrlImagen { get; set; }
        public int HaHo_Id { get; set; }

        public virtual tbHabitacionesPorHotel HaHo { get; set; }
    }
}