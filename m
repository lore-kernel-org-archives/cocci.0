From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 30 May 2018 22:33:54 +0200 (CEST)
Subject: [Cocci] Increase precision for display of SmPL script execution
 durations
In-Reply-To: <b36b5d25-1784-6228-a689-0dbf8d15ffb0@users.sourceforge.net>
References: <b36b5d25-1784-6228-a689-0dbf8d15ffb0@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805302233130.2349@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 30 May 2018, SF Markus Elfring wrote:

> Hello,
>
> The Coccinelle software can display profiling results for the execution
> of SmPL scripts. The measured durations are formatted in a way so that
> the information ?0.000 sec? is presented for some functions so far.
> I guess that these data processing efforts were performed with a non-zero
> time value.
> How do you think about to show this detail precisely?

Normally, one uses --profile to find the things that take seconds, not
to find the thing that take less than 0.01 seconds.

julia

>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
