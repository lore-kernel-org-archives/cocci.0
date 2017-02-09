From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 9 Feb 2017 13:47:00 +0100 (CET)
Subject: [Cocci] using "attribute" in - context?
In-Reply-To: <1486640886.17671.0.camel@sipsolutions.net>
References: <1486640886.17671.0.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1702091346030.2006@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 9 Feb 2017, Johannes Berg wrote:

> Is there a way to make this work?
>
> @@
> identifier fam;
> attribute __ro_after_init;
> attribute __genl_ro_after_init;
> @@
> ?struct genl_family fam
> - __ro_after_init
> + __genl_ro_after_init
> ?= {...};

Not currently, I think.  I think that Coccinelle only recognizes
attributes on function definitions.

julia

>
>
> Thanks,
> johannes
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
