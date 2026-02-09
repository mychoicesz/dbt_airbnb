with reviews_w_listing as 
(
select r.*, l.created_at from  {{ ref('fct_reviews') }} r
inner join  {{ ref('dim_listings_cleansed') }} l
on r.listing_id = l.listing_id
)
select *
from reviews_w_listing
where review_date < created_at
limit 10