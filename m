From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 23 Sep 2015 17:17:35 +0200
Subject: [Cocci] [PATCH v3] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <5602560B.2000601@samsung.com>
References: <alpine.DEB.2.02.1509180734350.2064@localhost6.localdomain6>
 <1442831864-25759-1-git-send-email-a.hajda@samsung.com>
 <55FFFFF4.4000007@users.sourceforge.net> <56000777.6060208@samsung.com>
 <56017374.3080402@users.sourceforge.net> <5602560B.2000601@samsung.com>
Message-ID: <5602C28F.9010302@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> In the example above spatch finds ull, ulli, but not ul and uli.
> If you add int to unsigned long long, it won't find anything.

I suggest to take another look at the use of type modifiers
in the semantic patch language. It seems that it matters occasionally
to specify them explicitly.

How do you think about to reuse a SmPL script like the following?


@find_unsigned@
typedef _Bool, bool, u8, u16, u32, u64;
{
unsigned,
unsigned char,
unsigned int,
unsigned short,
unsigned short int,
unsigned long,
unsigned long int,
unsigned long long,
unsigned long long int,
size_t,
_Bool,
bool,
u8,
u16,
u32,
u64
} var;
@@
*var


Regards,
Markus
