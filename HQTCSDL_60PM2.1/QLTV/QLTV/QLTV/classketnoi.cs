using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
namespace QLTV
{
    class ClassKetNoi
    {
        SqlConnection con;
        string connect = @"Data Source=DESKTOP-B1HTTG8\SQLEXPRESS;Initial Catalog=QLTV;Integrated Security=True";
        DataTable dt;

        public SqlConnection Openconnect()
        {
            con = new SqlConnection(connect);
            if (con.State == ConnectionState.Closed)
                con.Open();
            return con;
        }
        public SqlConnection Closeconnect()
        {
            con = new SqlConnection(connect);
            if (con.State == ConnectionState.Open)
                con.Close();
            return con;
        }
    }
}
