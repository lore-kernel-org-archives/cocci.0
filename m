From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 16 Aug 2017 09:03:52 +0200
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <8594a1d8-c2b1-2607-807b-2b7a1c42dd50@users.sourceforge.net>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
 <69d615e4-0f62-2289-dd59-97c625ba47e8@users.sourceforge.net>
 <76e2fbf5-4812-18eb-2968-53019d97ab14@users.sourceforge.net>
 <alpine.DEB.2.20.1708152208320.2049@hadrien>
 <8594a1d8-c2b1-2607-807b-2b7a1c42dd50@users.sourceforge.net>
Message-ID: <f19870ac-ba92-d635-d5b5-4d0a189e1c4e@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Unfortunately, the software version ?1.0.6-00186-g0acd38ee? does not like this
> SmPL specification.

I overlooked to add parentheses in my evolving SmPL script.

@duplicated_code@
identifier work;
statement s1, s2;
statement list sl;
type T;
@@
 T work(...)
 {
 ... when any
(
*if ((...) < 0) {
*   s1
*   s2
    ...
*}
&{
    sl
 }
)
 ...
(
*if ((...) < 0) {
*   s1
*   s2
    ...
*}
&{
    sl
 }
)
 ...
 }


The following command does not show the expected source code analysis results at the moment.

elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch.opt show_same_statements2.cocci ../Probe/hdsp-excerpt1.c


Is there any more clarification needed for the use of SmPL conjunctions?

Regards,
Markus
