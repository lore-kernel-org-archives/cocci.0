From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 15 Sep 2015 15:01:48 +0200
Subject: [Cocci] [PATCH] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <1442309232-5902-1-git-send-email-a.hajda@samsung.com>
References: <1442309232-5902-1-git-send-email-a.hajda@samsung.com>
Message-ID: <55F816BC.5050407@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> + at r depends on context || org || report@
> +position p;
> +typedef u8, u16, u32, u64;

Can the involved data types be restricted for unsigned types for such
a source code analysis in a more general way?


> +{unsigned char, unsigned short int, unsigned int, unsigned long, unsigned long long, size_t, u8, u16, u32, u64} v;
> +@@
> +
> +(
> +*v at p < 0
> +|
> +*v at p >= 0
> +)

How do you think about to use the following SmPL wording instead?

 v at p
(
*< 0
|
*<= 0
)

Regards,
Markus
