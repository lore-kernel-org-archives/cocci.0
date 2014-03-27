From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 27 Mar 2014 19:10:13 +0100 (CET)
Subject: [Cocci] How to exclude volatile data accesses in expressions
 with SmPL?
In-Reply-To: <53342A9C.9070406@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <53342A9C.9070406@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1403271907390.2088@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 27 Mar 2014, SF Markus Elfring wrote:

> > Not sure what you mean by extended.  There are indeed some other functions
> > in Linux that perform NULL tests before doing anything, and thus they
> > don't really need a null test around them.
>
> I have got another concern for a corresponding implementation detail.
> How can a constraint be specified for the filter in the semantic patch
> so that the expression refers only to non-volatile data?
> Is it a software development challenge to exclude accesses on volatile
> data elements eventually from the suggested deletion of condition checks?
> https://en.wikipedia.org/wiki/Volatile_variable#In_C_and_C.2B.2B

Perhaps it is possible to write:

@@
volatile x;
@@

* x == NULL

Or maybe

@@
type T;
volatile T x;
@@

* x == NULL

Or at worst:

@@
type T;
identifier i;
@@

volatile T i;
...
*i == NULL

I don't know if this would find much.  Intuitively, one might expect such
problems to be detected easily by testing or developers to know better in
thw first place, but who knows.

julia
