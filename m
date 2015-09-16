From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 16 Sep 2015 20:56:57 +0200
Subject: [Cocci] [PATCH v2] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <1442409749-32700-1-git-send-email-a.hajda@samsung.com>
References: <alpine.DEB.2.10.1509161125370.2429@hadrien>
 <1442409749-32700-1-git-send-email-a.hajda@samsung.com>
Message-ID: <55F9BB79.20203@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> As we discussed earlier I have dropped idea of adding v <= 0 as it is widely
> used in checking ranges, counters, quantities.

I find that such a design decision will need more fine-tuning of the suggested
small SmPL script.


> + at r depends on context || org || report@
> +position p;
> +typedef u8, u16, u32, u64;
> +{unsigned char, unsigned short int, unsigned int, unsigned long, unsigned long long, size_t, u8, u16, u32, u64} v;

Is it eventually needed to mention the key word "int" also together with the "long" data types?


> +@@
> +
> +(
> +*v at p < 0
> +|
> +*v at p >= 0
> +)

How do you think about to split this SmPL rule so that corresponding warning
messages will really fit?

Regards,
Markus
