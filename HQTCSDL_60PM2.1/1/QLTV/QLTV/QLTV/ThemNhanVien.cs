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
    public partial class ThemNhanVien : Form
    {
        SqlConnection connection;
        SqlCommand command;
        string str = @"Data Source=DESKTOP-B1HTTG8\SQLEXPRESS;Initial Catalog=QLTV;Integrated Security=True";
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable table = new DataTable();
        void loaddata()
        {
            command = connection.CreateCommand();
            command.CommandText = "Select * from Sach"; 
            adapter.SelectCommand = command;
            table.Clear();
            adapter.Fill(table);
            dgvdsnv.DataSource = table;
        }
        public ThemNhanVien()
        {
            InitializeComponent();
        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "INSERT INTO NhanVien Values('" + txtMaNhanVien.Text + "','" + txtMatKhau.Text + "','" + txtHoTen.Text + "','" + txtDiaChi.Text + "','" + txtCMT.Text + "','" + txtLuong.Text + "','" + datetimeNgaySinh.Text + "','" + txtGioiTinh.Text + "','" + txtChucVu.Text + "')";
            command.ExecuteNonQuery();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            String MaNv = txtTimKiemMaNhanVien.Text;
            connection = new SqlConnection(str);
            connection.Open();
            command = connection.CreateCommand();
            command.CommandText = "Select * from Sach Where MaNhanVien='" + MaNv + "'";
            adapter.SelectCommand = command;
            table.Clear();
            adapter.Fill(table);
            dgvdsnv.DataSource = table;
        }

        private void ThemNhanVien_Load(object sender, EventArgs e)
        {
            connection = new SqlConnection(str);
            connection.Open();
            loaddata();
        }
    }
}
