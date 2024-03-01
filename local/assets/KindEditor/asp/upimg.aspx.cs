using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Drawing;

namespace zxwup
{
    public partial class uploadSave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //数据配置
            int isCheckToken=0;     //是否需要进行token检测，0=否、1=是
            int isCompressImg=1;    //是否要压缩图片尺寸，0=否、1=是                  
            int isCreatSmallimg=1;  //是否生成小图（0=否、1=是）
            int isCreatLogo=1;      //是否打水印（0=否、1=是）
            int compressType=1;     //压缩图片方式，0=固定尺寸压缩、1=按照最大宽或者高等比例压缩 
            int compressWidth=800;  //压缩图片宽度（固定压缩=宽度、等比例压缩=最大宽度）
            int compressHeight=600; //压缩图片高度（固定压缩=高度度、等比例压缩=最大高度）
            int smallImgWidth=200;                 //生成小图宽度
            int smallImgHeight=200;             //生成小图高度
            string logoPostion="左下角、rigth";  //水印位置（left=左下角、rigth=右下角、leftTop=左上角、rightTop=右上角）
            string logoUrl="logo.png";  //水印文件
            int allowMinSize=1;     //允许上传文件的最小大小
            int allowMaxSize=2*1024*1024;   //允许上传文件的最大大小
            int isAllowExt=3;   //是否进行文件类型检测（0=不检测、1=仅扩展名检测、2=仅文件内容检测、3=扩展名+内容检测：内容检测允许上传类型：jpeg|jpg|png|gif|txt|htm|html|xls|doc|csv|docx|xlsx）
            string allowExt="jpeg|jpg|png|gif|bmp";     //允许上传文件类型(扩展名检测)
            string folder_big="/upload/editor/big/";   //上传文件保存文件夹地址（大图或者原图保存地址）
            string folder_small="/upload/editor/small/"; //上传文件保存文件夹地址（小图保存地址）            
            string token_key="zxw@@@88";    //des解码密钥，非必要无需调整，调整请与加密程序密钥一起调整
            string md5_key="";              //生成md5插入的随机字符串

            //上传步骤：检测token+上传文件
            //检测token：token一般由 tk（tkid进行md5加密后产生）+ts(时间戳)+key 生成；解密token后拆解成tk+ts,验证tk是否正确，ts是否过期
            //上传文件：生成文件夹、检测文件大小、检测文件扩展名、打水印、压缩图片、生成小图
            //方法： 检测token：cheToken，解密：DesDec，Md5加密：setMd5，时间戳：getTimeTamp，4位随机数：rnd，检测文件扩展名：chkExt；检测文件类型：chkExt2；打水印：logoImg；压缩图片：comImg；生成小图：smallImg

            try
            {
                //string 
                //检测token
                if(isCheckToken==1){
                    string token = "", tkid = "";
                    tkid = Request.Form["tkid"];
                    token = Request.Form["token"];
                    if (token == "" || tkid == "")
                    {
                        Response.Write("<script language='javascript'>alert('非法提交！');history.go(-1)</script>");
                        return;
                    }
                    else
                    {
                        string chktoken = cheToken(tkid+md5_key, token,token_key);
                        if (chktoken != "success")
                        {
                            Response.Write("<script language='javascript'>alert('" + chktoken + "');history.go(-1)</script>");
                            return;
                        };
                    }
                }
                
                //开始上传文件
                HttpPostedFile files = Request.Files["imgFile"];
                string folder = folder_big;           //上传文件夹
                folder = folder + DateTime.Now.ToString("yyyyMM")+"/";
                if (System.IO.Directory.Exists(folder) == false)    //文件夹不存在生成文件夹
                {
                    System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath(folder));
                }
                string sjs = rnd(4);                //4位随机数
                string ext = Path.GetExtension(files.FileName).ToLower();       //获取扩展名
                string path = Server.MapPath(folder);
                string fileName=DateTime.Now.ToString("yyyyMMddHHmmss") + sjs + ext;          //保存文件的文件名
                int fileSize = files.ContentLength;             //上传文件大小
                int minSize = allowMinSize;                        //最小允许上传1K
                int maxSize = allowMaxSize;          //最大允许上传2M
                string exts=allowExt;           //允许上传的文件类型
                if(isAllowExt==1||isAllowExt==3){
                    if (chkExt(ext,exts) != "success")   //通过文件名判断文件格式
                    {
                        Response.Write("{ \"error\" : 1,\"message\" : \"上传文件格式错误！\"}");
                        return;
                    }
                }
                if(isAllowExt==2||isAllowExt==3){
                    if (chkExt2(files,folder) != "success")    //通过文件内容判断文件格式
                    {
                        Response.Write("{ \"error\" : 1,\"message\" : \"上传文件格式错误！\"}");
                        return;
                    }
                }
                if (fileSize < minSize)
                {
                    Response.Write("{ \"error\" : 1,\"message\" : \"请选择上传文件！\"}");
                    return;
                }
                if (fileSize > maxSize)
                {
                    Response.Write("{ \"error\" : 1,\"message\" : \"上传文件过大！\"}");
                    return;
                }

