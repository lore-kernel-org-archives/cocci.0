From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 04 May 2017 09:57:33 -0500
Subject: [Cocci] trying to catch false positives with cocci script
Message-ID: <20170504095733.Horde.JpTNXNRhG9VnLmTmKlcw4vb@gator4166.hostgator.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Hello everybody,

I'm trying to write a cocci script to catch false positives during  
static analysis to the Linux kernel code.
What I want to catch is the following type of code:

...
if (!ptr) {
...
goto label;
}
...
var = ptr->x;
...
label:
... (here it is not supposed to find any other _ptr_ pointer dereference)

in the piece of code above a static code analyzer like Coverity issues  
a pointer dereference after null check.

I've been trying the following:

@@
expression E;
identifier i, id, label;
position p1, p2;
@@
+E = NULL;
if (!E) {
...
goto at p1 label;
+E = NULL;
}@p2
...
id = E->i
...
label:
+E = NULL;

but I don't get any output. Here all the _+_ are just for reference. I  
don't plan to include them in any patch. I just want to spot all  
similar code.

Any help would be greatly appreciated.

Thank you!
--
Gustavo A. R. Silva
