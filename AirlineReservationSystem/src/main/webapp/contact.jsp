<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Contact Us - SkyWings Airlines" scope="request"/>
<%@ include file="/includes/header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1><i class="bi bi-envelope-paper"></i> Contact Us</h1>
        <p class="mb-0">We'd love to hear from you. Get in touch with our team.</p>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-5 mb-4">
            <div class="form-card h-100">
                <h5 class="mb-4">Get In Touch</h5>

                <div class="d-flex mb-4">
                    <div class="feature-icon me-3" style="width:46px;height:46px;font-size:1.1rem;"><i class="bi bi-geo-alt-fill"></i></div>
                    <div>
                        <h6 class="mb-1">Head Office</h6>
                        <p class="text-muted small mb-0">SkyWings Towers, Hyderabad, Telangana, India</p>
                    </div>
                </div>

                <div class="d-flex mb-4">
                    <div class="feature-icon me-3" style="width:46px;height:46px;font-size:1.1rem;"><i class="bi bi-telephone-fill"></i></div>
                    <div>
                        <h6 class="mb-1">Phone</h6>
                        <p class="text-muted small mb-0">+91 12345 67890</p>
                    </div>
                </div>

                <div class="d-flex mb-4">
                    <div class="feature-icon me-3" style="width:46px;height:46px;font-size:1.1rem;"><i class="bi bi-envelope-fill"></i></div>
                    <div>
                        <h6 class="mb-1">Email</h6>
                        <p class="text-muted small mb-0">support@skywings.com</p>
                    </div>
                </div>

                <div class="d-flex">
                    <div class="feature-icon me-3" style="width:46px;height:46px;font-size:1.1rem;"><i class="bi bi-clock-fill"></i></div>
                    <div>
                        <h6 class="mb-1">Support Hours</h6>
                        <p class="text-muted small mb-0">24 hours a day, 7 days a week</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-7 mb-4">
            <div class="form-card">
                <h5 class="mb-3">Send Us a Message</h5>

                <c:if test="${not empty successMessage}">
                    <div class="alert alert-airline-success alert-auto-dismiss">${successMessage}</div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-airline-danger alert-auto-dismiss">${errorMessage}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/contact" method="post" class="needs-validation" novalidate>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="name" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="subject" class="form-label">Subject</label>
                        <input type="text" class="form-control" id="subject" name="subject" placeholder="How can we help?">
                    </div>
                    <div class="mb-3">
                        <label for="message" class="form-label">Message</label>
                        <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary-airline px-5">Send Message</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>
