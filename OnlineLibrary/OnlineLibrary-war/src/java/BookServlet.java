/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.alibaba.fastjson.JSON;
import static com.google.common.collect.Maps.newHashMap;
import eneity.Admin;
import eneity.Bookdynamic;
import eneity.Bookstatic;
import eneity.Br;
import eneity.Studentuser;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import session.AdminFacadeLocal;
import session.BookdynamicFacadeLocal;
import session.BookstaticFacadeLocal;
import session.BrFacadeLocal;
import session.CartBeanLocal;
import session.StudentuserFacadeLocal;
import session.UserBeanLocal;

/**
 *
 * @author lh_11
 */
public class BookServlet extends HttpServlet {
    @EJB
    private AdminFacadeLocal adminFacade;
    @EJB
    private StudentuserFacadeLocal studentuserFacade;
    UserBeanLocal userBean ;
    @EJB
    private BookdynamicFacadeLocal bookdynamicFacade;
    @EJB
    private BrFacadeLocal brFacade;
    @EJB
    private BookstaticFacadeLocal bookstaticFacade;
    CartBeanLocal cartBean ;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet BookServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet BookServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
            if(request.getSession().getAttribute("cartbean") == null){
                cartBean = lookupCartBeanLocal();
                request.getSession().setAttribute("cartbean", this.cartBean);
            }
            else{
                cartBean = (CartBeanLocal)request.getSession().getAttribute("cartbean");
            }
            if(request.getSession().getAttribute("userbean") == null){
                userBean = lookupUserBeanLocal();
                request.getSession().setAttribute("userbean", this.userBean);
                
            }
            else{
                userBean = (UserBeanLocal)request.getSession().getAttribute("userbean");
            }
            String page = request.getParameter("page");
            String submit = new String();
            Map<String,Object> result = new HashMap();
            switch(page){
                case"index":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"sousuo":
                            String type = request.getParameter("type");//未对接的属性名
                            type = new String(type.getBytes("ISO-8859-1"),"UTF-8");
                            String key = request.getParameter("key");
                            key = new String(key.getBytes("ISO-8859-1"),"UTF-8");
                            String book_list = new String();
                            ArrayList<HashMap<String,Object>> j_book_list = new ArrayList<HashMap<String,Object>>();
                            //数据库查询操作
                            j_book_list = this.bookstaticFacade.find(key, type);
                            book_list = JSON.toJSONString(j_book_list);
                            request.getSession().setAttribute("book_list", j_book_list);
//                            request.getRequestDispatcher("search.html").forward(request, response);
                            response.sendRedirect("/OnlineLibrary-war/search.jsp");
                            submit = null;
                            break;
                        
                        default:
                            out.print("错误参数");
                    }
                    break;
                case"search":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"sousuo":
                            String type = request.getParameter("type");//未对接的属性名
                            type = new String(type.getBytes("ISO-8859-1"),"UTF-8");
                            String key = request.getParameter("key");
                            key = new String(key.getBytes("ISO-8859-1"),"UTF-8");
                            String book_list = new String();
                            ArrayList<HashMap<String,Object>> j_book_list = new ArrayList<HashMap<String,Object>>();
                            //数据库查询操作
                            j_book_list = this.bookstaticFacade.find(key, type);
                            book_list = JSON.toJSONString(j_book_list);
                            request.getSession().setAttribute("book_list", book_list);
//                            request.getRequestDispatcher("search.html").forward(request, response);
                            response.sendRedirect("/OnlineLibrary-war/search.jsp");
                            submit = null;
                            break;
                        case"add":
                            Enumeration names = request.getParameterNames();
                                while(names.hasMoreElements()) {
                                    String name = (String)names.nextElement();
                                    if(!name.equals("page")&&!name.equals("submit")) {
                                        String isbn = request.getParameter(name);
                                        this.cartBean.add(isbn);
                                    }
                                }
                                response.sendRedirect("/OnlineLibrary-war/search.jsp");
                            break;
                            
