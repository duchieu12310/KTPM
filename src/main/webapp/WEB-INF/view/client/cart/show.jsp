<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title>Giỏ hàng - kinhmta</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">

                    <!-- Google Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Fonts -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                    <!-- Bootstrap & Custom Styles -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
                    <link href="/client/css/style.css" rel="stylesheet">
                </head>

                <body>
                    <!-- Spinner -->
                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>

                    <jsp:include page="../layout/header.jsp" />

                    <!-- Cart Page Start -->
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <!-- Breadcrumb -->
                            <nav aria-label="breadcrumb" class="mb-3">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Chi Tiết Giỏ Hàng</li>
                                </ol>
                            </nav>

                            <!-- Xóa toàn bộ giỏ hàng -->
                            <c:if test="${not empty cartDetails}">
                                <div class="mb-4 text-end">
                                    <form method="post" action="/delete-all"
                                        onsubmit="return confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?')">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button type="submit" class="btn btn-danger rounded-pill px-4">
                                            <i class="fa fa-trash"></i> Xóa toàn bộ giỏ hàng
                                        </button>
                                    </form>
                                </div>
                            </c:if>

                            <!-- Table -->
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Sản phẩm</th>
                                            <th>Tên</th>
                                            <th>Giá cả</th>
                                            <th>Số lượng</th>
                                            <th>Thành tiền</th>
                                            <th>Xử lý</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty cartDetails}">
                                            <tr>
                                                <td colspan="6" class="text-center">Không có sản phẩm trong giỏ hàng
                                                </td>
                                            </tr>
                                        </c:if>

                                        <c:forEach var="cartDetail" items="${cartDetails}" varStatus="status">
                                            <tr>
                                                <td>
                                                    <img src="/images/product/${cartDetail.product.image}"
                                                        class="img-fluid rounded-circle"
                                                        style="width: 80px; height: 80px;" alt="">
                                                </td>
                                                <td>
                                                    <a href="/product/${cartDetail.product.id}"
                                                        target="_blank">${cartDetail.product.name}</a>
                                                </td>
                                                <td>
                                                    <fmt:formatNumber type="number" value="${cartDetail.price}" /> đ
                                                </td>
                                                <td>
                                                    <div class="input-group quantity" style="width: 100px;">
                                                        <button
                                                            class="btn btn-sm btn-minus rounded-circle bg-light border"><i
                                                                class="fa fa-minus"></i></button>
                                                        <input type="text"
                                                            class="form-control form-control-sm text-center border-0"
                                                            value="${cartDetail.quantity}"
                                                            data-cart-detail-id="${cartDetail.id}"
                                                            data-cart-detail-price="${cartDetail.price}"
                                                            data-cart-detail-index="${status.index}">
                                                        <button
                                                            class="btn btn-sm btn-plus rounded-circle bg-light border"><i
                                                                class="fa fa-plus"></i></button>
                                                    </div>
                                                </td>
                                                <td>
                                                    <fmt:formatNumber type="number"
                                                        value="${cartDetail.price * cartDetail.quantity}" /> đ
                                                </td>
                                                <td>
                                                    <form method="post" action="/delete-cart-product/${cartDetail.id}">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <button class="btn btn-md rounded-circle bg-light border">
                                                            <i class="fa fa-times text-danger"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Order Info & Checkout Form -->
                            <div class="mt-5 row g-4 justify-content-start">
                                <div class="col-12 col-md-8">
                                    <div class="bg-light rounded">
                                        <div class="p-4">
                                            <h1 class="display-6 mb-4">Thông Tin <span class="fw-normal">Đơn Hàng</span>
                                            </h1>
                                            <div class="d-flex justify-content-between mb-4">
                                                <h5 class="mb-0">Tạm tính:</h5>
                                                <p class="mb-0">
                                                    <fmt:formatNumber type="number"
                                                        value="${totalPrice != null ? totalPrice : 0}" /> đ
                                                </p>
                                            </div>
                                            <div class="d-flex justify-content-between">
                                                <h5 class="mb-0">Phí vận chuyển</h5>
                                                <p class="mb-0">0 đ</p>
                                            </div>
                                        </div>

                                        <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                            <h5 class="mb-0 ps-4">Tổng số tiền</h5>
                                            <p class="mb-0 pe-4">
                                                <fmt:formatNumber type="number"
                                                    value="${totalPrice != null ? totalPrice : 0}" /> đ
                                            </p>
                                        </div>

                                        <!-- Form thanh toán luôn hiển thị -->
                                        <form:form id="checkoutForm" action="/confirm-checkout" method="post"
                                            modelAttribute="cart">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <c:if test="${not empty cart.cartDetails}">
                                                <div style="display: none;">
                                                    <c:forEach var="cartDetail" items="${cart.cartDetails}"
                                                        varStatus="status">
                                                        <form:input path="cartDetails[${status.index}].id"
                                                            value="${cartDetail.id}" />
                                                        <form:input path="cartDetails[${status.index}].quantity"
                                                            value="${cartDetail.quantity}" />
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                            <button type="submit"
                                                class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4"
                                                onclick="return checkCartNotEmpty();">
                                                Xác nhận thanh toán
                                            </button>
                                        </form:form>

                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- Cart Page End -->

                    <jsp:include page="../layout/footer.jsp" />

                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>

                    <!-- JS Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <!-- Custom JS -->
                    <script src="/client/js/main.js"></script>

                    <!-- JS kiểm tra giỏ hàng trước khi thanh toán -->
                    <script>
                        function checkCartNotEmpty() {
                            // Kiểm tra nếu có dòng "Không có sản phẩm"
                            var emptyRow = document.querySelector("table tbody tr td[colspan='6']");
                            if (emptyRow) {
                                alert("Không thể thanh toán khi không có mặt hàng nào trong giỏ hàng!");
                                return false; // Ngăn form submit
                            }
                            return true; // Cho phép submit form
                        }
                    </script>

                </body>

                </html>