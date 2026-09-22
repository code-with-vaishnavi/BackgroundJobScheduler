package com.vaishnavi.scheduler;

import com.vaishnavi.dao.JobDAO;
import com.vaishnavi.dao.JobHistoryDAO;
import com.vaishnavi.model.Job;
import com.vaishnavi.model.JobHistory;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class SchedulerService {

    private final JobDAO jobDAO = new JobDAO();

    private final JobHistoryDAO historyDAO =
            new JobHistoryDAO();

    private final ScheduledExecutorService scheduler =
            Executors.newScheduledThreadPool(1);


    // ==================================================
    // START BACKGROUND SCHEDULER
    // ==================================================

    public void startScheduler() {

        System.out.println("================================");
        System.out.println("Starting Background Scheduler");
        System.out.println("Check Interval: 10 seconds");
        System.out.println("================================");

        scheduler.scheduleAtFixedRate(
                this::checkPendingJobs,
                0,
                10,
                TimeUnit.SECONDS
        );
    }


    // ==================================================
    // CHECK PENDING JOBS
    // ==================================================

    private void checkPendingJobs() {

        System.out.println();
        System.out.println("================================");
        System.out.println("Checking Pending Jobs...");
        System.out.println("================================");

        try {

            List<Job> jobs =
                    jobDAO.getAllJobs();

            System.out.println(
                    "Total Jobs Found : "
                            + jobs.size()
            );

            Date today =
                    Date.valueOf(
                            LocalDate.now()
                    );

            Time now =
                    Time.valueOf(
                            LocalTime.now().withNano(0)
                    );

            System.out.println(
                    "Today's Date : "
                            + today
            );

            System.out.println(
                    "Current Time : "
                            + now
            );


            for (Job job : jobs) {

                System.out.println(
                        "--------------------------------"
                );

                System.out.println(
                        "Job ID : "
                                + job.getJobId()
                );

                System.out.println(
                        "Job Name : "
                                + job.getJobName()
                );

                System.out.println(
                        "Execution Status : "
                                + job.getExecutionStatus()
                );

                System.out.println(
                        "Schedule Date : "
                                + job.getScheduleDate()
                );

                System.out.println(
                        "Schedule Time : "
                                + job.getScheduleTime()
                );


                // ==================================================
                // CHECK EXECUTION STATUS
                // ==================================================

                String executionStatus =
                        job.getExecutionStatus();

                if (executionStatus == null
                        || !"Pending".equalsIgnoreCase(
                        executionStatus.trim()
                )) {

                    System.out.println(
                            "Skipped (Status is not Pending)"
                    );

                    continue;
                }


                // ==================================================
                // CHECK DATE
                // ==================================================

                if (job.getScheduleDate() == null) {

                    System.out.println(
                            "Skipped (Schedule Date is NULL)"
                    );

                    continue;
                }


                // ==================================================
                // CHECK TIME
                // ==================================================

                if (job.getScheduleTime() == null) {

                    System.out.println(
                            "Skipped (Schedule Time is NULL)"
                    );

                    continue;
                }


                Date scheduleDate =
                        job.getScheduleDate();

                Time scheduleTime =
                        job.getScheduleTime();


                // ==================================================
                // CHECK WHETHER JOB IS DUE
                // ==================================================

                boolean jobIsDue = false;


                // --------------------------------------------------
                // PAST DATE
                // --------------------------------------------------

                if (scheduleDate.before(today)) {

                    jobIsDue = true;
                }


                // --------------------------------------------------
                // TODAY
                // --------------------------------------------------

                else if (scheduleDate.equals(today)
                        && !scheduleTime.after(now)) {

                    jobIsDue = true;
                }


                // --------------------------------------------------
                // FUTURE DATE
                // --------------------------------------------------

                else {

                    jobIsDue = false;
                }


                // ==================================================
                // JOB NOT DUE
                // ==================================================

                if (!jobIsDue) {

                    System.out.println(
                            "Not Time Yet"
                    );

                    continue;
                }


                // ==================================================
                // EXECUTE JOB
                // ==================================================

                executeJob(job);
            }


        } catch (Exception e) {

            System.out.println(
                    "Scheduler Error!"
            );

            e.printStackTrace();
        }
    }


    // ==================================================
    // EXECUTE SINGLE JOB
    // ==================================================

    private void executeJob(Job job) {

        System.out.println();
        System.out.println(
                "================================"
        );

        System.out.println(
                "Job is Due!"
        );

        System.out.println(
                "Executing Job : "
                        + job.getJobName()
        );

        System.out.println(
                "Job ID : "
                        + job.getJobId()
        );

        System.out.println(
                "================================"
        );


        // ==================================================
        // CHANGE PENDING → RUNNING
        // ==================================================

        boolean runningUpdated =
                jobDAO.updateExecutionStatus(
                        job.getJobId(),
                        "Running"
                );


        if (!runningUpdated) {

            System.out.println(
                    "Failed to change job status to Running."
            );

            return;
        }


        System.out.println(
                "Job Status : Running"
        );


        // ==================================================
        // JOB EXECUTION
        // ==================================================

        try {

            System.out.println(
                    "Executing job..."
            );


            // ==================================================
            // TEST FAILURE HANDLING
            // ==================================================

            if ("FAIL_TEST".equalsIgnoreCase(
                    job.getJobType()
            )) {

                System.out.println(
                        "TEST FAILURE TRIGGERED!"
                );

                throw new RuntimeException(
                        "Simulated job execution failure."
                );
            }


            // ==================================================
            // NORMAL JOB EXECUTION
            // ==================================================

            Thread.sleep(2000);


            // ==================================================
            // CHANGE RUNNING → COMPLETED
            // ==================================================

            boolean completedUpdated =
                    jobDAO.updateExecutionStatus(
                            job.getJobId(),
                            "Completed"
                    );


            if (!completedUpdated) {

                System.out.println(
                        "Failed to update job to Completed."
                );

                return;
            }


            System.out.println(
                    "Job Status : Completed"
            );


            // ==================================================
            // SAVE SUCCESS HISTORY
            // ==================================================

            saveHistory(
                    job,
                    "Completed",
                    "Executed Successfully"
            );


        } catch (InterruptedException e) {

            // ==================================================
            // THREAD INTERRUPTED
            // ==================================================

            Thread.currentThread().interrupt();

            System.out.println(
                    "Job execution interrupted."
            );


            // ==================================================
            // CHANGE RUNNING → FAILED
            // ==================================================

            jobDAO.updateExecutionStatus(
                    job.getJobId(),
                    "Failed"
            );


            // ==================================================
            // SAVE FAILED HISTORY
            // ==================================================

            saveHistory(
                    job,
                    "Failed",
                    "Job execution interrupted."
            );


        } catch (Exception e) {

            // ==================================================
            // GENERAL EXECUTION FAILURE
            // ==================================================

            System.out.println(
                    "Job execution failed."
            );

            e.printStackTrace();


            // ==================================================
            // CHANGE RUNNING → FAILED
            // ==================================================

            jobDAO.updateExecutionStatus(
                    job.getJobId(),
                    "Failed"
            );


            // ==================================================
            // SAVE FAILED HISTORY
            // ==================================================

            saveHistory(
                    job,
                    "Failed",
                    "Job execution failed."
            );
        }
    }


    // ==================================================
    // SAVE JOB HISTORY
    // ==================================================

    private void saveHistory(
            Job job,
            String status,
            String result) {

        JobHistory history =
                new JobHistory();


        history.setJobId(
                job.getJobId()
        );


        history.setJobName(
                job.getJobName()
        );


        history.setExecutionTime(
                new Timestamp(
                        System.currentTimeMillis()
                )
        );


        history.setStatus(
                status
        );


        history.setResult(
                result
        );


        boolean historySaved =
                historyDAO.addHistory(
                        history
                );


        if (historySaved) {

            System.out.println(
                    "Job History Saved Successfully"
            );

        } else {

            System.out.println(
                    "Failed to Save Job History"
            );
        }
    }


    // ==================================================
    // STOP BACKGROUND SCHEDULER
    // ==================================================

    public void stopScheduler() {

        System.out.println(
                "Stopping Background Scheduler..."
        );


        if (!scheduler.isShutdown()) {

            scheduler.shutdownNow();
        }


        System.out.println(
                "Background Scheduler Stopped"
        );
    }
}