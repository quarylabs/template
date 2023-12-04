select
  employee_id,
  shop_id,
  date as shift_date,
  shift
from
  q.raw_shifts
