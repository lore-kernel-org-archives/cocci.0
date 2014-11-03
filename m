From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 3 Nov 2014 18:32:59 +0100 (CET)
Subject: [Cocci] s390/net: Deletion of unnecessary checks before two
 function calls
In-Reply-To: <5457B5C7.7020406@knosof.co.uk>
References: <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <5453C98C.90105@users.sourceforge.net>
 <20141103095059.GL6879@mwanda> <5457A560.2020304@users.sourceforge.net>
 <20141103162528.GT6890@mwanda> <5457B5C7.7020406@knosof.co.uk>
Message-ID: <alpine.DEB.2.10.1411031818200.2386@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 3 Nov 2014, Derek M Jones wrote:

> Dan
>
> > The truth is I think that all these patches are bad and they make the
> > code harder to read.
>
> I disagree, I think the code requires less effort to read without the
> if test.
>
> A developer reading the code will wonder why kfree does not handle the
> case when its argument is NULL.  This takes effort.
>
> Now there might be a reason while kfree (or any other function) does
> not handle NULL, in which case the test is necessary for that reason.
> Or perhaps calling kfree has other consequences and this means it is
> good to minimise the number of calls, fair enough.

This may be true in general, but the standard assumption about kernel
functions is that they are not defensive.  Everything used in the kernel
is defined in the kernel, and is normally written in a way to be optimal
for in-kernel usage.

> > The if statements are there for *human* readers to understand and you are
> > making it harder for humans to understand the code.
>
> The reverse is true.
>
> But if there are other reasons, then leave the test in.

The point about a null test is that it makes it apparent at the current
point that the value can be null.  The default assumption is that it
cannot, ie that functions are only called when doing so is useful.

Actually, this assumption can be exploited by automatic tools for finding
out what needs to be done when:

Suman Saha, Jean-Pierre Lozi, Ga?l Thomas, Julia L. Lawall, Gilles Muller:
Hector: Detecting Resource-Release Omission Faults in error-handling code
for systems software. DSN 2013: 1-12

The point is that Linux code contains a huge number of alloc and free
functions, many of which are not very well known.  If free functions are
only called when they are useful, then you can infer which free functions
go with which alloc functions.  If all free functions are just lumped
together and called at random, then you lose a lot of information.

Similarly, as a human, when I look at code I don't know, it is very
confusing to have functions called when as far as I can tell they don't
need to be.  A bunch of validity tests at the beginning of the
called function doesn't really help, because as Dan points out the code is
not always easy to find, and in the function definition itself one doesn't
know in what contexts that code is intended to be used.

In separate cleanup functions (destroy_xxx) perhaps the tests are more or
less noise.  But in the error handling code of an initialization function,
no test means to me that the call is needed at the current point, and a
test means to me that for some reason it is not statically known whether a
call is needed or not.  This is information that is really useful for
understanding the code, for both humans and for tools.

julia
