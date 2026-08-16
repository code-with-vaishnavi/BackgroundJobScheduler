package com.vaishnavi.model;

import java.sql.Date;
import java.sql.Time;

public class Job {

    private int jobId;
    private String jobName;
    private String jobDescription;
    private String jobType;
    private String jobStatus;
    private Date scheduleDate;
    private Time scheduleTime;
    private String executionStatus;

    // IMPORTANT: Job owner
    private int userId;


    public Job() {
    }


    public Job(int jobId,
               String jobName,
               String jobDescription,
               String jobType,
               String jobStatus) {

        this.jobId = jobId;
        this.jobName = jobName;
        this.jobDescription = jobDescription;
        this.jobType = jobType;
        this.jobStatus = jobStatus;
    }


    // ================= JOB ID =================

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }


    // ================= JOB NAME =================

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }


    // ================= DESCRIPTION =================

    public String getJobDescription() {
        return jobDescription;
    }

    public void setJobDescription(String jobDescription) {
        this.jobDescription = jobDescription;
    }


    // ================= JOB TYPE =================

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }


    // ================= JOB STATUS =================

    public String getJobStatus() {
        return jobStatus;
    }

    public void setJobStatus(String jobStatus) {
        this.jobStatus = jobStatus;
    }


    // ================= SCHEDULE DATE =================

    public Date getScheduleDate() {
        return scheduleDate;
    }

    public void setScheduleDate(Date scheduleDate) {
        this.scheduleDate = scheduleDate;
    }


    // ================= SCHEDULE TIME =================

    public Time getScheduleTime() {
        return scheduleTime;
    }

    public void setScheduleTime(Time scheduleTime) {
        this.scheduleTime = scheduleTime;
    }


    // ================= EXECUTION STATUS =================

    public String getExecutionStatus() {
        return executionStatus;
    }

    public void setExecutionStatus(String executionStatus) {
        this.executionStatus = executionStatus;
    }


    // ================= USER ID =================
    // IMPORTANT FOR USER/ADMIN SEPARATION

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

}