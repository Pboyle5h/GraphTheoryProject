//In this querry it shows how many candidates ran from each individual party and sorts them from highest to lowest

MATCH(a:candidates)-[t:RanIn]->(c:Constituencies)
RETURN COUNT(a) AS Candidates_ran, a.party as Party 
Order by COUNT(a)desc