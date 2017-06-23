<%@ WebHandler Language="C#" Class="AutoApprovalCommentsHandler" %>

using System.IO;
using System.Xml;
using System.Net;
using System.Web;
using MarvalSoftware.UI.WebUI.ServiceDesk.RFP.Plugins;
using Newtonsoft.Json;


/// <summary>
/// Auto Approval Comments Plugin Handler
/// </summary>
public class AutoApprovalCommentsHandler : PluginHandler
{
    public override bool IsReusable { get { return false; } }

    /// <summary>
    /// Main Request Handler
    /// </summary>
    public override void HandleRequest(HttpContext context)
    {
        switch (context.Request.HttpMethod)
        {
            case "GET":
                context.Response.Write(JsonConvert.SerializeObject(new PluginSettings(this.GlobalSettings["Approve Comment"], this.GlobalSettings["Reject Comment"], this.GlobalSettings["Override Existing"])));
                break;
        }
    }

    public class PluginSettings
    {
        public string approveComment { get; set; }
        public string rejectComment { get; set; }
        public bool overrideExisting { get; set; }
        public PluginSettings()
        {
            approveComment = string.Empty;
            rejectComment = string.Empty;
            overrideExisting = false;
        }
        public PluginSettings(string ApprovalComment, string RejectComment, string OverrideExisting)
        {
            approveComment = ApprovalComment ?? string.Empty;
            rejectComment = RejectComment ?? string.Empty;
            overrideExisting = String2BoolF(OverrideExisting);
        }
    }

    private static bool String2BoolF(string bools)
    {
        bool b = false;
        return System.Boolean.TryParse((bools ?? string.Empty), out b) ? b : false;
    }

}