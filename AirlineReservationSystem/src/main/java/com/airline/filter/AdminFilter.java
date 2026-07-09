package com.airline.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter that protects the admin section of the application.
 * Only users whose session role is "ADMIN" are allowed through;
 * everyone else is redirected to the login page.
 */
@WebFilter(urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
        // No initialization required
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        boolean isAdmin = (session != null
                && session.getAttribute("loggedInUser") != null
                && "ADMIN".equals(session.getAttribute("role")));

        if (isAdmin) {
            chain.doFilter(request, response);
        } else {
            req.getSession().setAttribute("errorMessage", "Admin access only. Please login as an administrator.");
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
        // No cleanup required
    }
}
