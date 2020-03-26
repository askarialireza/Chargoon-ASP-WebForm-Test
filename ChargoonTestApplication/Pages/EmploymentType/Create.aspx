<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="ChargoonTestApplication.Pages.EmploymentType.Create" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h5>ایجاد نواع استخدام</h5>
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
        <div class="card">
            <div class="card-body">
                <div class="form-group">
                    <div class="row">
                        <label class="col-md-4">عنوان</label>
                        <div class="col-md-8">
                            <asp:TextBox CssClass="form-control" ID="NameTextBox" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-md-4">وضعیت</label>
                        <div class="col-md-8">
                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="IsActiveRadioButtonList" runat="server">
                                <asp:ListItem Selected="True" Value="true">فعال</asp:ListItem>
                                <asp:ListItem Value="false">غیرفعال</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="button-group">
            <div class="form-group float-md-left">
                <a class="btn btn-info mb-2" href="/EmploymentType/Index">لیست انواع استخدام</a>
                <button type="reset" class="btn btn-secondary mb-2" onclick="this.form.reset();return false"><%=  Resources.Buttons.Reset %></button>
                <asp:Button CssClass="btn btn-success mb-2" ID="SubmitButton" Text="<%$ Resources:Buttons, Submit %>" OnClick="SubmitButton_Click" runat="server" />
            </div>
        </div>
    </form>
</asp:Content>
