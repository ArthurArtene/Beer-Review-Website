SELECT
    (SELECT 'Beers' FOR XML PATH(''),TYPE) AS 'caption',
    (SELECT 'Name' AS th, 'Style' AS th, 'ABV' AS th, 'Rating' AS th , 'Number of reviews' AS th, 'Sweetness' AS th FOR XML raw('tr'),ELEMENTS, TYPE) AS 'thead',
    (SELECT Name AS td, Style AS td,(SELECT CAST(ABV as decimal(10,1))) AS td, (SELECT CAST(review_overall as decimal(10,2))) as td,number_of_reviews as td, (SELECT CAST(Sweet as decimal(10,2))) as td FROM dbo.beer_profile_and_ratings WHERE number_of_reviews>400 ORDER BY Sweet DESC
    FOR XML RAW('tr'), ELEMENTS, TYPE
    ) AS 'tbody'
  FOR XML PATH(''), ROOT('table')