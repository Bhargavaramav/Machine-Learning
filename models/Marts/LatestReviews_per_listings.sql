
{{ config(materialized='table')}}


{{ config(pre_hook="SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '{{ this.name }}' LIMIT 1;") }}

{% if result is not none %}
  TRUNCATE TABLE {{ this }};
{% endif %}



with cte as (select * from airbnb.raw.raw_listings a
join airbnb.raw.raw_reviews b
on a.id=b.listing_id
)
select 1
-- select listing_id, max(date) as latest_review_date,
-- reviewer_name,comments
-- from cte
--group by listing_id,reviewer_name,comments