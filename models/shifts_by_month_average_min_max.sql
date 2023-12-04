SELECT
    shift_month,
    AVG(total_shifts) as average_shifts,
    MIN(total_shifts) as min_shifts,
    MAX(total_shifts) as max_shifts
FROM
    q.shifts_by_month
GROUP BY shift_month
ORDER BY shift_month