From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 12 May 2017 15:09:00 +0200
Subject: [Cocci] Easy search for elements besides binary operators with SmPL
Message-ID: <45237ab7-f7ba-07dd-e492-dc5ce330364e@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I would like to check also the application of elements which are used together
with binary operators like the following.


@find@
expression target;
identifier action;
@@
 target = action(...,
                 ...
*                | __GFP_NOFAIL
                 | ...,
                 ...);


elfring at Sonne:~/Projekte/Linux/next-patched> spatch.opt drivers/md/dm-region-hash.c ~/Projekte/Coccinelle/janitor/show_use_of_nofail1.cocci
?
minus: parse error: 
  File "/home/elfring/Projekte/Coccinelle/janitor/show_use_of_nofail1.cocci", line 6, column 17, charpos = 87
  around = '...',
  whole content =                  ...


How should I improve my search pattern?


A metavariable can already be used for the search of a function parameter at an
undetermined position within a bigger list. Can similar functionality work also
for binary operators?

Regards,
Markus
