{{ if not (and .Time.Interval.Start .Time.Interval.End) }}
 SELECT "timeIntervalStart and timeIntervalEnd are required" AS "!message";
{{ else if not (or .Caller (gt (len .Phones) 0) )}}
 SELECT "caller name or company fields are required" AS "!message";
{{ else }}
SELECT
    period AS `period£{{ .Time.Group }}Date`,
    cid,
    name,
    company,
    qname,
    qdescr,
    `total` AS `results$total£num`,
    `good` AS `results$good£num#hide`,
    `failed` AS `results$failed£num#hide`,
    `timeout` AS `results$timeout£num#hide`,
    `exitempty` AS `results$exitempty£num#hide`,
    `exitkey` AS `results$exitkey£num#hide`,
    `full` AS `results$full£num#hide`,
    `joinempty` AS `results$joinempty£num#hide`,
    `null` AS `results$null£num#hide`,
    min_hold AS `hold$min_hold£seconds#hide`,
    avg_hold AS `hold$avg_hold£seconds`,
    max_hold AS `hold$max_hold£seconds#hide`,
    min_duration AS `duration$min_duration£seconds#hide`,
    avg_duration AS `duration$avg_duration£seconds`,
    max_duration AS `duration$max_duration£seconds#hide`,
    min_position AS `position$min_position£seconds#hide`,
    avg_position AS `position$avg_position£seconds`,
    max_position AS `position$max_position£seconds#hide`
FROM
    data_caller_{{ .Time.Group }}_name_company
WHERE   TRUE
    {{ if and .Time.Interval.Start .Time.Interval.End }}
        AND period >= "{{ .Time.Interval.Start }}"
        AND period <= "{{ .Time.Interval.End }}"
    {{ end }}
    {{ if gt (len .Queues) 0 }}
        AND qname in ({{ ExtractStrings .Queues }})
    {{ end }}
    {{ if .Caller }}
        AND cid LIKE "{{ .Caller }}%"
    {{ end }}
    {{ if gt (len .Phones) 0 }}
        AND cid in ({{ ExtractPhones .Phones true }})
    {{ end }}
{{ end }}