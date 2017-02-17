From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Fri, 17 Feb 2017 16:19:26 +0100
Subject: [Cocci] Python Output Not Flushed With -j > 1
In-Reply-To: <9bb393fd-22cf-8b1e-33e8-755e0ba02ed3@redhat.com>
References: <9bb393fd-22cf-8b1e-33e8-755e0ba02ed3@redhat.com>
Message-ID: <ow4wpco975t.fsf@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Michael:
> With a slightly modified .cocci file from last time:
> sibiu:/tmp$ spatch -j 1 cocciprint.cocci cocciprint.c > out 2> /dev/null
> && cat out
> cocciprint.c:3:8-9: coccilib.report.print_report Suceeded
> print() Succeded
> sibiu:/tmp$ spatch -j 2 cocciprint.cocci cocciprint.c > out 2> /dev/null
> && cat out
> sibiu:/tmp$ spatch -j 3 cocciprint.cocci cocciprint.c > out 2> /dev/null
> && cat out
> sibiu:/tmp$

It should be fixed now (commit 8996213b).
Thank you for the report.
-- 
Thierry.

Michael Stefaniuc (2017/02/17, 13:29 UTC)?:
> Hello,
>
> this is a follow up on the "[Cocci] coccilib.report.print_report Broken
> For Redirected STDOUT".
>
> But this not only affects coccilib.report.print_report but also the
> normal print. I noticed this only when running my real script in my own
> coccicheck implementation that automatically uses -j <nr_cpus>.
> I have another script that uses the python print() but that produces so
> much output to more than fill the buffers.
>
>
> With a slightly modified .cocci file from last time:
> sibiu:/tmp$ spatch -j 1 cocciprint.cocci cocciprint.c > out 2> /dev/null
> && cat out
> cocciprint.c:3:8-9: coccilib.report.print_report Suceeded
> print() Succeded
> sibiu:/tmp$ spatch -j 2 cocciprint.cocci cocciprint.c > out 2> /dev/null
> && cat out
> sibiu:/tmp$ spatch -j 3 cocciprint.cocci cocciprint.c > out 2> /dev/null
> && cat out
> sibiu:/tmp$
>
>
> I use for now print(..., flush=True) to workaround the issue.
>
> bye
> 	michael
> @r@
> identifier i;
> position p;
> @@
>  int i at p;
>
>
> @ script:python @
> p << r.p;
> @@
> coccilib.report.print_report(p[0], "coccilib.report.print_report Suceeded")
> print("print() Succeded")
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
