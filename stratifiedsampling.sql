CREATE FUNCTION getStratSum(N INT, Ni_array AS INT[]) RETURNS INT
BEGIN
	RETURN (
      	SELECT SUM(Ni_array[])
		(SELECT country, COUNT(country) AS n_i, AVG(age) AS u_i, VARIANCE(age) AS SampVar_i, 
		ROW_NUMBER() OVER(ORDER BY country DESC) AS i, Ni_array as Ni, N 
		FROM Customers
		GROUP BY country) as Data_Summary
  );
  END
