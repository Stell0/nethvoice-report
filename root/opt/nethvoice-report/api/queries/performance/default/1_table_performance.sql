SELECT p_a_d.period AS period£{{ .Time.Group }}Date,
       p_a_d.qname AS queueName,
       p_a_d.qdescr AS queueDescription,
       (SELECT total
        FROM   performance_total_{{ .Time.Group }}
        WHERE  period = p_a_d.period
               AND qname = p_a_d.qname)               AS `incoming£num`,
       (SELECT count
        FROM   performance_processed_{{ .Time.Group }}
        WHERE  period = p_a_d.period
               AND qname = p_a_d.qname)               AS `processed$tot£num`,
       ( Round((SELECT count
                FROM   performance_processed_{{ .Time.Group }}
                WHERE  period = p_a_d.period
                       AND qname = p_a_d.qname) * 100 /
               (SELECT total
                FROM   performance_total_{{ .Time.Group }}
                WHERE  period = p_a_d.period
                       AND qname = p_a_d.qname),
           2) )                                       AS `processed$percentage£percent#hide`,
       (SELECT count
        FROM   performance_good_{{ .Time.Group }}
        WHERE  period = p_a_d.period
               AND qname = p_a_d.qname)               AS `processed$60sec£num#hide`,
       ( Round((SELECT count
                FROM   performance_good_{{ .Time.Group }}
                WHERE  period = p_a_d.period
                       AND qname = p_a_d.qname) * 100 / (SELECT total
                                                         FROM
               performance_total_{{ .Time.Group }}
                                                         WHERE
               period = p_a_d.period
               AND qname =
           p_a_d.qname), 2) )                         AS `processed$percentage£percent#hide`,
       Sum((SELECT COALESCE(Sum(count), 0)
            FROM   performance_failed_{{ .Time.Group }}
            WHERE  period = p_a_d.period
                   AND qname = p_a_d.qname)
           + (SELECT COALESCE(Sum(count), 0)
              FROM   performance_timeout_{{ .Time.Group }}
              WHERE  period = p_a_d.period
                     AND qname = p_a_d.qname)
           + (SELECT COALESCE(Sum(count), 0)
              FROM   performance_exitempty_{{ .Time.Group }}
              WHERE  period = p_a_d.period
                     AND qname = p_a_d.qname)
           + (SELECT COALESCE(Sum(count), 0)
              FROM   performance_exitkey_{{ .Time.Group }}
              WHERE  period = p_a_d.period
                     AND qname = p_a_d.qname)
           + (SELECT COALESCE(Sum(count), 0)
              FROM   performance_full_{{ .Time.Group }}
              WHERE  period = p_a_d.period
                     AND qname = p_a_d.qname)
           + (SELECT COALESCE(Sum(count), 0)
              FROM   performance_joinempty_{{ .Time.Group }}
              WHERE  period = p_a_d.period
                     AND qname = p_a_d.qname))        AS `notProcessed$tot£num`,
       ( Round(( Sum((SELECT COALESCE(Sum(count), 0)
                      FROM   performance_failed_{{ .Time.Group }}
                      WHERE  period = p_a_d.period
                             AND qname = p_a_d.qname)
                     + (SELECT COALESCE(Sum(count), 0)
                        FROM   performance_timeout_{{ .Time.Group }}
                        WHERE  period = p_a_d.period
                               AND qname = p_a_d.qname)
                     + (SELECT COALESCE(Sum(count), 0)
                        FROM   performance_exitempty_{{ .Time.Group }}
                        WHERE  period = p_a_d.period
                               AND qname = p_a_d.qname)
                     + (SELECT COALESCE(Sum(count), 0)
                        FROM   performance_exitkey_{{ .Time.Group }}
                        WHERE  period = p_a_d.period
                               AND qname = p_a_d.qname)
                     + (SELECT COALESCE(Sum(count), 0)
                        FROM   performance_full_{{ .Time.Group }}
                        WHERE  period = p_a_d.period
                               AND qname = p_a_d.qname)
                     + (SELECT COALESCE(Sum(count), 0)
                        FROM   performance_joinempty_{{ .Time.Group }}
                        WHERE  period = p_a_d.period
                               AND qname = p_a_d.qname)) ) * 100 / (SELECT total
                                                                    FROM
                       performance_total_{{ .Time.Group }}
                                                                    WHERE
                       period = p_a_d.period
                       AND qname = p_a_d.qname), 2) ) AS `notProcessed$percentage£percent#hide`,
       (SELECT Sum(count)
        FROM   performance_failed_{{ .Time.Group }}
        WHERE  period = p_a_d.period
               AND qname = p_a_d.qname)               AS `notProcessed$failed£num#hide`,
       ( Round((SELECT Sum(count)
                FROM   performance_failed_{{ .Time.Group }}
                WHERE  period = p_a_d.period
                       AND qname = p_a_d.qname) * 100 / (SELECT total
                                                         FROM
               performance_total_{{ .Time.Group }}
                                                         WHERE
               period = p_a_d.period
               AND qname =
           p_a_d.qname), 2) )                         AS `notProcessed$percentage£percent#hide`,
       (SELECT Sum(count)
        FROM   performance_timeout_{{ .Time.Group }}
        WHERE  period = p_a_d.period
               AND qname = p_a_d.qname)               AS `notProcessed$timeout£num#hide`,
       ( Round((SELECT Sum(count)
                FROM   performance_timeout_{{ .Time.Group }}
                WHERE  period = p_a_d.period
                       AND qname = p_a_d.qname) * 100 / (SELECT total
                                                         FROM
               performance_total_{{ .Time.Group }}
                                                         WHERE
               period = p_a_d.period
               AND qname =
           p_a_d.qname), 2) )                         AS `notProcessed$percentage£percent#hide`,
       (SELECT Sum(count)
        FROM   performance_exitempty_{{ .Time.Group }}
        WHERE  period = p_a_d.period
               AND qname = p_a_d.qname)               AS `notProcessed$exitempty£num#hide`,
       ( Round((SELECT Sum(count)
                FROM   performance_exitempty_{{ .Time.Group }}
                WHERE  period = p_a_d.period
                       AND qname = p_a_d.qname) * 100 / (SELECT total
                                                         FROM
               performance_total_{{ .Time.Group }}
                                                         WHERE
               period = p_a_d.period
               AND qname =
           p_a_d.qname), 2) )                         AS `notProcessed$percentage£percent#hide`,
       (SELECT Sum(count)
        FROM   performance_exitkey_{{ .Time.Group }}
        WHERE  period = p_a_d.period
               AND qname = p_a_d.qname)               AS `notProcessed$exitkey£num#hide`,
       ( Round((SELECT Sum(count)
                FROM   performance_exitkey_{{ .Time.Group }}
                WHERE  period = p_a_d.period
                       AND qname = p_a_d.qname) * 100 / (SELECT total
                                                         FROM
               performance_total_{{ .Time.Group }}
                                                         WHERE
               period = p_a_d.period
               AND qname =
           p_a_d.qname), 2) )                         AS `notProcessed$percentage£percent#hide`,
       (SELECT Sum(count)
        FROM   performance_full_{{ .Time.Group }}
        WHERE  period = p_a_d.period
               AND qname = p_a_d.qname)               AS `notProcessed$full£num#hide`,
       ( Round((SELECT Sum(count)
                FROM   performance_full_{{ .Time.Group }}
                WHERE  period = p_a_d.period
                       AND qname = p_a_d.qname) * 100 / (SELECT total
                                                         FROM
               performance_total_{{ .Time.Group }}
                                                         WHERE
               period = p_a_d.period
               AND qname =
           p_a_d.qname), 2) )                         AS `notProcessed$percentage£percent#hide`,
       (SELECT Sum(count)
        FROM   performance_joinempty_{{ .Time.Group }}
        WHERE  period = p_a_d.period
               AND qname = p_a_d.qname)               AS `notProcessed$joinempty£num#hide`,
       ( Round((SELECT Sum(count)
                FROM   performance_joinempty_{{ .Time.Group }}
                WHERE  period = p_a_d.period
                       AND qname = p_a_d.qname) * 100 / (SELECT total
                                                         FROM
               performance_total_{{ .Time.Group }}
                                                         WHERE
               period = p_a_d.period
               AND qname =
           p_a_d.qname), 2) )                         AS `notProcessed$percentage£percent#hide`,
       (SELECT Sum(count)
        FROM   performance_null_{{ .Time.Group }}
        WHERE  period = p_a_d.period
               AND qname = p_a_d.qname)               AS `null$tot£num`,
       ( Round((SELECT Sum(count)
                FROM   performance_null_{{ .Time.Group }}
                WHERE  period = p_a_d.period
                       AND qname = p_a_d.qname) * 100 / (SELECT total
                                                         FROM
               performance_total_{{ .Time.Group }}
                                                         WHERE
               period = p_a_d.period
               AND qname =
           p_a_d.qname), 2) )                         AS `null$percentage£percent`,
       p_a_d.min_hold                                 AS `waiting$min£seconds`,
       p_a_d.max_hold                                 AS `waiting$max£seconds`,
       p_a_d.avg_hold                                 AS `waiting$avg£seconds`,
       p_a_d.min_duration                             AS `duration$min£seconds`,
       p_a_d.max_duration                             AS `duration$max£seconds`,
       p_a_d.avg_duration                             AS `duration$avg£seconds`
FROM   performance_wait_duration_{{ .Time.Group }} p_a_d
WHERE  TRUE {{ if and .Time.Interval.Start .Time.Interval.End }} AND p_a_d.period >= "{{ .Time.Interval.Start }}" AND p_a_d.period <= "{{ .Time.Interval.End }}" {{ end }} {{ if gt (len .Queues) 0 }} AND p_a_d.qname in ({{ ExtractStrings .Queues }}) {{ end }}
GROUP  BY p_a_d.period,
          p_a_d.qname;
