<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="ktpm Admin" />
                <meta name="author" content="Nhom 13" />
                <title>Quản lý danh mục</title>

                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />

                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Quản lý danh mục</h1>

                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger">
                                        ${errorMessage}
                                    </div>
                                </c:if>

                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success">
                                        ${successMessage}
                                    </div>
                                </c:if>

                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item">
                                        <a href="/admin">Bảng điều khiển</a>
                                    </li>
                                    <li class="breadcrumb-item active">Danh mục</li>
                                </ol>

                                <div class="mt-4">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h3>Bảng danh mục</h3>
                                        <a href="/admin/factory/create" class="btn btn-primary">
                                            Thêm danh mục
                                        </a>
                                    </div>

                                    <table class="table table-bordered table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Tên danh mục</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <!-- KHÔNG CÓ DỮ LIỆU -->
                                            <c:if test="${empty factories}">
                                                <tr>
                                                    <td colspan="3" class="text-center text-muted">
                                                        Chưa có danh mục nào
                                                    </td>
                                                </tr>
                                            </c:if>

                                            <!-- CÓ DỮ LIỆU -->
                                            <c:forEach var="factory" items="${factories}">
                                                <tr>
                                                    <td>${factory.id}</td>
                                                    <td>${factory.name}</td>
                                                    <td>
                                                        <a href="/admin/factory/${factory.id}"
                                                            class="btn btn-success btn-sm">
                                                            Xem
                                                        </a>

                                                        <a href="/admin/factory/update/${factory.id}"
                                                            class="btn btn-warning btn-sm mx-1">
                                                            Cập nhật
                                                        </a>

                                                        <a href="/admin/factory/delete/${factory.id}"
                                                            class="btn btn-danger btn-sm"
                                                            onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này không?');">
                                                            Xóa
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                    <!-- PAGINATION -->
                                    <c:if test="${totalPages > 0}">
                                        <nav aria-label="Page navigation example">
                                            <ul class="pagination justify-content-center">

                                                <!-- PREVIOUS -->
                                                <li class="page-item">
                                                    <a class="${currentPage <= 1 ? 'disabled page-link' : 'page-link'}"
                                                        href="/admin/factory?page=${currentPage - 1}">
                                                        &laquo;
                                                    </a>
                                                </li>

                                                <!-- PAGE NUMBER -->
                                                <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                                    <li class="page-item">
                                                        <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                                            href="/admin/factory?page=${loop.index + 1}">
                                                            ${loop.index + 1}
                                                        </a>
                                                    </li>
                                                </c:forEach>

                                                <!-- NEXT -->
                                                <li class="page-item">
                                                    <a class="${currentPage >= totalPages ? 'disabled page-link' : 'page-link'}"
                                                        href="/admin/factory?page=${currentPage + 1}">
                                                        &raquo;
                                                    </a>
                                                </li>

                                            </ul>
                                        </nav>
                                    </c:if>

                                </div>
                            </div>
                        </main>

                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>