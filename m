From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 19 Nov 2016 09:00:10 +0100
Subject: [Cocci] Better syntax for SmPL script constraints
In-Reply-To: <alpine.DEB.2.20.1611182246430.2139@hadrien>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
 <alpine.DEB.2.10.1611161152570.3153@hadrien>
 <6810eb15-839c-8aa5-6485-401d43ba1246@users.sourceforge.net>
 <alpine.DEB.2.10.1611161350550.3153@hadrien>
 <69c3643e-10b4-007a-f847-d0098f298e16@users.sourceforge.net>
 <alpine.DEB.2.10.1611161514250.3153@hadrien>
 <b90e8f82-aa00-0a11-1e38-53d8c4dfd9fd@users.sourceforge.net>
 <alpine.DEB.2.10.1611181842240.2963@hadrien>
 <5da250c3-e80f-8842-7e85-481cdf6a6259@users.sourceforge.net>
 <alpine.DEB.2.10.1611181901530.2963@hadrien>
 <24f0d5ad-aae9-70fc-cf66-bd62b001e463@users.sourceforge.net>
 <alpine.DEB.2.20.1611182105460.2139@hadrien>
 <3463364f-746d-f73b-753b-7c3ead97341e@users.sourceforge.net>
 <alpine.DEB.2.20.1611182246430.2139@hadrien>
Message-ID: <67d3d6bc-24b0-dd2f-1c86-9f6ac33fd6b5@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> No interest in supporting either.

This is a pity at the moment.

Are there any other software development concerns involved which result
into such a rejection?


> How are these so vastly better than:
> 
> @initialize:python@
> @@
> def is_watched(id):
>     return id in ['a', 'c']
> 
> @structured_replacement@
> identifier ID: script:python()


> { is_watched(ID) };

I find this notation improvable. Can a few characters be omitted
for the data processing of a named predicate to make it a bit more succinct?

I find that curly brackets would only be useful there if a function body
would be directly passed instead of a function name.
Is the suggested usage of ad hoc (unnamed) predicates occasionally
more convenient?

Regards,
Markus
