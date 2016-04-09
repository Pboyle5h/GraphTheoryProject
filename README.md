# Irish Constituencies Neo4j Database
###### Pauric Boyle, G00316554

## Introduction
This project was designed for my 3rd year module Graph Theory. The project consists of a neo4j graph database. The database is based on the recent election that took place in Ireland. 

## Database
I dsigned this database with a root node of Ireland and the coming out of that was Counties then Constituencies then Candidates then parties. 

I added the counties manually using the create method as there wasnt many counties to do. To do Constituencies I knew there would be more properties and nodes so I used a csv file in which I obtained from https://github.com/storyful/irish-elections. to load this into the database i used the following querry. 

LOAD CSV WITH HEADERS FROM
'file:///C:/Users/pauri/Desktop/Graph%20Theory/GraphTheoryProject/Constituencies.csv'
AS csvLine
CREATE (p:Constituencies {id: toInt(csvLine.id), constituencies:
csvLine.constituencies, name: csvLine.name, seats: toInt(csvLine.seats),
population: toInt(csvLine.population)})
return p;

This Querry reads the csv file from local disk and uses the headings for the properties labels.

## Queries
Summarise your three queries here.
Then explain them one by one in the following sections.

#### Query one title
This query retreives the Bacon number of an actor...
```cypher
MATCH
	(Bacon)
RETURN
	Bacon;
```

#### Query two title
This query retreives the Bacon number of an actor...
```cypher
MATCH
	(Bacon)
RETURN
	Bacon;
```

#### Query three title
This query retreives the Bacon number of an actor...
```cypher
MATCH
	(Bacon)
RETURN
	Bacon;
```

## References
1. [Neo4J website](http://neo4j.com/), the website of the Neo4j database.
2. https://en.wikipedia.org/wiki/Parliamentary_constituencies_in_the_Republic_of_Ireland
3. http://neo4j.com/docs/stable/query-where.html#query-where-string
