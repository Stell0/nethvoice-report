SELECT
    DISTINCT CONCAT(
        (
            SELECT
                prefisso
            FROM
                zone
            WHERE
                comune = q.comune
        ),
        ",",
        q.comune,
        ",",
        q.provincia,
        ",",
        q.regione
    )
FROM
    report_queue_callers q
WHERE
    CONCAT(q.comune, ",", q.provincia, ",", q.regione) NOT LIKE ""
ORDER BY
    CONCAT(q.comune, ",", q.provincia, ",", q.regione);