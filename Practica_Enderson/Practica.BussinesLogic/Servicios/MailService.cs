using Agencia.Common.Models;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Agencia.API.Configuration;
using MimeKit;
using MailKit.Net.Smtp;
using SistemaAsilos.BussinesLogic;
using Practica.DataAcces.Repositorio;
using Agencia.Entities.Entities;

namespace Agencia.BussinesLogic.Servicios
{
    public class MailService : IMailService
    {
        private readonly MailSettings _mailSettings;
        private readonly UsuarioRepositorio _usuarioRepositorio;

        public MailService(IOptions<MailSettings> mailSettingsOptions, UsuarioRepositorio usuarioRepositorio)
        {
            _mailSettings = mailSettingsOptions.Value;
            _usuarioRepositorio = usuarioRepositorio;

        }

        public ServiceResult SendMail(MailData mailData)
        {
            var result = new ServiceResult();
            try
            {
                using (MimeMessage emailMessage = new MimeMessage())
                {
                    MailboxAddress emailFrom = new MailboxAddress(_mailSettings.SenderName, _mailSettings.SenderEmail);
                    emailMessage.From.Add(emailFrom);
                    MailboxAddress emailTo = new MailboxAddress(mailData.EmailToName, mailData.EmailToId);
                    emailMessage.To.Add(emailTo);

                    emailMessage.Subject = "PIN de verificación";

                    BodyBuilder emailBodyBuilder = new BodyBuilder();
                    
                    Random generator = new Random();
                    var codigo = generator.Next(0, 1000000).ToString("D6");
                    _usuarioRepositorio.ActualizarCodigoVerificacion(Convert.ToInt32(mailData.EmailSubject), codigo);
                    emailBodyBuilder.TextBody = codigo;

                    emailMessage.Body = emailBodyBuilder.ToMessageBody();
                    using (SmtpClient mailClient = new SmtpClient())
                    {
                        mailClient.Connect(_mailSettings.Server, _mailSettings.Port, MailKit.Security.SecureSocketOptions.StartTls);
                        mailClient.Authenticate(_mailSettings.UserName, _mailSettings.Password);
                        mailClient.Send(emailMessage);
                        mailClient.Disconnect(true);
                    }
                }
                return result.Ok("Correo enviado");
            }
            catch (Exception ex)
            {
                return result.Error("Error al enviar el correo");
            }
        }
    }
}
