using Hackathon2.Images;
using MentalHealth3;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hackathon2
{
    public partial class AdminPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedIn"] == (object)false || Session["LoggedIn"] == null)
            {
                Response.Redirect("MainPage.aspx");
            }


            while (gridview.Columns.Count > 0)
            {
                gridview.Columns.RemoveAt(0);
            }

            List<Report> Reports;
            string json;
            json = Firebase.Read(ConfigurationManager.AppSettings["FireBase"]);
            Firebase.Parse(json, out Reports);
            Session["Reports"] = Reports;

            gridview.RowStyle.HorizontalAlign = HorizontalAlign.Center;
            gridview.AutoGenerateColumns = true;

            DataTable dt1 = new DataTable();

            dt1.Columns.Add("Category", typeof(string));
            dt1.Columns.Add("Reports", typeof(string));

            for (int i = 0; i < Reports.Count; i++)
            {
                DataRow row = dt1.NewRow();
                row[0] = Reports[i].Category;
                row[1] = Reports[i].Likes;

                dt1.Rows.Add(row);
            }

            gridview.Columns.Add(new ButtonField() { HeaderText = "Details", ButtonType = ButtonType.Image, ImageUrl = "~/Images/Details.png", CommandName = "Details" });
            gridview.Columns.Add(new ButtonField() { HeaderText = "Location", ButtonType = ButtonType.Image, ImageUrl = "~/Images/Location.png", CommandName = "Location" });
            gridview.RowCommand += GridView_RowCommand;
            gridview.DataSource = dt1;
            gridview.DataBind();
        }

        private void GridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Details" && Session["Reports"] != null)
            {
                List<Report> reports = (Session["Reports"] as List<Report>);
                int index = int.Parse(e.CommandArgument.ToString());

                Session["pictures"] = (Session["Reports"] as List<Report>)[index].Pictures;
                Response.Redirect("Details.aspx");
            }
            if (e.CommandName == "Location" && Session["Reports"] != null)
            {
                List<Report> reports = (Session["Reports"] as List<Report>);
                int index = int.Parse(e.CommandArgument.ToString());

                Response.Redirect("Map.aspx?Location=" + reports[index].Location + "&Category=" + reports[index].Category);
            }
        }

        protected void timer1_Tick(object sender, EventArgs e)
        {

        }
    }
}