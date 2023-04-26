using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
namespace QLTV
{
    public partial class KhachHang : Form
    {
        SqlConnection connection;
        SqlCommand command;
        string str = @"Data Source=DESKTOP-B1HTTG8\SQLEXPRESS;Initial Catalog=QLTV;Integrated Security=True";
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable table = new DataTable();
        void loaddata()
        {
            command = connection.CreateCommand();
            command.CommandText = "Select * from DocGia";
            adapter.SelectCommand = command;
            table.Clear();
            adapter.Fill(table);
            dgvttkh.DataSource = table;
        }
        public KhachHang()
        {
            InitializeComponent();
        }

        private void KhachHang_Load(object sender, EventArgs e)
        {
            connection = new SqlConnection(str);
            connection.Open();
            loaddata();
        }

        private void btTimKiem_Click(object sender, EventArgs e)
        {
            String MaNv = txtTimKiem.Text;
            connection = new SqlConnection(str);
            connection.Open();
            command = connection.CreateCommand();
            command.CommandText = "Select * from DocGia Where MaDocGia='" + MaNv + "'";
            adapter.SelectCommand = command;
            table.Clear();
            adapter.Fill(table);
            dgvttkh.DataSource = table;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Quanly f = new Quanly();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }
    }
}
