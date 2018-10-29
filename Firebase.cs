using Hackathon2;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace MentalHealth3
{
    public class Firebase
    {
        static public string Read(string Address)
        {
            string Data;
            string URL = Address;
            HttpWebRequest request1 = (HttpWebRequest)WebRequest.Create(URL);
            request1.ContentType = "application/json: charset=utf-8";
            HttpWebResponse response1 = request1.GetResponse() as HttpWebResponse;
            using (Stream responsestream = response1.GetResponseStream())
            {
                StreamReader Read = new StreamReader(responsestream, Encoding.UTF8);
                Data = Read.ReadLine();
            }

            if (Data == null)
                return "NULL";
            return Data;
        }

        public static void Parse(string json, out List<Report> Reports)
        {
            Reports = new List<Report>();


            try
            {
                JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                serializer.MaxJsonLength = Int32.MaxValue;

                dynamic j = serializer.DeserializeObject(json);
                foreach (KeyValuePair<string, object> entry in j)
                {
                    foreach (KeyValuePair<string, object> item in (entry.Value as Dictionary<string, object>))
                    {
                        Reports.Add(new Report());
                        Reports.Last().Category = entry.Key;
                        Reports.Last().Grid = item.Key;
                        Reports.Last().Likes = (item.Value as Dictionary<string, object>).Values.ToArray()[0].ToString();
                        Reports.Last().Pictures = (item.Value as Dictionary<string, object>).Values.ToArray()[1].ToString();
                        Reports.Last().Location = (item.Value as Dictionary<string, object>).Values.ToArray()[2].ToString() + ", " + (item.Value as Dictionary<string, object>).Values.ToArray()[3].ToString();
                        Reports.Last().Rating = double.Parse((item.Value as Dictionary<string, object>).Values.ToArray()[4].ToString());
                    }
                }

            }
            catch (Exception)
            {

            }
        }
    }
}