                files.SaveAs(path+ fileName); //保存文件  
                if(isCompressImg==1){
                    comImg(folder,fileName,compressType,compressWidth,compressHeight);   //压缩图片
                }
                if(isCreatLogo==1){
                    logoImg(folder,fileName,logoUrl,logoPostion);   //打水印
                }
                if(isCreatSmallimg==1){
                    smallImg(folder,folder_small,fileName,smallImgWidth,smallImgHeight); //生成小图
                }
                string successUrl=folder+fileName;
                Response.Write("{ \"error\" : 0,\"url\" : \""+successUrl+"\"}");
                return;

            }
            catch (Exception ex){
                Response.Write("{ \"error\" : 1,\"message\" : \"上传失败！\"}");
                return;
            }

        }


        //生成小图
        static string smallImg(string small_oldPath,string small_path,string small_file,int small_width,int small_height)
        {
            string folder_old = small_oldPath ; 
            string path = HttpContext.Current.Server.MapPath(folder_old+small_file);
            Bitmap img = new Bitmap(path);
            string folder = small_path;
            string newFolder = folder + DateTime.Now.ToString("yyyyMM")+"/";
            if (System.IO.Directory.Exists(newFolder) == false)
            {
                System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath(newFolder));
            }
            int oldW = img.Width;
            int oldH = img.Height;
            int newW = small_width;
            int newH = small_height;
            string fileName = newFolder+small_file;
            string fielPath = HttpContext.Current.Server.MapPath(fileName);
            System.Drawing.Image bitmap = new System.Drawing.Bitmap(newW, newH);
            Graphics g = System.Drawing.Graphics.FromImage(bitmap);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            g.Clear(Color.Transparent);
            g.DrawImage(img, new Rectangle(0, 0, newW, newH), new Rectangle(0, 0, oldW, oldH), GraphicsUnit.Pixel);
            string smallImg = "";
            try
            {
                bitmap.Save(fielPath, System.Drawing.Imaging.ImageFormat.Jpeg);
                smallImg = fileName;
            }
            catch
            {
            }
            finally
            {
                img.Dispose();
                bitmap.Dispose();
                g.Dispose();
            }
            return smallImg;
        }


        //原图压缩图片
        public string comImg(string com_path,string com_file,int com_type,int com_widht,int com_height)
        {          
            string folder_old = com_path ;
            string path = HttpContext.Current.Server.MapPath(folder_old+com_file);
            Bitmap img = new Bitmap(path);
            string newFolder = folder_old;
            
            if (System.IO.Directory.Exists(newFolder) == false)
            {
                System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath(newFolder));
            }
            int newW;
            int newH;
            int oldW = img.Width;
            int oldH = img.Height;
            
            if (com_type==0){//固定尺寸压缩
                newW=com_widht;
                newH=com_height;
            }else{//等比例压缩
                newW = com_widht;
                newH = com_height;
                if (newW > oldW)
                {
                    newW = oldW;
                    newH = oldH;
                }
                else
                {
                    newH = (newW * oldH) / oldW;
                }
            }              
            System.Drawing.Image bitmap = new System.Drawing.Bitmap(newW, newH);
            Graphics g = System.Drawing.Graphics.FromImage(bitmap);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            g.Clear(Color.Transparent);
            g.DrawImage(img, new Rectangle(0, 0, newW, newH), new Rectangle(0, 0, oldW, oldH), GraphicsUnit.Pixel);
            string comImg = "";
            try
            {
                img.Dispose();
                g.Dispose();
                bitmap.Save(path, System.Drawing.Imaging.ImageFormat.Jpeg);
                comImg = com_path;
                bitmap.Dispose();
            }
            catch
            {
                img.Dispose();
                bitmap.Dispose();
                g.Dispose();
            }
            return comImg;
        }


        //打水印
        static string logoImg(string logo_folder, string logo_file, string logo_url, string logo_postion)
        {
            string path = HttpContext.Current.Server.MapPath(logo_folder+logo_file);
            string logoPath = HttpContext.Current.Server.MapPath(logo_url);
            System.Drawing.Image oldImg = System.Drawing.Image.FromFile(path);
            System.Drawing.Image logoImg = System.Drawing.Image.FromFile(logoPath);
            Bitmap img = new Bitmap(oldImg.Width, oldImg.Height);
            Graphics g = Graphics.FromImage(img);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            g.Clear(Color.Transparent);
            g.DrawImage(oldImg, new Rectangle(0, 0, oldImg.Width, oldImg.Height), new Rectangle(0, 0, oldImg.Width, oldImg.Height), GraphicsUnit.Pixel);
            int logo_w=logoImg.Width;
            int logo_h=logoImg.Height;
            if (logo_postion == "leftTop") {
                g.DrawImage(logoImg, new Rectangle(30, 30, logo_w, logo_h), new Rectangle(0, 0, logo_w, logo_h), GraphicsUnit.Pixel);
            }
            if (logo_postion == "rightTop")
            {
                g.DrawImage(logoImg, new Rectangle(oldImg.Width - (logo_w+30), 30, logo_w, logo_h), new Rectangle(0, 0, logo_w, logo_h), GraphicsUnit.Pixel);
            }
            if (logo_postion == "left") {
                g.DrawImage(logoImg, new Rectangle(30, oldImg.Height-(logo_h+30), logo_w, logo_h), new Rectangle(0, 0, logo_w, logo_h), GraphicsUnit.Pixel);
            }
            if (logo_postion == "right")
            {
                g.DrawImage(logoImg, new Rectangle(oldImg.Width - (logo_w+30), oldImg.Height - (logo_h+30), logo_w, logo_h), new Rectangle(0, 0, logo_w, logo_h), GraphicsUnit.Pixel);
            }           
            string logo_img = "";
            try
            {
                oldImg.Dispose();
                logoImg.Dispose();
                g.Dispose();
                img.Save(path, System.Drawing.Imaging.ImageFormat.Jpeg);
                img.Dispose();
                logo_img = logo_file;
            }
            catch
            {
                oldImg.Dispose();
                logoImg.Dispose();
                img.Dispose();
                g.Dispose();
            }
            return logo_img;
        }



        //检测文件扩展名（普通检测）
        public string chkExt(string ext,string exts) {
            string result = "false";
            string[] arrExt=exts.Split('|');
            foreach(string ext_i in arrExt){
                if(ext=="."+ ext_i)
                {
                  result="success";
                  break;  
                }
            }            
            return result;
        }


        //文件扩展名检测2（根据内容检测）
        public string chkExt2(HttpPostedFile f,string path)
        {
            string result = "false";
            string folder = path;  //上传文件夹
            string newFile = Server.MapPath(folder) + DateTime.Now.ToString("yyyyMMddHHmmss") + rnd(4) + ".tmp";  //保存文件的文件名
            f.SaveAs(newFile);
            System.IO.FileStream fs = new System.IO.FileStream(newFile, System.IO.FileMode.Open, System.IO.FileAccess.Read);
            System.IO.BinaryReader r = new System.IO.BinaryReader(fs);
            string fileclass = "";
            byte buffer;
            try
            {
                buffer = r.ReadByte();
                fileclass = buffer.ToString();
                buffer = r.ReadByte();
                fileclass += buffer.ToString();
            }
            catch
            {
                return "false";
            }
            r.Close();
            fs.Close();
            Dictionary<String, String> ftype = new Dictionary<string, string>();
            ftype.Add("7173", "gif");
            ftype.Add("255216", "jpg");
            ftype.Add("13780", "png");
            ftype.Add("6677", "bmp");;
            ftype.Add("208207", "xlsx"); //xls,doc,xlsx,docx
            ftype.Add("4944", "csv");   //csv
            ftype.Add("6033", "html");   //html htm
            ftype.Add("210187", "txt");   //txt
            if (ftype.ContainsKey(fileclass))
            {
                result = "success";
            }else{
                result= fileclass;
            }
            System.IO.File.Delete(newFile);
            return result;
        }


        //检查token是否正确
        public string cheToken(string tkid,string token,string key) {
            try {
                string newToken = DesDec(token,key);
                string newtk = setMd5(tkid);
                if (newToken.Substring(0, 16) != newtk)
                {
                    return "非法提交2！";
                }
                else
                {
                    string newTs = newToken.Replace(newToken.Substring(0, 16), "");
                    string curTs = getTimeTamp();
                    int iNewTs = Convert.ToInt32(newTs);
                    int iCurTs = Convert.ToInt32(curTs);
                    int passTs = iCurTs - iNewTs;
                    if (passTs > 60 * 20)
                    {
                        return "上传超时，请刷新页面重新上传！";
                    }
                    else {
                        return "success";
                    }
                }
            } catch {
                return "非法提交21！";
            }
        }


        //md5加密
        public string setMd5(string k)
        {
            MD5 md5 = MD5.Create();
            byte[] byteOld = Encoding.UTF8.GetBytes(k);
            byte[] byteNew = md5.ComputeHash(byteOld);
            StringBuilder sb = new StringBuilder();
            foreach (byte b in byteNew)
            {
                sb.Append(b.ToString("x2"));
            }
            string v = sb.ToString();
            v = v.Substring(8, 16);
            return v;
        }


        //des 解密
        public static string DesDec(string strText,string desKey)
        {
            try
            {
                string sDecrKey = desKey;
                byte[] byKey = null;
                byte[] IV = { 0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF };
                byte[] inputByteArray = new Byte[strText.Length];
                byKey = Encoding.UTF8.GetBytes(sDecrKey.Substring(0, 8));
                DESCryptoServiceProvider des = new DESCryptoServiceProvider();
                inputByteArray = Convert.FromBase64String(strText);
                MemoryStream ms = new MemoryStream();
                CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(byKey, IV), CryptoStreamMode.Write);
                cs.Write(inputByteArray, 0, inputByteArray.Length);
                cs.FlushFinalBlock();
                Encoding encoding = new UTF8Encoding();
                return encoding.GetString(ms.ToArray());
            }
            catch
            {
                return null;
            }
        }


        //获取时间戳
        public string getTimeTamp()
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
            return Convert.ToInt64(ts.TotalSeconds).ToString();
        }


        //生成4位随机数
        public static string rnd(int n)
        {
            Random rNum = new Random();//随机生成类
            string rndStr = "";
            for (int i = 0; i < n; i++)
            {
                rndStr = rndStr + rNum.Next(0, 9).ToString();
            }
            return rndStr;
        }
    }
}