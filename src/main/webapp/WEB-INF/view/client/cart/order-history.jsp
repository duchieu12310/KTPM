<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <title>Lịch sử mua hàng - ktpm</title>
                <meta content="width=device-width, initial-scale=1.0" name="viewport">

                <!-- Google Web Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">

                <!-- Icon Font -->
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <!-- Libraries -->
                <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                <!-- Bootstrap -->
                <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                <!-- Custom CSS -->
                <link href="/client/css/style.css" rel="stylesheet">
            </head>

            <body>

                <!-- Spinner -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>

                <jsp:include page="../layout/header.jsp" />

                <!-- Order History -->
                <div class="container-fluid py-5">
                    <div class="container py-5">

                        <!-- Breadcrumb -->
                        <div class="mb-4">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                                    <li class="breadcrumb-item active">Lịch sử mua hàng</li>
                                </ol>
                            </nav>
                        </div>

                        <!-- Table -->
                        <div class="table-responsive">
                            <table class="table table-bordered align-middle">
                                <thead class="table-dark text-center">
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Tên</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>
                                        <th>Thành tiền</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <!-- Không có đơn -->
                                    <c:if test="${empty orders}">
                                        <tr>
                                            <td colspan="6" class="text-center text-muted">
                                                Bạn chưa có đơn hàng nào
                                            </td>
                                        </tr>
                                    </c:if>

                                    <!-- Danh sách đơn -->
                                    <c:forEach var="order" items="${orders}">

                                        <!-- Dòng thông tin đơn -->
                                        <tr class="table-secondary fw-bold">
                                            <td colspan="2">Mã đơn: #${order.id}</td>
                                            <td>
                                                <fmt:formatNumber value="${order.totalPrice}" type="number" /> đ
                                            </td>
                                            <td colspan="2">Thanh toán: COD</td>
                                            <td class="text-danger">${order.status}</td>
                                        </tr>

                                        <!-- Chi tiết sản phẩm -->
                                        <c:forEach var="orderDetail" items="${order.orderDetails}">
                                            <tr>
                                                <td class="text-center">
                                                    <img src="/images/product/${orderDetail.product.image}"
                                                        class="img-fluid rounded" style="width: 80px; height: 80px;">
                                                </td>

                                                <td>
                                                    <a href="/product/${orderDetail.product.id}" target="_blank"
                                                        class="text-decoration-none">
                                                        ${orderDetail.product.name}
                                                    </a>
                                                </td>

                                                <td>
                                                    <fmt:formatNumber value="${orderDetail.price}" type="number" /> đ
                                                </td>

                                                <td class="text-center">
                                                    ${orderDetail.quantity}
                                                </td>

                                                <td>
                                                    <fmt:formatNumber
                                                        value="${orderDetail.price * orderDetail.quantity}"
                                                        type="number" /> đ
                                                </td>

                                                <td></td>
                                            </tr>
                                        </c:forEach>

                                    </c:forEach>

                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>

                <jsp:include page="../layout/footer.jsp" />

                <!-- Back to Top -->
                <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
                    <i class="fa fa-arrow-up"></i>
                </a>

                <!-- JS -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/easing/easing.min.js"></script>
                <script src="/client/lib/waypoints/waypoints.min.js"></script>
                <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
                <script src="/client/js/main.js"></script>

            </body>

            </html>