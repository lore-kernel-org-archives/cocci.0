From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 23 Aug 2017 16:43:14 +0200
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <fda11784-5ed9-33ae-7beb-b5714abb11bc@users.sourceforge.net>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
 <69d615e4-0f62-2289-dd59-97c625ba47e8@users.sourceforge.net>
 <76e2fbf5-4812-18eb-2968-53019d97ab14@users.sourceforge.net>
 <alpine.DEB.2.20.1708152208320.2049@hadrien>
 <be855581-e22e-2b58-8565-68412ae590b3@users.sourceforge.net>
 <c5f3c8db-e5ec-47c1-3d84-8392a7101645@users.sourceforge.net>
 <alpine.DEB.2.20.1708172043460.2068@hadrien>
 <b4451f01-e10a-c0f3-91ff-f49e185b3644@users.sourceforge.net>
 <alpine.DEB.2.20.1708172130300.2068@hadrien>
 <fda11784-5ed9-33ae-7beb-b5714abb11bc@users.sourceforge.net>
Message-ID: <a4596fc8-dbe4-3f54-f8d6-2d24cb870d7e@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I have tried another variant out for a source code analysis.

Does the following SmPL script variant make sense?

@duplicated_code@
identifier work;
statement s1, s2;
type T;
@@
 T work(...)
 {
 ... when any
*if ((...) < 0)
*{
    ...
*   s1
*   s2
*}
 <+...
*if ((...) < 0)
*{
    ...
*   s1
*   s2
*}
 ...+>
 }


Can this approach find interesting places in any source files?

Regards,
Markus
