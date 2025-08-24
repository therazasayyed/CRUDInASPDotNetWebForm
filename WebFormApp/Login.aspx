<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebFormApp.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="Style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="center-container">
            <div class="login-box">
                <h3>Login</h3>
                <div class="form-group">
                    <asp:Label ID="lblUserName" runat="server" Text="Username" CssClass="form-label" />
                    <asp:TextBox ID="txtUserName" runat="server" CssClass="input-box" />
                </div>
                <div class="form-group">
                    <asp:Label ID="lblPassword" runat="server" Text="Password" CssClass="form-label" />
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-box" />
                </div>
                <div style="text-align: center; margin-top: 10px;">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="buttonAlign" OnClick="btnLogin_Click" />
                </div>
                <asp:Label ID="lblMsg" runat="server" ForeColor="Red" CssClass="lblAlign" /><br />
            </div>
        </div>
    </form>
</body>
</html>
