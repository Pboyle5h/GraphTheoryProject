// This querry shows a table in which it shows which parties has the most females who arnt currently tds. so this means they either are newly running or they 
//didnt get elected in the last vote

MATCH(a:candidates {gender: "Female", current_td:"FALSE"})-[r:IsIn]->(b:Parties) 
RETURN COUNT(a) AS NewFemales, b.PartyName
Order by COUNT(a)desc

//To check the same result for Males you just change "females" to "Males"
MATCH(a:candidates {gender: "Male", current_td:"FALSE"})-[r:IsIn]->(b:Parties) 
RETURN COUNT(a) AS NewMales, b.PartyName
Order by COUNT(a)desc