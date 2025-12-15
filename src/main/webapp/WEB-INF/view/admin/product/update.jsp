<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <title>Update Product</title>
                <link href="/css/styles.css" rel="stylesheet" />

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

                <script>
                    $(document).ready(function () {
                        const avatarFile = $("#avatarFile");
                        const orgImage = "${product.image}";

                        if (orgImage) {
                            $("#avatarPreview")
                                .attr("src", "/images/product/" + orgImage)
                                .show();
                        }

                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL).show();
                        });
                    });
                </script>
            </head>

            <body class="sb-nav-fixed">

                <jsp:include page="../layout/header.jsp" />

                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">

                                <h1 class="mt-4">Update Product</h1>

                                <div class="row mt-4">
                                    <div class="col-md-8 mx-auto">

                                        <form:form method="post" action="/admin/product/update/${product.id}"
                                            modelAttribute="product" enctype="multipart/form-data" class="row">

                                            <!-- ID -->
                                            <form:hidden path="id" />

                                            <!-- Name -->
                                            <div class="mb-3 col-md-6">
                                                <label class="form-label">Name</label>
                                                <form:input path="name" class="form-control" />
                                                <form:errors path="name" cssClass="text-danger" />
                                            </div>

                                            <!-- Price -->
                                            <div class="mb-3 col-md-6">
                                                <label class="form-label">Price</label>
                                                <form:input path="price" type="number" class="form-control" />
                                                <form:errors path="price" cssClass="text-danger" />
                                            </div>

                                            <!-- Detail Description -->
                                            <div class="mb-3 col-12">
                                                <label class="form-label">Detail Description</label>
                                                <form:textarea path="detailDesc" class="form-control" />
                                                <form:errors path="detailDesc" cssClass="text-danger" />
                                            </div>

                                            <!-- Short Description -->
                                            <div class="mb-3 col-md-6">
                                                <label class="form-label">Short Description</label>
                                                <form:input path="shortDesc" class="form-control" />
                                                <form:errors path="shortDesc" cssClass="text-danger" />
                                            </div>

                                            <!-- Quantity -->
                                            <div class="mb-3 col-md-6">
                                                <label class="form-label">Quantity</label>
                                                <form:input path="quantity" type="number" class="form-control" />
                                                <form:errors path="quantity" cssClass="text-danger" />
                                            </div>

                                            <!-- Factory -->
                                            <div class="mb-3 col-md-6">
                                                <label class="form-label">Factory</label>
                                                <form:select path="factoryId" class="form-select">
                                                    <form:options items="${factories}" itemValue="id"
                                                        itemLabel="name" />
                                                </form:select>
                                            </div>

                                            <!-- Image -->
                                            <div class="mb-3 col-md-6">
                                                <label class="form-label">Image</label>
                                                <input type="file" class="form-control" id="avatarFile"
                                                    name="nhom13File" accept=".png,.jpg,.jpeg" />
                                            </div>

                                            <!-- Preview -->
                                            <div class="mb-3 col-12">
                                                <img id="avatarPreview" style="max-height:250px; display:none;"
                                                    alt="Preview" />
                                            </div>

                                            <!-- Submit -->
                                            <div class="col-12">
                                                <button type="submit" class="btn btn-warning">
                                                    Update
                                                </button>
                                            </div>

                                        </form:form>

                                    </div>
                                </div>

                            </div>
                        </main>

                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>

            </body>

            </html>