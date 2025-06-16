# 🎯 SQL Case Study: Contest Performance Analytics

This project explores a real-world-style SQL challenge involving multi-table joins, data aggregation, and filtering. 
It simulates a scenario where contest and challenge data is spread across multiple tables, and the goal is to analyze contest performance metrics.

## 🧩 Problem Statement

Samantha organizes coding contests for various colleges. Each contest can be used by more than one college,
and each college creates its own challenges based on the contest. Students interact with these challenges by viewing and submitting solutions.

Your task is to write a SQL query that prints the following for each contest:
- `contest_id`
- `hacker_id` (creator of the contest)
- `name` (of the hacker)
- Total Submissions
- Total Accepted Submissions
- Total Views
- Total Unique Views

⚠️ **Important Condition**:  
Only include contests that had at least one activity (i.e., total of submissions, accepted submissions, views, or unique views is greater than zero).

## 🧱 Tables Used

### 1. Contests
| Column       | Type    |
|--------------|---------|
| contest_id   | INTEGER |
| hacker_id    | INTEGER |
| name         | STRING  |

### 2. Colleges
| Column       | Type    |
|--------------|---------|
| college_id   | INTEGER |
| contest_id   | INTEGER |

### 3. Challenges
| Column       | Type    |
|--------------|---------|
| challenge_id | INTEGER |
| college_id   | INTEGER |

### 4. View_Stats
| Column              | Type    |
|---------------------|---------|
| challenge_id        | INTEGER |
| total_views         | INTEGER |
| total_unique_views  | INTEGER |

### 5. Submission_Stats
| Column                   | Type    |
|--------------------------|---------|
| challenge_id             | INTEGER |
| total_submissions        | INTEGER |
| total_accepted_submissions | INTEGER |

## 📊 SQL Query (Solution)

```sql
SELECT
    C.contest_id,
    C.hacker_id,
    C.name,
    SUM(IFNULL(SS.TotalSubmissions, 0)) AS total_submissions,
    SUM(IFNULL(SS.TotalAcceptedSubmissions, 0)) AS total_accepted_submissions,
    SUM(IFNULL(VS.TotalViews, 0)) AS total_views,
    SUM(IFNULL(VS.TotalUniqueViews, 0)) AS total_unique_views
FROM Contests AS C
JOIN Colleges AS COL ON C.contest_id = COL.contest_id
JOIN Challenges AS CHA ON COL.college_id = CHA.college_id
LEFT JOIN (
    SELECT
        challenge_id,
        SUM(total_views) AS TotalViews,
        SUM(total_unique_views) AS TotalUniqueViews
    FROM View_Stats
    GROUP BY challenge_id
) AS VS ON CHA.challenge_id = VS.challenge_id
LEFT JOIN (
    SELECT
        challenge_id,
        SUM(total_submissions) AS TotalSubmissions,
        SUM(total_accepted_submissions) AS TotalAcceptedSubmissions
    FROM Submission_Stats
    GROUP BY challenge_id
) AS SS ON CHA.challenge_id = SS.challenge_id
GROUP BY C.contest_id, C.hacker_id, C.name
HAVING
    SUM(IFNULL(SS.TotalSubmissions, 0)) +
    SUM(IFNULL(SS.TotalAcceptedSubmissions, 0)) +
    SUM(IFNULL(VS.TotalViews, 0)) +
    SUM(IFNULL(VS.TotalUniqueViews, 0)) > 0
ORDER BY C.contest_id;
