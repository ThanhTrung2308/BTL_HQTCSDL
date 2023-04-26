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
    public partial class PhieuTra : Form
    {
        SqlConnection connection;
        SqlCommand command;
        string str = @"Data Source=DESKTOP-B1HTTG8\SQLEXPRESS;Initial Catalog=QLTV;Integrated Security=True";
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable table = new DataTable(); void loaddata()
        {
            command = connection.CreateCommand();
            command.CommandText = "Select * from PhieuTra";
            adapter.SelectCommand = command;
            table.Clear();
            adapter.Fill(table);
            dgvpm.DataSource = table;
        }
        public PhieuTra()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            String MaPhieuMuon = txtMaPhieuMuon.Text;
            String MaPhieuTra = txtMaPhieuTra.Text;
            String MaKhach = txtMaKhach.Text;
            String NgayMuon = datetimengaymuon.Text;
            String NgayTra = datetimengaytra.Text;
            connection = new SqlConnection(str);
            connection.Open();
            command = connection.CreateCommand();
            if (MaPhieuMuon != "")
            {
                command.CommandText = "Select * from PhieuTra Where MaPhieuMuon='" + MaPhieuMuon + "'";
            }
            else if (MaKhach != "")
            {
                command.CommandText = "Select * from PhieuTra Where MaDocGia='" + MaKhach + "'";
            }
            else if (MaPhieuTra != "")
            {
                command.CommandText = "Select * from PhieuTra Where MaPhieuTra='" + MaPhieuTra + "'";
            }
            else if (NgayMuon != "")
            {
                command.CommandText = "Select * from PhieuTra Where NgayMuon='" + NgayMuon + "'";
            }
            else
            {
                command.CommandText = "Select * from PhieuTra Where NgayTra='" + NgayTra + "'";
            }
            adapter.SelectCommand = command;
            table.Clear();
            adapter.Fill(table);
            dgvpm.DataSource = table;
        }

        private void PhieuTra_Load(object sender, EventArgs e)
        {
            connection = new SqlConnection(str);
            connection.Open();
            loaddata();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Quanly f = new Quanly();
            this.Hide();
            f.ShowDialog();
            this.Show();
        }
    }
}
