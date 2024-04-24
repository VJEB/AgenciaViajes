﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

#nullable disable

namespace Agencia.Entities.Entities
{
    public partial class tbHabitacionesCategorias
    {
        public tbHabitacionesCategorias()
        {
            tbFotografiasPorHabitacion2 = new HashSet<tbFotografiasPorHabitacion2>();
            tbHabitacionesPorHotel = new HashSet<tbHabitacionesPorHotel>();
        }

        public int HaCa_Id { get; set; }
        public string HaCa_Nombre { get; set; }
        public int Hote_Id { get; set; }
        public int? Habi_Id { get; set; }
        public decimal HaCa_PrecioPorNoche { get; set; }
        [NotMapped]
        public int Habi_NumCamas { get; set; }
        [NotMapped]

        public int Habi_NumPersonas { get; set; }
        [NotMapped]

        public int TiCa_Id { get; set; }
        [NotMapped]
        public string FoHa_UrlImagen { get; set; }


        public virtual tbHabitaciones Habi { get; set; }
        public virtual tbHoteles Hote { get; set; }
        public virtual ICollection<tbFotografiasPorHabitacion2> tbFotografiasPorHabitacion2 { get; set; }
        public virtual ICollection<tbHabitacionesPorHotel> tbHabitacionesPorHotel { get; set; }
    }
}