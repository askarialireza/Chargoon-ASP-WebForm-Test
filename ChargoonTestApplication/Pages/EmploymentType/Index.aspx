<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ChargoonTestApplication.Pages.EmploymentType.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h5>فهرست انواع استخدام</h5>
    <hr />

    <% if (Services.EmploymentTypeService.GetAll().Count() > 0)
        {
    %>

    <div class="table-responsive">
        <table class="table table-sm table-bordered">
            <thead class="thead-light">
                <tr>
                    <th scope="col"><%= Resources.Models.Employment.Id %></th>
                    <th scope="col"><%= Resources.Models.Employment.Name %></th>
                    <th scope="col"><%= Resources.Models.Employment.IsActive %></th>
                    <th scope="col"></th>
                </tr>
            </thead>
            <tbody id="employee-table">
                <%
                    foreach (var item in Services.EmploymentTypeService.GetAll())
                    {
                %>
                <tr>
                    <td><%= item.Id %></td>
                    <td class="search-firstname"><%= item.Name %></td>
                    <td class="search-firstname">

                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" checked="<%= item.IsActive%>" disabled>
                            <span class="custom-control-label">
                                <%=(item.IsActive)?"فعال":"غیرفعال"%>
                            </span>
                        </div>
                    </td>
                    <td>
                        <div class="action-buttons">
                            <a class="btn btn-sm btn-danger text-white" data-employee-id="<%=item.Id %>" id="delete-employee-<%=item.Id%>" onclick="openModal(<%=item.Id%>)">
                                <%= Resources.Buttons.Delete %>
                            </a>
                            <a class="btn btn-sm btn-info" href="/Employee/Edit/<%=item.Id %>">
                                <%= Resources.Buttons.Edit %>
                            </a>
                        </div>
                    </td>
                </tr>
                <%    
                    }
                %>
            </tbody>
        </table>
    </div>

    <%
        }
        else
        {
    %>
    <div class="col-12">
        <div class="alert alert-warning">
            <label>هیچ نوع استخدامی در سیستم ثبت نشده است.</label>
        </div>
    </div>
    <%
        }
    %>
</asp:Content>
