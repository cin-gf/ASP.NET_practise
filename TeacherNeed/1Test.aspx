<%@ Page Language="C#" AutoEventWireup="true" CodeFile="1Test.aspx.cs" MaintainScrollPositionOnPostback="true" Inherits="_20231130" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" defaultfocus="TBtest" defaultbutton="nextButton">
        <div>
            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="View1" runat="server">
                    <asp:GridView ID="CBF110048_GV1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="id" DataSourceID="SqlDataSource2" EmptyDataText="There are no data records to display." ForeColor="Black" GridLines="None" OnRowDeleted="CBF110048_GV1_RowDeleted">
                        <AlternatingRowStyle BackColor="PaleGoldenrod" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True" CommandName="Update" Text="更新"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消"></asp:LinkButton>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" CommandName="Edit" Text="編輯"></asp:LinkButton>
                                    &nbsp;<asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('你確定要刪除嗎?')" Text="刪除"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Wrap="False" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="word" HeaderText="word" SortExpression="word" />
                            <asp:BoundField DataField="ch_explanation" HeaderText="ch_explanation" SortExpression="ch_explanation" />
                            <asp:TemplateField HeaderText="sentence" SortExpression="sentence">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("sentence") %>' TextMode="MultiLine" Width="98%"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("sentence") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="sno" HeaderText="sno" SortExpression="sno" />
                            <asp:BoundField DataField="level" HeaderText="level" SortExpression="level" />
                        </Columns>
                        <FooterStyle BackColor="Tan" />
                        <HeaderStyle BackColor="Tan" Font-Bold="True" />
                        <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                        <SortedAscendingCellStyle BackColor="#FAFAE7" />
                        <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                        <SortedDescendingCellStyle BackColor="#E1DB9C" />
                        <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString1 %>" DeleteCommand="DELETE FROM [gept_words] WHERE [Id] = @Id" InsertCommand="INSERT INTO [gept_words] ([Id], [word], [ch_explanation], [sentence], [sno], [level], [frequency], [weight]) VALUES (@Id, @word, @ch_explanation, @sentence, @sno, @level, @frequency, @weight)" SelectCommand="SELECT [Id], [word], [ch_explanation], [sentence], [sno], [level], [frequency], [weight] FROM [gept_words]" UpdateCommand="UPDATE [gept_words] SET [word] = @word, [ch_explanation] = @ch_explanation, [sentence] = @sentence, [sno] = @sno, [level] = @level, [frequency] = @frequency, [weight] = @weight WHERE [Id] = @Id">
                        <DeleteParameters>
                            <asp:Parameter Name="Id" Type="Double" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Id" Type="Double" />
                            <asp:Parameter Name="word" Type="String" />
                            <asp:Parameter Name="ch_explanation" Type="String" />
                            <asp:Parameter Name="sentence" Type="String" />
                            <asp:Parameter Name="sno" Type="String" />
                            <asp:Parameter Name="level" Type="Double" />
                            <asp:Parameter Name="frequency" Type="Double" />
                            <asp:Parameter Name="weight" Type="Double" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="word" Type="String" />
                            <asp:Parameter Name="ch_explanation" Type="String" />
                            <asp:Parameter Name="sentence" Type="String" />
                            <asp:Parameter Name="sno" Type="String" />
                            <asp:Parameter Name="level" Type="Double" />
                            <asp:Parameter Name="frequency" Type="Double" />
                            <asp:Parameter Name="weight" Type="Double" />
                            <asp:Parameter Name="Id" Type="Double" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    <br />
                    <br />
                    請點選單字來查詢中文解釋<br /> 
                    <asp:DropDownList ID="CBF110048_DDL1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="word" DataValueField="ch_explanation" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString1 %>" SelectCommand="SELECT * FROM [gept_words]"></asp:SqlDataSource>
                    <asp:Button ID="CBF110048_PreviousButton" runat="server" OnClick="CBF110048_PreviousButton_Click" Text="PreviousButton" />
                    <asp:Button ID="CBF110048_NextButton" runat="server" OnClick="CBF110048_NextButton_Click" Text="NextButton" />
                    <asp:Button ID="TestButton" runat="server" OnClick="TestButton_Click" Text="測驗去" />
                    <div id="mydiv" runat="server">
                    </div>
                    <br />
                    <br />
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="https://github.com/cin-gf/ASP.NET_practise/blob/main/TeacherNeed/HtmlPage.html">GitHub心得</asp:HyperLink>
                    &nbsp;<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/HtmlPage.html">本地端心得網頁</asp:HyperLink>
                    <br />
                </asp:View>
                <asp:View ID="View2" runat="server">
                    <asp:Literal ID="msg" runat="server"></asp:Literal>
                    <asp:TextBox ID="TBtest" runat="server" onfocus="this.select()"></asp:TextBox>
                    <asp:Button ID="nextButton" runat="server" OnClick="nextButton_Click" Text="下一題" />
                    <asp:Button ID="endButton" runat="server" OnClick="endButton_Click" Text="結束" Visible="False" />
                    <br />
                    <span style="color: rgb(0, 0, 0); font-family: &quot;Times New Roman&quot;; font-size: medium; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">請輸入完整單字(底線是用來提示有幾個字元, 如果消失了可以移動滑鼠至方格上來查看.)<br /> </span>
                    <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/1Test.aspx" Visible="False">重玩</asp:HyperLink>
                </asp:View>
                <asp:View ID="View3" runat="server">
                    
                </asp:View>
            </asp:MultiView>
            <br />
        </div>
        <br />
    </form>
</body>
</html>
