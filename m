From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 31 May 2015 11:42:44 +0200 (CEST)
Subject: [Cocci] [PATCH 1/1] scripts/coccinelle/misc: add swap.cocci
In-Reply-To: <1432060501-9463-1-git-send-email-fabf@skynet.be>
References: <1432060501-9463-1-git-send-email-fabf@skynet.be>
Message-ID: <alpine.DEB.2.02.1505311131150.2084@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I propose the extended version below (not currently coccicheck friendly).  
the extra features are:

1.  The original version requires i1 and i2 to be identifiers, eg x and y.  
This doesn't address the case where they are terms line x->a or x[b].  The 
fact that the original code contains assignments with both i1 and i2 on 
the left hand side is enough to ensure that they are appropriate arguments 
for swap.  So they can be changed to expression metavariables.

2. The original patch rule always removed the tmp variable.  This is not 
valid if the tmp variable is used for something else.  The new semantic 
patch separates the introduction of swap (rule r) from the removal of the 
variable declaration (rule ok and the one folowing).  The rule ok checks 
that this is a function containing an introduced call to swap, and then 
the rule after removes the declaration if the variable is not used for 
anything else.  Note that the name of the tmp variable is remembered in 
the invalid three-argument version of sawp.  This is then cleaned up in 
the rule below.

3. The original patch always removed the initialization of the tmp 
variable.  Actually, some code uses the tmp variable afterwards to refer 
to the old value.  In the new semantic patch, the first set of rules 
considers the cases where the tmp variable is not used, and the last rule 
is for the case where the tmp variable is stll needed.  No cleaning up of 
the declaration is needed in that case.

There is one regression as compared to the original semantic patch: In the
file lib/mpi/mpi-pow.c, the temporary variable is not needed after the 
change, but it is also not removed.  It is declared within a loop, and 
Coccinelle does not realize that it is not needed afterwards, because it 
is needed on subsequent loop iterations.  Trying to adjust the semantic 
patch to address this issue made it much slower and didn't fix the 
problem.  Perhaps it is easier to rely on gcc to give an unused variable 
warning, and to clean it up then.

Fabian, if you are o with this, do you want to sgenify it ans submit a new 
patch?

thanks,
julia

// it may be possible to remove the tmp variable

@r@
expression i1, i2, E;
identifier tmp;
@@

- tmp = i1;
- i1 = i2;
- i2 = tmp;
+ swap(i1, i2, tmp);
  ... when != tmp
? tmp = E

@ok exists@
type t1;
identifier r.tmp;
expression i1,i2;
position p;
@@

t1 at p tmp;
...
swap(i1, i2, tmp);

@@
expression i1,i2;
identifier tmp;
type t1;
position ok.p;
@@

-t1 at p tmp;
 <... when strict
      when != tmp
 swap(i1, i2, tmp);
 ...>

@depends on r@
expression i1,i2;
identifier tmp;
@@

swap(i1,i2
- ,tmp
 )

// tmp variable still needed

@@
expression i1, i2;
identifier tmp;
@@

  tmp = i1;
- i1 = i2;
- i2 = tmp;
+ swap(i1, i2);
