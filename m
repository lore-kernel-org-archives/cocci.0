From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 14 Feb 2014 16:51:18 +0100 (CET)
Subject: [Cocci] Patch macros
In-Reply-To: <87eh35emhk.fsf@tassilo.jf.intel.com>
References: <87eh35emhk.fsf@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.10.1402141649210.2118@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 14 Feb 2014, Andi Kleen wrote:

>
> Hi,
>
> I was trying to replace static asmlinkage with static. However
> it always gives a cocci parsing error. I assume the problem is that
> asmlinkage is really a macro (for __attribute__((visible)) in
> my case). How to handle this in cocci?

Unfortunately, I don't think it is possible.  The Coccinelle C parser
doesn't have any notion of asmlinkage, and so it skips over it.

julia

>
> Thanks,
>
> -Andi
>
> @@
> type T;
> @@
> - static asmlinkage T
> + static T
>
>
> --
> ak at linux.intel.com -- Speaking for myself only
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
