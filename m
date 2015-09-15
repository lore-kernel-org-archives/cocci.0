From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 15 Sep 2015 15:42:37 +0200
Subject: [Cocci] [PATCH] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <55F816BC.5050407@users.sourceforge.net>
References: <1442309232-5902-1-git-send-email-a.hajda@samsung.com>
 <55F816BC.5050407@users.sourceforge.net>
Message-ID: <55F8204D.3080606@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 09/15/2015 03:01 PM, SF Markus Elfring wrote:
>> + at r depends on context || org || report@
>> +position p;
>> +typedef u8, u16, u32, u64;
> Can the involved data types be restricted for unsigned types for such
> a source code analysis in a more general way?

I am not sure if I understand correctly. If you think about removing all u*
typedefs it
will result in omitting u* related comparisons, unless you use
--recursive-includes option.
Another solution is to add '--include include/asm-generic/int-ll64.h' to kbuild,
surprisingly
this header file is common for all architectures :)

Regards
Andrzej

>
>
>> +{unsigned char, unsigned short int, unsigned int, unsigned long, unsigned long long, size_t, u8, u16, u32, u64} v;
>> +@@
>> +
>> +(
>> +*v at p < 0
>> +|
>> +*v at p >= 0
>> +)
> How do you think about to use the following SmPL wording instead?
>
>  v at p
> (
> *< 0
> |
> *<= 0
> )
>
> Regards,
> Markus
>
