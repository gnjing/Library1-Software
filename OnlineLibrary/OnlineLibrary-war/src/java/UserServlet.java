/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.alibaba.fastjson.JSON;
import eneity.Studentuser;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import session.BrFacadeLocal;
import session.CartBeanLocal;
import session.OrdertableFacadeLocal;
import session.StudentuserFacadeLocal;
import session.UserBeanLocal;

/**
 *
 * @author lh_11
 */
public class UserServlet extends HttpServlet {
    @EJB
    private OrdertableFacadeLocal ordertableFacade;
    @EJB
    private BrFacadeLocal brFacade;
    @EJB
    private AdminFacadeLocal adminFacade;
    @EJB
    private StudentuserFacadeLocal studentuserFacade;
    UserBeanLocal userBean ;

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
//            out.println("<title>Servlet UserServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet UserServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
            if(request.getSession().getAttribute("userbean") == null){
                userBean = lookupUserBeanLocal();
                request.getSession().setAttribute("userbean", this.userBean);
            }
            else{
                userBean = (UserBeanLocal)request.getSession().getAttribute("userbean");
            }
            String page = request.getParameter("page");
            Map<String,Object> result = new HashMap();
            String submit = new String();
            switch(page){
                case"index":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"user":
//                            this.userBean.setUser("123");
                            Studentuser stu = this.studentuserFacade.findstu(this.userBean.getUser());
                            HashMap<String,Object> stu_info = new HashMap<String,Object>();
                            stu_info.put("user", this.userBean.getUser());
                            stu_info.put("no", stu.getStudentnum());
                            request.getSession().setAttribute("stu_info", stu_info);
                            ArrayList<HashMap<String,Object>> br_list = this.brFacade.findbyUser(this.studentuserFacade.findstu(this.userBean.getUser()));
                            request.getSession().setAttribute("br_list", br_list);
                            ArrayList<HashMap<String,Object>> order_list = this.ordertableFacade.findbyStu(stu);
                            request.getSession().setAttribute("order_list", order_list);
                            response.sendRedirect("/OnlineLibrary-war/user.jsp");
                            break;
                        default:
                    }
                    break;
                case"login":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"denglu":
                            result = new HashMap();
                            try{
                                String user = request.getParameter("user");
                                String pwd = request.getParameter("pwd");
                                result = new HashMap();
                                //user-ejb
                                //TODO返回主页
                                if(user.equals("admin")){
                                    boolean a = this.adminFacade.checkPwd(user, pwd);
                                    if(a == false){
                                        result.put("errcode", -2);
                                        result.put("errmsg", "管理员密码错误");
                                        request.getSession().setAttribute("err", result);
                                        response.sendRedirect("");
                                        break;
                                    }
                                    this.userBean.setUser("admin");
                                }
                                else{
                                    boolean a = this.studentuserFacade.checkPwd(user, pwd);
                                    if(a == false){
                                        result.put("errcode", -2);
                                        result.put("errmsg", "用户密码错误");
                                        request.getSession().setAttribute("err", result);
                                        response.sendRedirect("404.jsp");
                                        break;
                                    }
                                    this.userBean.setUser(user);
                                }
//                                request.getRequestDispatcher("").forward(request, response);
                                result.put("errcode", 0);
                                result.put("count", 0);
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("/OnlineLibrary-war/index.html");
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode", -1);
                                result.put("errmsg", "系统错误");
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.setAttribute("err", result);
                                response.sendRedirect("404.jsp");
                            }
                            break;
                        case"zhuce"://TODO
//                            request.getRequestDispatcher("reg.html").forward(request, response);
                            response.sendRedirect("reg.html");
                            break;
                        default:
                            out.print("参数错误");
                    }
                    break;
                case"register":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"zhuce":
                            String user = request.getParameter("user");
                            String pwd = request.getParameter("pwd");
                            String no = request.getParameter("no");
                            result = new HashMap();
                            //user-ejb
                            //TODO注册成功后返回登录页？
                            boolean a = this.studentuserFacade.register(user, no, pwd);
                            if(a == false){
                                result.put("errcode", -2);
                                result.put("errmsg", "注册失败");
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("404.html");
                                break;
                            }
//                            request.getRequestDispatcher("login.html").forward(request, response);
                            result.put("errode", 0);
                            result.put("count", 0);
                            request.getSession().setAttribute("err", result);
                            response.sendRedirect("/OnlineLibrary-war/login.jsp");
                            break;
                        default:
                            out.print("参数错误");
                    }
                    break;
                case"changepw":
                    submit = request.getParameter("change_pwd");
                    switch(submit){
                        case"submit":
                            result = new HashMap();
                            try{
                                String new_pwd = request.getParameter("new_pwd");
                                
                                //user-ejb
                                boolean a = this.studentuserFacade.changPwd(this.userBean.getUser(), new_pwd);
                                if(a == false){
                                    result.put("errcode", -1);
                                    result.put("errmsg", "修改失败");
                                    request.getSession().setAttribute("err", result);
                                    response.sendRedirect("404.html");
                                    break;
                                }
                                this.userBean.logout();
                                result.put("errcode", 0);
                                result.put("count", 0);
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("login.html");
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode", -1);
                                result.put("errmsg", "系统错误");
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("404.html");
                            }
                            break;
                        default:
                            out.print("参数错误");
                    }
                    break;
                case"pw"://管理员修改别人的密码
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"newpwd":
                            result = new HashMap();
                            try{
                                String no = request.getParameter("no");
                                String new_pwd = request.getParameter("new_pwd");
                                //user-ejb
                                boolean a = this.studentuserFacade.admChangePwd(no, new_pwd);
                                if(a == false){
                                    result.put("errcode", -1);
                                    result.put("errmsg", "修改失败");
                                    request.getSession().setAttribute("err", result);
                                    response.sendRedirect("404.html");
                                    break;
                                }
                                result.put("errcode", 0);
                                result.put("count", 0);
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("");
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode", -1);
                                result.put("errmsg", "系统错误");
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("404.html");
                            }
                            break;
                        default:
                            out.print("参数错误");
                    }
                    break;
//                case"adm_pwd":
//                    submit = request.getParameter("submit");
//                    switch(submit){
//                        case"new_pwd":
//                            result = new HashMap();
//                            try{
//                                String new_pwd = request.getParameter("new");
//                                //TODO adm-ejb?
//                                
//                                result.put("errcode", 0);
//                                result.put("count", 0);
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
//                            }catch(Exception e){
//                                e.printStackTrace();
//                                result.put("errcode", -1);
//                                result.put("errmsg", "系统错误");
//                                response.setHeader("Content-type", "application/json; charset=utf-8");
//                                out.print(JSON.toJSONString(result));
//                            }
//                            break;
//                        default:
//                            out.print("参数错误");
//                    }
//                    break;
                default:
                    out.print("参数错误");
            }
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
