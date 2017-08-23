From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 23 Aug 2017 17:39:38 +0200
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <alpine.DEB.2.20.1708231644340.3150@hadrien>
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
 <a4596fc8-dbe4-3f54-f8d6-2d24cb870d7e@users.sourceforge.net>
 <alpine.DEB.2.20.1708231644340.3150@hadrien>
Message-ID: <5d690e96-5217-a89c-dac3-19c5f4066008@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> You would need when any on the ...  Otherwise, it will not match anything
> (perhaps declarations). The s1 after is precludes matching any statement.
> Likewise in the next if.

The suggested variant does still not work in the way I would expect it.

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
    ... when any
*   s1
*   s2
*}
 <+...
*if ((...) < 0)
*{
    ... when any
*   s1
*   s2
*}
 ...+>
 }


I got some promising test results from the following SmPL approach.

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
    ... when any
*   s1
*   s2
*}
 ... when any
*if ((...) < 0)
*{
    ... when any
*   s1
*   s2
*}
 ... when any
 }


elfring@Sonne:~/Projekte/Linux/next-patched> XX=$(date) && spatch.opt --timeout 12 --sp-file ~/Projekte/Coccinelle/janitor/show_same_statements3b.cocci --dir sound > ~/Projekte/Bau/Linux/scripts/Coccinelle/tuning1/next/20170803/same_statements3b.diff 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/tuning1/next/20170803/same_statements3b-errors.txt; YY=$(date) && echo "$XX | $YY"
Mi 23. Aug 17:25:54 CEST 2017 | Mi 23. Aug 17:29:15 CEST 2017


How should the source code search be improved further here?

Regards,
Markus
