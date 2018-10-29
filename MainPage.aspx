<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MainPage.aspx.cs" Inherits="Hackathon2.MainPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleSheets/MainPage.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <div id="mainDiv">
        <img src="Images/Logo.png" id="imgLogo" />

        <table id="tableLogin" style="transform: translate(8%, 10%)">
            <tr>
                <td>
                    <input type="text" runat="server" id="textBoxUser" placeholder="Please insert the User" autocomplete="off" spellcheck="false" />
                </td>
                
                <td>
                    <asp:RequiredFieldValidator runat="server" ForeColor="#33B093" Text="*" ControlToValidate="textBoxUser"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td>
                    <input type="password" runat="server" id="textBoxPwd" placeholder="Please insert the password" />
                </td>
                <td>
                    <asp:RequiredFieldValidator runat="server" ForeColor="#33B093" Text="*" ControlToValidate="textBoxPwd"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>

            </tr>

            <tr>
                <td colspan="2" style="border-spacing: 5px; border-collapse: separate">
                    <input type="submit" id="buttonSubmit" value="Login" style="font-family: 'Josefin Sans Std'" runat="server" onserverclick="buttonSubmit_ServerClick" />
                </td>
            </tr>
        </table>
    </div>

        <footer style="color: white; position: fixed; bottom: 20px; left: 50%; transform: translate(-50%, 0); font-family: 'Josefin Sans Std'">
        &copy;2018 By Insomniacs2.0 Elevate Hackathon
    </footer>
</asp:Content>
