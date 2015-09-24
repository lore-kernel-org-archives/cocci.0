From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 24 Sep 2015 17:51:01 +0200
Subject: [Cocci] [PATCH] coccinelle: assign signed result to unsigned
	variable
In-Reply-To: <1443099286-16559-1-git-send-email-a.hajda@samsung.com>
References: <1443099286-16559-1-git-send-email-a.hajda@samsung.com>
Message-ID: <56041BE5.5010005@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> + at rs@
> +position p;
> +typedef bool, u8, u16, u32, u64, s8, s16, s32, s64;
> +{char, short int, int, long, long long, s8, s16, s32, s64} vs;

Can it matter to specify also the type modifier "signed" in this SmPL approach?
http://coccinelle.lip6.fr/docs/main_grammar005.html#ctype_qualif


> +{unsigned char, unsigned short, unsigned int, unsigned long, unsigned long long, size_t, bool, u8, u16, u32, u64} vu;

How do you think about to reformat such a data type enumeration?


> +@@
> +
> +vu at p = vs
> +
> + at r@
> +position rs.p;
> +identifier v, f;
> +statement S1, S2;
> +expression e;
> +@@
> +
> +*v at p = f(...);

Do you try to check here if the value receiver is at the same source code
position from the SmPL rule "rs"?

Regards,
Markus
