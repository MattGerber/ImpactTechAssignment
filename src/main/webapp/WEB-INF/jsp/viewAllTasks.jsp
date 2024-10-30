<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<head>
    <meta charset="ISO-8859-1">
    <title>ToDo List</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

    <style>
        a{
            color: white;
        }
        a:hover {
            color: white;
            text-decoration: none;
        }
    </style>

</head>
<body>

<div class="container">

    <h1 class="p-3"> ToDo List</h1>
    <hr />

    <p><a class="btn btn-info" href="/analytics?dateFrom=${dateFrom}&dateTo=${dateTo}">
        <i class="bi bi-bar-chart-fill"></i> View Analytics</a>
    </p>

    <form:form>

        <table class="table table-bordered">
            <tr>
                <th>Id</th>
                <th>Title</th>
                <th>Description</th>
                <th>Date Created</th>
                <th>Date Completed</th>
                <th>Due Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>

            <c:forEach var="task" items="${list}">
                <tr class="${task.completed ? 'alert alert-success' : 'alert alert-warning'}" >
                    <td>${task.id}</td>
                    <td>${task.title}</td>
                    <td>${task.description}</td>
                    <td>${task.createdAt}</td>
                    <td>${task.completedAt}</td>
                    <td>${task.dueDate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${task.completed==true}"><span>Yes</span></c:when>
                            <c:otherwise ><span>No</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <div class="btn btn-group-sm" role="group">
                            <a class="btn btn-success" href="/completeTask/${task.id}">
                                <i class="bi bi-check-lg"></i>Complete Task</a>
                            <a class="btn btn-info" href="/editTask/${task.id}">
                                <i class="bi bi-pencil-fill"></i> Edit</a>
                            <a class="btn btn-danger" href="/deleteTask/${task.id}">
                                <i class="bi bi-trash-fill"></i> Delete</a>
                        </div>
                    </td>
                </tr>

            </c:forEach>

        </table>

    </form:form>

    <p><a class="btn btn-outline-success" href="/addTask">
        <i class="bi bi-plus-square-fill"></i> Add Task</a>
    </p>


</div>

<script th:inline="javascript">
    function selectDates(date) {
        var searchParams = new URLSearchParams(window.location.search);
        searchParams.append("DateFrom", date.toString())
        window.location.search = searchParams.toString();
        console.log([...searchParams.keys()])
    }
    window.onload = function() {

        var message = "${message}";

        if (message == "Save Success") {
            Command: toastr["success"]("Item added successfully!!")
        } else if (message == "Delete Success") {
            Command: toastr["success"]("Item deleted successfully!!")
        } else if (message == "Delete Failure") {
            Command: toastr["error"]("Some error occurred, couldn't delete item")
        } else if (message == "Edit Success") {
            Command: toastr["success"]("Item updated successfully!!")
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