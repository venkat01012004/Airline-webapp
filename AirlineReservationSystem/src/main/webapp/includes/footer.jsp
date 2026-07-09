<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ============================================================
     Shared Footer
     Included at the bottom of every public-facing JSP page.
     ============================================================ -->
<footer class="footer-airline">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4">
                <h5><i class="bi bi-airplane-engines-fill"></i> SkyWings Airlines</h5>
                <p>Your trusted partner for safe, comfortable and affordable air travel across the country and beyond.</p>
            </div>
            <div class="col-md-2 mb-4">
                <h5>Quick Links</h5>
                <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
                <a href="${pageContext.request.contextPath}/search-flight.jsp">Search Flights</a>
                <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
                <a href="${pageContext.request.contextPath}/register.jsp">Register</a>
            </div>
            <div class="col-md-3 mb-4">
                <h5>Support</h5>
                <a href="${pageContext.request.contextPath}/contact.jsp">Contact Us</a>
                <a href="${pageContext.request.contextPath}/contact.jsp">Help Center</a>
                <a href="${pageContext.request.contextPath}/contact.jsp">Baggage Policy</a>
            </div>
            <div class="col-md-3 mb-4">
                <h5>Get In Touch</h5>
                <a href="tel:+911234567890"><i class="bi bi-telephone-fill"></i> +91 12345 67890</a>
                <a href="mailto:support@skywings.com"><i class="bi bi-envelope-fill"></i> support@skywings.com</a>
                <a href="#"><i class="bi bi-geo-alt-fill"></i> Hyderabad, India</a>
            </div>
        </div>
        <div class="footer-bottom">
            &copy; 2026 SkyWings Airlines. All rights reserved. | Built with Java, Servlets, JSP &amp; MySQL.
        </div>
    </div>
</footer>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JavaScript -->
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
