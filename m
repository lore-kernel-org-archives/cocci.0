From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 29 Jun 2017 14:07:58 -0600 (MDT)
Subject: [Cocci] Matching format strings
In-Reply-To: <20170629175852.trzk7w6nwxswzi5x@eos.mistotebe.net>
References: <20170629160437.nvpn32fsetlzvni7@eos.mistotebe.net>
 <alpine.DEB.2.20.1706291026390.2983@hadrien>
 <WM!fa141e32a0b1e5356bb136cefca80be54d02a269aa1d5e1c1d01b9dd1e9da14f2f9fffdc08676c298a48132a86f2037e!@mailstronghold-1.zmailcloud.com>
 <20170629175852.trzk7w6nwxswzi5x@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1706291406370.2989@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 29 Jun 2017, Ond?ej Kuzn?k wrote:

> On Thu, Jun 29, 2017 at 10:31:43AM -0600, Julia Lawall wrote:
> >
> >
> > On Thu, 29 Jun 2017, Ond?ej Kuzn?k wrote:
> >
> >> Hi all,
> >> I'm looking into what's needed to replace OpenLDAP's debug macro
> >> implementation which at the moment always takes 3 arguments:
> >>
> >> Debug(LEVEL, "format", arg1, arg2, arg3);
> >>
> >> to something more useful (and get rid of the obvious compiler warnings
> >> we get from doing things like that).
> >>
> >> There are two (or three) cases I need to handle where I hope coccinelle
> >> would be able to help:
> >>
> >> 1. Where less than three arguments are needed, they are always filled
> >> with zeros:
> >>
> >> Debug(level, "text with less than three format specifiers", 0, 0, 0);
> >>
> >> We want to change that to
> >>
> >> Debug( level, "format" );
> >>
> >> or equivalent. This is by far the most common one. But obviously where
> >> we have zeros as arguments, but there is a corresponding % format
> >> specifier, we don't want to drop those.
> >
> > See demos/format.cocci.  So you could have somthing like
> >
> > @@
> > format d;
> > expression level,str;
> > @@
> >
> > (
> > Debug(level,"...%@d at ...",0,0,0)
> > |
> > - Debug(level,str,0,0,0)
> > + Debug(level,str)
> > )
>
> Sweet! I missed that one, this should save me loads of time :)
>
> Using Debian Stretch at the moment and format.cocci doesn't seem to
> generate the correct patch, it outputs
>
> --- format.c
> +++ /tmp/cocci-output-16488-ebe9ee-format.c
> @@ -3,5 +3,5 @@ int main () {
>    foo("blah %d two %2x three %s xxx %d");
>    foo("xyz %d %d %0.2f %s three\n");
>    foo("xyz %d %0.2f abc");
> -  foo("xxx %s");
> +  foo("yyy %@d@");
>  }
>
> instead, is that a known issue in that version (as in, should I use
> latest git)?

Use the version from github.

I will answer the rest shortly.

julia

>
> >> 2. When more are needed, usually the code looks like this:
> >>
> >> snprintf( buffer, size, "format", ... );
> >> Debug( level, "text: %s\n", buffer, ... );
> >>
> >> We'd like to change that to:
> >>
> >> Debug( level, "new format", merged arguments );
> >>
> >> There are fewer of those but still too many for a human to maintain
> >> while we discuss the merits of this change on openldap-devel with
> >> regards to C89, old compilers and stuff like that :)
> >>
> >> 2a. There might be a place that reuses the buffer contents, but that's
> >> easy to check for I guess?
> >
> > I'm not sure to understand what is wanted here.
>
> One of the more complicated examples is here https://github.com/openldap/openldap/blob/master/servers/slapd/back-meta/search.c#L302-L311
>
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
