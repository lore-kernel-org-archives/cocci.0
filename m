From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 4 Dec 2015 14:18:44 +0100 (CET)
Subject: [Cocci] how to find missing initializer
In-Reply-To: <56617976.9040405@users.sourceforge.net>
References: <56603DC3.8040609@hurleysoftware.com>
 <56608E06.9060003@metafoo.de> <alpine.DEB.2.10.1512032310280.2777@hadrien>
 <56617976.9040405@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1512041418130.2777@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 4 Dec 2015, SF Markus Elfring wrote:

> >> @r1@
> >> identifier fops;
> >> identifier fn;
> >> position p;
> >> @@
> >> struct tty_operations fops at p = {
> >>     ...,
> >>     .cleanup = fn,
> >>     ...
> >> };
> >
> > You don't need the ...
>
> I find it interesting that you suggest to omit the use of SmPL ellipsis here.
>
>
> > Coccinelle is very relaxed about matching structure initializers.
>
> Would you like to explain the handling of designated initialisers
> with the semantic patch language a bit more?

I think I already did...  What you provide is required to b a subset is
what is present in the code to be matched.

julia
