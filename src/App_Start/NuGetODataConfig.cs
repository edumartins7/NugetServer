using System.Configuration;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.ExceptionHandling;
using System.Web.Http.Routing;
using NuGet.Server;
using NuGet.Server.Infrastructure;
using NuGet.Server.V2;

[assembly: WebActivatorEx.PreApplicationStartMethod(typeof(MyNugetServer.App_Start.NuGetODataConfig), "Start")]

namespace MyNugetServer.App_Start 
{
    public static class NuGetODataConfig 
	{
        public static void Start() 
		{
            string baseUrl = ConfigurationManager.AppSettings.Get("baseUrl");

            ServiceResolver.SetServiceResolver(new DefaultServiceResolver());

            var config = GlobalConfiguration.Configuration;

            NuGetV2WebApiEnabler.UseNuGetV2WebApiFeed(config, "NuGetDefault", baseUrl, "PackagesOData");

            config.Services.Replace(typeof(IExceptionLogger), new TraceExceptionLogger());

            // Trace.Listeners.Add(new TextWriterTraceListener(HostingEnvironment.MapPath("~/NuGet.Server.log")));
            // Trace.AutoFlush = true;

            config.Routes.MapHttpRoute(
                name: "NuGetDefault_ClearCache",
                routeTemplate: $"{baseUrl}/clear-cache",
                defaults: new { controller = "PackagesOData", action = "ClearCache" },
                constraints: new { httpMethod = new HttpMethodConstraint(HttpMethod.Get) }
            );

        }
    }
}