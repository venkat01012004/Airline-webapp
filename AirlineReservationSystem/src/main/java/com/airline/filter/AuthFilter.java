package com.airline.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter that protects pages which require the user to be logged in
 * (e.g. booking a flight, viewing booking history, making a payment).
 * Unauthenticated requests are redirected to the login page.
 */
@WebFilter(urlPatterns = {"/booking/*", "/my-bookings.jsp", "/book-flight.jsp", "/payment.jsp", "/customer/*"})
public class AuthFilter implements Filter {

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
        boolean loggedIn = (session != null && session.getAttribute("loggedInUser") != null);

        if (loggedIn) {
            chain.doFilter(request, response);
        } else {
            req.getSession().setAttribute("errorMessage", "Please login to continue.");
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
        // No cleanup required
    }
}
