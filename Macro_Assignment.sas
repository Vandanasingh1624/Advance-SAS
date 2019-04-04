/*1) Write a macro to import different type of files. Let’s say we have files that are tab
delimited text files as well as csv files. (“Sample.csv” and “Scores.txt”)
(Hint: Define a macro variable for different delimiters.)*/

%macro Import(x,y,del);

proc import datafile = "/home/kvandanamba0/AdvanceSas/Graded Assign/&x." out = &y. dbms = &del. replace;
run;
%mend Import;
%import(x=Sample.csv,y=sample,del=csv);
%import(x=scores.txt,y=score,del=tab);

/* NOTE: 40 records were read from the infile '/home/kvandanamba0/AdvanceSas/Graded Assign/Sample.csv'.
       The minimum record length was 26.
       The maximum record length was 36.
 NOTE: The data set WORK.SAMPLE has 40 observations and 5 variables.
 NOTE: DATA statement used (Total process time):
       real time           0.00 seconds
       user cpu time       0.00 seconds
       system cpu time     0.01 seconds
       memory              10610.21k
       OS Memory           36896.00k
       Timestamp           01/28/2019 05:48:57 AM
       Step Count                        18  Switch Count  1
       Page Faults                       0
       Page Reclaims                     245
       Page Swaps                        0
       Voluntary Context Switches        7
       Involuntary Context Switches      0
       Block Input Operations            0
       Block Output Operations           264


NOTE: 10 records were read from the infile '/home/kvandanamba0/AdvanceSas/Graded Assign/scores.txt'.
       The minimum record length was 28.
       The maximum record length was 30.
 NOTE: The data set WORK.SCORE has 10 observations and 6 variables.
 NOTE: DATA statement used (Total process time):
       real time           0.00 seconds
       user cpu time       0.01 seconds
       system cpu time     0.00 seconds
       memory              9562.43k
       OS Memory           37152.00k
       Timestamp           01/28/2019 05:48:57 AM
       Step Count                        19  Switch Count  1
       Page Faults                       0
       Page Reclaims                     163
       Page Swaps                        0
       Voluntary Context Switches        8
       Involuntary Context Switches      0
       Block Input Operations            0
       Block Output Operations           264  */
      
/* 2) Convert the below SAS codes into macros.
a) proc gchart data=HTWT; vbar gender/sumvar=weight; Title "Average weight by
Gender";
run;
b) proc plot data=HTWT; Title "Scatter plot"; plot &height*&weight;
run;
(Hint: Define two different macros.) */

FILENAME REFFILE '/home/kvandanamba0/AdvanceSas/Graded Assign/HTWT.csv';
PROC IMPORT DATAFILE=REFFILE
 DBMS=CSV
 OUT=WORK.HTWT;
 GETNAMES=YES;
RUN;
 
/* 2). A */
%macro chart(dset,var1,var2);
proc gchart data=&dset.; 
vbar &var1./sumvar=&var2.; 
Title "Average &var2. by &var1.";
run;
%mend chart;
%chart(dset=HTWT, var1=Gender,var2=Weight);

/* LOG 
 1          OPTIONS NONOTES NOSTIMER NOSOURCE NOSYNTAXCHECK;
 70         
 71         %macro chart(dset,var1,var2);
 72         proc gchart data=&dset.;
 73         vbar &var1./sumvar=&var2.;
 74         Title "Average &var2. by &var1.";
 75         run;
 76         %mend chart;
 77         %chart(dset=HTWT, var1=Gender,var2=Weight);
 78         
 79         OPTIONS NONOTES NOSTIMER NOSOURCE NOSYNTAXCHECK;
 91         
 User: kvandanamba0
*/

 
/*2).B */

%macro scatter(dset,var1,var2);
proc plot data=&dset.; 
Title "Scatter plot"; 
plot &var1.*&var2.;
run;
%mend scatter;
%scatter(dset=HTWT, var1=height,var2=weight);

/* 1          OPTIONS NONOTES NOSTIMER NOSOURCE NOSYNTAXCHECK;
 70         
 71         %macro scatter(dset,var1,var2);
 72         proc plot data=&dset.;
 73         Title "Scatter plot";
 74         plot &var1.*&var2.;
 75         run;
 76         %mend scatter;
 77         %scatter(dset=HTWT, var1=height,var2=weight);
 
 78         
 79         
 80         
 81         OPTIONS NONOTES NOSTIMER NOSOURCE NOSYNTAXCHECK;
 93         
 */

/*3)
a) Import HTWT data set to extract 10 observations starting from fifth observation using
SAS macros.
b) Write a macro to compare two numeric values.
(Hint: a) Use proc print. b) Use %if %then %do statement.)*/
 

FILENAME REFFILE '/home/kvandanamba0/AdvanceSas/Graded Assign/HTWT.csv';
PROC IMPORT DATAFILE=REFFILE
 DBMS=CSV
 OUT=WORK.HTWT;
 GETNAMES=YES;
RUN;
 
/*3)- A*/
%macro print1_data(name,FOBS,NOBS) ;
proc print data=&name(FIRSTOBS=&FOBS. OBS=&NOBS.);
run;
%mend;
%print1_data(name=HTWT,FOBS=5,NOBS=14);

