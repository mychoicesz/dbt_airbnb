{% test minimum_row_count(model, minimum_row_count) %}
{{ config(severity = 'warn')}}
SELECT
    COUNT(*) as cnt,
FROM
    {{ model }}
HAVING
    COUNT(*) < {{ minimum_row_count }}
{% endtest %}
