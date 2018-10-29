using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hackathon2
{
    public partial class Map : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedIn"] == (object)false || Session["LoggedIn"] == null)
            {
                Response.Redirect("MainPage.aspx");
            }
        }
    }
}