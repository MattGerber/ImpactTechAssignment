<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<head>
    <meta charset="ISO-8859-1">
    <title>Add Task</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

</head>
<body>

<div class="container">

    <h1 class="p-3"> Add a Task </h1>

    <form:form action="/saveTask" method="post" modelAttribute="task">

        <div class="row">
            <div class="form-group col-md-12">
                <label class="col-md-3" for="title">Title</label>
                <div class="col-md-6">
                    <form:input type="text" path="title" id="title"
                                class="form-control input-sm" required="required" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-12">
                <label class="col-md-3" for="description">Description</label>
                <div class="col-md-6">
                    <form:input type="text" path="description" id="description"
                                class="form-control input-sm" required="required" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-md-12">
                <label class="col-md-3" for="dueDate">Due Date</label>
                <div class="col-md-6">
                    <form:input type="date" path="dueDate" id="dueDate"
                                class="form-control input-sm" required="required" />
                </div>
            </div>
        </div>

        <form:input type="hidden" path="completed" id="completed"
            class="form-control input-sm" value="false" />

        <div class="row p-2">
            <div class="btn btn-group-sm" role="group">
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-check-lg"></i>Add Task</button>
                <a class="btn btn-danger" href="/viewAllTasks">
                    <i class="bi bi-times-lg"></i>Cancel</a>
            </div>
        </div>

    </form:form>

</div>

<script th:inline="javascript">
    window.onload = function() {

        var message = "${message}";
        console.log(msg);
        if (message == "Save Failure") {
            Command: toastr["error"]("Something went wrong with the save.")
        }

        toastr.options = {
            "closeButton": true,
            "debug": false,
            "newestOnTop": false,
            "progressBar": true,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        }
    }
</script>

</body>

</html>