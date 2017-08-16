From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 16 Aug 2017 09:35:56 +0200
Subject: [Cocci] Comparing statement lists with SmPL
In-Reply-To: <alpine.DEB.2.20.1708152208320.2049@hadrien>
References: <aff3ee47-e4cd-af52-1a66-304f36ddc1ed@users.sourceforge.net>
 <alpine.DEB.2.20.1708151930140.4600@hadrien>
 <69d615e4-0f62-2289-dd59-97c625ba47e8@users.sourceforge.net>
 <76e2fbf5-4812-18eb-2968-53019d97ab14@users.sourceforge.net>
 <alpine.DEB.2.20.1708152208320.2049@hadrien>
Message-ID: <be855581-e22e-2b58-8565-68412ae590b3@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Can the search for duplicated source code be improved by the means of the
>> semantic patch language?
> 
> For two statements at least you could do:

An other SmPL script variant can work to some degree.

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
*   s1
*   s2
    ...
*}
 ...
*if ((...) < 0)
*{
*   s1
*   s2
    ...
*}
 ...
 }


But matched statements will not be mapped to the discussed metavariable type
in this use case.
I am curious on how such an approach can be used for corresponding source
code transformations.

Regards,
Markus
