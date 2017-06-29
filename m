From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 29 Jun 2017 10:31:43 -0600 (MDT)
Subject: [Cocci] Matching format strings
In-Reply-To: <20170629160437.nvpn32fsetlzvni7@eos.mistotebe.net>
References: <20170629160437.nvpn32fsetlzvni7@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1706291026390.2983@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 29 Jun 2017, Ond?ej Kuzn?k wrote:

> Hi all,
> I'm looking into what's needed to replace OpenLDAP's debug macro
> implementation which at the moment always takes 3 arguments:
>
> Debug(LEVEL, "format", arg1, arg2, arg3);
>

> to something more useful (and get rid of the obvious compiler warnings
> we get from doing things like that).
>
> There are two (or three) cases I need to handle where I hope coccinelle
> would be able to help:
>
> 1. Where less than three arguments are needed, they are always filled
> with zeros:
>
> Debug(level, "text with less than three format specifiers", 0, 0, 0);
>
> We want to change that to
>
> Debug( level, "format" );
>
> or equivalent. This is by far the most common one. But obviously where
> we have zeros as arguments, but there is a corresponding % format
> specifier, we don't want to drop those.

See demos/format.cocci.  So you could have somthing like

@@
format d;
expression level,str;
@@

(
Debug(level,"...%@d at ...",0,0,0)
|
- Debug(level,str,0,0,0)
+ Debug(level,str)
)

>
> 2. When more are needed, usually the code looks like this:
>
> snprintf( buffer, size, "format", ... );
> Debug( level, "text: %s\n", buffer, ... );
>
> We'd like to change that to:
>
> Debug( level, "new format", merged arguments );
>
> There are fewer of those but still too many for a human to maintain
> while we discuss the merits of this change on openldap-devel with
> regards to C89, old compilers and stuff like that :)
>
> 2a. There might be a place that reuses the buffer contents, but that's
> easy to check for I guess?

I'm not sure to understand what is wanted here.

You can indeed also use python.  Perhaps a metavariable like the following
would be helpful:

constant char[] x : script:python() { ok_string(x) };

ok_string should be defined at the top of the file in

@initialize:python@
@@

def ok_string ...

julia

> Looking around the docs and the archive, there is some python support,
> but I have no idea how to use it yet to pick up the format strings, test
> whether a Debug line matches and prepare the change.
>
> Is coccinelle capable of expressing a semantic patch like that, and if
> yes, do you have any pointers and suggestions about how I should go
> about writing it?
>
> Thanks!
>
> --
> Ond?ej Kuzn?k
> Senior Software Engineer
> Symas Corporation                       http://www.symas.com
> Packaged, certified, and supported LDAP solutions powered by OpenLDAP
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
