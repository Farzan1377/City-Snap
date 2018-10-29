using MentalHealth3;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hackathon2
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string Line = Firebase.Read(ConfigurationManager.AppSettings["FireBase"]);

            List<Report> reports;
            Firebase.Parse(Line, out reports);

            for (int i = 0; i < reports.Count; i++)
            {
            }
        }
    }
}