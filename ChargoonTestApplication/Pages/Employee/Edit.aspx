<%@ Page Title="ویرایش پرسنل" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="ChargoonTestApplication.Pages.Employee.Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h5>ویرایش پرسنل</h5>
    <hr />
    <%
        if (Infrastructure.Validation.ErrorMessages.Count > 0)
        {
    %>
    <div class="alert alert-danger w-100" runat="server">
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
        <div class="col-12 card">
            <h5>مشخصات فردی</h5>
            <div class="card-body">
                <div class="form-group row">
                    <label class="col-md-4" for="FirstName"><%= Resources.Models.Employee.FirstName %></label>
                    <div class="col-md-8">
                        <asp:TextBox CssClass="form-control" ID="FirstName" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-md-4" for="LastName"><%= Resources.Models.Employee.LastName %></label>
                    <div class="col-md-8">
                        <asp:TextBox CssClass="form-control" ID="LastName" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-md-4" for="NationalCode"><%= Resources.Models.Employee.NationalCode %></label>
                    <div class="col-md-8">
                        <asp:TextBox TextMode="Number" CssClass="form-control" ID="NationalCode" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-md-4" for="asas"><%= Resources.Models.Employee.BirthDate %></label>
                    <div class="col-md-8">
                        <asp:TextBox TextMode="Date" CssClass="form-control" ID="BirthDate" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12 card">
            <h5>جزییات استخدام</h5>
            <div class="card-body">
                <div class="form-group row">
                    <label class="col-md-4" for="NationalCode"><%= Resources.Models.Employment.Date %></label>
                    <div class="col-md-8">
                        <asp:TextBox TextMode="Date" CssClass="form-control" ID="EmploymentDate" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-md-4" for="NationalCode"><%= Resources.Models.Employment.Type %></label>
                    <div class="col-md-8">
                        <asp:DropDownList ID="EmploymentType" CssClass="form-control" DataTextField="Name" DataValueField="Id" runat="server"></asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12 button-group">
            <div class="form-group float-md-left">
                <asp:Button CssClass="btn btn-info" ID="Button2" Text="لیست پرسنل" runat="server" />
                <button type="reset" class="btn btn-secondary" onclick="this.form.reset();return false"><%= Resources.Buttons.Reset %></button>
                <asp:Button CssClass="btn btn-success" ID="SubmitButton" OnClick="SubmitButton_Click" Text="ثبت اطلاعات" runat="server" />
            </div>
        </div>
    </form>
</asp:Content>
