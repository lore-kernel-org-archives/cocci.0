From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 4 Jul 2017 17:25:46 +0200 (CEST)
Subject: [Cocci] Matching format strings
In-Reply-To: <20170704151108.2mvifcg7cyhztbh5@eos.mistotebe.net>
References: <20170629175852.trzk7w6nwxswzi5x@eos.mistotebe.net>
 <alpine.DEB.2.20.1706291733320.2968@hadrien>
 <WM!a6114e049b67df39e40551cd95bf5d65e432ff2f8c0445b0273a6b12349ae6346924a09e4c027fdcc87febe26a5e6a4e!@mailstronghold-2.zmailcloud.com>
 <20170630135727.lyjp7ayalzxf73jf@eos.mistotebe.net>
 <20170704132241.nzin5ihmmhzk2puf@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041531280.3224@hadrien>
 <WM!8666006bd8d2547072f2aaa49a217ebee942918ea85a26184b30aa0c245a807e35f125c1045776851fe6d85360d3ed76!@mailstronghold-3.zmailcloud.com>
 <20170704135006.wipw7z7pzyjwc7jv@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041552400.3224@hadrien>
 <WM!65159de96edf810da1e56d42962da09a256f7f76b7d8eab05109b214b5dc8c18f88b6a34ac273725a5e7afd1a6bed1d7!@mailstronghold-2.zmailcloud.com>
 <20170704151108.2mvifcg7cyhztbh5@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1707041721300.11588@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 4 Jul 2017, Ond?ej Kuzn?k wrote:

> On Tue, Jul 04, 2017 at 03:53:21PM +0200, Julia Lawall wrote:
> > On Tue, 4 Jul 2017, Ond?ej Kuzn?k wrote:
> >> That does work and seems to preserve the things that needed escaping,
> >> so just putting quotes around when merging looks enough, great!
> >>
> >> There is another scenario that I probably need to be able to handle, a
> >> string like this does not seem to match anything I throw at it (and in
> >> retrospect, you might have mentioned that earlier):
> >>
> >> "asd" "fgh" "jkl"
> >>
> >> Is there a way around that somehow or match, then pass into python to
> >> handle that?
> >
> > This is in the C code?  I think that it should be matched by an
> > expression.
>
> Hmm, suddenly the problems with passing expressions to python I stated
> earlier disappeared, good. Running this takes a log time on some files
> (over 10 minutes for ./servers/slapd/back-ldap/bind.c and processing of
> servers/slapd/back-meta/search.c has yet to finish after 30 minutes of
> processing).
>
> I suppose going through all the potential combinations of snprintf/Debug
> statements is what takes so long, any tips on what usually helps to
> speed things up?

Some functions in those files have a lot of ifs.  Ifs are very expensive,
because both branches have to be considered.

In the rule below at least, I don't think you need the initial
{ ... and final ... }.  That would only seem to be necessary if you have a
lot of redeclarations of variables.

Also, it could help to be more specific about the type of buf.

> Also, more importantly, the patch below this seems to remove this
> comment:
> https://github.com/openldap/openldap/blob/master/servers/slapd/back-asyncmeta/conn.c#L547
>
> {
> ...
> -T buf;
> ...
> ldap_pvt_thread_mutex_lock(lock);
> ...
> -snprintf at p1( buf, E, format1, args );
> +Debug( L, merged, args_before, args, args_after );
> ...
> ldap_pvt_thread_mutex_unlock(lock);
> ...
> -Debug at p2( L, format2, args_before, buf, args_after );
> ...
> }
>
> I would like to preserve the comment, is there something I can do about
> that?

I thought that comments are only removed when they come before removed
code, while here they come after removed code.  I can check on it.

julia
