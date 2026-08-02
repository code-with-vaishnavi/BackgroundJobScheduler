package com.vaishnavi.scheduler;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class SchedulerContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        SchedulerService service = new SchedulerService();

        service.startScheduler();

        System.out.println("Background Scheduler Started");

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

        System.out.println("Background Scheduler Stopped");

    }

}