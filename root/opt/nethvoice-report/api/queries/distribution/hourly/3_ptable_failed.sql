{{ if gt (len .Queues) 0 }}
SELECT
        period AS period£{{ .Time.Group }}Date,
        qname,
        qdescr,
        time_{{ .Time.Division  }} AS `time£hourDate#pivot`,
        total AS `{{ ExtractSettings "StartHour" }}-{{ ExtractSettings "EndHour" }}£num^sum_total`
FROM    distribution_hour_failed_{{ .Time.Group }}_{{ .Time.Division  }}
WHERE   time_{{ .Time.Division  }} >= '{{ ExtractSettings "StartHour" }}' AND time_{{ .Time.Division  }} <= '{{ ExtractSettings "EndHour" }}'
        {{ if and .Time.Interval.Start .Time.Interval.End }}
            AND period >= "{{ .Time.Interval.Start }}"
            AND period <= "{{ .Time.Interval.End }}"
        {{ end }}
        {{ if gt (len .Queues) 0 }}
            AND qname in ({{ ExtractStrings .Queues }})
        {{ end }}
GROUP BY period, time_{{ .Time.Division }},qdescr
ORDER BY period, qdescr,time_{{ .Time.Division }}
{{ else }}
SELECT "queues field is required" AS "!message";
{{ end }}