<%@ Page Title="<%$ Resources:EmploymentTypeCreate, Title %>" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="ChargoonTestApplication.Pages.EmploymentType.Create" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h5><%= Resources.EmploymentTypeCreate.Title %></h5>
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
                        <label class="col-md-4"><%= Resources.EmploymentTypeCreate.Name %></label>
                        <div class="col-md-8">
                            <asp:TextBox CssClass="form-control" ID="NameTextBox" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="row">
                        <label class="col-md-4"><%= Resources.EmploymentTypeCreate.Status %></label>
                        <div class="col-md-8">
                            <asp:RadioButtonList RepeatDirection="Horizontal" ID="IsActiveRadioButtonList" runat="server">
                                <asp:ListItem Selected="True" Value="true" Text="<%$ Resources:EmploymentTypeCreate, Active %>"></asp:ListItem>
                                <asp:ListItem Value="false" Text="<%$ Resources:EmploymentTypeCreate, NotActive %>"></asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="button-group">
            <div class="form-group float-md-left">
                <a class="btn btn-info mb-2" href="/EmploymentType/Index">
                    <i class="fa fa-list"></i>
                    <%=  Resources.Buttons.ListEmploymentType %>
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
</asp:Content>
