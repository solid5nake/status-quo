module StatusQuoHelper

  def status_quo_events(start_date, end_date)
    render partial: "status_quo/events",
           locals: {start_date: start_date, end_date: end_date}
  end

  def sq_table_data(start_date, end_date)
    data = ActiveRecord::Base.connection.select_rows <<-SQL
      SELECT
        sqe.resource,
        sqe.segment,
        DATE_FORMAT(sqe.moment, "%Y-%m-%d") AS date,
        SUM(IF(sqe.status = "OK", 1, 0)) AS oks,
        SUM(IF(sqe.status = "FAIL", 1, 0)) AS fails,
        (
          SELECT last_sqe.status
          FROM status_quo_events last_sqe
          WHERE last_sqe.resource = sqe.resource
          AND last_sqe.segment = sqe.segment
          AND DATE(last_sqe.moment) = date
          ORDER BY last_sqe.moment DESC
          LIMIT 1
        ) AS last_status
      FROM status_quo_events sqe
      GROUP BY sqe.resource, sqe.segment, date
      HAVING date >= "#{start_date}"
      AND date <= "#{end_date}"
      ORDER BY sqe.resource, sqe.segment, date;
    SQL

    data
      .group_by do |row|
        row.shift # removes the first element of the row array and returns it
      end
      .inject({}) do |hash, (key, value)| # includes new hash to the collection
        segments = value.group_by{|row| row.shift}
        hash[key] = segments
        hash
      end
  end

end