/* OUTPUT

Obs	ID	Gender	Age	Height	Weight	Year
5	534787	M	12	59		99.5	2003
6	513842	F	12	59.8	84.5	2003
7	968743	M	14	60.5	85	2001
8	456901	F	11	61.2	99	2004
9	515151	F	15	62.5	112.5	2000
10	765412	F	16	63		115	1999
11	564211	F	23	65.1	125	1992
12	785412	M	12	67.8	121	2003
13	547810	M	19	68.5	155	1996
14	765921	M	22	68.6	170	1993
 
User: kvandanamba0 */

/* 3)-B */

%macro comparenum(firstnum,secondnum);
%if %sysevalf(&firstnum>&secondnum) %then %put &firstnum is greater than &secondnum;
%else %if %sysevalf(&firstnum=&secondnum) %then %put &firstnum equals &secondnum;
%else %put &firstnum is less than &secondnum;
%mend comparenum;

/* LOG

 1          OPTIONS NONOTES NOSTIMER NOSOURCE NOSYNTAXCHECK;
 70         
 71         
 72         %macro comparenum(firstnum,secondnum);
 73         %if %sysevalf(&firstnum>&secondnum) %then %put &firstnum is greater than &secondnum;
 74         %else %if %sysevalf(&firstnum=&secondnum) %then %put &firstnum equals &secondnum;
 75         %else %put &firstnum is less than &secondnum;
 76         %mend comparenum;
 77         
 78         
 79         OPTIONS NONOTES NOSTIMER NOSOURCE NOSYNTAXCHECK;
 91         
 */

/*4) Let’s say you have "Revenue" information for different years from 2005 to 2009 with
variable revenue. Write SAS macro which will apply means and univariate procedure on
each year for revenue variable.
(Hint: Define a macro variable to specify the procedure “name”.)
Code:
*/

%macro stats(dsetname,name,vars_grp,vars);
proc &name data=&dsetname;
class &vars_grp;
var &vars;
run;
%mend;

%STATS(revenue_data,means,year,revenue);
%STATS(revenue_data,univariate,year,revenue);

/* LOG
 1          OPTIONS NONOTES NOSTIMER NOSOURCE NOSYNTAXCHECK;
 70         
 71         
 72         %macro stats(dsetname,name,vars_grp,vars);
 73         proc &name data=&dsetname;
 74         class &vars_grp;
 75         var &vars;
 76         run;
 77         %mend;
 78         
 79         OPTIONS NONOTES NOSTIMER NOSOURCE NOSYNTAXCHECK;
 91         
 */


/*5) The data set "Macro definition.txt" has two SAS macros definition, import them and
apply on HTWT data set.
(Hint: Use %INCLUDE.)*/


filename InpPrg  "/home/kvandanamba0/AdvanceSas/Graded Assign/Macro definition.txt";
%include InpPrg ;

%contents_of(name=HTWT);
%print_data(name=HTWT);


/* LOG
NOTE: PROCEDURE CONTENTS used (Total process time):
       real time           0.05 seconds
       user cpu time       0.05 seconds
       system cpu time     0.01 seconds
       memory              2553.00k
       OS Memory           31920.00k
       Timestamp           01/28/2019 10:13:51 AM
       Step Count                        29  Switch Count  0
       Page Faults                       0
       Page Reclaims                     858
       Page Swaps                        0
       Voluntary Context Switches        0
       Involuntary Context Switches      0
       Block Input Operations            0
       Block Output Operations           16
       
 
 73         %print_data(name=HTWT);
 
 NOTE: There were 20 observations read from the data set WORK.HTWT.
 NOTE: PROCEDURE PRINT used (Total process time):
       real time           0.03 seconds
       user cpu time       0.04 seconds
       system cpu time     0.00 seconds
       memory              734.62k
       OS Memory           31916.00k
       Timestamp           01/28/2019 10:13:52 AM
       Step Count                        30  Switch Count  0
       Page Faults                       0
       Page Reclaims                     189
       Page Swaps                        0
       Voluntary Context Switches        0
       Involuntary Context Switches      0
       Block Input Operations            0
       Block Output Operations           16
       
 
 74         
 75         OPTIONS NONOTES NOSTIMER NOSOURCE NOSYNTAXCHECK;
 87         
 */


/*
6) Save the macros permanently defined so far and list all the macros.
(Hint: Use options mstored sasmstore then run proc catalog.) 
Code:
 options source source2 MSTORED;
 */
%macro contents_of(name) / store source;
proc contents data=&name;
run;
%mend;
%macro print_data(name) / store source ;
proc print data=&name;
run;
%mend;

libname mylib1  'D:\Vandana\Jigsaw\SQL\Macro';
options mstored sasmstore=mylib1;

%print_data(name=HTWT)


/* LOG 
80 libname mylib1 'D:\Vandana\Jigsaw\SQL\Macro';
81 options mstored sasmstore=mylib1;
OPTIONS NONOTES NOSTIMER NOSOURCE NOSYNTAXCHECK;
89 ODS HTML CLOSE;
90 &GRAPHTERM; ;*';*";*/;RUN;QUIT;
91 QUIT;RUN;
92 ODS HTML5 (ID=WEB) CLOSE;
93
94 ODS PDF (ID=WEB) CLOSE;
95 FILENAME _GSFNAME;
96 DATA _NULL_;
97 RUN;
98 OPTIONS VALIDMEMNAME=COMPAT;
99 OPTIONS NOTES STIMER SOURCE SYNTAXCHECK;
100
 User: kvandanamba0

*/



