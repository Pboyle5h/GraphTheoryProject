// This query is designed so you can see which party represents rural Ireland the best. 
//the query counts all the candidates that have ran in a constituency that has a population of <=90000
//it then returns the the number of candidates and the party names.


MATCH(a:candidates)-[t:RanIn]->(c:Constituencies)
where toInt(c.population)<= 90000
RETURN COUNT(a) AS Candidates_rural_Ireland, a.party as Party 
Order by COUNT(a)desc