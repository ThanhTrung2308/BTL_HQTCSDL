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
    public partial class QLPM : Form
    {
        SqlConnection connection;
        SqlCommand command;
        string str = @"Data Source=DESKTOP-B1HTTG8\SQLEXPRESS;Initial Catalog=QLTV;Integrated Security=True";
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable table = new DataTable();
        void loaddata()
        {
            command = connection.CreateCommand();
            command.CommandText = "Select * from PhieuMuon";
            adapter.SelectCommand = command;
            table.Clear();
            adapter.Fill(table);
            dgvpm.DataSource = table;
        }
        public QLPM()
        {
            InitializeComponent();
        }

        private void QLPM_Load(object sender, EventArgs e)
        {
            connection = new SqlConnection(str);
            connection.Open();
            loaddata();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            String MaPhieu = txtMaPhieu.Text;
            String MaKhach = txtMaKhach.Text;
            String Ngay = datetimengaymuon.Text;
            connection = new SqlConnection(str);
            connection.Open();
            command = connection.CreateCommand();
            if (MaPhieu != "")
            {
                command.CommandText = "Select * from PhieuMuon Where MaPhieu='" + MaPhieu + "'";
            }
            else if(MaKhach!="")
            {
                command.CommandText = "Select * from PhieuMuon Where MaDocGia='" + MaKhach + "'";
            }
            else
            {
                command.CommandText = "Select * from PhieuMuon Where NgayMuon='" + Ngay + "'";
            }
            adapter.SelectCommand = command;
            table.Clear();
            adapter.Fill(table);
            dgvpm.DataSource = table;
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
