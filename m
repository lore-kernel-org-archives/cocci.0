From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 9 Feb 2016 10:18:22 +0100 (CET)
Subject: [Cocci] [PATCH v2] coccinelle: add style check for assignment
	in if
In-Reply-To: <56B9A2F6.4040109@users.sourceforge.net>
References: <1454935571-4054-1-git-send-email-kborer@gmail.com>
 <56B9A2F6.4040109@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1602091016200.2578@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 9 Feb 2016, SF Markus Elfring wrote:

> > +virtual patch
>
> How do you think about to use this variable in a subsequent
> SmPL rule?
>
> Would you like to consider also the reuse of SmPL variables
> like "org" and "report"?

I think that there is no point for these things, because checkpatch
already gives warnings about this issue.

It could be nice for the provided rules to actually depend on patch.  But
in the context of make coccicheck, it doesn't matter, because attempts to
run the rule in another mode will just fail, due to the mode not being
declared.

julia
