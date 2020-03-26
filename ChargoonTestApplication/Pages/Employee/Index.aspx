<%@ Page Title="فهرست پرسنل" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ChargoonTestApplication.Pages.Employee.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h5><%= Resources.Pages.EmployeeIndex.Title %></h5>
    <hr />

    <%
        if (Services.EmployeeService.GetAllWithFullDetails().Count() > 0)
        {
    %>

    <form class="form-inline mb-3">
        <label class="mr-md-2"><%= Resources.Pages.EmployeeIndex.SearchEmployee %></label>
        <div class="form-group">
            <input class="form-control mb-1 mb-md-0 mr-md-2" id="search-input" placeholder="<%= Resources.Pages.EmployeeIndex.SearchInputPlaceholder %>" />
        </div>
        <a class="btn btn-sm btn-primary mt-2 mt-md-0  mr-md-2 text-white" id="search-button">
            <%= Resources.Pages.EmployeeIndex.SearchButton %>
        </a>
        <a class="btn btn-sm btn-warning mt-2 mt-md-0 text-white" id="show-all-button" style="display: none">نمایش همه
        </a>
        <a class="ml-auto btn btn-success text-white" href="/Employee/Create">
            <%= Resources.Pages.EmployeeIndex.CreateEmployee %>
        </a>
    </form>

    <div id="search-no-result">
        <div class="alert alert-warning">
            <label><%= Resources.Pages.EmployeeIndex.SearchNoResult %></label>
        </div>
    </div>

    <div id="search-found-result">
        <div class="alert alert-success">
            <label id="result-count"></label>
            <label><%= Resources.Pages.EmployeeIndex.SearchFoundResult %></label>
        </div>
    </div>

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
            <tbody id="employee-table">
                <%
                    foreach (var item in Services.EmployeeService.GetAllWithFullDetails())
                    {
                %>
                <tr>
                    <td><%= item.Id %></td>
                    <td class="search-firstname"><%= item.FirstName %></td>
                    <td class="search-lastname"><%= item.LastName %></td>
                    <td><%= item.NationalCode %></td>
                    <td><%= item.BirthDate.ToShortDateString() %></td>
                    <td><%= item.EmploymentType %></td>
                    <td><%= item.EmploymentDate.ToShortDateString() %></td>
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
            <label><%= Resources.Messages.NoEmployees %></label>
        </div>
    </div>
    <%
        }
    %>

    <div class="modal fade" id="deleteEmployeeModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><%= Resources.Pages.EmployeeIndex.EmployeeDeleteTitle %></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <label><%= Resources.Pages.EmployeeIndex.EmployeeDeleteQuestion %></label>
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
        </div>
    </div>

    <script>
        $(document).ready(function () {

            $("#search-input").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#search-button").prop("disabled", (value === "") ? true : false);
            });

            $("#show-all-button").on("click", function () {
                $("#search-input").val('');
                $("#search-button").click();
                $("#show-all-button").toggle(false);
            });

            $("#search-button").on("click", function () {
                var value = $("#search-input").val().toLowerCase();
                var found = false;
                var count = 0;
                $("#employee-table tr").filter(function () {
                    var firstName = $(this).find(".search-firstname").text();
                    var lastName = $(this).find(".search-lastname").text();
                    var fullName = firstName + " " + lastName;
                    var isFound = fullName.indexOf(value) > -1;
                    if (isFound == true) {
                        count++;
                    }
                    found = found || isFound;

                    $(this).toggle(fullName.indexOf(value) > -1)
                });
                if (count > 0 && value !== "") {
                    $("#show-all-button").toggle(true);
                    $("#result-count").html(count);
                    $("#search-found-result").toggleClass("d-none", !found);
                }
                $("#search-no-result").toggle(count === 0 && !found && value !== "");
                $("#search-found-result").toggle(count > 0 && found && value !== "");
                $(".table-responsive").toggleClass("d-none", count == 0 && !found && value !== "");
            });
        });

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
