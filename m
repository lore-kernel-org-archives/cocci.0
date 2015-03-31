From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 31 Mar 2015 15:47:21 +0200 (CEST)
Subject: [Cocci] Patching nested if's?
In-Reply-To: <CABE47THmL74Gy62cmGE+=V5bF6gqUP4qUPkKLxijcSbbrW4smQ@mail.gmail.com>
References: <CABE47THmL74Gy62cmGE+=V5bF6gqUP4qUPkKLxijcSbbrW4smQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1503311544490.2749@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I came up with the following invalid attempt
> @@
> expression t;
> constant M;
> @@
> ?if (...)

I think that the only problem is that you are missing an open brace here,
after the first if line.

> ??? if (...)
> ??? {
> ?????? if (
> -??? ?? t < M
> +????????? myfunc()
> ????????? )
> ????????? {
> ??? ? ...
> ??? ? } else {
> ??? ? ...
> ??? ? }

Markus suggested to put else S here.  Doing that would allow the else to
disappear, if sometimes in your code there is no else in this case.  If
any of your ifs may or may not have an else, you can put eg else S1, else
S2, else S3.  An isomorphism will allow them all to disppear.

julia

> ??? }
> ? }
>
> Thanks for any hint.
>
>
