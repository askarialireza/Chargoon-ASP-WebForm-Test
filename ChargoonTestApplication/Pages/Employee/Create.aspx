<%@ Page Title="<%$ Resources:EmployeeCreate, Title %>" EnableEventValidation="true" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="ChargoonTestApplication.Pages.Employee.Create" %>

<asp:Content ID="CreateEmployee" ContentPlaceHolderID="MainContent" runat="server">

    <h5><%= Resources.EmployeeCreate.Title %></h5>
    <hr />


    <%
        if (NoEmploymentType == true)
        {
    %>
    <div class="alert alert-danger">
        <label class="w-100"><%=Resources.EmployeeCreate.NoEmploymentTypeError %></label>
    </div>
    <%
        }
        else
        {
    %>

    <%
        if (Infrastructure.Validation.ErrorMessages.Count > 0)
        {
    %>
    <div class="alert alert-danger">
        <ul>
            <%
                foreach (var item in Infrastructure.Validation.ErrorMessages)
                {
            %>
            <li><%= item %></li>
            <%
                }
            %>
        </ul>
    </div>
    <%
        }
    %>
    <form runat="server">
        <div class="card">
            <h5 class="title"><%= Resources.EmployeeCreate.EmployeeCardTitle %></h5>
            <hr />
            <div class="card-body">
                <div class="form-group">
                    <div class="row">
                        <label class="col-md-4" for="FirstName"><%= Resources.Employee.FirstName %></label>
                        <div class="col-md-8">
                            <asp:TextBox CssClass="form-control" ID="FirstName" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-md-4" for="LastName"><%= Resources.Employee.LastName %></label>
                        <div class="col-md-8">
                            <asp:TextBox CssClass="form-control" ID="LastName" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-md-4" for="NationalCode"><%= Resources.Employee.NationalCode %></label>
                        <div class="col-md-8">
                            <asp:TextBox TextMode="Number" CssClass="form-control" ID="NationalCode" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-md-4" for="asas"><%= Resources.Employee.BirthDate %></label>
                        <div class="col-md-8">
                            <asp:TextBox TextMode="Date" CssClass="form-control" ID="BirthDate" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card">
            <h5 class="title"><%= Resources.EmployeeCreate.EmploymentCardTitle %></h5>
            <hr />
            <div class="card-body">
                <div class="form-group">
                    <div class="row">
                        <label class="col-md-4" for="NationalCode"><%= Resources.Employment.Date %></label>
                        <div class="col-md-8">
                            <asp:TextBox TextMode="Date" CssClass="form-control" ID="EmploymentDate" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-md-4" for="NationalCode"><%= Resources.Employment.Type %></label>
                        <div class="col-md-8">
                            <asp:DropDownList ID="EmploymentType" CssClass="form-control" DataTextField="Name" DataValueField="Id" runat="server"></asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="button-group">
            <div class="form-group float-md-left">
                <a class="btn btn-info mb-2" href="/Employee/Index">
                    <i class="fa fa-list"></i>
                    <%= Resources.Buttons.ListEmployee %>
                </a>
                <button type="reset" class="btn btn-secondary mb-2" onclick="this.form.reset();return false">
                    <i class="fa fa-ban"></i>
                    <%=  Resources.Buttons.Reset %>
                </button>
                <button class="btn btn-success mb-2" runat="server" onserverclick="SubmitButton_Click">
                    <i class="fa fa-check"></i>
                    <%=  Resources.Buttons.Submit %>
                </button>
            </div>
        </div>
    </form>

    <%
        }
    %>
</asp:Content>

