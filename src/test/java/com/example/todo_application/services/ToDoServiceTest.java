package com.example.todo_application.services;

import com.example.todo_application.model.Task;
import com.example.todo_application.repositories.TaskRepository;
import com.example.todo_application.service.ToDoService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class ToDoServiceTest {

    @Autowired
    private ToDoService service;

    @Autowired
    private TaskRepository repo;

    @AfterEach
    void deleteAllTasks() {
        repo.deleteAll();
    }

    @Test
    @DisplayName("find a Task by Id")
    void findTaskById() {
        Task task = new Task();
        task.setTitle("Task Title");
        task.setDescription("Task Description");

        service.saveOrUpdateTask(task);
        Task testItem = service.getTaskById(task.getId());
        assertEquals(testItem.getId(), task.getId());
    }

    @Test
    void getAllTasks() {
        Task item1 = new Task();
        item1.setDescription("todo item1");

        service.saveOrUpdateTask(item1);

        Task item2 = new Task();
        item2.setDescription("todo item1");

        service.saveOrUpdateTask(item2);

        Iterable<Task> items = service.getAllTasks();
        List<Task> list = new ArrayList<>();
        items.iterator().forEachRemaining(list::add);
        assertNotEquals(list.size(), 0);
        assertEquals(list.size(), 2);
        assertEquals(list.get(0).getId(), item1.getId());
        assertEquals(list.get(1).getId(), item2.getId());
    }

    @Test
    void savingAValidTaskSucceeds() {
        Task item = new Task();
        item.setDescription("todo item1");

        service.saveOrUpdateTask(item);
        assertNotEquals(item.getId(), (Long) null);
    }

    @Test
    void deletingAValidTaskSucceeds() {
        Task item = new Task();
        item.setDescription("todo item1");

        service.saveOrUpdateTask(item);
        service.deleteTask(item.getId());

        Iterable<Task> items = service.getAllTasks();
        List<Task> list = new ArrayList<>();
        items.iterator().forEachRemaining(list::add);
        assertEquals(list.size(), 0);
    }

    @Test
    void completeTaskById() {
        Task item = new Task();
        item.setDescription("todo item1");

        service.saveOrUpdateTask(item);
        service.completeTask(item.getId());

        assertEquals(service.getTaskById(item.getId()).getCompleted(), true);
    }


    @Test
    void getTasksByDatRange() {
        Task item = new Task();
        item.setDescription("todo item1");
        item.setCreatedAt(LocalDate.now().minusMonths(1));
        Task item2 = new Task();
        item2.setDescription("todo item1");
        item2.setCreatedAt(LocalDate.now());

        service.saveOrUpdateTask(item);
        service.saveOrUpdateTask(item2);
        List<Task> list = new ArrayList<>(service.getTasksByRange(LocalDate.now().minusDays(2), LocalDate.now()));
        assertEquals(list.size(), 1);
    }

    @Test
    void getOverdueTasks() {
        Task item = new Task();
        item.setDescription("todo item1");
        item.setCreatedAt(LocalDate.now().minusMonths(1));
        item.setDueDate(new Date(-7));
        Task item2 = new Task();
        item2.setDescription("todo item1");
        item2.setCreatedAt(LocalDate.now());
        item.setDueDate(new Date(+7));

        service.saveOrUpdateTask(item);
        service.saveOrUpdateTask(item2);
        List<Task> list = new ArrayList<>(service.getOverdueTasks());
        assertEquals(list.size(), 1);
    }


}
