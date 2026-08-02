package com.vaishnavi.dao;

import com.vaishnavi.model.Job;
import com.vaishnavi.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    // ================== ADD JOB ==================
    public boolean addJob(Job job) {

        boolean status = false;

        String sql = "INSERT INTO jobs(job_name,job_description,job_type,job_status,schedule_date,schedule_time,execution_status) VALUES(?,?,?,?,?,?,?)";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, job.getJobName());
            ps.setString(2, job.getJobDescription());
            ps.setString(3, job.getJobType());
            ps.setString(4, job.getJobStatus());

            ps.setDate(5, job.getScheduleDate());
            ps.setTime(6, job.getScheduleTime());
            ps.setString(7, job.getExecutionStatus());

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }


    // ================== GET ALL JOBS ==================
    public List<Job> getAllJobs() {

        List<Job> jobList = new ArrayList<>();

        String sql = "SELECT * FROM jobs";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Job job = new Job();

                job.setJobId(rs.getInt("job_id"));
                job.setJobName(rs.getString("job_name"));
                job.setJobDescription(rs.getString("job_description"));
                job.setJobType(rs.getString("job_type"));
                job.setJobStatus(rs.getString("job_status"));
                job.setScheduleDate(rs.getDate("schedule_date"));
                job.setScheduleTime(rs.getTime("schedule_time"));
                job.setExecutionStatus(rs.getString("execution_status"));

                jobList.add(job);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return jobList;


    }
    // ================== GET JOB BY ID ==================
    public Job getJobById(int jobId) {

        Job job = null;

        String sql = "SELECT * FROM jobs WHERE job_id=?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, jobId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                job = new Job();

                job.setJobId(rs.getInt("job_id"));
                job.setJobName(rs.getString("job_name"));
                job.setJobDescription(rs.getString("job_description"));
                job.setJobType(rs.getString("job_type"));
                job.setJobStatus(rs.getString("job_status"));
                job.setScheduleDate(rs.getDate("schedule_date"));
                job.setScheduleTime(rs.getTime("schedule_time"));
                job.setExecutionStatus(rs.getString("execution_status"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return job;
    }
    // ================== UPDATE JOB ==================
    public boolean updateJob(Job job) {

        boolean status = false;

        String sql = "UPDATE jobs SET job_name=?, job_description=?, job_type=?, job_status=?, schedule_date=?, schedule_time=?, execution_status=? WHERE job_id=?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, job.getJobName());
            ps.setString(2, job.getJobDescription());
            ps.setString(3, job.getJobType());
            ps.setString(4, job.getJobStatus());

            ps.setDate(5, job.getScheduleDate());
            ps.setTime(6, job.getScheduleTime());
            ps.setString(7, job.getExecutionStatus());

            ps.setInt(8, job.getJobId());

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    // ================== DELETE JOB ==================
    public boolean deleteJob(int jobId) {

        boolean status = false;

        String sql = "DELETE FROM jobs WHERE job_id=?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, jobId);

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    // ================== TOTAL JOBS ==================
    public int getTotalJobs() {

        int count = 0;

        String sql = "SELECT COUNT(*) FROM jobs";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    // ================== UPDATE EXECUTION STATUS ==================
    public boolean updateExecutionStatus(int jobId, String status) {

        boolean result = false;

        String sql = "UPDATE jobs SET execution_status=? WHERE job_id=?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, jobId);

            int row = ps.executeUpdate();

            if (row > 0) {
                result = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    // ================== PENDING JOBS ==================
    public int getPendingJobs() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM jobs WHERE execution_status='Pending'");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;

    }

    // ================== COMPLETED JOBS ==================
    public int getCompletedJobs() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM jobs WHERE execution_status='Completed'");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;

    }

    // ================== FAILED JOBS ==================
    public int getFailedJobs() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM jobs WHERE execution_status='Failed'");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;

    }
}