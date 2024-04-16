using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica.DataAcces.Repositorio
{
    interface IRepository<T>
    {
        public IEnumerable<T> List();

        public RequestStatus Insertar(T item);

        public RequestStatus Actualizar(T item);

        public RequestStatus Eliminar(int? id);

        public T Find(int? id);
    }
}
