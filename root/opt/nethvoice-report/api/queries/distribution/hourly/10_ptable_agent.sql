{{ if gt (len .Agents) 0 }}
SELECT
	period AS period£{{ .Time.Group }}Date,
	agentNum,
	agentName,
	time_{{ .Time.Division  }} AS `time£hourDate#pivot`,
	total AS `{{ ExtractSettings "StartHour" }}-{{ ExtractSettings "EndHour" }}£num^sum_total`
FROM	distribution_hour_agent_{{ .Time.Group }}_{{ .Time.Division  }}
WHERE   time_{{ .Time.Division  }} >= '{{ ExtractSettings "StartHour" }}' AND time_{{ .Time.Division  }} <= '{{ ExtractSettings "EndHour" }}'
        {{ if and .Time.Interval.Start .Time.Interval.End }}
            AND period >= "{{ .Time.Interval.Start }}"
            AND period <= "{{ .Time.Interval.End }}"
        {{ end }}
        {{ if gt (len .Agents) 0 }}
            AND agentName in ({{ ExtractStrings .Agents }})
        {{ end }}
GROUP BY period, time_{{ .Time.Division }},qdescr
ORDER BY period, agentNum, time_{{ .Time.Division }}
{{ else }}
SELECT "agents field is required" AS "!message";
{{ end }}
