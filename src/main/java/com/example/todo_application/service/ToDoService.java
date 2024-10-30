package com.example.todo_application.service;

import com.example.todo_application.repositories.TaskRepository;
import com.example.todo_application.model.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class ToDoService {

    @Autowired
    TaskRepository repo;

    public List<Task> getAllTasks () {
        return new ArrayList<>(repo.findAll());
    }

    public Task getTaskById (long id) {
        return repo.findById(id).get();
    }

    public boolean completeTask (long id) {
        Task todo = getTaskById(id);
        if (!todo.getCompleted()) {
            todo.setCompleted(true);
            todo.setCompletedAt(LocalDate.now());
        }

        return saveOrUpdateTask(todo);
    }

    public boolean saveOrUpdateTask (Task todo) {
        Task newTask = repo.save(todo);

        return getTaskById(newTask.getId()) != null;
    }

    public boolean deleteTask (long id) {
        repo.deleteById(id);

        return (repo.findById(id).isEmpty());
    }

    public List<Task> getTasksByRange (LocalDate from, LocalDate to) {
        return new ArrayList<>(repo.findTaskByCreatedAtBetween(from, to));
    }

    public List<Task> getOverdueTasks () {
        return new ArrayList<>(repo.findTasksByCompletedAndDueDateLessThan(false, new Date()));
    }
}
