<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ChargoonTestApplication.Pages.Employee.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h5>فهرست پرسنل</h5>

    <%
        if (Services.EmployeeService.GetAllWithFullDetails().Count > 0)
        {
    %>
    <div class="table-responsive">
        <table class="table table-sm table-bordered">
            <thead class="thead-light">
                <tr>
                    <th scope="col"><%= Resources.Models.Employee.Id %></th>
                    <th scope="col"><%= Resources.Models.Employee.FirstName %></th>
                    <th scope="col"><%= Resources.Models.Employee.LastName %></th>
                    <th scope="col"><%= Resources.Models.Employee.NationalCode %></th>
                    <th scope="col"><%= Resources.Models.Employee.BirthDate %></th>
                    <th scope="col"><%= Resources.Models.Employment.Type %></th>
                    <th scope="col"><%= Resources.Models.Employment.Date %></th>
                    <th scope="col"></th>
                </tr>
            </thead>
            <tbody>
                 <%
                     foreach (var item in Services.EmployeeService.GetAllWithFullDetails())
                     {
                 %>
            <tr>
                <td><%= item.Id %></td>
                <td><%= item.FirstName %></td>
                <td><%= item.LastName %></td>
                <td><%= item.NationalCode %></td>
                <td><%= item.BirthDate.ToShortDateString() %></td>
                <td><%= item.EmploymentType %></td>
                <td><%= item.EmploymentDate.ToShortDateString() %></td>
                <td>
                    <div class="">
                        <a class="btn btn-danger" data-employee-id="<%=item.Id %>" id="delete-employee-<%=item.Id%>" onclick="openModal(<%=item.Id%>)">
                            <%= Resources.Buttons.Delete %>
                        </a>
                        <a class="btn btn-info" href="/Employee/Edit/<%=item.Id %>">
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
                <%= Resources.Messages.NoEmployees %>
            </div>
        </div>
    <%
        }
    %>

    <div class="modal fade" id="deleteEmployeeModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <asp:UpdatePanel ID="upModal" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">حذف پرسنل
                            </h4>
                        </div>
                        <div class="modal-body">
                            <label>آیا مطمئن به حذف کارمند می‌باشید؟</label>
                        </div>
                        <div class="modal-footer">
                            <button id="delete-employee-modal-button" data-employee-id="1" class="btn btn-danger" onclick="deleteEmployee()">
                                <%= Resources.Buttons.Delete %>
                            </button>
                            <button data-employee-id="1" class="btn btn-secondary" data-dismiss="modal">
                                <%= Resources.Buttons.Cancel %>
                            </button>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <script>

        function openModal(id) {

            $('#deleteEmployeeModal').modal();

            $("#delete-employee-modal-button").data('employee-id', id);
        }

        function deleteEmployee() {

            var id = $("#delete-employee-modal-button").data('employee-id');

            $.ajax({
                type: "POST",
                url: "/Pages/Employee/Index.aspx/DeleteEmployee",
                data: '{id: "' + id + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (success) {
                    console.log(success.d)
                    if (success.d == true) {
                        location.reload();
                    }
                },
                error: function (error) {
                }
            });
        }
    </script>

</asp:Content>
