From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 12 May 2017 16:42:37 +0200
Subject: [Cocci] Easy search for elements besides binary operators with
 SmPL
In-Reply-To: <alpine.DEB.2.20.1705122137090.3416@hadrien>
References: <45237ab7-f7ba-07dd-e492-dc5ce330364e@users.sourceforge.net>
 <alpine.DEB.2.20.1705122137090.3416@hadrien>
Message-ID: <e535373d-3307-2bb3-a843-5f7f413f6226@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Maybe put parentheses around the second argument.  An isomorphism will
> drop them and you will avoid whatever parsing issue is being encountered.

I do not observe a desired improvement after such a SmPL code adjustment.

@find@
expression target;
identifier action;
@@
 target = action(...,
                 ...
*                | __GFP_NOFAIL
                 | (...),
                 ...);



The Coccinelle software does also not like a reduced script variant so far.

@find@
expression target;
identifier action;
@@
 target = action(...,
                 ...
*                | __GFP_NOFAIL
                 );


elfring at Sonne:~/Projekte/Linux/next-patched> spatch.opt drivers/md/dm-region-hash.c ~/Projekte/Coccinelle/janitor/show_use_of_nofail_as_last_option1.cocci
?
minus: parse error: 
  File "/home/elfring/Projekte/Coccinelle/janitor/show_use_of_nofail_as_last_option1.cocci", line 6, column 17, charpos = 87
  around = '...',
  whole content =                  ...


Do you get further ideas?

Regards,
Markus
