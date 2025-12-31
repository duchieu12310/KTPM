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

                    <!-- Cart Page Start -->
                    <div class="container-fluid py-5">
                        <div class="container py-5">

                            <!-- ===== BREADCRUMB ===== -->
                            <nav aria-label="breadcrumb" class="mb-3">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">
                                        Chi Tiết Giỏ Hàng
                                    </li>
                                </ol>
                            </nav>

                            <!-- ===== XÓA TOÀN BỘ ===== -->
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

                            <!-- ===== TABLE GIỎ HÀNG ===== -->
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
                                                <td colspan="6" class="text-center">
                                                    Không có sản phẩm trong giỏ hàng
                                                </td>
                                            </tr>
                                        </c:if>

                                        <c:forEach var="cartDetail" items="${cartDetails}">
                                            <tr>
                                                <td>
                                                    <img src="/images/product/${cartDetail.product.image}"
                                                        class="img-fluid rounded-circle" style="width:80px;height:80px">
                                                </td>

                                                <td>
                                                    <a href="/product/${cartDetail.product.id}" target="_blank">
                                                        ${cartDetail.product.name}
                                                    </a>
                                                </td>

                                                <!-- ===== GIÁ GỐC ===== -->
                                                <td class="item-price" data-price="${cartDetail.price}">
                                                    <fmt:formatNumber value="${cartDetail.price}" /> đ
                                                </td>

                                                <!-- ===== SỐ LƯỢNG ===== -->
                                                <td>
                                                    <div class="input-group quantity" style="width:100px">
                                                        <button
                                                            class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                            <i class="fa fa-minus"></i>
                                                        </button>
                                                        <input type="text"
                                                            class="form-control form-control-sm text-center border-0"
                                                            value="${cartDetail.quantity}"
                                                            data-cart-detail-id="${cartDetail.id}">
                                                        <button
                                                            class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </div>
                                                </td>

                                                <!-- ===== THÀNH TIỀN ===== -->
                                                <td class="item-total">
                                                    <fmt:formatNumber
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

                            <!-- ===== THÔNG TIN ĐƠN HÀNG ===== -->
                            <div class="mt-5 row g-4 justify-content-start">
                                <div class="col-12 col-md-8">
                                    <div class="bg-light rounded">

                                        <div class="p-4">
                                            <h1 class="display-6 mb-4">
                                                Thông Tin <span class="fw-normal">Đơn Hàng</span>
                                            </h1>

                                            <div class="d-flex justify-content-between mb-4">
                                                <h5 class="mb-0">Tạm tính:</h5>
                                                <p class="mb-0" id="subTotal">
                                                    <fmt:formatNumber value="${totalPrice != null ? totalPrice : 0}" />
                                                    đ
                                                </p>
                                            </div>

                                            <div class="d-flex justify-content-between">
                                                <h5 class="mb-0">Phí vận chuyển</h5>
                                                <p class="mb-0">0 đ</p>
                                            </div>
                                        </div>

                                        <div class="py-4 mb-4 border-top border-bottom
                                d-flex justify-content-between">
                                            <h5 class="mb-0 ps-4">Tổng số tiền</h5>
                                            <p class="mb-0 pe-4" id="grandTotal">
                                                <fmt:formatNumber value="${totalPrice != null ? totalPrice : 0}" /> đ
                                            </p>
                                        </div>

                                        <form:form action="/confirm-checkout" method="post" modelAttribute="cart">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <button type="submit" class="btn border-secondary rounded-pill
                                       px-4 py-3 text-primary ms-4 mb-4" onclick="return checkCartNotEmpty();">
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

                    <!-- ===== JS ===== -->
                    <script>
                        function formatMoney(number) {
                            return number.toLocaleString('vi-VN') + " đ";
                        }

                        function updateTotals() {
                            let total = 0;

                            document.querySelectorAll("tbody tr").forEach(row => {
                                const qtyInput = row.querySelector("input[data-cart-detail-id]");
                                const priceCell = row.querySelector(".item-price");
                                const totalCell = row.querySelector(".item-total");

                                if (!qtyInput || !priceCell || !totalCell) return;

                                const quantity = parseInt(qtyInput.value);
                                const price = parseFloat(priceCell.dataset.price);

                                const itemTotal = quantity * price;
                                totalCell.innerText = formatMoney(itemTotal);
                                total += itemTotal;
                            });

                            document.getElementById("subTotal").innerText = formatMoney(total);
                            document.getElementById("grandTotal").innerText = formatMoney(total);
                        }

                        document.addEventListener("DOMContentLoaded", function () {

                            document.querySelectorAll(".btn-plus").forEach(btn => {
                                btn.onclick = function () {
                                    const input = this.closest(".quantity").querySelector("input");
                                    input.value = parseInt(input.value) + 1;
                                    updateTotals();
                                }
                            });

                            document.querySelectorAll(".btn-minus").forEach(btn => {
                                btn.onclick = function () {
                                    const input = this.closest(".quantity").querySelector("input");
                                    let v = parseInt(input.value);
                                    if (v > 1) {
                                        input.value = v - 1;
                                        updateTotals();
                                    }
                                }
                            });

                        });

                        function checkCartNotEmpty() {
                            return document.querySelectorAll("tbody tr td[colspan='6']").length === 0;
                        }
                    </script>

                </body>

                </html>