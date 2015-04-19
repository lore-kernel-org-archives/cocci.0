From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 19 Apr 2015 17:37:21 +0200 (CEST)
Subject: [Cocci] version 1.0.0
Message-ID: <alpine.DEB.2.02.1504191727560.2028@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle version 1.0.0 is released.

The main changes are:

* Metavariables for binary and assignment operators.  Examples can be 
found by grepping for "operator" in coccinelle/tests.  For example, the 
metavariable declaration

binary operator bop = { &&, ||, ==, !=, <, <=, >, >= };

will cause bop to match any of the operators in the set { &&, ||, ==, !=, 
<, <=, >, >= }.

* A rewrite of the code for inserting newlines among function call 
arguments, when these pass column 80.

* Support for disjunctions in structure names.

* Performance optimizations for cases where one rule inherits position 
variables, to only consider code that contains the mentioned positions.

* Support for const in some strange places in C code.

* Improved management of remaining comments when nearby code is removed.

Comments and bug reports are welcome.

julia
