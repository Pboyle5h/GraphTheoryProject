# Irish Constituencies Neo4j Database
###### Pauric Boyle, G00316554

## Introduction
This project was designed for my 3rd year module, Graph Theory. The project consists of a neo4j graph database. The database is based on the recent election that took place in Ireland and is used to represent all candidates, parties and constituencies as nodes so they can be easily querried. 

## Database
I dsigned this database with a root node of Ireland and the coming out of that was Counties then Constituencies then Candidates then parties. 

I added the counties manually using the create method as there wasnt many counties to do. To do Constituencies I knew there would be more properties and nodes so I used a 3 CSV file to setup my datatbase 2 CSV files I obtained from https://github.com/storyful/irish-elections. 

### Constituencies
The first CSV file i used was the Constituencies file. In this file it had the Constitucy ID, Constituency Name and Population of that constituency.  To Load this into the database I used the following query.  

```Cypher
LOAD CSV WITH HEADERS FROM
'file:///C:/Users/pauri/Desktop/Graph%20Theory/GraphTheoryProject/Constituencies.csv'
AS csvLine
CREATE (p:Constituencies {id: toInt(csvLine.id), constituencies:
csvLine.constituencies, name: csvLine.name, seats: toInt(csvLine.seats),
population: toInt(csvLine.population)})
return p;
```
The method reads the CSV file line by line until the end. It uses the first line as headers and they are in turned used as the property names.

The first querry I used to match up the counties with their own constituency e.g Donegal, Clare. I done this using the following querry 
```Cypher
MATCH (b:Constituencies),(a:Counties)
WHERE a.name = b.constituencyName
CREATE (b)-[r:RanIn]->(a)
RETURN r
```
This matched all the nodes that had the same Constituency name as County name.


To match the  the remaining nodes I used the where method with regular expression. This is used to search for parts of string so I used the following query to do this.
```Cypher
MATCH (a:Constituencies),(b:Counties)
WHERE a.name =~'Dublin.*' AND b.name="Dublin"
CREATE (b)-[r:ConstituencyOf]->(a)
RETURN r
```
This query matches all counties with a name Dublin and all constituencies with Dublin in its name so it will return Dublin-north, Dublin-South ect.

I then repeated this until all the Counties and Constituencies were matched. 

### Candidates 

The next CSV file I used was the Candidates file. I loaded this in the same way as i did with the constituencies file. In this section I had to match the candidates up with the constituencies. This was a difficult section as some constituencies were two counties joined.

```Cypher
MATCH (a:Constituencies),(b:candidates)
WHERE a.name = b.constituencyName
CREATE (b)-[r:RanIn]->(a)
RETURN r
```
This Query matches all candidates to there constituencies as in the candidates CSV file there is a Constitucy column with all the Constituency names.  


#### Number of new females
This querry shows a table in that has all parties with the most females who arnt currently tds. so this means they either are newly running or they didnt get elected in the last vote. The query itself is designed to count all candidates that are females and arnt currently a TD and match them to their repective parties. it then returns a list of the results for each party and sorts them descending so that the party with the most is first and so on. 
```Cypher
MATCH(a:candidates {gender: "Female", current_td:"FALSE"})-[r:IsIn]->(b:Parties) 
RETURN COUNT(a) AS NewFemales, b.PartyName
Order by COUNT(a)desc
```
This querry is easily altered and can be used to find out the same result for as shown below. 
```Cypher
MATCH(a:candidates {gender: "Male", current_td:"FALSE"})-[r:IsIn]->(b:Parties) 
RETURN COUNT(a) AS NewMales, b.PartyName
Order by COUNT(a)desc
```

#### Rural Ireland
This query is designed so you can see which party represents rural Ireland the best. The query counts all the candidates that have ran in a constituency that has a population of <=90,000 it then returns the the number of candidates and the party names.

This could also be altered to show the top 3 for example by adding "limit 3" at the end of the query and that will return the top 3 parties. 
```Cypher
MATCH(a:candidates)-[t:RanIn]->(c:Constituencies)
where toInt(c.population)<= 90000
RETURN COUNT(a) AS Candidates_rural_Ireland, a.party as Party 
Order by COUNT(a)desc
```

#### Number of candidates per party
In this querry it shows how many candidates ran from each individual party and sorts them from highest to lowest
```Cypher
MATCH(a:candidates)-[t:RanIn]->(c:Constituencies)
RETURN COUNT(a) AS Candidates_ran, a.party as Party 
Order by COUNT(a)desc
```

## References
1. [Neo4J website](http://neo4j.com/), the website of the Neo4j database.
2. https://en.wikipedia.org/wiki/Parliamentary_constituencies_in_the_Republic_of_Ireland
3. http://neo4j.com/docs/stable/query-where.html#query-where-string
