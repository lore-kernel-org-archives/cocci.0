From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Aug 2017 13:02:04 +0200 (CEST)
Subject: [Cocci] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <f170ecf7-0c9a-c43f-23c0-0e89f928c50e@users.sourceforge.net>
References: <1502690386-5605-2-git-send-email-elena.reshetova@intel.com>
 <f170ecf7-0c9a-c43f-23c0-0e89f928c50e@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708151259550.3849@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 Aug 2017, SF Markus Elfring wrote:

> Dear Elena,
>
> Would you like to take another look at my development suggestion for your approach?
> https://systeme.lip6.fr/pipermail/cocci/2017-August/004300.html
>
> How do you think about to refactor another rule like the following?
>
> @r3 exists@
> expression E;
> identifier I=~"^atomic(?:64|_long)?_add_return$";
> position P;
> @@
>  E = I at P(-1, ...);
>
>
> Can the specification of SmPL constraints be occasionally be more succinct
> with the use of regular expressions?

Elena, please don't follow Markus's suggestion.  Coccinelle doesn't
interpret regular expressions when selecting code to work on, and thus the
resulting rule will be less efficient.

Markus, if you see this somehow, at least yesterday all mail sent to you
was bouncing.

julia
