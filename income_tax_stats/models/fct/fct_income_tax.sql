{{
    config(
        materialized = 'incremental',
        on_schema_change='ignore'
    )
}}
WITH src_tax_data AS (
    SELECT * FROM {{ ref('src_tax_data')}}
),
dim_agi_class AS (
    SELECT * FROM {{ ref('dim_agi_class')}}
)
SELECT
STATEFIPS, STATE, ZIPCODE, 
RETIREMENT_SAVING_CONTRIBUTE,
NUM_OF_RETURNS_WITH_RETIRE_SAVING_CONTR,
TAXABLE_INCOME,
NUM_OF_RETURNS_WITH_TAXABLE_INCOME,
SALARIES_WAGES,
TOTAL_INCOME,
NUM_OF_RETURNS_WITH_TOT_INCOME,
AGI,
rt.AGI_CLASS, 
d.AGI_STUB,
REGEXP_SUBSTR(FILE_NAME, '\\d{4}') AS INC_YEAR
FROM 
src_tax_data rt
inner join 
dim_agi_class d
on rt.AGI_CLASS = d.AGI_CLASS
{% if is_incremental() %}
AND REGEXP_SUBSTR(FILE_NAME, '\\d{4}') > (select max(INC_YEAR) from {{ this }})
{%endif %}