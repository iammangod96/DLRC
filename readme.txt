Dual Linear Regression Classification for Face Cluster Recognition
MANISH SHARMA 2014A3PS181P
18/03/2017
---------------------------------------------------------------------------

Dataset used (as mentioned in paper) - 
	http://www.openu.ac.il/home/hassner/data/lfwa/
Partitioned dataset(Training and Testing samples) after preprocessing - 
	/partitioned/newtest
	/partitioned/newtrain

---------------------------------------------------------------------------

OS -
	Windows 8.1
Coding environment -
	MATLAB R2014a

---------------------------------------------------------------------------

Code for preprocessing dataset ( Selection of foders with more than 20 pictures and cropping ) - 
	filer.m
Code for partitioning ( Partitioning the dataset into training and testing sets ) -
	partition.m
	partition_test.m
Code for Linear regression classifier for Face Recognition -
	LRC.m
Code for Dual Linear regression classifier for Face Cluster Recognition -
	DLRC.m
PDF project report -
	2014A3PS181P - ML Project Report.pdf
LATEX project report -
	2014A3PS181P - ML Project Report.tex
LRC paper -
	LRC.pdf
DLRC paper -
	DLRC.pdf
PLRC paper -
	PLRC.pdf

---------------------------------------------------------------------------

Classifier Prediction accuracy -

DLRC -
Correct 	= 	58
Total		= 	62
Accuracy	=	93.55%

LRC -
Correct 	= 	285
Total		= 	620
Accuracy	=	45.96%