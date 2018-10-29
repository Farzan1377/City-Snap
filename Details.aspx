<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="Hackathon2.Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleSheets/Details.css" rel="stylesheet" />
    <script>
        function choose(n) {
            Image = document.getElementById("mainImage");
            Image.src = document.getElementById("img" + n).src;
            Image.style["width"] = "425px";
            Image.style["height"] = "425px";
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">

    <img id="mainImage" src="Images/NoImage.png" style="width: 525px; height: 525px; display: block; margin: auto;" onload="loadImage" />

    <hr />

    <div id="divList" runat="server">

    </div>

    <img src="Images/Return.png" id="imgReturn" style="position: fixed; bottom: 50px; right: 50px; width: 50px; cursor: pointer" onclick="window.location.replace('AdminPanel.aspx')" />
</asp:Content>
