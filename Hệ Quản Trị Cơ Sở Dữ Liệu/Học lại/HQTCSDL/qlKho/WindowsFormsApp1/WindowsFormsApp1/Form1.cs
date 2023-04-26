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

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        SqlConnection connection;
        SqlCommand command;
        string str = @"Data Source=DESKTOP-5TFUH4V\SQLEXPRESS;Initial Catalog=QuanLyKho_Final;Integrated Security=True";
      //  SqlDataAdapter adapter = new SqlDataAdapter();
        
     //   DataTable table = new DataTable();
        


        void loadDataq(string query)
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
        void loadDatan(string query)
        {
            SqlDataAdapter adapter1 = new SqlDataAdapter();
            DataTable table1 = new DataTable();
            command = connection.CreateCommand();
            command.CommandText = query;
            dataGridView3.Columns.Clear();
            dataGridView3.Refresh();
            adapter1.SelectCommand = command;
            dataGridView3.DataSource = null;
            table1.Clear();
            adapter1.Fill(table1);
            dataGridView3.DataSource = table1;
        }
        void loadDatat(string query)
        {
            SqlDataAdapter adapter2 = new SqlDataAdapter();
            DataTable table2 = new DataTable();
            command = connection.CreateCommand();
            command.CommandText = query;
            adapter2.SelectCommand = command;
            dataGridView2.Columns.Clear();
            dataGridView2.Refresh();
            dataGridView2.DataSource = null;
            dataGridView2.AutoGenerateColumns = true;
            table2.Clear();
            adapter2.Fill(table2);
            dataGridView2.DataSource = table2;
        }
        public void con_InfoMessage(object mySender, SqlInfoMessageEventArgs myEvent)
        {
            string myMsg = ("The following message was produced:\n" + myEvent.Errors[0]);
        }
        public Form1()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            nhanVienBindingSource.AddNew();

        }

        private void textBox6_TextChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
        static void connection_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            // this gets the print statements (maybe the error statements?)
            var outputFromStoredProcedure = e.Message;
            MessageBox.Show(outputFromStoredProcedure);
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            connection = new SqlConnection(str);
            connection.Open();
            connection.InfoMessage += connection_InfoMessage;
            //connection.InfoMessage += new SqlInfoMessageEventHandler(con_InfoMessage);
            loadDataq("select * from NhaCungCap");

            //// TODO: This line of code loads data into the 'quanLyKho_FinalDataSet1.KhachHang' table. You can move, or remove it, as needed.
            //this.khachHangTableAdapter.Fill(this.quanLyKho_FinalDataSet1.KhachHang);
            //// TODO: This line of code loads data into the 'quanLyKho_FinalDataSet.MatHang' table. You can move, or remove it, as needed.
            //this.matHangTableAdapter.Fill(this.quanLyKho_FinalDataSet.MatHang);
            //// TODO: This line of code loads data into the 'quanLyKho_FinalDataSet.NhanVien' table. You can move, or remove it, as needed.
            //this.nhanVienTableAdapter.Fill(this.quanLyKho_FinalDataSet.NhanVien);

        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                nhanVienBindingSource.EndEdit();
                nhanVienTableAdapter.Update(quanLyKho_FinalDataSet.NhanVien);

            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            
        }

        private void button3_Click(object sender, EventArgs e)
        {
            nhanVienBindingSource.RemoveCurrent();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button10_Click(object sender, EventArgs e)
        {
            matHangBindingSource.AddNew();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            try
            {
                matHangBindingSource.EndEdit();
                matHangTableAdapter.Update(quanLyKho_FinalDataSet.MatHang);                
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }


        }

        private void button8_Click(object sender, EventArgs e)
        {
            matHangBindingSource.RemoveCurrent();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button15_Click(object sender, EventArgs e)
        {
            khachHangBindingSource1.AddNew();
        }

        private void button14_Click(object sender, EventArgs e)
        {
            try
            {
                khachHangBindingSource1.EndEdit();
                khachHangTableAdapter.Update(quanLyKho_FinalDataSet1.KhachHang);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            
        }

        private void button13_Click(object sender, EventArgs e)
        {
            khachHangBindingSource1.RemoveCurrent();
        }

        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button6_Click(object sender, EventArgs e)
        {
            loadDatat("select * from SoLuongTon");
        }

        private void button11_Click(object sender, EventArgs e)
        {
            string nam = namHopTac.Value.ToString();
            string que = $"select * from KhachHang where (year(getdate()) - year(NgayHopTac)) >= {nam}";
            loadDatan(que);
        }

        private void button19_Click(object sender, EventArgs e)
        {
            string start = dateTimePicker1.Value.ToString("d");
            string end = dateTimePicker2.Value.Date.ToString("d");
            string que = $"select distinct MatHang.* , PhieuXuat.NgayXuat from PhieuXuat, TT_PhieuXuat, MatHang where PhieuXuat.ID_PX = TT_PhieuXuat.ID_PX and TT_PhieuXuat.ID_MH = MatHang.ID_MH and PhieuXuat.NgayXuat between '{start}' and '{end}'";
           loadDatat(que);
        }

        private void button18_Click(object sender, EventArgs e)
        {
            string start = dateTimePicker3.Value.ToString("d");
            string MH = textBox16.Text;
            loadDataq($"select dbo.sln('{MH}', '{start}', getdate()) as SoLuongNhap");
        }

        private void label16_Click(object sender, EventArgs e)
        {

        }

        private void button17_Click(object sender, EventArgs e)
        {
            string MH = textBox16.Text;
            loadDataq($"select * from dskh('{MH}')");
        }

        private void button16_Click(object sender, EventArgs e)
        {
            

            try
            {
                string start = dateTimePicker3.Value.ToString("yyyy");
                string MH = textBox16.Text;
                loadDataq($"select dbo.F_TongTien('{MH}', '{start}' ) as TongGiaPN");

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
