From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 9 Jan 2013 13:34:54 +0100
Subject: [Cocci] Matching outside of blocks
Message-ID: <20130109123454.GA29477@avionic-0098.adnet.avionic-design.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I'm trying to come up with a semantic patch to modify the meaning of the
devm_request_and_ioremap() functions return value. The goal is to return
an ERR_PTR() encoded errno in order to allow the proper error code to be
propagated to the caller.

Since devm_request_and_ioremap() is called quite often, I thought this
would be an interesting task to solve with coccinelle. I've come up with
this semantic patch:

	virtual patch
	virtual report

	@depends on patch@
	expression e;
	@@

	 e = devm_request_and_ioremap(...);
	 ...
	(
	-if (\(e == NULL\|!e\)) {
	+if (IS_ERR(e)) {
	 	...
	-	return ...;
	+	return PTR_ERR(e);
	 }
	|
	-if (\(e == NULL\|!e\))
	-	return ...;
	+if (IS_ERR(e))
	+	return PTR_ERR(e);
	)

	@r depends on report@
	expression e;
	position p1;
	@@

	*e = devm_request_and_ioremap at p1(...);
	 ...
	(
	 if (\(e == NULL\|!e\)) {
	 	...
	 	return ...;
	 }
	|
	 if (\(e == NULL\|!e\))
	 	return ...;
	)

	@script:python depends on r@
	p1 << r.p1;
	@@

	msg = "ERROR: old devm_request_and_ioremap() API used on line %s" % (p1[0].line)
	coccilib.report.print_report(p1[0], msg)

This seems to work fine for most cases, but I've come across a tricky
one in drivers/gpio/gpio-mxs.c. The code looks roughly like this:

	if (np) {
		...
		base = of_iomap(parent, 0);
		...
	} else {
		iores = platform_get_resource(...);
		base = devm_request_and_ioremap(...);
	}
	if (!base)
		return -EADDRNOTAVAIL;

The odd thing is that in report mode this case is actually detected, but
the patch mode doesn't generate a hunk for this occurrence.

I wonder what I need to change to make this case work. From my very
limited understanding of coccinelle it would seem that the issue is that
the devm_request_and_ioremap() call and the return value check are in
different blocks, but I have no idea how to take that into account. Then
again, maybe the problem is something completely different.

Does anybody have any hints?

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130109/645627ea/attachment.asc>
