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
   babynames.names_2014 y ON ( x.name<>y.name)
WHERE
  x.gender = 'F' and x.count >= 100
  AND y.gender='F' and y.count >= 100
ORDER BY
  scr DESC;
 
