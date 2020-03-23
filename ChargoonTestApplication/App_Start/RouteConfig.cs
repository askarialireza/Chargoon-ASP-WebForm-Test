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
                "~/Pages/Employee/Index.aspx/DeleteEmployee"
            );
            routes.MapPageRoute(
                "Error",
                "{*url}",
                "~/Pages/Error/Error.aspx"
            );
        }
    }
}
