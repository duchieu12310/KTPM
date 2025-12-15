<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Update Factory</title>
            <link href="/css/styles.css" rel="stylesheet" />
        </head>

        <body class="sb-nav-fixed">
            <jsp:include page="../layout/header.jsp" />

            <div id="layoutSidenav">
                <jsp:include page="../layout/sidebar.jsp" />

                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">
                            <h1 class="mt-4">Update Factory</h1>

                            <form:form method="post" modelAttribute="newFactory" action="/admin/factory/update">

                                <form:hidden path="id" />

                                <div class="mb-3">
                                    <label class="form-label">Factory Name</label>
                                    <form:input path="name" class="form-control" />
                                </div>

                                <button class="btn btn-warning">Update</button>
                                <a href="/admin/factory" class="btn btn-secondary">Cancel</a>

                            </form:form>
                        </div>
                    </main>

                    <jsp:include page="../layout/footer.jsp" />
                </div>
            </div>
        </body>

        </html>