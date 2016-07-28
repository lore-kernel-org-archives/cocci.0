From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 28 Jul 2016 14:51:36 +0200
Subject: [Cocci] Determination of statement list lengths with SmPL
In-Reply-To: <alpine.DEB.2.10.1607281437340.2896@hadrien>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <20151027101421.GA14273@redhat.com>
 <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
 <20151027115733.GB14273@redhat.com>
 <20151027123748.GA27349@pl-59055.rocqadm.inria.fr>
 <alpine.DEB.2.02.1510282304240.2054@localhost6.localdomain6>
 <8e56fe29-5518-0155-42ac-06ab06b3b958@users.sourceforge.net>
 <alpine.DEB.2.10.1607281034470.2896@hadrien>
 <c119d954-aca8-0238-72ac-0d86ceaafdb4@users.sourceforge.net>
 <alpine.DEB.2.10.1607281437340.2896@hadrien>
Message-ID: <71f33211-934e-f30d-aaf5-a290a9ba0dc8@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Did you try it?

Yes.

elfring at Sonne:~/Projekte/Linux/next-patched> spatch.opt -sp-file ~/Projekte/Coccinelle/janitor/show_lengths_for_if_statements2.cocci drivers/staging/ks7010/ks7010_sdio.c
init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
minus: parse error: 
  File "/home/elfring/Projekte/Coccinelle/janitor/show_lengths_for_if_statements2.cocci", line 6, column 4, charpos = 89
  around = 'is',
  whole content =     is


> I think you would need braces around is and es.

Another SmPL approach:

@lengths@
statement list [if_count] isl;
statement list [else_count] esl;
@@
 if (...)
    { isl }
 else
    { esl }

@script:python display@
if_n << lengths.if_count;
else_n << lengths.else_count;
@@
print("{0}|{1}".format(if_n, else_n))


elfring@Sonne:~/Projekte/Linux/next-patched> spatch.opt -sp-file ~/Projekte/Coccinelle/janitor/show_lengths_for_if_statements3.cocci drivers/staging/ks7010/ks7010_sdio.c
init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
Cannot resolve PyUnicodeUCS2_AsEncodedString.


How should this surprise be fixed?


> Otherwise, the result would always be 1, because there can only be one
> statement in each branch of an if.

Can the number of "steps" that were stored by a metavariable of the
type "statement" also be determined anyhow?

Regards,
Markus
