From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 28 Oct 2014 19:33:17 +0100 (CET)
Subject: [Cocci] Parsing errors in several headers
In-Reply-To: <544FDF5C.6040009@dumbbell.fr>
References: <544FDF5C.6040009@dumbbell.fr>
Message-ID: <alpine.DEB.2.10.1410281930130.2567@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 28 Oct 2014, Jean-S?bastien P?dron wrote:

> Hi!
>
> I'm very new to Coccinelle and I don't understand why spatch(1) returns
> parsing errors on some headers and what I can do about that.
>
> == First example ==
>
> Header to parse:
> https://github.com/freebsd/freebsd/blob/master/sys/ofed/include/linux/bitops.h
>
> Full spatch command line and output:
> http://pastebin.com/DbNhBAF7
>
> spatch(1) fails to parse the #define at the end of the header. This
> #define starts a for() loop and uses functions declared ealier in the
> same file.

Do you need to match or transform some code that is related to this?  If
not, it doesn't matter.

julia

> == Second example ==
>
> Header to parse:
> https://github.com/freebsd/freebsd/blob/master/sys/ofed/include/linux/spinlock.h
>
> Full spatch command line and output:
> http://pastebin.com/C0h5ZN7r
>
> Here, it doesn't like the last #define again. This #define calls other
> macros defined in other headers.
>
> FYI, I'm using Coccinelle 1.0.0rc19 on FreeBSD.
>
> Can somebody help me understand what's wrong here?
>
> Thanks!
>
> --
> Jean-S?bastien P?dron
>
>
