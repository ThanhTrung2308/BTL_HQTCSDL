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
    public partial class ThemKhachHang : Form
    {
        SqlConnection connection;
        SqlCommand command;
        string str = @"Data Source=DESKTOP-B1HTTG8\SQLEXPRESS;Initial Catalog=QLTV;Integrated Security=True";
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable table = new DataTable();
        public ThemKhachHang()
        {
            InitializeComponent();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "INSERT INTO DocGia Values('" + txtMaKhachHang.Text + "','" + txtTenKhachHang.Text + "','" + txtSDT.Text + "','" + txtDiaChi.Text + "','" + txtCMT.Text + "','" + datetimeNgaySinh.Text + "','" + txtGioiTinh.Text + "',)";
            command.ExecuteNonQuery();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            ThuThu f = new ThuThu();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }
    }
}
