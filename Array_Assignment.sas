proc import datafile = "/home/kvandanamba0/AdvanceSas/Graded Assign/Online Orders.csv"
out = order dbms = csv replace;
run;


/* Q1 : -Replace 0s with missing values for numeric variable in credit_card.csv file by using(*)*/

data num_miss;
set order;

array n_miss(*) viewed CartAdditions Revenue order ;
do i=1 to 4;
if n_miss(i) = 0 then n_miss(i) = .;
end;
run;


/*Q 2a : - Change the value of NA ,? to missing charecter values by using IF THEN statement*/

data char_miss;
set order;
array c_miss _character_;
do over c_miss;
if c_miss = 'NA' then c_miss='?';
end;
run;
/*Q 2b : -Detect and correct the errors in below codes*/
Data char_m;
set order;
array char_var{*} _character_;
do i= 1 to dim(Char_var);
char_var{i}=lowcase(char_var{i});
end;
run;

/*3 : - Use IF THEN statement to increamnet the value in scores.txt dataset which are lesser than 65
(Hint : Add the value to the points to increment the points to just above 65) */

proc import datafile = "/home/kvandanamba0/AdvanceSas/Graded Assign/scores.txt"
out = Scores dbms =dlm replace;
run;
proc contents data =scores;
run;


data values;
input test1 test2 test3 test4 test5;
datalines;
90.5 88.4 92.3 95.1 90.0
64.3 64.6 77.4 72.3 71.1
;run;

data add;
set values;
array add65(*) _numeric_;
do i = 1 to dim(add65);
if add65(i) < 65 then add65(i)= add65(i)+(66-add65(i));
end;
run;

data add_val;
set scores;
test1= input(Test_1, best5.);
run;
array change_val(5) Test_1 Test_2 Test_3 Test_4 Test_5 ;
do i = 1 to dim(change_val);
if change_val(1) le 65 then change_val(i)=0;
*if change_val(i) < 65 then  change_val(i)=change_val(i)+(66-change_val(i)));
*else 
*change_val(i)=change_val(i);
end;
run;

/*
if change_val(i) < 65 then  do;
change_val(i)=(change_val(i)+(66-change_val(i)));
leave;
end;
end;
run;*/
/*array above65(5) test_1, test_2, test_3, test_4, test_5;
*array final65(5) test1 test2 test3 test4 test5;
do i = 1 to 5;
if above65(i) le 65 then
*do j= 1 to 5 ;
final65(i)=(above65(i)+ (66-above65(i)));
end;
*above65(i)=above65(i);
*end;
run; 


/*4 :-The dataset "Sales.csv" has details of numbers of units sold accross regions of 
four products.The target sales accross regions(North,East,West), of four products is given as
(9450,9100,8550,9700) with the help of SAS Arrays find what was the percentage
of target achieved for each product in region (HINT : Use temporary arrays)*/

proc import datafile = "/home/kvandanamba0/AdvanceSas/Graded Assign/Sales.csv"
out = Sales dbms = csv replace;
run;

data Region_Sales;
set sales;
array R_Sales(4) _temporary_ (9450,9100,8550,9700);
array product(4) product_1-product_4;
do i = 1 to 4;
product(i)= (product(i)/R_sales(i))*100;
end;
run;

/* 5 :- To create four observations for each original observation one for each variable */

data wide;
input ID S1 S2 S3 S4;
datalines ;
1 12 15 20 23
2 17 21 33 13
3 19 23 39 30
;
run;

Data Long;
set wide;
array id1(1:4) s1-s4;
array id2(1:4) s1-s4;
array id3(1:4) s1-s4;
do id = 1 to 4;

data1 =id1(id);
data2=id2(id);
data3=id3(id);
output;
end;
run;


/*6 :- Count the missing values across the rows*/

proc import datafile = "/home/kvandanamba0/AdvanceSas/Graded Assign/Subset.csv"
out = Subset dbms = csv replace;
run; 
data count ;
set subset;
array c_miss(2,3) $ day1-day3 $ city1-city3;
array count1(2) ;
do i=1 to 2;
do j = 1 to 3;
if c_miss(i,j) = "NA" then do;
count1(i)= sum(count1(i),ifn(c_miss(i,j),"NA",0,1));
end;
end;
run;



