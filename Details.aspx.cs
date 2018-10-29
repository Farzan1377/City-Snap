using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hackathon2
{
    public partial class Details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedIn"] == (object)false || Session["LoggedIn"] == null)
            {
                Response.Redirect("MainPage.aspx");
            }

            string Pictures = Session["pictures"].ToString();

            for (int i = 0; i < Pictures.Split(' ').Length; i++)
            {
                divList.InnerHtml += string.Format(@"
                    <img src='{0}' id='img{1}' style='width: 150px; height: 150px; cursor: pointer' onclick='choose({1})' />     
            ", Pictures.Split(' ')[i], i);
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "key", "choose(0)", true);
        }
    }
}