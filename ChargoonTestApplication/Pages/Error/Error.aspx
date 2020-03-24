<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="ChargoonTestApplication.Pages.Error.Error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="alert alert-danger">
            <h5><%= Resources.Messages.PageNotFoundErrorMessage %></h5>
        </div>
</asp:Content>