                        case"tocart":
                            result = newHashMap();
                            try{
                                ArrayList<HashMap<String,Object>> j_cart_list = this.cartBean.gets();
//                                this.cartBean.add("123");
                                //cart操作
                                j_cart_list = this.cartBean.gets();
                                ArrayList<HashMap<String,Object>> temp = new ArrayList<HashMap<String,Object>>();
                                for(int i = 0;i < j_cart_list.size(); i ++){
                                    ArrayList<HashMap<String,Object>> b_l = this.bookstaticFacade.find((String)j_cart_list.get(i).get("isbn"),"isbn");
                                    temp.add(b_l.get(0));
                                }
                                String cart_list = JSON.toJSONString(temp);
                                request.getSession().setAttribute("count", j_cart_list.size());
                                request.getSession().setAttribute("cart_list", temp);
//                                request.getRequestDispatcher("cart.html").forward(request, response);
                                
                                result.put("errcode", 0);
                                result.put("count",0);
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("/OnlineLibrary-war/cart.jsp");
                                
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode", -1);
                                result.put("errmsg", "系统错误");
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("404.jsp");
                            }
                            submit = null;
                            break;
                        default:
                            out.print("错误参数");
                    }
                    break;
                case"cart":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"del":
                            result = new HashMap();
                            try{
                                String isbn = request.getParameter("isbn");
                                this.cartBean.del(isbn);
                                result.put("errcode",0);
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
//                                response.sendRedirect(".jsp");
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode", -1);
                                result.put("errmsg", "系统错误");
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("404.jsp");
                            }
                            break;
                        case"cart_confirm":
                            result = new HashMap();
                            try{
                                ArrayList<HashMap<String,Object>> call = this.cartBean.gets();
                                ArrayList<HashMap<String,Object>> cart_list = new ArrayList<HashMap<String,Object>>();
                                //book-ejb
                                ArrayList<HashMap<String,Object>> j_cart_list = this.cartBean.gets();
//                                this.cartBean.add("123");
                                //cart操作
                                j_cart_list = this.cartBean.gets();
                                for(int i = 0;i < j_cart_list.size(); i ++){
                                    ArrayList<HashMap<String,Object>> b_l = this.bookstaticFacade.find((String)j_cart_list.get(i).get("isbn"),"isbn");
                                    cart_list.add(b_l.get(0));
                                }
                                String s_cart_list = JSON.toJSONString(cart_list);
                                request.getSession().setAttribute("cart_list", cart_list);
//                                response.sendRedirect("/OnlineLibrary-war/cart_confirm.jsp");
                                result.put("errcode", 0);
                                result.put("count", 0);//功能有待考察
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                request.getSession().setAttribute("user", this.userBean.getUser());
                                response.sendRedirect("/OnlineLibrary-war/borrow_confirm.jsp");
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode", -1);
                                result.put("errmsg", "系统错误");
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("404.jsp");
                            }
                            break;
                        default:
                            out.print("错误参数");
                    }
                    break;
                case"borrow_confirm":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"back":
                            //更改value为tocart即可
                            Br new_br = new Br();
                            new_br.setBrnum("123");
                            new_br.setBday("0");
                            new_br.setBtime("0");
                            new_br.setOverr(false);
                            new_br.setPaying(0.00);

                            new_br.setRday("0000-01-01");
                            new_br.setRtime("00:00:00");
                            new_br.setBooknum(this.bookdynamicFacade.findbyisbn(this.bookstaticFacade.findbyisbn("123")));
   
                            new_br.setStudentnum(this.studentuserFacade.findstu("123"));
                            this.brFacade.create(new_br);
//                            Bookdynamic bd = new Bookdynamic();
//                            bd.setAdminname(this.adminFacade.find("admin"));
//                            bd.setBooknum("1234");
//                            bd.setCollectnum(123);
//                            bd.setIntime("123");
//                            bd.setIsbn(this.bookstaticFacade.findbyisbn("123"));
//                            bd.setLoannum(123);
//                            bd.setShelfplace("123");
//                            this.bookdynamicFacade.create(bd);
                            break;
                        case"continue"://TODO：结束页名称
