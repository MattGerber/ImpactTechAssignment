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

    <h1>Analytics for Data from ${dateFrom} to ${dateTo}</h1>
    <h2>Most Productive Day: ${mostCompleted} (${countCompleted} tasks completed)</h2>
    <h2>Average Time to complete task ${average} Days</h2>
    <h2>Day Most Tasks created: ${mostCreated} (${countCreated} tasks created)</h2>
    <p><a class="btn btn-success" href="/viewAllTasks">
        <i class="bi bi-house-door"></i> Home Page</a>
    </p>
    <hr />

    <form onsubmit="changeDates(event)">
        <h2>Change Date Range</h2>
        <div class="row">
            <div class="form-group col-md-12">
                <label class="col-md-3" for="dateFrom">Date From:</label>
                <div class="col-md-6">
                    <input type="date"  id="dateFrom" name="dateFrom"
                                class="form-control input-sm" required="required" />
                </div>
            </div>
            <div class="form-group col-md-12">
                <label class="col-md-3" for="dateTo">Date To</label>
                <div class="col-md-6">
                    <input type="date" path="dateTo" id="dateTo" name="dateTo"
                                class="form-control input-sm" required="required" />
                </div>
            </div>
        </div>
        <div class="row p-2">
            <div class="col-md-2">
                <button type="submit" value="Register" class="btn btn-success">Update Range</button>
            </div>
        </div>
    </form>

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
                </tr>

            </c:forEach>

        </table>

    </form:form>

    <h1 class="p-3"> Overdue Tasks</h1>
    <hr />

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
            </tr>

            <c:forEach var="task" items="${overdue}">
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
                </tr>

            </c:forEach>

        </table>

    </form:form>


</div>

<script th:inline="javascript">
    function changeDates(event) {
        searchParams = new URLSearchParams(window.location.search);
        searchParams.set("dateFrom", event.target.dateFrom.value);
        searchParams.set("dateTo", event.target.dateTo.value);
        window.location.search = searchParams.toString();
    };
    window.onload = function() {
        console.log(${list});

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