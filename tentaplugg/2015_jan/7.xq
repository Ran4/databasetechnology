<!-- d) (3 pts.) Write an XPath expression starting with /Countries/ that finds all cities (cityID values) that are nested inside the Country with countryID of “USA”.
The output should be an untagged sequence starting like:
“New York City” ...  -->

/Countries/Country[@countryID = "USA"]//@CityID
<!-- note: // -->
