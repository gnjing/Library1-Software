/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.alibaba.fastjson.JSON;
import static com.sun.corba.se.spi.presentation.rmi.StubAdapter.request;
import eneity.Seat;
import eneity.Studentuser;
import java.io.IOException;
import java.io.PrintWriter;
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
import session.OrdertableFacadeLocal;
import session.SeatFacadeLocal;
import session.StudentuserFacadeLocal;
import session.UserBeanLocal;

/**
 *
 * @author lh_11
 */
public class SeatServlet extends HttpServlet {
    @EJB
    private StudentuserFacadeLocal studentuserFacade;
    @EJB
    private OrdertableFacadeLocal ordertableFacade;
    @EJB
    private SeatFacadeLocal seatFacade;
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
//            out.println("<title>Servlet SeatServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet SeatServlet at " + request.getContextPath() + "</h1>");
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
            String submit = new String();
            Map<String,Object> result = new HashMap();
            switch(page){
                case"user":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"del":
                            result = new HashMap();
                            try{
                                String seatplace = request.getParameter("seat");
                                String ordertime = request.getParameter("ordertime");
                                //预约-ejb
                                this.userBean.setUser("123");
                                Studentuser stunum = this.studentuserFacade.findstu(this.userBean.getUser());
                                Seat seat = this.seatFacade.findbyPlace(seatplace);
                                this.ordertableFacade.delOrder(seat.getSeatplace(), stunum, ordertime);
                                result.put("errcode", 0);
                                result.put("count", 0);
                                response.setHeader("Content-type", "application/json; charset=utf-8");
                                out.print(JSON.toJSONString(result));
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode", -1);
                                result.put("errmsg", "系统错误");
                                response.setHeader("Content-type", "application/json; charset=utf-8");
                                out.print(JSON.toJSONString(result));
                            }
                            break;
                        default:
                            out.print("参数错误");
                    }
                    break;
                case"book_seat":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"shaixuan":
                            break;
                        case"order":
                            result = new HashMap();
                            try{
                                String seat = request.getParameter("seat");
                                String ordertime = request.getParameter("ordertime");
                                //order-ejb
                                //seat-ejb
                                this.userBean.setUser("123");
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
                                response.sendRedirect("404.jsp");
                            }
                            break;
                        default:
                            out.print("参数错误");
                    }
                    break;
                case"seat_confirm":
                    submit = request.getParameter("submit");
                    switch(submit){
                        case"confirm":
                            //TODO
                            result = new HashMap();
                            String seat = request.getParameter("seat");
                            String ordertime = request.getParameter("ordertime");
                            boolean check = this.ordertableFacade.checkOrder(this.seatFacade.findbyPlace(seat), this.studentuserFacade.findstu(this.userBean.getUser()), ordertime);
                            if(check == false){
                                result.put("errcode", -1);
                                result.put("errmsg", "预约记录已存在");
                                request.getSession().setAttribute("err", result);
                                response.sendRedirect("");
                                break;
                            }
                            this.ordertableFacade.addOrder(this.seatFacade.findbyPlace(seat), this.studentuserFacade.findstu(this.userBean.getUser()), ordertime);
                            response.sendRedirect("");
//                            request.getRequestDispatcher("").forward(request, response);
                            break;
                        default:
                            out.print("参数错误");
                    }
                    break;
                case"seat"://TODO
                    submit = request.getParameter("submit");
                    switch(submit){//TODO:new
                        case"add_submit":
                            result = new HashMap();
                            try{
                                String seat = request.getParameter("seat");
                                String add = request.getParameter("add");
                                String del = request.getParameter("del");
                                //seat-ejb
                                
                                result.put("errcode", 0);
                                result.put("count", 0);
                                response.setHeader("Content-type", "application/json; charset=utf-8");
                                out.print(JSON.toJSONString(result));
                            }catch(Exception e){
                                e.printStackTrace();
                                result.put("errcode", -1);
                                result.put("errmsg", "系统错误");
                                response.setHeader("Content-type", "application/json; charset=utf-8");
                                out.print(JSON.toJSONString(result));
                            }
                            break;
                        case"del_submit":
                            break;
                        case"modify_submit":
                            break;
                        default:
                            out.print("参数错误");
                    }
                    break;
                default:
                    out.print("错误参数");
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
