From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 15 Sep 2015 16:36:50 +0200
Subject: [Cocci] [PATCH] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <55F8204D.3080606@samsung.com>
References: <1442309232-5902-1-git-send-email-a.hajda@samsung.com>
 <55F816BC.5050407@users.sourceforge.net> <55F8204D.3080606@samsung.com>
Message-ID: <55F82D02.5010004@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> If you think about removing all u* typedefs

I became interested in the use case to consider more type definitions
besides the ones which should usually be handled for Linux source files.


> it will result in omitting u* related comparisons,
> unless you use --recursive-includes option.

How do you think about to make this source code analysis parameter configurable?


>>> +{unsigned char, unsigned short int, unsigned int, unsigned long, unsigned long long, size_t, u8, u16, u32, u64} v;

How does the data type "size_t" fit into the suggested SmPL approach?

Would you like to reuse your approach for checking of more software eventually?

Regards,
Markus
