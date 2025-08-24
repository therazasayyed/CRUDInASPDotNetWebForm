using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFormApp
{
    public partial class UsersForm : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("data source=.\\SQLEXPRESS;initial catalog=WebformApp;integrated security=true;");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetGenders();
                GetUsersList();
            }
        }

        public void GetUsersList()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("ProcUsers", con);
            cmd.Parameters.AddWithValue("@Action", "GetUsersList");
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            gvUsersList.DataSource = dt;
            gvUsersList.DataBind();
        }

        public void GetGenders()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("ProcUsers", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Action", "GetGender");
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            rblGender.DataValueField = "GenderId";
            rblGender.DataTextField = "GenderName";
            rblGender.DataSource = dt;
            rblGender.DataBind();
        }

        public void ClearFieldsData()
        {
            txtName.Text = "";
            txtDateOfBirth.Text = "";
            rblGender.ClearSelection();
            txtPhone.Text = "";
            txtAddress.Text = "";
            btnSubmit.Text = "Submit";
        }

        protected void gvUsersList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UserEdit")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("ProcUsers", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "Edit");
                cmd.Parameters.AddWithValue("@UserId", e.CommandArgument);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                con.Close();
                txtName.Text = dt.Rows[0]["UserName"].ToString();
                txtDateOfBirth.Text = dt.Rows[0]["UserDateOfBirth"].ToString();
                rblGender.SelectedValue = dt.Rows[0]["GenderId"].ToString();
                txtPhone.Text = dt.Rows[0]["UserPhone"].ToString();
                txtAddress.Text = dt.Rows[0]["UserAddress"].ToString();
                ViewState["img"] = dt.Rows[0]["UserPhoto"].ToString();
                btnSubmit.Text = "Update";
                ViewState["id"] = e.CommandArgument;
                lblMsg.Visible = false;
            }
            else if (e.CommandName == "UserDelete")
            {
                string[] idAndImage = e.CommandArgument.ToString().Split(',');
                con.Open();
                SqlCommand cmd = new SqlCommand("ProcUsers", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "Delete");
                cmd.Parameters.AddWithValue("@UserId", idAndImage[0]);
                cmd.ExecuteNonQuery();
                con.Close();
                GetUsersList();
                lblMsg.Text = "You Are Deleted Successfully !!";
                lblMsg.Visible = true;
                string script = $"setTimeout(function(){{ document.getElementById('{lblMsg.ClientID}').style.display='none'; }}, 2000);";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "HideMessage", script, true);
                File.Delete(Server.MapPath("UsersImage" + "\\" + idAndImage[1]));
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(rblGender.SelectedValue))
            {
                lblMsg.Text = "Gender is required";
                lblMsg.Visible = true;
                return;
            }
            if (string.IsNullOrEmpty(txtDateOfBirth.Text))
            {
                lblMsg.Text = "Date of Birth is required";
                lblMsg.Visible = true;
                return;
            }
            if (btnSubmit.Text == "Submit" && !fuPhoto.HasFile)
            {
                lblMsg.Text = "Photo is required for new registration";
                lblMsg.Visible = true;
                return;
            }
            string fileName = "";
            if (fuPhoto.HasFile)
            {
                fileName = Path.GetFileName(fuPhoto.PostedFile.FileName);
                fuPhoto.SaveAs(Server.MapPath("UsersImage" + "\\" + fileName));
            }
            if (btnSubmit.Text == "Submit")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("ProcUsers", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "Insert");
                cmd.Parameters.AddWithValue("@UserName", txtName.Text);
                cmd.Parameters.AddWithValue("@UserDateOfBirth", txtDateOfBirth.Text);
                cmd.Parameters.AddWithValue("@GenderId", rblGender.SelectedValue);
                cmd.Parameters.AddWithValue("@UserPhone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@UserAddress", txtAddress.Text);
                cmd.Parameters.AddWithValue("@UserPhoto", fileName);
                cmd.ExecuteNonQuery();
                con.Close();
                GetUsersList();
                ClearFieldsData();
                lblMsg.Text = "You Are Registered Successfully !!";
                string script = $"setTimeout(function(){{ document.getElementById('{lblMsg.ClientID}').style.display='none'; }}, 2000);";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "HideMessage", script, true);
            }
            else if (btnSubmit.Text == "Update")
            {
                if (!fuPhoto.HasFile)
                {
                    lblMsg.Text = "Photo is required";
                    lblMsg.Visible = true;
                    return;
                }
                File.Delete(Server.MapPath("UsersImage" + "\\" + ViewState["img"]));
                con.Open();
                SqlCommand cmd = new SqlCommand("ProcUsers", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "Update");
                cmd.Parameters.AddWithValue("@UserName", txtName.Text);
                cmd.Parameters.AddWithValue("@UserDateOfBirth", txtDateOfBirth.Text);
                cmd.Parameters.AddWithValue("@GenderId", rblGender.SelectedValue);
                cmd.Parameters.AddWithValue("@UserPhone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@UserAddress", txtAddress.Text);
                cmd.Parameters.AddWithValue("@UserPhoto", fileName);
                cmd.Parameters.AddWithValue("@UserId", ViewState["id"]);
                cmd.ExecuteNonQuery();
                con.Close();
                GetUsersList();
                ClearFieldsData();
                lblMsg.Text = "You Are Updated Successfully !!";
                lblMsg.Visible = true;
                string script = $"setTimeout(function(){{ document.getElementById('{lblMsg.ClientID}').style.display='none'; }}, 2000);";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "HideMessage", script, true);
            }
        }
    }
}