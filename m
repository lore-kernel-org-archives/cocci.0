From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 12 May 2017 22:49:46 +0800 (SGT)
Subject: [Cocci] Easy search for elements besides binary operators with
 SmPL
In-Reply-To: <e535373d-3307-2bb3-a843-5f7f413f6226@users.sourceforge.net>
References: <45237ab7-f7ba-07dd-e492-dc5ce330364e@users.sourceforge.net>
 <alpine.DEB.2.20.1705122137090.3416@hadrien>
 <e535373d-3307-2bb3-a843-5f7f413f6226@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1705122248340.3416@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 12 May 2017, SF Markus Elfring wrote:

> > Maybe put parentheses around the second argument.  An isomorphism will
> > drop them and you will avoid whatever parsing issue is being encountered.
>
> I do not observe a desired improvement after such a SmPL code adjustment.

Your change is not what I suggested either.  The second argument starts to
the right of one comma and ends to the left of the next one.

julia

> @find@
> expression target;
> identifier action;
> @@
>  target = action(...,
>                  ...
> *                | __GFP_NOFAIL
>                  | (...),
>                  ...);
>
>
>
> The Coccinelle software does also not like a reduced script variant so far.
>
> @find@
> expression target;
> identifier action;
> @@
>  target = action(...,
>                  ...
> *                | __GFP_NOFAIL
>                  );
>
>
> elfring at Sonne:~/Projekte/Linux/next-patched> spatch.opt drivers/md/dm-region-hash.c ~/Projekte/Coccinelle/janitor/show_use_of_nofail_as_last_option1.cocci
> ?
> minus: parse error:
>   File "/home/elfring/Projekte/Coccinelle/janitor/show_use_of_nofail_as_last_option1.cocci", line 6, column 17, charpos = 87
>   around = '...',
>   whole content =                  ...
>
>
> Do you get further ideas?
>
> Regards,
> Markus
>
