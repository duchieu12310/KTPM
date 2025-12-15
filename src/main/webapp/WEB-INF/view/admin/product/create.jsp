<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Nhom 13 - Laptopshop" />
                <meta name="author" content="Nhom 13" />
                <title>Create Product</title>

                <link href="/css/styles.css" rel="stylesheet" />

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(function () {
                        $("#avatarFile").change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL).show();
                        });
                    });
                </script>

                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">

                <jsp:include page="../layout/header.jsp" />

                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">

                                <h1 class="mt-4">Products</h1>

                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/product">Product</a></li>
                                    <li class="breadcrumb-item active">Create</li>
                                </ol>

                                <div class="mt-4">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">

                                            <h3>Create a product</h3>
                                            <hr />

                                            <form:form method="post" action="/admin/product/create"
                                                modelAttribute="newProduct" enctype="multipart/form-data" class="row">

                                                <!-- ERROR -->
                                                <c:set var="errorName">
                                                    <form:errors path="name" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="errorPrice">
                                                    <form:errors path="price" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="errorDetailDesc">
                                                    <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="errorShortDesc">
                                                    <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="errorQuantity">
                                                    <form:errors path="quantity" cssClass="invalid-feedback" />
                                                </c:set>

                                                <!-- NAME -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Name</label>
                                                    <form:input path="name"
                                                        class="form-control ${not empty errorName ? 'is-invalid' : ''}" />
                                                    ${errorName}
                                                </div>

                                                <!-- PRICE -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Price</label>
                                                    <form:input path="price" type="number"
                                                        class="form-control ${not empty errorPrice ? 'is-invalid' : ''}" />
                                                    ${errorPrice}
                                                </div>

                                                <!-- DETAIL -->
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Detail description</label>
                                                    <form:textarea path="detailDesc"
                                                        class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}" />
                                                    ${errorDetailDesc}
                                                </div>

                                                <!-- SHORT -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Short description</label>
                                                    <form:input path="shortDesc"
                                                        class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}" />
                                                    ${errorShortDesc}
                                                </div>

                                                <!-- QUANTITY -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Quantity</label>
                                                    <form:input path="quantity" type="number"
                                                        class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}" />
                                                    ${errorQuantity}
                                                </div>

                                                <!-- FACTORY (ENTITY) -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label>Factory</label>
                                                    <form:select path="factoryId" class="form-select">
                                                        <form:option value="" label="-- Chọn factory --" />
                                                        <c:forEach items="${factories}" var="f">
                                                            <form:option value="${f.id}">${f.name}</form:option>
                                                        </c:forEach>
                                                    </form:select>
                                                </div>

                                                <!-- TARGET -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Target</label>
                                                    <form:select path="target" class="form-select">
                                                        <form:option value="GAMING">Gaming</form:option>
                                                        <form:option value="SINHVIEN-VANPHONG">Sinh viên - Văn phòng
                                                        </form:option>
                                                        <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa
                                                        </form:option>
                                                        <form:option value="MONG-NHE">Mỏng nhẹ</form:option>
                                                        <form:option value="DOANH-NHAN">Doanh nhân</form:option>
                                                    </form:select>
                                                </div>

                                                <!-- IMAGE -->
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Image</label>
                                                    <input type="file" class="form-control" id="avatarFile"
                                                        name="nhom13File" accept=".png,.jpg,.jpeg" />
                                                </div>

                                                <div class="col-12 mb-3">
                                                    <img id="avatarPreview" style="max-height:250px; display:none;" />
                                                </div>

                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-primary">
                                                        Create
                                                    </button>
                                                </div>

                                            </form:form>

                                        </div>
                                    </div>
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