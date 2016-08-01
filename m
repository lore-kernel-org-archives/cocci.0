From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 1 Aug 2016 13:23:33 +0200
Subject: [Cocci] [PATCH v3] Coccinelle: Script to replace allocate and
 memset with zalloc functions
In-Reply-To: <20160801070233.GA19102@amitoj-Inspiron-3542>
References: <20160801070233.GA19102@amitoj-Inspiron-3542>
Message-ID: <d3dde65e-a1d5-54ba-d65f-9e996bb4f8f5@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> + at vz1 depends on patch && !context && !org && !report@
> +type T;
> +T *d;
> +statement S;
> +@@
> +
> +        d =
> +-            vmalloc
> ++            vzalloc
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(T));
> +
> + at vz2 depends on patch && !context && !org && !report@
> +expression d;
> +statement S;
> +@@
> +
> +        d =
> +-            vmalloc
> ++            vzalloc
> +             (...);
> +        if (!d) S
> +-       memset(d, 0, sizeof(*d));

I suggest to take another look at a few implementation details.

1. Would it make sense to merge such SmPL rules into one
   so that code duplication could be reduced a bit
   in such a script?

2. How do you think about to extend the shown check list
   with the function "kvm_kvzalloc"?

3. Do you want to maintain a growing (?) function name list manually?

Regards,
Markus
