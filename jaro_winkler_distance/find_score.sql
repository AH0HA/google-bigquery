 CREATE TEMP FUNCTION
  jwd(a STRING,
    b STRING)
  RETURNS INT64
  LANGUAGE js AS """
    // Assumes 'doInterestingStuff' is defined in one of the library files.
    //return doInterestingStuff(a, b);
    return jaro_winkler_distance(a,b);
""" OPTIONS ( library="gs://kayama808/javascript/jaro_winkler_google_UDF.js" );
SELECT
  x.name name1,
  y.name name2,
  jwd(x.name,
    y.name) scr
FROM
   babynames.names_2014 x
JOIN
   babynames.names_2014 y ON ( 1=1)
WHERE
  x.gender = 'F'
  AND y.gender='F'
ORDER BY
  scr DESC;
 
 //https://bigquery.cloud.google.com:443/savedquery/470771908106:101aff26b41948d0b90b50f6f2651698