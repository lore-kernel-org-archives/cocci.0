From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Wed, 16 Aug 2017 15:09:43 -0500
Subject: [Cocci] Reading multiple input files
Message-ID: <92854f94-595d-180f-5288-c18017c4cc01@embeddedor.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello everybody,

Is there any way to make a cocci script read from a list of files and 
run on each of them?

The scenario is as follows: I have a list of files that I know may 
contain either actual bugs or false positives. I want to run cocci 
scripts on each of them and I wonder if I can do this using Coccinelle only.

Maybe giving the cocci script a file containing the list as input and, 
then reading the list with a python script from inside the cocci script?

Is this possible?

Thank you
-- 
Gustavo A. R. Silva
