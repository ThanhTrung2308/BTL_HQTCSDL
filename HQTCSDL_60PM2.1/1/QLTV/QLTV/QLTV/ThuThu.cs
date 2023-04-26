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
    public partial class ThuThu : Form
    {
        SqlConnection connection;
        SqlCommand command;
        string str = @"Data Source=DESKTOP-B1HTTG8\SQLEXPRESS;Initial Catalog=QLTV;Integrated Security=True";
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable table = new DataTable();
        public ThuThu()
        {
            InitializeComponent();
        }

        private void btNhapPhieuMuon_Click(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "INSERT INTO PhieuMuon Values('"+ txtMaPhieu .Text+ "','" + txtMaSach.Text + "','" + txtTenSach.Text + "','" + txtMaKhachHang.Text + "','" + txtTenKhachHang.Text + "','" + datetimeNgayMuon.Text + "','" + datetimehantra.Text + "','" + txtTienMuon.Text + "','" + txtTienCoc.Text + "')";
            command.ExecuteNonQuery();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            command = connection.CreateCommand();
            command.CommandText = "INSERT INTO PhieuTra Values('" + txt2MaPhieuTra.Text + "','" + txt2MaPhieuMuon.Text + "','" + txt2MaKhachHang.Text + "','" + txt2TenKhachHang.Text + "','" + datetime2NgayMuon.Text + "','" + datetime2HanTra.Text + "','" + datetime2NgayTra.Text + "','" + txt2TienCoc.Text + "')";
            command.ExecuteNonQuery();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            DialogResult tb = MessageBox.Show("Bạn thật sự muốn thoát?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (tb == DialogResult.Yes)
            {
                Application.Exit();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            ThemKhachHang f = new ThemKhachHang();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }
    }
}
