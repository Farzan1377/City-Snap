using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;

namespace Hackathon2
{
    public class ImageProcessing
    {
        public static void TheSame(string url1, string url2)
        {
            WebClient wc = new WebClient();
            byte[] bytes = wc.DownloadData(url1);
            MemoryStream ms = new MemoryStream(bytes);

            System.Drawing.Image img1 = System.Drawing.Image.FromStream(ms);

            bytes = wc.DownloadData(url2);
            ms = new MemoryStream(bytes);

            System.Drawing.Image img2 = System.Drawing.Image.FromStream(ms);
        }
    }
}