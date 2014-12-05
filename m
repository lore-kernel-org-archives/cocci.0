From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 5 Dec 2014 16:32:16 +0100 (CET)
Subject: [Cocci] Finding embedded function names?
In-Reply-To: <87tx1a6sdp.fsf@rasmusvillemoes.dk>
References: <1417741951.2721.30.camel@perches.com>
 <alpine.DEB.2.02.1412050742500.2059@localhost6.localdomain6>
 <1417764516.2721.37.camel@perches.com> <87tx1a6sdp.fsf@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.10.1412051631460.2360@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 5 Dec 2014, Rasmus Villemoes wrote:

> On Fri, Dec 05 2014, Joe Perches <joe@perches.com> wrote:
>
> > On Fri, 2014-12-05 at 08:18 +0100, Julia Lawall wrote:
> >> On Thu, 4 Dec 2014, Joe Perches wrote:
> >>
> >> Yes, by using python/ocaml:
> >>
> >> @r@
> >> char [] c;
> >> position p;
> >> identifier f;
> >> @@
> >>
> >> f(...,c at p,...)
> >>
> >> @script:ocaml@
> >> c << r.c;
> >> p << r.p;
> >> @@
> >>
> >> let ce = (List.hd p).current_element in
> >> if List.length(Str.split_delim (Str.regexp ce) c) > 1
> >> then Printf.printf "%s:%d: %s\n"
> >>        (List.hd p).file (List.hd p).line c
> >
> > Good to know, thanks.
> >
> >> Here are some results:
> >>
> >> drivers/net/wireless/zd1211rw/zd_usb.c:1573: "%s usb_exit()\n"
> > []
> >> The idea would be to replace these by %s and __func__?  That would also be
> >> possible.
> >
> > Yes and no.
> >
> > A lot of these are function tracing style messages and
> > those should just be deleted.
>
> Hardcoding the function name in a literal string also makes typos (or
> copy-pastos) possible. I extended Julia's code to allow a small edit
> distance. Requires the Levenshtein python module (on debian, apt-get
> install python-levenshtein). It's not terribly slow, but to be really
> useful I (or someone) would need to reduce the number of false positives.

Cool.  Thanks!

julia

> One gets for example
>
> drivers/net/wireless/rtlwifi/rtl8821ae/dm.c:2082:rtl8821ae_dm_txpwr_track_set_pwr():2: "===>rtl8812ae_dm_txpwr_track_set_pwr\n"
> drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c:1229:bnx2x_ets_e3b0_config():2: "bnx2x_ets_E3B0_config SP failed\n"
>
> The first of these is probably one of the tracing style messages; the
> second probably falls in the 'should use %s, __func__' category (other
> strings in that function actually use lowercase e3b0).
>
>
> @initialize:python@
> @@
> import re
> from Levenshtein import distance
> mindist = 1
> maxdist = 2
> ignore_leading = True
>
> @r@
> char [] c;
> position p;
> identifier f;
> @@
>
> f(...,c at p,...)
>
> @script:python@
> c << r.c;
> p << r.p;
> @@
>
> func = p[0].current_element
> wpattern = "[a-zA-Z_][a-zA-Z0-9_]*"
> if ignore_leading:
>    func = func.strip("_")
>    wpattern = "[a-zA-Z][a-zA-Z0-9_]*"
> lf = len(func)
> // ignore extremely short function names
> if lf > 3:
>    words = [w for w in re.findall(wpattern, c) if abs(len(w) - lf) <= maxdist]
>    for w in words:
>        d = distance(w, func)
>        if mindist <= d and d <= maxdist:
>        	  print "%s:%d:%s():%d: %s" % (p[0].file, int(p[0].line), func, d, c)
> 	  break
>
>
>
> Rasmus
>
