From: josh@joshtriplett.org (Josh Triplett)
Date: Sat, 2 Nov 2013 06:36:49 -0700
Subject: [Cocci] Matching an absence of statements before the closing brace
 of a function?
Message-ID: <20131102133648.GA4190@leaf>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I wanted to write a semantic patch that matched (and removed) "return;"
at the end of a void function.  I've attached the full .cocci file
written for coccicheck, but the key bit looks like this:

@@
identifier fn;
@@
void fn ( ... )
{
...
- return;
}

However, that patch also produces results like this:

--- a/drivers/scsi/aacraid/dpcsup.c
+++ b/drivers/scsi/aacraid/dpcsup.c
@@ -255,7 +255,6 @@ static void aac_aif_callback(void *conte
 	    cpu_to_le32(NoMoreAifDataAvailable)) {
 		aac_fib_complete(fibptr);
 		aac_fib_free(fibptr);
-		return;
 	}
 
 	aac_intr_normal(dev, 0, 1, 0, fibptr->hw_fib_va);

I'm guessing that either coccinelle didn't pair the braces (so that the
'}' matches close braces other than the one matching fn's opening brace)
or coccinelle allowed extra statements before the logical end of the
function despite the lack of '...'.

How can I write this patch such that it requires an absence of
statements between the return and the end of the function?

Note that matching the "return;" in the following would be fine from a
control-flow perspective:

void f(void)
{
	if (e) {
		return;
	}
}

But matching the "return;" in the following is not OK:

void f(void)
{
	if (e) {
		return;
	}
	f2();
}

- Josh Triplett
-------------- next part --------------
/// void functions don't need return statements at the end.
//
// Confidence: High
// Options: --no-includes --include-headers

virtual patch
virtual report
virtual context

@r1 depends on patch@
identifier fn;
@@
void fn ( ... )
{
...
- return;
}

@r2 depends on report || context@
identifier fn;
position p;
@@

void fn ( ... )
{
...
return;@p
}


@script:python depends on report@
p << r2.p;
fn << r2.fn;
@@

msg = "WARNING: unnecessary return@end of function '%s'" % fn
coccilib.report.print_report(p[0], msg)
