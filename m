From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 24 Nov 2017 11:23:53 +0100 (CET)
Subject: [Cocci] Why some changes are not done ?
In-Reply-To: <764056da-dd1d-ee19-e6fb-d70b5447ca59@orange.fr>
References: <764056da-dd1d-ee19-e6fb-d70b5447ca59@orange.fr>
Message-ID: <alpine.DEB.2.20.1711241122300.3316@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 24 Nov 2017, Francois-Xavier Le Bail wrote:

> Hi,
>
> I use the following Coccinelle script to rename some macros:
> @@
> expression E;
> @@
> (
> -EXTRACT_16BITS(E)
> +EXTRACT_BE_16BITS(E)
> |
> -EXTRACT_32BITS(E)
> +EXTRACT_BE_32BITS(E)
> )
>
> on the this source:
> https://raw.githubusercontent.com/the-tcpdump-group/tcpdump/6151e2190b0b40bdb6cf56354eb016284762d27b/print-tcp.c
>
> Most of the changes are done (20).
> But 2 old macro names are left.
>
> $ git grep -n -E 'EXTRACT_[0-9]+' print-tcp.c
> print-tcp.c:871:                tlen = EXTRACT_16BITS(&ip->ip_len) - IP_HL(ip) * 4;
> print-tcp.c:878:                len32 = htonl(EXTRACT_16BITS(&ip6->ip6_plen));
>
> It seems that the problem is link to macro USES_APPLE_DEPRECATED_API on line 835.
> If I comment this macro, the changes are done.
> On Apple systems:
> #define USES_APPLE_DEPRECATED_API DIAG_OFF(deprecated-declarations)
> On other systems (like the one I use):
> #define USES_APPLE_DEPRECATED_API

Just make a file macros.h and put in it

 #define USES_APPLE_DEPRECATED_API

Then run spatch with --macro-file macros.h (or if that doesn't work then
--macro-file-builtins macros.h).  Then it will ignore this code.

julia


>
> Did I miss something?
> --
> Francois-Xavier
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
