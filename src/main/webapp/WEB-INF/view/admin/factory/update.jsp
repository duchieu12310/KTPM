<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Cập nhật danh mục</title>
                <link href="/css/styles.css" rel="stylesheet" />
            </head>

            <body class="sb-nav-fixed">

                <!-- HEADER -->
                <jsp:include page="../layout/header.jsp" />

                <div id="layoutSidenav">

                    <!-- SIDEBAR -->
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">

                                <h1 class="mt-4">Cập nhật danh mục</h1>

                                <!-- THÔNG BÁO CHUNG -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">
                                        ${error}
                                    </div>
                                </c:if>

                                <form:form method="post" action="/admin/factory/update" modelAttribute="newFactory">

                                    <!-- ID (KHÔNG CHO SỬA) -->
                                    <div class="mb-3">
                                        <label class="form-label">Mã danh mục</label>
                                        <form:input path="id" class="form-control" readonly="true" />
                                    </div>

                                    <!-- CATEGORY NAME -->
                                    <div class="mb-3">
                                        <label class="form-label">Tên danh mục</label>
                                        <form:input path="name" class="form-control" placeholder="Nhập tên danh mục" />
                                        <form:errors path="name" cssClass="text-danger" />
                                    </div>

                                    <!-- BUTTON -->
                                    <button type="submit" class="btn btn-warning">
                                        Cập nhật
                                    </button>
                                    <a href="/admin/factory" class="btn btn-secondary">
                                        Hủy
                                    </a>

                                </form:form>

                            </div>
                        </main>

                        <!-- FOOTER -->
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>

            </body>

            </html>