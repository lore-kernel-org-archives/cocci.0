From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 29 Jun 2017 17:40:31 -0600 (MDT)
Subject: [Cocci] Matching format strings
In-Reply-To: <20170629175852.trzk7w6nwxswzi5x@eos.mistotebe.net>
References: <20170629160437.nvpn32fsetlzvni7@eos.mistotebe.net>
 <alpine.DEB.2.20.1706291026390.2983@hadrien>
 <WM!fa141e32a0b1e5356bb136cefca80be54d02a269aa1d5e1c1d01b9dd1e9da14f2f9fffdc08676c298a48132a86f2037e!@mailstronghold-1.zmailcloud.com>
 <20170629175852.trzk7w6nwxswzi5x@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1706291733320.2968@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I would need to be able to convert
>
> char	buf[ SLAP_TEXT_BUFLEN ];
> snprintf( buf, sizeof( buf ),
>         "retrying URI=\"%s\" DN=\"%s\"",
>         mt->mt_uri,
>         BER_BVISNULL( &msc->msc_bound_ndn ) ?
>         "" : msc->msc_bound_ndn.bv_val );
>
> Debug( LDAP_DEBUG_ANY,
>         "%s meta_search_dobind_init[%d]: %s.\n",
>         op->o_log_prefix, candidate, buf );
>
> into
>
> Debug( LDAP_DEBUG_ANY,
>         "%s meta_search_dobind_init[%d]: "
>         "retrying URI=\"%s\" DN=\"%s\""
>         ".\n",
>         op->o_log_prefix, candidate, buf,
>         mt->mt_uri,
>         BER_BVISNULL( &msc->msc_bound_ndn ) ?
>         "" : msc->msc_bound_ndn.bv_val );
>
> or equivalent.
>
> I'll play around with the format string support a bit, but does it make
> the above possible out of the box without extra python code?

I don't think that the SmPL pattern language will allow you to construct
concatenated strings.  So you would need to use python here.  Try
something like the following (see demos/pythontococci.cocci):

@r1@
constant char [] c1;
constant char [] c2;
@@

f(c1);
g(c2);

@script:python res@
c1 << r1.c1;
c2 << r1.c2;
newstr;
@@

coccinelle.newstr = ... python code to concatenate c1 and c2 ...

@@
constant char [] r1.c1;
constant char [] r1.c2;
identifier res.newstr;
@@

- f(c1);
- g(c2);
+ h(res);

You may have to play with the python code a bit to make the "identifier"
being produced have string quotes in the right place.  Getting a newline
in the right place would be a further challenge.  Perhaps you could just
make an ordinary string, instead of using string concatenation.

julia

>
> The one I might want to be able to skip converting is
> https://github.com/openldap/openldap/blob/master/servers/slapd/config.c#L801
> since the buffer is used repeatedly. But I think I might be able to pull
> that off.
>
> > You can indeed also use python.  Perhaps a metavariable like the following
> > would be helpful:
> >
> > constant char[] x : script:python() { ok_string(x) };
> >
> > ok_string should be defined at the top of the file in
> >
> > @initialize:python@
> > @@
> >
> > def ok_string ...
> >
> > julia
>
> --
> Ond?ej Kuzn?k
> Senior Software Engineer
> Symas Corporation                       http://www.symas.com
> Packaged, certified, and supported LDAP solutions powered by OpenLDAP
>
