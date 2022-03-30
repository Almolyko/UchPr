using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfApp4
{
    class MyDbContext : DbContext
    {
        public MyDbContext()
                  : base("Server=LAPTOP-4RPQFG8K\\SQLEXPRESS;Database=People;Trusted_Connection=Yes;")
        { }
    }

}
