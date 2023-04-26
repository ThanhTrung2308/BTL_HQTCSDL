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
namespace QLK_BTLCSDL
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        string str = @"Data Source=DESKTOP-5TFUH4V\SQLEXPRESS;Initial Catalog=QuanLyKho_BTL;Integrated Security=True";
        SqlConnection connection;
        SqlCommand command;
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataTable table = new DataTable();


        void loadDataMatHang(string query)
        {
            SqlDataAdapter adapter2 = new SqlDataAdapter();
            DataTable table2 = new DataTable();
            command = connection.CreateCommand();
            command.CommandText = query;
            adapter2.SelectCommand = command;
            matHangDataGridView.Columns.Clear();
            matHangDataGridView.Refresh();
            matHangDataGridView.DataSource = null;
            matHangDataGridView.AutoGenerateColumns = true;
            table2.Clear();
            adapter2.Fill(table2);
            matHangDataGridView.DataSource = table2;
        }


        void loadDataKhachHang(string query)
        {
            SqlDataAdapter adapter1 = new SqlDataAdapter();
            DataTable table1 = new DataTable();
            command = connection.CreateCommand();
            command.CommandText = query;
            khachHangDataGridView.Refresh();
            adapter1.SelectCommand = command;
            khachHangDataGridView.DataSource = null;
            table1.Clear();
            adapter1.Fill(table1);
            khachHangDataGridView.DataSource = table1;
        }


        void loadDataSLN(string query)
        {
            SqlDataAdapter adapter = new SqlDataAdapter();
            DataTable table = new DataTable();
            command = connection.CreateCommand();
            command.CommandText = query;
            adapter.SelectCommand = command;
            q.Columns.Clear();
            q.Refresh();
            q.AutoGenerateColumns = true;
            table.Clear();
            adapter.Fill(table);
            q.DataSource = table;
        }
        private void nhanVienBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.nhanVienBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.quanLyKho_BTLDataSet);

        }

        private void Form1_Load(object sender, EventArgs e)
        {

            connection = new SqlConnection(str);
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }


            // TODO: This line of code loads data into the 'quanLyKho_BTLDataSet.MatHang' table. You can move, or remove it, as needed.
            this.matHangTableAdapter.Fill(this.quanLyKho_BTLDataSet.MatHang);
            // TODO: This line of code loads data into the 'quanLyKho_BTLDataSet.KhachHang' table. You can move, or remove it, as needed.
            this.khachHangTableAdapter.Fill(this.quanLyKho_BTLDataSet.KhachHang);
            // TODO: This line of code loads data into the 'quanLyKho_BTLDataSet.NhanVien' table. You can move, or remove it, as needed.
            this.nhanVienTableAdapter.Fill(this.quanLyKho_BTLDataSet.NhanVien);

            loadDataSLN("Select * from NhaCungCap");
        }


        private void btThemNV_Click(object sender, EventArgs e)
        {
            try
            {
                nhanVienBindingSource.AddNew();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void btLuuNV_Click(object sender, EventArgs e)
        {
            try
            {
                nhanVienBindingSource.EndEdit();
                nhanVienTableAdapter.Update(quanLyKho_BTLDataSet.NhanVien);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btXoaNV_Click(object sender, EventArgs e)
        {
            nhanVienBindingSource.RemoveCurrent();
        }

        private void btThemKH_Click(object sender, EventArgs e)
        {
            try
            {
                khachHangBindingSource.AddNew();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btLuuKH_Click(object sender, EventArgs e)
        {
            try
            {
                khachHangBindingSource.EndEdit();
                khachHangTableAdapter.Update(quanLyKho_BTLDataSet.KhachHang);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button13_Click(object sender, EventArgs e)
        {
            khachHangBindingSource.RemoveCurrent();
        }

        private void button12_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btThemMH_Click(object sender, EventArgs e)
        {
            try
            {
                matHangBindingSource.AddNew();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btLuuMH_Click(object sender, EventArgs e)
        {
            try
            {
                matHangBindingSource.EndEdit();
                matHangTableAdapter.Update(quanLyKho_BTLDataSet.MatHang);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btXoaMH_Click(object sender, EventArgs e)
        {
            matHangBindingSource.RemoveCurrent();
        }

        private void btExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btMHT_Click(object sender, EventArgs e)
        {
            command = new SqlCommand("QuanLyKho_BTL.dbo.SP_SoLuongTon", connection)
            {
                CommandType = CommandType.StoredProcedure
            };
            table.Clear();
            adapter = new SqlDataAdapter(command);
            adapter.Fill(table);
            matHangDataGridView.Columns.Clear();
            matHangDataGridView.Refresh();
            matHangDataGridView.DataSource = null;
            matHangDataGridView.AutoGenerateColumns = true;
            table.Clear();
            adapter.Fill(table);
            matHangDataGridView.DataSource = table;
        }

        private void button11_Click(object sender, EventArgs e)
        {
            string nam = namHopTac.Value.ToString();
            string que = "select * from KhachHang where (year(getdate()) - year(NgayHopTac)) >= '"+nam+"'";
            loadDataKhachHang(que);
        }

        private void btXemMH_Click(object sender, EventArgs e)
        {
            string start = dateTimePicker1.Value.ToString("d");
            string end = dateTimePicker2.Value.Date.ToString("d");
            string que = "select  MatHang.* , PhieuXuat.NgayXuat from PhieuXuat, TT_PhieuXuat, MatHang where PhieuXuat.ID_PX = TT_PhieuXuat.ID_PX and TT_PhieuXuat.ID_MH = MatHang.ID_MH and PhieuXuat.NgayXuat between '"+ start+ "' and '"+ end+"'";
            loadDataMatHang(que);
        }

        private void btRefresh_Click(object sender, EventArgs e)
        {
            loadDataMatHang("Select * from MatHang");
        }

        private void btRefreshKH_Click(object sender, EventArgs e)
        {
            loadDataKhachHang("Select * from KhachHang");
        }

        private void ngaySanXuatDateTimePicker_ValueChanged(object sender, EventArgs e)
        {

        }

        private void btSLN_Click(object sender, EventArgs e)
        {
            string start = dateTimePicker3.Value.ToString("d");
            string MH = textBox16.Text;
            loadDataSLN("select QuanLyKho_BTL.dbo.sln('"+MH+"', '"+start+"', getdate() ) as SoLuongNhap");
        }

        private void btDSMH_Click(object sender, EventArgs e)
        {
            string MH = textBox16.Text;
            loadDataSLN("select * from QuanLyKho_BTL.dbo.dskh('"+ MH +"')");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string dc = diachiTextBox2.Text;
            loadDataKhachHang("select * from QuanLyKho_BTL.dbo.F_dckh(N'%" + dc + "%')");
        }

        private void btTT_Click(object sender, EventArgs e)
        {
            try
            {
                string mpn = txtMPN.Text;
                loadDataSLN("select QuanLyKho_BTL.dbo.F_TongTien('" + mpn + "' ) as TongGiaPN");

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

    }
}
