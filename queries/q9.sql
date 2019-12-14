/* Q9 */
/* 
	Find top k most followed users in a given party. Show the  
	user’s screen name, the user’s party, and the number of 
	followers in descending order of the number of followers.
	
	Input: Value of category (e.g., 'GOP', 'Democrat')
	
	Rationale: This query finds the most influential users 
			   measured by the number of followers
	
	• The value of k is between 1 and 100.
*/
SET @subcategory = 'GOP'; /* User input here */

SELECT u.screen_name, 
       u.sub_category, 
       u.numfollowers 
FROM   user u 
WHERE  u.sub_category = @subcategory 
ORDER  BY u.numfollowers DESC 
LIMIT  5; /* User input here */