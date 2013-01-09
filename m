From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Jan 2013 18:09:46 +0100 (CET)
Subject: [Cocci] Matching outside of blocks
In-Reply-To: <20130109123454.GA29477@avionic-0098.adnet.avionic-design.de>
References: <20130109123454.GA29477@avionic-0098.adnet.avionic-design.de>
Message-ID: <alpine.DEB.2.02.1301091800030.2053@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 9 Jan 2013, Thierry Reding wrote:

> Hi,
> 
> I'm trying to come up with a semantic patch to modify the meaning of the
> devm_request_and_ioremap() functions return value. The goal is to return
> an ERR_PTR() encoded errno in order to allow the proper error code to be
> propagated to the caller.
> 
> Since devm_request_and_ioremap() is called quite often, I thought this
> would be an interesting task to solve with coccinelle.

Seems like a good idea.

> I've come up with
> this semantic patch:
> 
> 	virtual patch
> 	virtual report

This is done in the Linux semantic patches, to allow people to use them in 
different ways.  If you just want to run the semantic patch in one way, 
you don't have to bother with this.

> 	@depends on patch@
> 	expression e;
> 	@@
> 
> 	 e = devm_request_and_ioremap(...);
> 	 ...
> 	(
> 	-if (\(e == NULL\|!e\)) {
> 	+if (IS_ERR(e)) {
> 	 	...
> 	-	return ...;
> 	+	return PTR_ERR(e);

Here you are assuming that the function returns an integer.  Maybe that is 
always the case, given the overall constraints on the devm functions.

(Actually, I was just thinking yesterday that it was too bad that 
devm_request_and_ioremap returns such an undescriptive value.  Because it 
combines two operations, and the return value doesn't indicate which one 
failed.)

> 	 }
> 	|
> 	-if (\(e == NULL\|!e\))
> 	-	return ...;
> 	+if (IS_ERR(e))
> 	+	return PTR_ERR(e);

I don't think you should need this.  Isomorphisms (ie, rules that cause x 
== NULL to also match !x) should make { ... X } match just X also.

> 	)
> 
> 	@r depends on report@
> 	expression e;
> 	position p1;
> 	@@
> 
> 	*e = devm_request_and_ioremap at p1(...);
> 	 ...
> 	(
> 	 if (\(e == NULL\|!e\)) {
> 	 	...
> 	 	return ...;
> 	 }
> 	|
> 	 if (\(e == NULL\|!e\))
> 	 	return ...;
> 	)
> 
> 	@script:python depends on r@
> 	p1 << r.p1;
> 	@@
> 
> 	msg = "ERROR: old devm_request_and_ioremap() API used on line %s" % (p1[0].line)
> 	coccilib.report.print_report(p1[0], msg)
> 
> This seems to work fine for most cases, but I've come across a tricky
> one in drivers/gpio/gpio-mxs.c. The code looks roughly like this:
> 
> 	if (np) {
> 		...
> 		base = of_iomap(parent, 0);
> 		...
> 	} else {
> 		iores = platform_get_resource(...);
> 		base = devm_request_and_ioremap(...);
> 	}
> 	if (!base)
> 		return -EADDRNOTAVAIL;
> 
> The odd thing is that in report mode this case is actually detected, but
> the patch mode doesn't generate a hunk for this occurrence.
> 
> I wonder what I need to change to make this case work. 

Actually, this seems like a feature, not a bug.  Coccinelle has no way of 
knowing that the other value of base can also be an argument to PTR_ERR.  
I think you will have to fix this case by hand.  Or make a completely 
specific rule for it, which is probably not worthwhile.

The reason why you get different answers is that when you use * it 
searches for whether there exists a path with the given property.  And 
when you don't use *, it checks that all paths have the property.  
Actually, in your case I would have expected Coccinelle to crash, because 
your path matches a node that can also be reached from a node that is not 
part of your path.

You can explicitly specify whether all paths should be considered or only 
a single path should be considered by putting forall or exists between the 
initial @@.  Doing this is often useful when you are doing bug finding but 
use python to print line number information, rather than using * to get a 
diff.  You can also put when forall or when exists on a ... if you need 
very fine-grained control.

julia

> From my very
> limited understanding of coccinelle it would seem that the issue is that
> the devm_request_and_ioremap() call and the return value check are in
> different blocks, but I have no idea how to take that into account. Then
> again, maybe the problem is something completely different.
> 
> Does anybody have any hints?
> 
> Thanks,
> Thierry
> 
