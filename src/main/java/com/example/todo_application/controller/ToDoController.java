package com.example.todo_application.controller;

import com.example.todo_application.model.Task;
import com.example.todo_application.service.ToDoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;

@Controller
public class ToDoController {

    @Autowired
    private ToDoService service;

    @GetMapping({"/", "viewAllTasks"})
    public String viewAllTasks(Model model, @ModelAttribute("message") String message) {
        model.addAttribute("list",service.getAllTasks());
        model.addAttribute("message", message);
        model.addAttribute("dateFrom", LocalDate.now().minusDays(7));
        model.addAttribute("dateTo", LocalDate.now());

        return "viewAllTasks";
    }

    @GetMapping("completeTask/{id}")
    public String completeTask(@PathVariable long id, RedirectAttributes redirectAttributes) {
        if (service.completeTask(id)) {
            redirectAttributes.addFlashAttribute("message", "Update Success");
            return "redirect:/viewAllTasks";
        }
        redirectAttributes.addFlashAttribute("message", "Update Failure");
        return "redirect:/viewAllTasks";

    }

    @GetMapping("/addTask")
    public String addTask(Model model) {
        model.addAttribute("task", new Task());
        return "addTask";
    }

    @PostMapping("/saveTask")
    public String saveTask(Task task, RedirectAttributes redirectAttributes) {
        if (service.saveOrUpdateTask(task)) {
            redirectAttributes.addFlashAttribute("message", "Save Success");
            return "redirect:/viewAllTasks";
        }
        redirectAttributes.addFlashAttribute("message", "Save Failure");
        return "redirect:/addTask";
    }

    @GetMapping("/editTask/{id}")
    public String editTask(@PathVariable long id, Model model) {
        model.addAttribute("task", service.getTaskById(id));

        return "editTask";
    }

    @PostMapping("/editSaveTask")
    public String editSaveTask(Task task, RedirectAttributes redirectAttributes) {
        if (service.saveOrUpdateTask(task)) {
            redirectAttributes.addFlashAttribute("message", "Edit Success");
            return "redirect:/viewAllTasks";
        }
        redirectAttributes.addFlashAttribute("message", "Edit Failure");
        return "redirect:/editTask/" + task.getId();
    }

    @GetMapping("/deleteTask/{id}")
    public String deleteTask(@PathVariable long id, RedirectAttributes redirectAttributes) {
        if (service.deleteTask(id)) {
            redirectAttributes.addFlashAttribute("message", "Delete Success");
            return "redirect:/viewAllTasks";
        }
        redirectAttributes.addFlashAttribute("message", "Delete Failure");
        return "redirect:/viewAllTasks";
    }

}
