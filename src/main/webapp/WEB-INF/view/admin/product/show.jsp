<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Manage Products</title>
                <link href="/css/styles.css" rel="stylesheet">
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">

                <!-- HEADER -->
                <jsp:include page="../layout/header.jsp" />

                <div id="layoutSidenav">

                    <!-- SIDEBAR -->
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">
                        <main class="container-fluid px-4 mt-4">

                            <h1 class="mb-4">Manage Products</h1>

                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item active">Products</li>
                            </ol>

                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h3>Product List</h3>
                                <a href="/admin/product/create" class="btn btn-primary">Create a Product</a>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-bordered table-hover align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Price</th>
                                            <th>Factory</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${products}">
                                            <tr>
                                                <td>${product.id}</td>
                                                <td>${product.name}</td>
                                                <td>
                                                    <fmt:formatNumber value="${product.price}" type="number" /> đ
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty product.factory}">
                                                            ${product.factory.name}
                                                        </c:when>
                                                        <c:otherwise>N/A</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a href="/admin/product/${product.id}"
                                                        class="btn btn-success btn-sm">View</a>
                                                    <a href="/admin/product/update/${product.id}"
                                                        class="btn btn-warning btn-sm mx-1">Update</a>
                                                    <a href="/admin/product/delete/${product.id}"
                                                        class="btn btn-danger btn-sm"
                                                        onclick="return confirm('Are you sure you want to delete this product?');">
                                                        Delete
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- PAGINATION -->
                            <nav aria-label="Page navigation">
                                <ul class="pagination justify-content-center">

                                    <!-- PREVIOUS -->
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/product?page=${currentPage - 1}">&laquo;</a>
                                    </li>

                                    <!-- PAGE NUMBERS -->
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="/admin/product?page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <!-- NEXT -->
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/product?page=${currentPage + 1}">&raquo;</a>
                                    </li>

                                </ul>
                            </nav>

                        </main>

                        <!-- FOOTER -->
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>