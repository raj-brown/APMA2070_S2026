%%% Basic Step for a updating an array using adamupdate
p = rand(3,3,4);
avg_g = ones(3,3,4);
avg_sqg = ones(3,3,4); 
g = ones(3,3,4);
iteration = 15;
[p,avg_g,avg_sqg] = adamupdate(p,g,avg_g,avg_sqg,iteration,0.01,0.9,0.95);
 