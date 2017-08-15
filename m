From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Aug 2017 19:33:11 +0200 (CEST)
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708151930140.4600@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 Aug 2017, SF Markus Elfring wrote:

> Hello,
>
> The Coccinelle software supports metavariables with the type ?statement list?.
> Can statement lists be compared if they refer to the same source code structures?
> Is this programming interface usable to determine if any code could be combined
> to some degree?

I don't really understand the questions.  Statement list metavariables can
be used once they are bound like any other metavariables.  However they
can only be bound to the complete sequence of statements in a block.  So

@@
statement list sl;
@@
if (x) {
  sl
}

is ok, but

@@
statement list sl;
@@
if (x) {
  one();
  sl
  two();
}

is not.

julia

>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
