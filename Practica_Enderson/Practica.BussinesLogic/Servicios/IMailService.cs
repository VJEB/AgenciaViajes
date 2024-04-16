using Agencia.Common.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Agencia.BussinesLogic.Servicios
{
    public interface IMailService
    {
        bool SendMail(MailData mailData);
    }
}
