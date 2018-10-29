using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hackathon2
{
    public partial class MainPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            textBoxUser.Focus();
        }

        protected void buttonSubmit_ServerClick(object sender, EventArgs e)
        {
            if (textBoxUser.Value == ConfigurationManager.AppSettings["user"] && textBoxPwd.Value == ConfigurationManager.AppSettings["pwd"])
            {
                Session["LoggedIn"] = true;
                Response.Redirect("AdminPanel.aspx");
            }
        }
    }
}