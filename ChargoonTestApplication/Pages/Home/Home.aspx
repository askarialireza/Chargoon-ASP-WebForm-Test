<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ChargoonTestApplication.Pages.Home.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h5><%= Resources.Home.Title %></h5>
    <hr />
    <div class="alert alert-info">
        <div class="col-12">
            <label><%= Resources.Home.FastAccess %></label>
            <ul class="home-ul">
                <li><a href="/Employee/Create"><%= Resources.Home.CreateEmployee %></a></li>
                <li><a href="/Employee/Index"><%= Resources.Home.ListEmployee %></a></li>
                <li><a href="/EmploymentType/Create"><%= Resources.Home.CreateEmploymentType %></a></li>
                <li><a href="/EmploymentType/Index"><%= Resources.Home.ListEmploymentType %></a></li>
            </ul>
        </div>
    </div>

</asp:Content>
