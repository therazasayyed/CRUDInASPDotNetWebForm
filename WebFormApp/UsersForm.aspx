<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsersForm.aspx.cs" Inherits="WebFormApp.UsersForm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <link href="Style.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="smforajaxcontroltoolkit" runat="server"></asp:ScriptManager>
        <table style="width: 100%">
            <tr>
                <td style="width: 30%; padding: 8px;">
                    <div class="login-box">
                        <h3>Register</h3>
                        <div class="form-group">
                            <asp:Label ID="lblName" runat="server" Text="Name" CssClass="form-label" />
                            <asp:TextBox ID="txtName" runat="server" CssClass="input-box" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblDateOfBirth" runat="server" Text="DateOfBirth" CssClass="form-label" />
                            <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="input-box" />
                            <ajax:CalendarExtender ID="calDOB" runat="server" PopupButtonID="txtDateOfBirth" PopupPosition="TopRight" TargetControlID="txtDateOfBirth" Format="MM/dd/yyyy" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblGender" runat="server" Text="Gender" CssClass="form-label" />
                            <asp:RadioButtonList ID="rblGender" runat="server" RepeatColumns="3">
                            </asp:RadioButtonList>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblPhone" runat="server" Text="Phone" CssClass="form-label" />
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="input-box" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblAddress" runat="server" Text="Address" CssClass="form-label" />
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="input-box" TextMode="MultiLine" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblPhoto" runat="server" Text="Photo" CssClass="form-label" />
                            <asp:FileUpload ID="fuPhoto" runat="server" CssClass="fileUploadAlign" />
                        </div>
                        <div style="text-align: center; margin-top: 10px;">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="buttonAlign" />
                        </div>
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green" CssClass="lblAlign" /><br />
                    </div>
                </td>
                <td style="width: 70%">
                    <table>
                        <tr>
                            <td style="text-align: center;">
                                <h3>User Information</h3>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="gvUsersList" runat="server" Width="100%" AutoGenerateColumns="false" OnRowCommand="gvUsersList_RowCommand" EmptyDataText="No Records Found">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Id">
                                            <ItemTemplate>
                                                <%# Eval("UserId") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <%# Eval("UserName") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date Of Birth">
                                            <ItemTemplate>
                                                <%# Eval("DateOfBirth") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Gender">
                                            <ItemTemplate>
                                                <%# Eval("GenderName") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Phone No">
                                            <ItemTemplate>
                                                <%# Eval("UserPhone") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address">
                                            <ItemTemplate>
                                                <%# Eval("UserAddress") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Photo">
                                            <ItemTemplate>
                                                <asp:Image ID="userImg" runat="server" Width="45px" Height="25px" ImageUrl='<%# Eval("UserPhoto", "~/UsersImage/{0}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="UserEdit" CommandArgument='<%# Eval("UserId") %>' />
                                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="UserDelete" CommandArgument='<%# Eval("UserId") +","+Eval("UserPhoto") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
