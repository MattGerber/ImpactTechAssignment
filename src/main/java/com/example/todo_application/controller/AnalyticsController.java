package com.example.todo_application.controller;

import com.example.todo_application.model.Task;
import com.example.todo_application.service.ToDoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Controller
public class AnalyticsController {

    @Autowired
    private ToDoService service;

    private double calculateAverage(List <Long> numbers) {
        return numbers.stream()
                .mapToDouble(d -> d)
                .average()
                .orElse(0.0);
    };

    DateTimeFormatter format = DateTimeFormatter
            .ofPattern("yyyy-MM-dd");


    @GetMapping("analytics")
    public String analytics(Model model, @ModelAttribute("message") String message, @RequestParam LocalDate dateFrom, @RequestParam LocalDate dateTo) {
        List<Task> tasks = service.getTasksByRange(dateFrom, dateTo);
        List<Task> completedTasks = new ArrayList<>();
        List<LocalDate> datesCompleted = new ArrayList<>();
        List<LocalDate> datesCreated = new ArrayList<>();
        ArrayList<Long> timeToComplete = new ArrayList<>();
        final LocalDate[] bestDayCompleted = new LocalDate[1];
        final LocalDate[] besstDayCreated = new LocalDate[1];
        final Integer[] completedCount = {0};
        final Integer[] createdCount = {0};

        //This data consumption should be done at a query level. Find a way to do more advanced queries with repositories

        tasks.forEach(task -> {
            if (task.getCompleted()) {
                completedTasks.add(task);
                datesCompleted.add(task.getCompletedAt());
                //TODO: Find way to use hours instead of days
                timeToComplete.add(ChronoUnit.DAYS.between(task.getCreatedAt(), task.getCompletedAt()));
            }
            datesCreated.add(task.getCreatedAt());
        });

        datesCompleted.forEach(date -> {
           int x = Collections.frequency(datesCompleted, date);
           if (x > completedCount[0]) {
               bestDayCompleted[0] = date;
               completedCount[0] = x;
           }
        });

        datesCreated.forEach(date -> {
            int x = Collections.frequency(datesCreated, date);
            if (x > createdCount[0]) {
                besstDayCreated[0] = date;
                createdCount[0] = x;
            }
        });

        model.addAttribute("mostCompleted",bestDayCompleted[0]);
        model.addAttribute("countCompleted", completedCount[0]);

        model.addAttribute("mostCreated",besstDayCreated[0]);
        model.addAttribute("countCreated", createdCount[0]);

        model.addAttribute("dateFrom",dateFrom);
        model.addAttribute("dateTo",dateTo);

        model.addAttribute("list",tasks);
        model.addAttribute("overdue",service.getOverdueTasks());
        model.addAttribute("message", message);
        model.addAttribute("average", calculateAverage(timeToComplete));

        return "analytics";
    }
}