//                            this.cartBean.add("123");
                            String user = request.getParameter("user");
                            this.userBean.setUser("123");
                            ArrayList<HashMap<String,Object>> cart_list = this.cartBean.gets();
                            ArrayList<HashMap<String,Object>> c_l = new ArrayList<HashMap<String,Object>>();
                            
                            for(int i = 0;i < cart_list.size();i ++){
//                                ArrayList<HashMap<String,Object>> book = this.bookstaticFacade.find((String)cart_list.get(i).get("isbn"),"isbn");
                                Bookstatic book = this.bookstaticFacade.findbyisbn((String)cart_list.get(i).get("isbn"));
//                                ArrayList<HashMap<String,Object>> bd_list = this.bookdynamicFacade.find(book);
                                this.userBean.setUser("123");
                                Studentuser stu = this.studentuserFacade.findstu(user);
                                this.brFacade.addBr(this.bookdynamicFacade.findbyisbn(book), stu);
                                this.studentuserFacade.addBorrow(this.userBean.getUser());
                                ArrayList<HashMap<String,Object>> b_l = this.bookstaticFacade.find((String)cart_list.get(i).get("isbn"),"isbn");
                                c_l.add(b_l.get(0));
                                this.bookdynamicFacade.borrow((String)cart_list.get(i).get("isbn"));
                            }
                    
                            request.getSession().setAttribute("user", this.userBean.getUser());
                            request.getSession().setAttribute("cart_list", c_l);
                            response.sendRedirect("/OnlineLibrary-war/borrow_successful.jsp");
