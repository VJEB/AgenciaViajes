﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
using System;
using System.Collections.Generic;

#nullable disable

namespace Agencia.Entities.Entities
{
    public partial class tbPersonasPorTarjetas
    {
        public int PeTa_Id { get; set; }
        public int? Pers_Id { get; set; }
        public int? PaTa_Id { get; set; }

        public virtual tbPagosTarjetas PaTa { get; set; }
        public virtual tbPersonas Pers { get; set; }
    }
}