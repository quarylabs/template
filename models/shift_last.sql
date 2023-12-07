WITH min_shifts AS (SELECT employee_id,
                           max(shift_start) AS shift_start
                    FROM tbd.shifts
                    GROUP BY employee_id)

SELECT x.employee_id AS employee_id,
       x.shift_start AS shift_start,
       x.shift_end AS shift_end
FROM tbd.shifts x
INNER JOIN min_shifts y
ON y.employee_id = x.employee_id AND y.shift_start = x.shift_start
GROUP BY x.employee_id, x.shift_start