package com.example.todo_application.repositories;

import com.example.todo_application.model.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {

    List<Task> findTaskByCreatedAtBetween(LocalDate from, LocalDate to);

    List<Task> findTasksByCompletedAndDueDateLessThan(Boolean completed , Date today);

}