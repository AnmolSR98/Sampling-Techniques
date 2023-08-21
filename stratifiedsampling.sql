/** STILL NEED TO ACTUALLY CONTAINERIZE AND GENERALIZE THIS BUT THIS IS A GOOD START **/
/** The stratified mean is just the means summed with weights corresponding to population **/
SELECT SUM(N_i * u_i)/SUM(N_i) AS u_strat, 
/** The stratified variance is slightly more complex **/
SUM( POWER(N_i, 2) * (s2_i/small_n_i) * (1 - (small_n_i / N_i) ) ) / (SUM(N_i)*SUM(N_i)) AS var_strat 
FROM
(SELECT status, 
    SUM(num_messages)/COUNT(num_messages) AS u_i, 
    VARIANCE(num_messages) AS s2_i, 
    COUNT(num_messages) AS small_n_i,
    /** Adding the N_i's directly into this query rather than the outside to save time **/
    CAST(SPLIT_PART('4000, 500, 500', ',', 
                                CAST(ROW_NUMBER() OVER(ORDER BY status DESC) AS INT)) AS INT) AS N_i
FROM tickets
GROUP BY status) AS Data_Summary;