//                            request.getRequestDispatcher("结束页").forward(request, response);
                            break;
                        default:
                            out.print("错误参数");
                    }
                    break;
                case"borrow":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"borrow":
                            result = new HashMap();
                            try{
                                String isbn = request.getParameter("isbn");
                                String no = request.getParameter("no");
                                this.cartBean.add(isbn);
                                ArrayList<HashMap<String,Object>> b_i = new ArrayList<HashMap<String,Object>>();
                                //TODO：添加借书时间
                                //borrow-ejb
                                ArrayList<HashMap<String,Object>> borrow_list = this.bookstaticFacade.find(isbn, "isbn");
                                Studentuser stu = this.studentuserFacade.findbyno(no);
                                request.getSession().setAttribute("user", stu.getUsername());
                                request.getSession().setAttribute("cart_list", borrow_list);
                                //TODO：借书确认页名称
//                                request.getRequestDispatcher("").forward(request, response);
                                result.put("errcode", 0);
                                result.put("count", 0);
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("/OnlineLibrary-war/borrow_confirm.jsp");
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode", -1);
                                result.put("errmsg","系统错误");
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("404.jsp");
                            }
                            break;
                        default:
                            out.print("错误参数");
                    }
                    break;
                case"user":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"return"://TODO：名称未定
                            result = new HashMap();
                            try{
                                Enumeration names = request.getParameterNames();
                                ArrayList<HashMap<String,Object>> br_list = new ArrayList<HashMap<String,Object>>();
                                while(names.hasMoreElements()) {
                                    String name = (String)names.nextElement();
                                    if(!name.equals("page")&&!name.equals("submit")) {
                                        String br_num = request.getParameter(name);
                                        HashMap<String,Object> br = this.brFacade.find(br_num);
                                        br_list.add(br);
                                    }
                                }
                                //borrow-ejb
                                String a = this.userBean.getUser();
                                request.getSession().setAttribute("br_list", br_list);
                                request.getSession().setAttribute("usernum", this.userBean.getUser());
                                result.put("errcode",0);
                                result.put("count", 0);
                                response.sendRedirect("/OnlineLibrary-war/user_return_confirm.jsp");
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode",-1);
                                result.put("errmsg", "系统错误");
                                response.setHeader("Content-type", "application/json; charset=utf-8");
                                out.print(JSON.toJSONString(result));
                            }
                            break;
                        default:
                            out.print("错误参数");
                    }
                    break;
                case"user_return_confirm":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"submit"://TODO：未确定
                            result = new HashMap();
                            try{
                                Enumeration names = request.getParameterNames();
                                ArrayList<HashMap<String,Object>> br_list = new ArrayList<HashMap<String,Object>>();
                                while(names.hasMoreElements()) {
                                    String name = (String)names.nextElement();
                                    if(!name.equals("page")&&!name.equals("submit")&&!name.equals("user")) {
                                        String br_num = request.getParameter(name);
                                        this.brFacade.retBr(br_num);
                                        HashMap<String,Object> br = this.brFacade.find(br_num);
                                        br_list.add(br);
                                    }
                                }
//                                String br_num = request.getParameter("br_num");
//                                
//                                //borrow-ejb
//                                this.brFacade.retBr(br_num);
                                request.getSession().setAttribute("user", request.getParameter("user"));
                                request.getSession().setAttribute("br_list", br_list);
                                result.put("errcode",0);
                                result.put("count", -1);
                                request.getSession().setAttribute("err", result);
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
//                                if(request.getParameter("user").equals("admin")){
                                if(this.userBean.getUser().equals("admin")){
                                    response.sendRedirect("/OnlineLibrary-war/return_successful.jsp");
                                    break;
                                }
                                response.sendRedirect("/OnlineLibrary-war/user_return_successful.jsp");
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode",-1);
                                result.put("errmsg","系统错误");
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                            }
                            
                            break;
                        case"tofinal"://TODO:没有
                            request.getRequestDispatcher("").forward(request, response);
                            break;
                        default:
                            out.print("参数错误");
                    }
                    break;
                case"return":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"ret":
                            result = new HashMap();
                            try{
                                String isbn = request.getParameter("isbn");
                                String no = request.getParameter("no");
                                ArrayList<HashMap<String,Object>> b_i = new ArrayList<HashMap<String,Object>>();
                                //borrow-ejb
//                                ArrayList<HashMap<String,Object>> book = this.bookstaticFacade.find(isbn, "isbn");
                                this.userBean.setUser("admin");
                                Bookdynamic bd = this.bookdynamicFacade.findbyisbn(this.bookstaticFacade.findbyisbn(isbn));
//                                this.studentuserFacade.findstu(isbn);
                                HashMap<String,Object> br =  this.brFacade.findbybook(bd,this.studentuserFacade.findbyno(no));
                                ArrayList<HashMap<String,Object>> br_list = new ArrayList<HashMap<String,Object>>();
                                br_list.add(br);
                                request.getSession().setAttribute("br_list", br_list);
                                request.getSession().setAttribute("usernum", this.studentuserFacade.findbyno(no).getUsername());
                                //TODO
                                
//                                request.getRequestDispatcher("adm_retc.html").forward(request, response);
                                result.put("errocde", 0);
                                result.put("count", 0);
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("/OnlineLibrary-war/user_return_confirm.jsp");
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode", -1);
                                result.put("errmsg", "系统错误");
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                            }
                            break;
                        default:
                            out.print("系统错误");
                    }
                    break;
                case"return_confirm":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"submit"://TODO
                            result = new HashMap();
                            try{
                                String br_num = request.getParameter("br_num");
    //                            String no = request.getParameter("no");
    //                            request.getRequestDispatcher("").forward(request, response);
    //                            Bookdynamic bd = this.bookdynamicFacade.findbyisbn(isbn);
    //                                this.studentuserFacade.findstu(isbn);
    //                            HashMap<String,Object> er =  this.brFacade.findbybook(bd,this.studentuserFacade.findbyno(no));
                                this.brFacade.retBr(br_num);
                                result.put("errcode", 0);
                                result.put("count", 0);
                                response.sendRedirect("/.jsp");
                                break;
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode", -1);
                                result.put("errmsg", "系统错误");
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("404.jsp");
                            }
                        default:
                            out.print("系统错误");
                    }
                    break;
                case"add"://TODO:new
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"save":
                            result = new HashMap();
                            try{
                                String name = request.getParameter("name");
                                String author = request.getParameter("author");
                                String suoqu = request.getParameter("suoqu");
                                String press = request.getParameter("press");
                                String isbn = request.getParameter("isbn");
                                String location = request.getParameter("location");
                                String sum = request.getParameter("sum");
                                Bookstatic book = this.bookstaticFacade.add(isbn, name, author, press);
                                LocalDate date = LocalDate.now();
                                String time = date.toString();
                                this.bookdynamicFacade.add(location, Integer.parseInt(sum), Integer.parseInt(sum), time, book, this.adminFacade.find("admin"));
                                //book-ejb
                                result.put("errocde", 0);
                                result.put("count", 0);
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("/OnlineLibrary-war/admin.jsp");
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode", -1);
                                result.put("errmsg", "系统错误");
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                            }
                            break;
                        default:
                            out.print("参数错误");
                    }
                    break;
                case"modify"://TODO
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"save":
                            String isbn = request.getParameter("isbn");
                            Enumeration names = request.getParameterNames();
                            String num = new String();
                            String title = new String();
                            String author = new String();
                            String Isr = new String();
                            String bnum = new String();
                            String suoqu = new String();
                            String location = new String();
                            HashMap<String,Object> tag = new HashMap();
                            tag.put("num", 0);
                            tag.put("title", 0);
                            tag.put("author", 0);
                            tag.put("publisher", 0);
                            tag.put("bnum", 0);
                            tag.put("suoqu", 0);
                            tag.put("location", 0);
