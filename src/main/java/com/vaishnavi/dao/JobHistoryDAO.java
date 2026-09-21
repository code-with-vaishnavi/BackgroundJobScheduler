package com.vaishnavi.dao;

import com.vaishnavi.model.JobHistory;
import com.vaishnavi.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class JobHistoryDAO {

    // ================== ADD JOB HISTORY ==================
    public boolean addHistory(JobHistory history) {

        boolean status = false;

        String sql =
                "INSERT INTO job_history " +
                        "(job_id, job_name, execution_time, status, result) " +
                        "VALUES (?, ?, ?, ?, ?)";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, history.getJobId());
            ps.setString(2, history.getJobName());
            ps.setTimestamp(3, history.getExecutionTime());
            ps.setString(4, history.getStatus());
            ps.setString(5, history.getResult());

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }


    // ================== GET ALL HISTORY ==================
    public List<JobHistory> getAllHistory() {

        List<JobHistory> historyList = new ArrayList<>();

        String sql =
                "SELECT history_id, job_id, job_name, " +
                        "execution_time, status, result " +
                        "FROM job_history " +
                        "ORDER BY execution_time DESC";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                JobHistory history = new JobHistory();

                // History ID
                history.setHistoryId(
                        rs.getInt("history_id")
                );

                // IMPORTANT: Job ID
                history.setJobId(
                        rs.getInt("job_id")
                );

                // Job Name
                history.setJobName(
                        rs.getString("job_name")
                );

                // Execution Time
                history.setExecutionTime(
                        rs.getTimestamp("execution_time")
                );

                // Status
                history.setStatus(
                        rs.getString("status")
                );

                // IMPORTANT: Result
                history.setResult(
                        rs.getString("result")
                );

                historyList.add(history);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return historyList;
    }
}