<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Map.aspx.cs" Inherits="Hackathon2.Map" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #map {
            height: 900px;
            width: 900px;
        }

        #imgReturn {
            transition: 0.3s;
        }

            #imgReturn:hover {
                opacity: 0.3;
                transition: 0.3s;
            }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <link href="StyleSheets/Map.css" rel="stylesheet" />

    <div id="info" style="color: white; font-family: 'Josefin Sans Std'; width: 300px; height: 100px; font-size: 30px; float: left;"></div>

    <div id="map" style="width: 80%; height: 500px; margin: auto; margin-top: 10px; visibility: visible" >
    </div>

    <img src="Images/Return.png" id="imgReturn" style="position: fixed; bottom: 50px; right: 50px; width: 50px; cursor: pointer" onclick="window.location.replace('AdminPanel.aspx')" />

    <script>
        function getJsonFromUrl() {
            var query = location.search.substr(1);
            var result = {};
            query.split("&").forEach(function (part) {
                var item = part.split("=");
                result[item[0]] = decodeURIComponent(item[1]);
            });
            return result;
        }

        var querystring = getJsonFromUrl();
        var lat = querystring["Location"].split(',')[0];
        var lng = querystring["Location"].split(',')[1];
        var info = document.getElementById("info");
        info.innerHTML = "<h1>" + querystring["Category"] + "</h1><p style='font-size: 20px'>Latitude: " + String(lat) + "<br />" + "Longitude: " + String(lng) + "</p>";

        function init_map() {
            map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: parseFloat(lat), lng: parseFloat(lng) },
                zoom: 20,
                mapTypeId: 'satellite'
            });

            var marker = new google.maps.Marker({
                position: { lat: parseFloat(lat), lng: parseFloat(lng) },
                map: map,
            }); 
            marker.setMap(map);
        }

        window.onload = init_map;
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAxWPmjfB8khbSQ_Rntq-YnVnixGuXUg04&callback=initMap"
        async defer></script>
</asp:Content>
