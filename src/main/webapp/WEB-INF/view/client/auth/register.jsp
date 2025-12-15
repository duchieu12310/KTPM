<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Đăng ký tài khoản - Laptopshop</title>

                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="bg-primary">
                <div id="layoutAuthentication">
                    <div id="layoutAuthentication_content">
                        <main>
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-lg-7">
                                        <div class="card shadow-lg border-0 rounded-lg mt-5">

                                            <div class="card-header">
                                                <h3 class="text-center font-weight-light my-4">
                                                    Tạo tài khoản mới
                                                </h3>
                                            </div>

                                            <div class="card-body">
                                                <form:form method="post" action="/register"
                                                    modelAttribute="registerUser">

                                                    <!-- ===== ERRORS ===== -->
                                                    <c:set var="errorFirstName">
                                                        <form:errors path="firstName" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorEmail">
                                                        <form:errors path="email" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorPhone">
                                                        <form:errors path="phone" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorGender">
                                                        <form:errors path="gender" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorBirthYear">
                                                        <form:errors path="birthYear" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <c:set var="errorPassword">
                                                        <form:errors path="confirmPassword"
                                                            cssClass="invalid-feedback" />
                                                    </c:set>

                                                    <!-- ===== HỌ TÊN ===== -->
                                                    <div class="row mb-3">
                                                        <div class="col-md-6">
                                                            <div class="form-floating mb-3 mb-md-0">
                                                                <form:input path="firstName" type="text"
                                                                    placeholder="Nhập tên"
                                                                    class="form-control ${not empty errorFirstName ? 'is-invalid' : ''}" />
                                                                <label>Tên</label>
                                                                ${errorFirstName}
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="form-floating">
                                                                <form:input path="lastName" type="text"
                                                                    placeholder="Nhập họ" class="form-control" />
                                                                <label>Họ</label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- ===== EMAIL ===== -->
                                                    <div class="form-floating mb-3">
                                                        <form:input path="email" type="email" placeholder="Email"
                                                            class="form-control ${not empty errorEmail ? 'is-invalid' : ''}" />
                                                        <label>Địa chỉ email</label>
                                                        ${errorEmail}
                                                        <c:if test="${not empty emailExist}">
                                                            <div class="invalid-feedback d-block">
                                                                ${emailExist}
                                                            </div>
                                                        </c:if>
                                                    </div>

                                                    <!-- ===== SỐ ĐIỆN THOẠI ===== -->
                                                    <div class="form-floating mb-3">
                                                        <form:input path="phone" type="text" placeholder="Số điện thoại"
                                                            class="form-control ${not empty errorPhone ? 'is-invalid' : ''}" />
                                                        <label>Số điện thoại</label>
                                                        ${errorPhone}
                                                    </div>

                                                    <!-- ===== GIỚI TÍNH ===== -->
                                                    <div class="form-floating mb-3">
                                                        <form:select path="gender"
                                                            class="form-select ${not empty errorGender ? 'is-invalid' : ''}">
                                                            <form:option value="" label="-- Chọn giới tính --" />
                                                            <form:option value="NAM">Nam</form:option>
                                                            <form:option value="NU">Nữ</form:option>
                                                            <form:option value="KHAC">Khác</form:option>
                                                        </form:select>
                                                        <label>Giới tính</label>
                                                        ${errorGender}
                                                    </div>

                                                    <!-- ===== NĂM SINH ===== -->
                                                    <div class="form-floating mb-3">
                                                        <form:input path="birthYear" type="number"
                                                            placeholder="Năm sinh"
                                                            class="form-control ${not empty errorBirthYear ? 'is-invalid' : ''}" />
                                                        <label>Năm sinh</label>
                                                        ${errorBirthYear}
                                                    </div>

                                                    <!-- ===== MẬT KHẨU ===== -->
                                                    <div class="row mb-3">
                                                        <div class="col-md-6">
                                                            <div class="form-floating mb-3 mb-md-0">
                                                                <form:input path="password" type="password"
                                                                    placeholder="Mật khẩu"
                                                                    class="form-control ${not empty errorPassword ? 'is-invalid' : ''}" />
                                                                <label>Mật khẩu</label>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="form-floating mb-3 mb-md-0">
                                                                <form:input path="confirmPassword" type="password"
                                                                    placeholder="Nhập lại mật khẩu"
                                                                    class="form-control" />
                                                                <label>Xác nhận mật khẩu</label>
                                                                ${errorPassword}
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- ===== BUTTON ===== -->
                                                    <div class="mt-4 mb-0">
                                                        <div class="d-grid">
                                                            <button class="btn btn-primary btn-block">
                                                                Đăng ký tài khoản
                                                            </button>
                                                        </div>
                                                    </div>

                                                </form:form>
                                            </div>

                                            <div class="card-footer text-center py-3">
                                                <div class="small">
                                                    <a href="/login">Đã có tài khoản? Đăng nhập</a>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>

            </body>

            </html>