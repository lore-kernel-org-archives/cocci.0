From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 28 Jul 2016 10:32:23 +0200
Subject: [Cocci] Determination of statement list lengths with SmPL
In-Reply-To: <alpine.DEB.2.02.1510282304240.2054@localhost6.localdomain6>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <20151027101421.GA14273@redhat.com>
 <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
 <20151027115733.GB14273@redhat.com>
 <20151027123748.GA27349@pl-59055.rocqadm.inria.fr>
 <alpine.DEB.2.02.1510282304240.2054@localhost6.localdomain6>
Message-ID: <8e56fe29-5518-0155-42ac-06ab06b3b958@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Version 1.0.4 is released.  This removes the make of spgen when making 
> spatch, removes the pre-generated menhir file when menhir is available, 
> and adds the ability to reason about the lengths of statement lists.

I am becoming interested in this functionality a bit more.


The documentation contains information like the following so far.
https://github.com/coccinelle/coccinelle/blob/3b52bd3c6960dc996186e1c58c96355db288825c/docs/manual/cocci_syntax.tex#L181

"?
metadecl 	  ::=
?
|	parameter list [ id ] ids ;
|	parameter list [ const ] ids ;
?
|	statement [list] ids ;
?
|	expression list [ id ] ids ;
	expression list [ const ] ids ;
?"


Which programming interfaces (for OCaml and Python) will make it possible
to determine the length of statement sequences

Would it make sense to extend the support for statement lists
in a way which is similar to the other list types in the semantic
patch language?

Regards,
Markus
