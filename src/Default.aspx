﻿<%@ Page Language="C#" %>
<%@ Import Namespace="NuGet.Server" %>
<%@ Import Namespace="NuGet.Server.App_Start" %>
<%@ Import Namespace="NuGet.Server.Infrastructure" %>
<%@ Import Namespace="System.Configuration" %>

<%   
    if (!HttpContext.Current.Request.IsLocal)
    {
        Response.Status = "403 Forbidden";
        Response.End();
    }
%>

<% var baseUrl = ConfigurationManager.AppSettings.Get("baseUrl"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>NuGet Private Repository</title>
    <style>
        body { font-family: Calibri; }
    </style>
</head>
<body>
    <div>
        <h2>You are running NuGet.Server v<%= typeof(NuGetODataConfig).Assembly.GetName().Version %></h2>
        <p>
            Click <a href="<%= VirtualPathUtility.ToAbsolute($"~/{baseUrl}/Packages") %>">here</a> to view your packages.
        </p>
        <fieldset style="width:800px">
            <legend><strong>Repository URLs</strong></legend>
            In the package manager settings, add the following URL to the list of 
            Package Sources:
            <blockquote>
               <%-- <strong><%= Helpers.GetRepositoryUrl(Request.Url, Request.ApplicationPath) %></strong>--%>
                <strong><%= Request.Url.DnsSafeHost + "/" + baseUrl %></strong>
            </blockquote>
            <% if (string.IsNullOrEmpty(ConfigurationManager.AppSettings["apiKey"])) { %>
            To enable pushing packages to this feed using the <a href="https://www.nuget.org/downloads">NuGet command line tool</a> (nuget.exe), set the <code>apiKey</code> appSetting in web.config.
            <% } else { %>
            Use the command below to push packages to this feed using the <a href="https://www.nuget.org/downloads">NuGet command line tool</a> (nuget.exe).
            <blockquote>
                <strong>nuget.exe push {package file} {apikey} -Source 
                    <%--= Helpers.GetPushUrl(Request.Url, baseUrl) --%>
                    <strong><%= Request.Url.DnsSafeHost + "/" + baseUrl %></strong>
                </strong>
            </blockquote>
            <% } %> 
        </fieldset>

        <% if (Request.IsLocal) { %>
        <fieldset style="width:800px">
            <legend><strong>Adding packages</strong></legend>

            To add packages to the feed put package files (.nupkg files) in the folder
            <code><% = PackageUtility.PackagePhysicalPath %></code><br/><br/>

            Click <a href="<%= VirtualPathUtility.ToAbsolute($"~/{baseUrl}/clear-cache") %>">here</a> to clear the package cache.
        </fieldset>
        <% } %>
    </div>
</body>
</html>
