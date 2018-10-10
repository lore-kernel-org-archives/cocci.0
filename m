From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 10 Oct 2018 07:43:36 +0200 (CEST)
Subject: [Cocci] Dummy rule for simplifying "depends on" clauses?
In-Reply-To: <CAOZdJXUWj-U87j6p-AK8wx_V4qRPD2ogyLyOgLE7pSFofzQ_Gw@mail.gmail.com>
References: <CAOZdJXUWj-U87j6p-AK8wx_V4qRPD2ogyLyOgLE7pSFofzQ_Gw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1810100741210.2477@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 9 Oct 2018, Timur Tabi wrote:

> In my cocci script, I have several rules, only one of which will
> match.  I then have a bunch of other rules that should be run only if
> one of the first rules is run.  So I have something like this:
>
> @rule1@
> @@
> ...
>
> @rule2@
> @@
> ...
>
> @rule3@
> @@
> ...
>
> @depends on rule1 || rule2 || rule3@
> ...
>
> @depends on rule1 || rule2 || rule3@
> ...
>
> How can I create a dummy rule so that I can do something like this:
>
> @rule1@
> @@
> ...
>
> @rule2@
> @@
> ...
>
> @rule3@
> @@
> ...
>
> @depends on rule1 || rule2 || rule3@
> @dummy@
> ...

@dummy depends on rule1 || rule2 || rule3@

I guess that the problem is that you have to give dummy a pattern that
will always match.  Maybe something generic that matches a function would
do?  Or something generic that has the form of what is matched in rule1
rule2 and rule3.

julia


>
> @depends on dummy@
> ...
>
> @depends on dummy@
> ...
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
