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
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }

        private void btDangNhap_Click(object sender, EventArgs e)
        {
            SqlConnection connection;
            SqlCommand command;
            string str = @"Data Source=DESKTOP-B1HTTG8\SQLEXPRESS;Initial Catalog=QLTV;Integrated Security=True";
            SqlDataAdapter adapter = new SqlDataAdapter();
            DataTable table = new DataTable();
            try
            {
                connection.Open();
                string tk = txtTaiKhoan.Text;
                string mk = txtMatKhau.Text;
                string sql1 = "select * from NhanVien where MaNhanVien='" + tk + "' , MatKhau='" + mk + "' and ChucVu='QuanLy'";
                string sql2 = "select * from NhanVien where MaNhanVien='" + tk + "' , MatKhau='" + mk + "' and ChucVu='ThuThu'";
                string sql3 = "select * from NhanVien where MaNhanVien='" + tk + "' , MatKhau='" + mk + "' and ChucVu='ThuKho'";
                SqlCommand cmd1 = new SqlCommand(sql1, connection);
                SqlDataReader dat1 = cmd1.ExecuteReader();
                SqlCommand cmd2 = new SqlCommand(sql1, connection);
                SqlDataReader dat2 = cmd2.ExecuteReader();
                SqlCommand cmd3 = new SqlCommand(sql1, connection);
                SqlDataReader dat3 = cmd3.ExecuteReader();
                if (dat1.Read() == true)
                {
                        Quanly f = new Quanly();
                        this.Hide();
                        f.ShowDialog();
                        this.Show();
                }
                else if(dat2.Read() == true)
                {
                    ThuThu f = new ThuThu();
                    this.Hide();
                    f.ShowDialog();
                    this.Show();
                }
                else if (dat3.Read() == true)
                {
                    ThuKho f = new ThuKho();
                    this.Hide();
                    f.ShowDialog();
                    this.Show();
                }
                else
                {
                    MessageBox.Show("Đăng nhập thất bại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    txtTaiKhoan.Focus();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi kết nối");
            }
        }

        private void btHuy_Click(object sender, EventArgs e)
        {
            DialogResult tb = MessageBox.Show("Bạn thật sự muốn thoát?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (tb == DialogResult.Yes)
            {
                Application.Exit();
            }
        }
    }
}
