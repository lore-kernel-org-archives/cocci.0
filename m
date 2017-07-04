From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 4 Jul 2017 18:25:07 +0200 (CEST)
Subject: [Cocci] Matching format strings
In-Reply-To: <20170704160123.lilble53tmv5t5va@eos.mistotebe.net>
References: <20170630135727.lyjp7ayalzxf73jf@eos.mistotebe.net>
 <20170704132241.nzin5ihmmhzk2puf@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041531280.3224@hadrien>
 <WM!8666006bd8d2547072f2aaa49a217ebee942918ea85a26184b30aa0c245a807e35f125c1045776851fe6d85360d3ed76!@mailstronghold-3.zmailcloud.com>
 <20170704135006.wipw7z7pzyjwc7jv@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041552400.3224@hadrien>
 <WM!65159de96edf810da1e56d42962da09a256f7f76b7d8eab05109b214b5dc8c18f88b6a34ac273725a5e7afd1a6bed1d7!@mailstronghold-2.zmailcloud.com>
 <20170704151108.2mvifcg7cyhztbh5@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041721300.11588@hadrien>
 <WM!e764e7a6685d1e3af9c59f905772f1c4a8db9db4c655054ccb07f1b8485096c0979716269a6920eeac860b62d25a700e!@mailstronghold-2.zmailcloud.com>
 <20170704160123.lilble53tmv5t5va@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1707041822320.11588@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 4 Jul 2017, Ond?ej Kuzn?k wrote:

> On Tue, Jul 04, 2017 at 05:25:46PM +0200, Julia Lawall wrote:
> > On Tue, 4 Jul 2017, Ond?ej Kuzn?k wrote:
> >> Hmm, suddenly the problems with passing expressions to python I stated
> >> earlier disappeared, good. Running this takes a log time on some files
> >> (over 10 minutes for ./servers/slapd/back-ldap/bind.c and processing of
> >> servers/slapd/back-meta/search.c has yet to finish after 30 minutes of
> >> processing).
> >>
> >> I suppose going through all the potential combinations of snprintf/Debug
> >> statements is what takes so long, any tips on what usually helps to
> >> speed things up?
> >
> > Some functions in those files have a lot of ifs.  Ifs are very expensive,
> > because both branches have to be considered.
>
> Do they have to be considered every time or can coccinelle sometimes
> understand that taking neither branch can affect the match? (as in, can
> I adjust the patch to help coccinelle somehow?).
>
> > In the rule below at least, I don't think you need the initial
> > { ... and final ... }.  That would only seem to be necessary if you have a
> > lot of redeclarations of variables.
>
> That is the case at least in servers/slapd/back-meta/search.c, where
> buf is often declared just before it is used and I hoped that would
> speed things up slightly.
>
> > Also, it could help to be more specific about the type of buf.
>
> I have tried
>
> {
> -char buf[S];
> -snprintf at p1( buf, E, format1, args );
> -Debug at p2( L, format2, args_before, buf, args_after );
> +Debug( L, merged, args_before, args, args_after );
> ... when != buf
> }

It should help a little bit, although not as much as you would expect, to
put the following rule first:

{
-char buf[S];
-snprintf at p1( buf, E, format1, args );
-Debug at p2( L, format2, args_before, buf, args_after );
+Debug( L, merged, args_before, args, args_after );
}

julia

>
> To see whether I can remove a lot of the simple ones quickly and then
> work with a simpler file, but this one seems to take the same amount of
> time once I put the "... when != buf" in.
>
> >> Also, more importantly, the patch below this seems to remove this
> >> comment:
> >> https://github.com/openldap/openldap/blob/master/servers/slapd/back-asyncmeta/conn.c#L547
> >>
> >> [...]
> >>
> >> I would like to preserve the comment, is there something I can do about
> >> that?
> >
> > I thought that comments are only removed when they come before removed
> > code, while here they come after removed code.  I can check on it.
>
> Thanks!
>
>
> --
> Ond?ej Kuzn?k
> Senior Software Engineer
> Symas Corporation                       http://www.symas.com
> Packaged, certified, and supported LDAP solutions powered by OpenLDAP
>
