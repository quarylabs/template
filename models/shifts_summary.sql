WITH total_hours AS (
    SELECT employee_id,
           SUM(strftime('%s', shift_end) - strftime('%s', shift_start)) AS total_hours,
           COUNT(*) AS total_shifts
    FROM q.shifts
    GROUP BY employee_id
),

percentage_morning_shifts AS (
    SELECT employee_id,
           SUM(CASE WHEN shift = 'morning' THEN 1 ELSE 0 END) AS total_morning_shifts,
          COUNT(*) AS total_shifts
    FROM q.shifts
    GROUP BY employee_id
)

SELECT e.employee_id,
       e.first_name,
       e.last_name,
       sf.shift_start AS first_shift,
       sl.shift_start AS last_shift,
       pms.total_morning_shifts / pms.total_shifts * 100 AS percentage_morning_shifts,
       th.total_shifts,
       th.total_hours
FROM q.stg_employees e
LEFT JOIN q.shift_first sf
    ON e.employee_id = sf.employee_id
LEFT JOIN q.shift_last sl
    ON e.employee_id = sl.employee_id
LEFT JOIN total_hours th
    ON e.employee_id = th.employee_id
LEFT JOIN percentage_morning_shifts pms
    ON e.employee_id = pms.employee_id