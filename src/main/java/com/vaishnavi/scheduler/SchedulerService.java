package com.vaishnavi.scheduler;

import com.vaishnavi.model.JobHistory;
import com.vaishnavi.dao.JobDAO;
import com.vaishnavi.dao.JobHistoryDAO;
import com.vaishnavi.model.Job;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class SchedulerService {

    private JobDAO jobDAO = new JobDAO();
    private JobHistoryDAO historyDAO = new JobHistoryDAO();

    private final ScheduledExecutorService scheduler =
            Executors.newScheduledThreadPool(1);

    public void startScheduler() {

        scheduler.scheduleAtFixedRate(() -> {

            System.out.println("\n==============================");
            System.out.println("Checking Pending Jobs...");

            List<Job> jobs = jobDAO.getAllJobs();

            System.out.println("Total Jobs Found : " + jobs.size());

            Date today = Date.valueOf(LocalDate.now());
            Time now = Time.valueOf(LocalTime.now().withNano(0));

            System.out.println("Today's Date : " + today);
            System.out.println("Current Time : " + now);

            for (Job job : jobs) {

                System.out.println("--------------------------------");
                System.out.println("Job ID : " + job.getJobId());
                System.out.println("Job Name : " + job.getJobName());
                System.out.println("Execution Status : " + job.getExecutionStatus());
                System.out.println("Schedule Date : " + job.getScheduleDate());
                System.out.println("Schedule Time : " + job.getScheduleTime());

                if (!"Pending".equalsIgnoreCase(job.getExecutionStatus())) {
                    System.out.println("Skipped (Status is not Pending)");
                    continue;
                }

                if (job.getScheduleDate() == null || job.getScheduleTime() == null) {
                    System.out.println("Skipped (Schedule Date/Time is NULL)");
                    continue;
                }

                if (job.getScheduleDate().equals(today)
                        && !job.getScheduleTime().after(now)) {

                    System.out.println("================================");
                    System.out.println("Executing Job : " + job.getJobName());
                    System.out.println("================================");
                    boolean updated = jobDAO.updateExecutionStatus(
                            job.getJobId(),
                            "Completed"
                    );

                    if (updated) {

                        System.out.println("Job Marked Completed");

                        JobHistory history = new JobHistory();

                        history.setJobId(job.getJobId());

                        history.setJobName(job.getJobName());

                        history.setExecutionTime(
                                new java.sql.Timestamp(System.currentTimeMillis())
                        );

                        history.setStatus("Completed");

                        history.setResult("Executed Successfully");

                        boolean historySaved = historyDAO.addHistory(history);

                        if (historySaved) {

                            System.out.println("Job History Saved Successfully");

                        } else {

                            System.out.println("Failed to Save Job History");

                        }

                    }

                } else {

                    System.out.println("Not Time Yet");

                }

            }

        }, 0, 10, TimeUnit.SECONDS);

    }

}