From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 31 Aug 2017 18:47:37 +0200 (CEST)
Subject: [Cocci] OpenLDAP debug statements
In-Reply-To: <20170831164551.d2xorti4bon6pzse@eos.mistotebe.net>
References: <WM!31a93b9eaa05d271c5e490fb8cbf454d71a531b19f3453d107ecb7e19adb99d108c14ee93b5774c82e15694f7e635331!@mailstronghold-2.zmailcloud.com>
 <20170831133724.psnilhftsv5wosmu@eos.mistotebe.net>
 <alpine.DEB.2.20.1708311602290.6822@hadrien>
 <WM!dd59490e5b7de329073fb77c10065fccac3a9a41edb3acd8e86e03476c313ec5bb332d1b5b82bbc9f3c9941991f2c2e3!@mailstronghold-1.zmailcloud.com>
 <20170831154634.apai7ml2mdrf7ua4@eos.mistotebe.net>
 <alpine.DEB.2.20.1708311748110.6822@hadrien>
 <WM!a89a77e54968f94897ce9cfdcde91fbafe11503103440c35bc96b5b7348b143240bee9daf49db5256b5b922355576b8f!@mailstronghold-1.zmailcloud.com>
 <20170831155625.wypqab6gers4w4a7@eos.mistotebe.net>
 <alpine.DEB.2.20.1708311758540.6822@hadrien>
 <WM!dc7736266ab751636f2d1292c87d4c5cc5827df1e313d7788da99c4b8733ee5da91cdaf5189368ed6790a6408e97c69c!@mailstronghold-2.zmailcloud.com>
 <20170831164551.d2xorti4bon6pzse@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1708311846550.6822@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 31 Aug 2017, Ond?ej Kuzn?k wrote:

> On Thu, Aug 31, 2017 at 06:01:07PM +0200, Julia Lawall wrote:
> > On Thu, 31 Aug 2017, Ond?ej Kuzn?k wrote:
> >> On Thu, Aug 31, 2017 at 05:52:14PM +0200, Julia Lawall wrote:
> >>> So you want to drop the braces if there is no comment and keep the brace
> >>> if there is a comment?  You can't match on comments.  The only thing you
> >>> could do is check the number of lines between the { and Debug.
> >>
> >> Something slightly different, I want to remove the braces only if they
> >> do not "belong" to an if statement.
> >
> > Does that occur?
> >
> > In any case, just do:
> >
> > @r@
> > position p1;
> > statement S;
> > @@
> >
> > if (...) {@p1  Debug(...); } else S
> >
> > @@
> > position p1 != r.p1;
> > @@
> >
> > -{@p1
> >   Debug(...);
> > -}
>
> I have tried the following:
>
> @guard@
> position p;
> @@
>
> if ( ... ) {@p
>  Debug( ... );
> }

You didn't put the else S.

If you add it, the rule will still match cases with no else.

julia

>
> @@
> position p != guard.p;
> @@
> -{@p
>  Debug( ... );
> -}
>
> But it still modifies servers/slapd/back-asyncmeta/bind.c:879
>
> --
> Ond?ej Kuzn?k
> Senior Software Engineer
> Symas Corporation                       http://www.symas.com
> Packaged, certified, and supported LDAP solutions powered by OpenLDAP
>
