using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace ChargoonTestApplication
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            //var settings = new FriendlyUrlSettings();
            //settings.AutoRedirectMode = RedirectMode.Off;
            //routes.EnableFriendlyUrls(settings);
            routes.MapPageRoute(
                "Home",
                "",
                "~/Pages/Home/Home.aspx"
            );
            routes.MapPageRoute(
                "CreateEmployee",
                "Employee/Create",
                "~/Pages/Employee/Create.aspx"
            );
            routes.MapPageRoute(
                "EditEmployee",
                "Employee/Edit/{id}",
                "~/Pages/Employee/Edit.aspx"
            );
            routes.MapPageRoute(
                "IndexEmployees",
                "Employee/Index",
                "~/Pages/Employee/Index.aspx"
            );
            routes.MapPageRoute(
                "DeleteEmployee",
                "Employee/Delete/{id}",
                "~/Pages/Employee/Index.aspx/DeleteEmployee?id={id}"
            );
            routes.MapPageRoute(
                "SearchEmployee",
                "Employee/Search/",
                "~/Pages/Employee/Search.aspx"
            );
            routes.MapPageRoute(
                "CreateEmploymentType",
                "EmploymentType/Create",
                "~/Pages/EmploymentType/Create.aspx"
            );
            routes.MapPageRoute(
                "EditEmploymentType",
                "EmploymentType/Edit",
                "~/Pages/EmploymentType/Edit.aspx"
            );
            routes.MapPageRoute(
                "IndexEmploymentTypes",
                "EmploymentType/Index",
                "~/Pages/EmploymentType/Index.aspx"
            );
            routes.MapPageRoute(
                "Error",
                "{*url}",
                "~/Pages/Error/Error.aspx"
            );
        }
    }
}
