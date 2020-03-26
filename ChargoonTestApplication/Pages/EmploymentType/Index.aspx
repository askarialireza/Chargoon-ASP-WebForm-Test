<%@ Page Title="<%$ Resources:EmploymentTypeIndex, Title %>" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="ChargoonTestApplication.Pages.EmploymentType.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h5><%= Resources.EmploymentTypeIndex.Title %></h5>
    <hr />

    <% if (Services.EmploymentTypeService.GetAll().Count() > 0)
        {
    %>

    <div class="w-100">
        <a class="ml-auto mb-2 btn btn-success text-white float-md-left" href="/EmploymentType/Create">
            <%= Resources.EmploymentTypeIndex.CreateEmploymentType %>
        </a>
    </div>

    <div id="alert" class="alert alert-danger alert-dismissible fade show" role="alert" style="display: none;">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
        <label><%= Resources.EmploymentTypeIndex.NameIsRequired %></label>
    </div>

    <div class="table-responsive">
        <table class="table table-sm table-bordered" id="employment-table">
            <thead class="thead-light">
                <tr>
                    <th scope="col"><%= Resources.Employment.Id %></th>
                    <th scope="col"><%= Resources.Employment.Name %></th>
                    <th scope="col"><%= Resources.Employment.IsActive %></th>
                    <th scope="col"><%= Resources.EmploymentTypeIndex.Actions %></th>
                </tr>
            </thead>
            <tbody id="employment-table-body">
                <%
                    foreach (var item in Services.EmploymentTypeService.GetAll())
                    {
                %>
                <tr>
                    <td class="employment-id-col"><%= item.Id %></td>
                    <td class="employment-name-col">
                        <span class="employment-name-label"><%= item.Name %></span>
                        <input class="form-control employment-name-input" value="<%= item.Name %>" style="display: none;" />
                    </td>
                    <td class="employment-isactive-col">
                        <input type="checkbox" <%=item.IsActive?"checked":"" %> disabled>
                    </td>
                    <td>
                        <div class="buttons">
                            <a class="btn btn-sm btn-danger text-white" id="bDel" data-employment-type-id="<%=item.Id %>" onclick="openModal(<%=item.Id%>)">
                                <i class="fa fa-trash"></i>
                                <%= Resources.Buttons.Delete %>
                            </a>
                            <a class="btn btn-sm btn-success" style="display: none;" id="bAcep">
                                <i class="fa fa-check"></i>
                                <%= Resources.Buttons.Submit %>
                            </a>
                            <a class="btn btn-sm btn-warning" style="display: none;" id="bCanc">
                                <i class="fa fa-ban"></i>
                                <%= Resources.Buttons.Cancel %>
                            </a>
                            <a class="btn btn-sm btn-info" id="bEdit">
                                <i class="fa fa-pencil"></i>
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
            <label><%= Resources.EmploymentTypeIndex.NoEmploymentTypes %></label>
        </div>
    </div>
    <%
        }
    %>

    <div class="modal fade" id="deleteEmploymentModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><%= Resources.EmploymentTypeIndex.DeleteTitle %></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <label><%= Resources.EmploymentTypeIndex.DeleteQuestion %></label>
                </div>
                <div class="modal-footer">
                    <button id="delete-employment-type-modal-button" data-employee-id="1" class="btn btn-danger" onclick="deleteEmployee()">
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
        var oldName;
        var oldIsActive
        var newIsActive;
        var newName;

        function Cancel(object) {
            setEditableColumns(object, true);
            oldName = $(object).parent().parent().parent().find(".employment-name-label").text();
            $(object).parent().parent().parent().find(".employment-name-input").val(oldName);
            oldIsActive = $(object).parent().parent().parent().find("input[type='checkbox']").prop('checked');
        }
        //Edit Clicked ...
        $("tbody tr #bEdit").click(function () {
            Cancel(this);
        });
        // Cancel Clicked ...
        $("tbody tr #bCanc").click(function () {
            setEditableColumns(this, false);
            $(this).parent().parent().parent().find(".employment-name-label").text(oldName);
            $(this).parent().parent().parent().find(".employment-name-input").val(oldName);
            $(this).parent().parent().parent().find("input[type='checkbox']").prop('checked', oldIsActive);
        });
        // Submit Clicked
        $("tbody tr #bAcep").click(function () {
            setEditableColumns(this, false);
            newName = $(this).parent().parent().parent().find(".employment-name-input").val();
            newIsActive = $(this).parent().parent().parent().find("input[type='checkbox']").prop('checked');
            var id = $(this).parent().parent().parent().find(".employment-id-col").text();
            var oldLabel = $(this).parent().parent().parent().find(".employment-name-label");
            var myJsonData = {
                id: id,
                name: newName,
                isActive: newIsActive,
            }

            $.ajax({
                type: "POST",
                url: "/Pages/EmploymentType/Index.aspx/EditEmploymentType",
                data: JSON.stringify(myJsonData),
                contentType: "application/json; charset=utf-8",
                async: false,
                dataType: "json",
                success: function (success) {
                    if (success.d == 2) {
                        Cancel(this);
                    }
                    if (success.d == 1) {
                        Cancel(this);
                        $("#alert").fadeIn();
                        setTimeout(function () {
                            $('#alert').fadeOut(1000);
                        }, 3000);
                    }
                    if (success.d == 0) {
                        oldLabel.text(newName);

                    }
                },
                error: function (error) {
                }
            });
        });

        function setEditableColumns(col, value) {

            var buttons = $(col).parent();

            toggleButtons(buttons, value);

            var colName = buttons.parent().parent().find(".employment-name-col");
            colName.find(".employment-name-input").toggle();
            colName.find(".employment-name-label").toggle();
            colName.find(".employment-name-input").focus();

            var colActive = buttons.parent().parent().find(".employment-isactive-col");
            colActive.find("input").prop("disabled", !value);
        }

        function toggleButtons(buttons, value) {
            buttons.find("#bEdit").toggle(!value);
            buttons.find("#bDel").toggle(!value);
            buttons.find("#bAcep").toggle(value);
            buttons.find("#bCanc").toggle(value);
        }

        function openModal(id) {

            $('#deleteEmploymentModal').modal();

            $("#delete-employment-type-modal-button").data('employment-type-id', id);
        }

        function deleteEmployee() {

            var id = $("#delete-employment-type-modal-button").data('employment-type-id');

            $.ajax({
                type: "POST",
                url: "/Pages/EmploymentType/Index.aspx/DeleteEmploymentType",
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
