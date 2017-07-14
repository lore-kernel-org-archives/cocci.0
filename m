From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 14 Jul 2017 20:07:02 +0200 (CEST)
Subject: [Cocci] Dropping K&R support
In-Reply-To: <20170714172922.sziksfhmacwmoqph@eos.mistotebe.net>
References: <20170714172922.sziksfhmacwmoqph@eos.mistotebe.net>
Message-ID: <alpine.DEB.2.20.1707142005580.3699@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 14 Jul 2017, Ond?ej Kuzn?k wrote:

> Hi,
> in OpenLDAP we're thinking of dropping K&R support macros in our
> headers, but I'm having problems generating the semantic patch that
> would work.
>
> For example the LDAP_P macro in include/ldap.h. Let this serve as a
> trivial example:
>
> LDAP_F(int) some_func LDAP_P((int i, int j));
>
> Where (on some platforms) the macros are defined as follows:
>
> #define LDAP_P(params)    params
> #define LDAP_V(type)      extern type
>
> I'd think something like this should help convert it:
>
> @@
> @@
>
> -LDAP_P(
>  ...
> -)
>
> But with or without the above in --macro-file-builtins, I can't get this
> patch to apply. Without it, I guess it's the parse error that stops
> coccinelle from processing it, but with the above in
> --macro-file-builtins, no diff is produced either.
>
> Is there something wrong with the patch? Can this be done?

Sorry, it can't be done.  You rule wants to match an expression, not
something around bits of a function header.

julia
