<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title>Thanh toán - Laptopshop</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">

                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
                    <link href="/client/css/style.css" rel="stylesheet">
                </head>

                <body>

                    <jsp:include page="../layout/header.jsp" />

                    <div class="container-fluid py-5">
                        <div class="container py-5">

                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">Home</a></li>
                                    <li class="breadcrumb-item active">Thông tin thanh toán</li>
                                </ol>
                            </nav>

                            <!-- ====== DANH SÁCH SẢN PHẨM ====== -->
                            <div class="table-responsive mb-4">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Sản phẩm</th>
                                            <th>Tên</th>
                                            <th>Giá</th>
                                            <th>Số lượng</th>
                                            <th>Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="cartDetail" items="${cartDetails}">
                                            <tr>
                                                <td>
                                                    <img src="/images/product/${cartDetail.product.image}"
                                                        class="img-fluid rounded-circle"
                                                        style="width: 80px; height: 80px;">
                                                </td>
                                                <td>
                                                    <a href="/product/${cartDetail.product.id}" target="_blank">
                                                        ${cartDetail.product.name}
                                                    </a>
                                                </td>
                                                <td>
                                                    <fmt:formatNumber value="${cartDetail.price}" /> đ
                                                </td>
                                                <td>${cartDetail.quantity}</td>
                                                <td>
                                                    <fmt:formatNumber
                                                        value="${cartDetail.price * cartDetail.quantity}" /> đ
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- ====== FORM ĐẶT HÀNG ====== -->
                            <form action="/place-order" method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <input type="hidden" name="paymentMethod" value="COD">
                                <input type="hidden" name="totalPrice" value="${totalPrice}">

                                <div class="row g-4">
                                    <!-- ====== THÔNG TIN NGƯỜI NHẬN ====== -->
                                    <div class="col-md-6">
                                        <h5 class="mb-3">Thông tin người nhận</h5>

                                        <div class="mb-3">
                                            <label>Tên người nhận</label>
                                            <input class="form-control" name="receiverName" required>
                                        </div>

                                        <div class="mb-3">
                                            <label>Địa chỉ nhận hàng</label>
                                            <input class="form-control" name="receiverAddress" required>
                                        </div>

                                        <div class="mb-3">
                                            <label>Số điện thoại</label>
                                            <input class="form-control" name="receiverPhone" required>
                                        </div>

                                        <div class="mb-3">
                                            <label>Ghi chú</label>
                                            <textarea class="form-control" name="note" rows="3"
                                                placeholder="Giao giờ hành chính, gọi trước khi giao..."></textarea>
                                        </div>
                                    </div>

                                    <!-- ====== THANH TOÁN ====== -->
                                    <div class="col-md-6">
                                        <div class="bg-light rounded p-4">
                                            <h4 class="mb-4">Thông tin thanh toán</h4>

                                            <div class="d-flex justify-content-between mb-2">
                                                <span>Phí vận chuyển</span>
                                                <span>0 đ</span>
                                            </div>

                                            <div class="d-flex justify-content-between mb-2">
                                                <span>Hình thức thanh toán</span>
                                                <strong>Thanh toán khi nhận hàng (COD)</strong>
                                            </div>

                                            <hr>

                                            <div class="d-flex justify-content-between mb-4">
                                                <strong>Tổng tiền</strong>
                                                <strong>
                                                    <fmt:formatNumber value="${totalPrice}" /> đ
                                                </strong>
                                            </div>

                                            <button type="submit" class="btn btn-primary w-100 py-3">
                                                Xác nhận thanh toán
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>

                    <jsp:include page="../layout/footer.jsp" />

                </body>

                </html>