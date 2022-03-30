using System.Data;

namespace Microsoft
{
    internal class Data
    {
        internal class SqlClient
        {
            internal class SqlParameter
            {
                public string ParameterName { get; set; }
                public SqlDbType SqlDbType { get; set; }
                public ParameterDirection Direction { get; set; }
                public int Size { get; set; }
                public string Value { get; set; }
            }
        }
    }
}