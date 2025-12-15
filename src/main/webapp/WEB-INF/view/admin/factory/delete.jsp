<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Delete Factory</title>
        <link href="/css/styles.css" rel="stylesheet" />
    </head>

    <body class="sb-nav-fixed">
        <jsp:include page="../layout/header.jsp" />

        <div id="layoutSidenav">
            <jsp:include page="../layout/sidebar.jsp" />

            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4 text-danger">Delete Factory</h1>

                        <p>Bạn có chắc chắn muốn xoá factory này?</p>

                        <form method="post" action="/admin/factory/delete">
                            <input type="hidden" name="id" value="${id}" />

                            <button class="btn btn-danger">Delete</button>
                            <a href="/admin/factory" class="btn btn-secondary">Cancel</a>
                        </form>
                    </div>
                </main>

                <jsp:include page="../layout/footer.jsp" />
            </div>
        </div>
    </body>

    </html>