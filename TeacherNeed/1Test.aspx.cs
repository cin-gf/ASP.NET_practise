using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// 只差題目和分數

public partial class _20231130 : System.Web.UI.Page
{
    int[] subjectIndex;      // 紀錄題目順序
    int subjectNumber ;   // 紀錄目前題號0
    float correctans ;      // 紀錄正確數
    float faultans ;        // 紀錄作答錯誤數
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            MultiView1.ActiveViewIndex = 0;                    // 先顯示 view1
            Session["pageIndex"] = 0;                          // 預設選單是第一頁，編號為0
            Session["totalRowCount"] = GetTotalRowCount();     // 取得資料檔案共有多少筆資料 (1001)
            Session["faultans"] = faultans;
            Session["correctans"] = correctans;
            CBF110048_PreviousButton.Enabled = false;
            CBF110048_NextButton.Enabled = true;

            Session["subjectNumber"] = subjectNumber;

            BindDropDownList();         // 自創方法，建立 DDL 的資料
            CreateHyperLink();          // 自創方法，顯示 DDL 的連結資料
        }
    }

    protected void BindDropDownList()   // 建立 DDL 的資料
    {
        int pageIndex = (int)Session["pageIndex"];
        int pageSize = 10;     // pageSize 用來存放下拉是選單顯示的個數
        int offset = pageIndex * pageSize;

        SqlDataSource1.SelectCommand = $"SELECT * FROM [gept_words] ORDER BY [id] OFFSET {offset} ROWS FETCH NEXT {pageSize} ROWS ONLY";
        CBF110048_DDL1.DataBind();
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        CreateHyperLink();
    }
    protected int GetTotalRowCount()   // 得到 SqlDataSource1 的 資料總筆數
    {
        SqlDataSource1.SelectCommand = "select * from gept_words";
        DataSourceSelectArguments args = new DataSourceSelectArguments();
        DataView dv = (DataView)SqlDataSource1.Select(args);  //針對基本資料擷取以外的資料要求作業。

        int totalRowCount = dv.Count;
        return totalRowCount;
    }
    private void CreateHyperLink()   // 顯示 DDL 的連結資料
    {
        // 創建 HyperLink 控件
        HyperLink HL = new HyperLink();
        HL.Text = CBF110048_DDL1.SelectedItem.ToString();
        HL.NavigateUrl = "https://dictionary.cambridge.org/zht/詞典/英語-漢語-繁體/" + HL.Text;
        //HL.Target = "_blank"; // 在新視窗中開啟連結

        // 將 HyperLink 添加到 mydiv
        mydiv.InnerHtml += $"<a href='{HL.NavigateUrl}'>{HL.Text}</a>=>{CBF110048_DDL1.SelectedValue}<br />";

    }
    protected void CBF110048_NextButton_Click(object sender, EventArgs e)
    {
        int pageIndex = (int)Session["pageIndex"];
        CBF110048_PreviousButton.Enabled = true;
        pageIndex++;                        // 頁數 +1
        Session["pageIndex"] = pageIndex;
        BindDropDownList();
        if (pageIndex >= ((int)Session["totalRowCount"] / 10 - 1))  // totalRowCount / 10 = 100 ，但 pageIndex 由 0 計算所以 -1。
        {
            CBF110048_NextButton.Enabled = false;
        }
        mydiv.InnerText = "";
        CreateHyperLink();
    }

    protected void CBF110048_PreviousButton_Click(object sender, EventArgs e)
    {
        int pageIndex = (int)Session["pageIndex"];
        if (pageIndex == 0)
        {
            CBF110048_PreviousButton.Enabled = false;
        }
        else if (pageIndex == 1) 
        {
            pageIndex--;
            Session["pageIndex"] = pageIndex;
            BindDropDownList();
            CBF110048_PreviousButton.Enabled = false;
        }
        else
        {
            pageIndex--;
            Session["pageIndex"] = pageIndex;
            BindDropDownList();
        }
        CBF110048_NextButton.Enabled = true;
        mydiv.InnerText = "";
        CreateHyperLink();
    }
    

    protected void CBF110048_GV1_RowDeleted(object sender, GridViewDeletedEventArgs e)  // 刪除GV1的資料時，DDL 的資料也會立刻更新。
    {
        BindDropDownList();  
        mydiv.InnerText = "";
        CreateHyperLink();
    }
    private void Shuffle()  //洗牌演算法，回傳建立好的題目順序
    {
        // 初始化 subjectIndex 
        subjectIndex = new int[CBF110048_DDL1.Items.Count];     
        for (int i = 0; i < subjectIndex.Length; i++) subjectIndex[i] = i;
        // 洗牌 subjectIndex 的資料
        Random ran = new Random();
        for (int i = subjectIndex.Length - 1; i >= 0; i--)     // subjectIndex.Length ==> 10
        {
            int r = ran.Next(0, i + 1);           // 含0，不含i+1。
            int temp = subjectIndex[i];
            subjectIndex[i] = subjectIndex[r];
            subjectIndex[r] = temp;
        }
        Session["subjectIndex"] = subjectIndex;
    }
    private void displaytest()  //顯示題目
    {
        //Response.Output.WriteLine(subjectIndex[0]);
        //Shuffle();
        subjectNumber = (int)Session["subjectNumber"];
        subjectIndex = (int[])Session["subjectIndex"];

        CBF110048_DDL1.SelectedIndex = subjectIndex[subjectNumber];
        msg.Text = CBF110048_DDL1.SelectedValue;
        char firstword = Convert.ToString(CBF110048_DDL1.SelectedItem)[0];    // 存取 DDL1 資料的第一個字
        int wordnumber = Convert.ToInt32(Convert.ToString(CBF110048_DDL1.SelectedItem).Length - 1);   
        TBtest.Text = string.Format($"{firstword}");
        string lastword;
        for (int i = 0; i < wordnumber; i++)
        {
            if (i == wordnumber - 1) { lastword = "_"; }
            else { lastword = "_ "; }
            TBtest.Text += string.Format($"{lastword}");
        }
    }
    protected void TestButton_Click(object sender, EventArgs e)   // Button：測驗去
    {
        MultiView1.ActiveViewIndex = 1;
        Shuffle();
        displaytest();
        
    }
    protected void nextButton_Click(object sender, EventArgs e)   // Button：下一題
    {
        // 檢測作答正確性
        if (TBtest.Text == Convert.ToString(CBF110048_DDL1.SelectedItem))
        {
            Response.Output.Write($"答對了!");
            Session["correctans"] = (float)Session["correctans"] + 1;
        }
        else
        {
            Response.Output.Write($"答錯了! 答案是{CBF110048_DDL1.SelectedItem}");
            Session["faultans"] = (float)Session["faultans"] + 1;
            //Response.Output.WriteLine(string.Format($"分數：{(float)Session["faultans"],2}。"));
        }
        // 換題目
        if ((int)Session["subjectNumber"] < CBF110048_DDL1.Items.Count-1)
        {
            Session["subjectNumber"] = (int)Session["subjectNumber"] +1;
            displaytest();
        }
        else
        {
            float score = (float)Session["correctans"] * 10;
            Response.Output.WriteLine(string.Format($"總得分: {score:0.00}"));
            msg.Visible = false;           
            TBtest.Visible = false;        // 不能輸入TextBox
            nextButton.Visible = false;    // 不能在下一題
            endButton.Visible = true;      // 能案結束
            HyperLink3.Visible = true;     // 顯示重玩的連結
        }
    }
    protected void endButton_Click(object sender, EventArgs e)   // Button：結束
    {
        MultiView1.ActiveViewIndex = 2;
    }

}