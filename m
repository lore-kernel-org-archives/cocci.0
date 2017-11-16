From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 16 Nov 2017 09:02:56 +0900
Subject: [Cocci] [PATCH] coccinelle: flags.cocci: reorganize patterns to
	improve efficiency
In-Reply-To: <1510783347.25299.2.camel@perches.com>
References: <alpine.DEB.2.20.1711121704350.10412@hadrien>
 <CAK7LNASTP80Yp66UP=oBM7evXD3Pg1GXJ_P9+m=dGp=mAUbe4Q@mail.gmail.com>
 <alpine.DEB.2.20.1711151550190.3647@hadrien>
 <CAK7LNAT5_RriY7yORFoWeAd5354HVmU2xXWZTvmuk3YHO+MxFA@mail.gmail.com>
 <alpine.DEB.2.20.1711152253270.2134@hadrien>
 <1510783347.25299.2.camel@perches.com>
Message-ID: <CAK7LNASzWqa+Cu9r8QyFjUojPgxi9nSvWnShrE-KTa660wqHBw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2017-11-16 7:02 GMT+09:00 Joe Perches <joe@perches.com>:
> On Wed, 2017-11-15 at 22:55 +0100, Julia Lawall wrote:
>> What version of Coccinelle do you have?
>> > I tried 1.0.4 and 1.0.6,
>> > but both failed.
>> For me, it also fails for 1.0.6.  It should be OK for 1.0.7.
>
> Then likely this patch should not be applied or
> some form of local version checking should be done
> in the script itself.
>
> Scripts that use various tools are subject to
> language versioning requirements.
>
> For instance, there are many things that are
> possible with later versions of perl, but are not
> done for various scripts because many distributions
> do not ship with the latest versions.
>


OK.

// Requires: 1.0.7

is necessary
and applicable after coccinelle 1.0.7 is released.




-- 
Best Regards
Masahiro Yamada