//                            if(true){
//                                break;
//                            }
                            while(names.hasMoreElements()){
                                String name = (String)names.nextElement();
                                if(name.contains("in")){
                                    int a = name.length() -1;
                                    String count = name.substring(name.length()-1);
                                    String select = request.getParameter(name);
                                    String b = "searchOpac" + count;
                                    switch(select){
                                        case"num":
                                            num = request.getParameter("searchOpac" + count);
                                            tag.put("num", num);
                                            break;
                                        case"title":
                                            title = request.getParameter("searchOpac"+count);
                                            tag.put("title",title);
                                            break;
                                        case"author":
                                            author = request.getParameter("searchOpac"+count);
                                            tag.put("author",author);
                                            break;
                                        case"lsr":
                                            Isr = request.getParameter("searchOpac"+count);
                                            tag.put("publisher", Isr);
                                            break;
                                        case"bnum":
                                            bnum = request.getParameter("searchOpac"+count);
                                            tag.put("bnum", bnum);
                                            break;
                                        case"suoqu":
                                            suoqu = request.getParameter("searchOpac"+count);
                                            tag.put("suoqu", suoqu);
                                            break;
                                        case"location":
                                            location = request.getParameter("searchOpac"+count);
                                            tag.put("location", location);
                                            break;
                                        default:
                                            
                                    }
                                }
                                
                            }
                            Bookstatic book = this.bookstaticFacade.modify(tag, isbn);
                            Bookstatic bo = this.bookstaticFacade.findbyisbn(isbn);
                            this.bookdynamicFacade.modify(tag, bo);
                            response.sendRedirect("/OnlineLibrary-war/admin.jsp");
                            break;
                        default:
                           out.print("参数错误");
                    }
                    break;
                default:
                    out.println("无效参数");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private CartBeanLocal lookupCartBeanLocal() {
        try {
            Context c = new InitialContext();
            return (CartBeanLocal) c.lookup("java:global/OnlineLibrary/OnlineLibrary-ejb/CartBean!session.CartBeanLocal");
        } catch (NamingException ne) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }

    private UserBeanLocal lookupUserBeanLocal() {
        try {
            Context c = new InitialContext();
            return (UserBeanLocal) c.lookup("java:global/OnlineLibrary/OnlineLibrary-ejb/UserBean!session.UserBeanLocal");
        } catch (NamingException ne) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }

}
