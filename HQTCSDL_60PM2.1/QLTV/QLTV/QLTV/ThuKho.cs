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
    
    public partial class ThuKho : Form
    {
        SqlConnection connection;
        SqlCommand command;
        string str = @"Data Source=DESKTOP-B1HTTG8\SQLEXPRESS;Initial Catalog=QLTV;Integrated Security=True";
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable table = new DataTable();
        void loaddata()
        {
            command = connection.CreateCommand();
            command.CommandText = "Select * from Sach ";
            adapter.SelectCommand = command;
            table.Clear();
            adapter.Fill(table);
            dgvthongtinsach.DataSource = table;
        }
        public ThuKho()
        {
            InitializeComponent();
        }

        private void btThem_Click(object sender, EventArgs e)
        {
            string MaSach = txtMaSach.Text;
            string TenSach = txtTenSach.Text;
            string TheLoai = txtTheLoai.Text;
            string NhaXuatBan = txtNhaXuatBan.Text;
            string NamXuatBan = dateNamXuatBan.Text;
            string TacGia = txtTacGia.Text;
            command = connection.CreateCommand();
            command.CommandText = "INSERT INTO Sach Values('"+MaSach+ "','" + TenSach + "','" + TheLoai + "','" + NhaXuatBan + "','" + NamXuatBan + "','" + TacGia + "')";
            command.ExecuteNonQuery();

        }

        private void ThuKho_Load(object sender, EventArgs e)
        {
            connection = new SqlConnection(str);
            connection.Open();
            loaddata();
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }
    }
}
