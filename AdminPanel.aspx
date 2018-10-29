<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="Hackathon2.AdminPanel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleSheets/AdminPanel.css" rel="stylesheet" />

    <script>
        function toggle() {
            div1 = document.getElementById("div1");
            div2 = document.getElementById("div2");
            button = document.getElementById("buttonToggle");
            button.style["transition"] = "linear 0.2s";

            if (div1.style["visibility"] != "visible" && div1.style["visibility"] != "hidden") {
                div1.style["visibility"] = "visible";
                div2.style["visibility"] = "hidden";
            }

            if (div1.style["visibility"] == "visible" && div2.style["visibility"] == "hidden") {
                div1.style["visibility"] = "hidden";
                div1.style["height"] = "0px";
                div2.style["visibility"] = "visible";
                div1.style["height"] = "900px";
            }
            else {
                div1.style["visibility"] = "visible";
                div1.style["height"] = "900px";
                div2.style["visibility"] = "hidden";
                div2.style["height"] = "0px";
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <asp:ScriptManager runat="server" ID="scriptManager"></asp:ScriptManager>

    <br />

    <asp:Timer runat="server" ID="timer1" Interval="3000" OnTick="timer1_Tick"></asp:Timer>

    <asp:UpdatePanel runat="server">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="timer1" />    
        </Triggers>

        <ContentTemplate>
            <div id="divMain">
                <div id="div1">
                    <asp:GridView runat="server" ID="gridview" CellPadding="3" GridLines="Horizontal" Height="338px" Width="635px" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" Font-Names="Josefin Sans Std">
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <SortedAscendingCellStyle BackColor="#F4F4FD" />
                        <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                        <SortedDescendingCellStyle BackColor="#D8D8F0" />
                        <SortedDescendingHeaderStyle BackColor="#3E3277" />
                    </asp:GridView>
                </div>

                <img src="Images/Signout.png" id="imgSignout" onclick='window.location.replace("Mainpage.aspx")' />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
