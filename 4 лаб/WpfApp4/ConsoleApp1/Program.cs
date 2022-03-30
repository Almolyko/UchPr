using System;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            using (ApplicationContext db = new ApplicationContext())
            {
                var login = new Microsoft.Data.SqlClient.SqlParameter
                {
                    ParameterName = "@login",
                    SqlDbType = System.Data.SqlDbType.VarChar,
                    Direction = System.Data.ParameterDirection.Input,
                    Size = 50,
                    Value = "Mike"
                };
                var password = new Microsoft.Data.SqlClient.SqlParameter
                {
                    ParameterName = "@password",
                    SqlDbType = System.Data.SqlDbType.VarChar,
                    Direction = System.Data.ParameterDirection.Input,
                    Size = 50,
                    Value = "12345"
                };
                var result = new Microsoft.Data.SqlClient.SqlParameter
                {
                    ParameterName = "@result",
                    SqlDbType = System.Data.SqlDbType.VarChar,
                    Direction = System.Data.ParameterDirection.Output,
                    Size = 250
                };
                db.Database.Exe("UserLogin @login, @password, @result OUTPUT", login, password, result);
                Console.WriteLine(result.Value);
            }

        }
    }
}
