package com.example.todo_application.model;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.Date;

@Entity
@Table (name = "task")
public class Task {

    @Id
    @GeneratedValue (strategy = GenerationType.AUTO)
    private long id;

    @Column
    private String title;
    @Column
    private String description;
    @Column
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate createdAt =LocalDate.now();
    @Column
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate completedAt;
    @Column
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dueDate;
    @Column
    private Boolean completed = false;

    public Task() {

    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate created_at) {
        this.createdAt = created_at;
    }

    public LocalDate getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(LocalDate completed_at) {
        this.completedAt = completed_at;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Boolean getCompleted() {
        return completed;
    }

    public void setCompleted(Boolean completed) {
        this.completed = completed;
    }
}
