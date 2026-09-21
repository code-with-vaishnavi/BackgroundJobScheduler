package com.vaishnavi.scheduler;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class SchedulerContextListener implements ServletContextListener {

    private SchedulerService service;

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        service = new SchedulerService();

        service.startScheduler();

        System.out.println("================================");
        System.out.println("Background Scheduler Started");
        System.out.println("================================");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

        if (service != null) {

            service.stopScheduler();
        }

        System.out.println("================================");
        System.out.println("Background Scheduler Stopped");
        System.out.println("================================");
    }
}