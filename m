From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 23 Sep 2015 09:34:35 +0200
Subject: [Cocci] [PATCH v3] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <56017374.3080402@users.sourceforge.net>
References: <alpine.DEB.2.02.1509180734350.2064@localhost6.localdomain6>
 <1442831864-25759-1-git-send-email-a.hajda@samsung.com>
 <55FFFFF4.4000007@users.sourceforge.net> <56000777.6060208@samsung.com>
 <56017374.3080402@users.sourceforge.net>
Message-ID: <5602560B.2000601@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 09/22/2015 05:27 PM, SF Markus Elfring wrote:
>> If you mean adding int to 'unsigned long [long]' types, it does not work.
>> For some reason it works only without adding int after long.
> Do you get any error message for this SmPL approach?
> With which source files do you try the extended SmPL script out?
>
> Regards,
> Markus
>
No, spatch just does not find everything it should. Sample below:
--- test.cocci
virtual context

@r depends on context@
{unsigned char, unsigned short int, unsigned int, unsigned long int, unsigned
long long, size_t} v;
@@

*v
--- test.c
void f()
{
    unsigned long ul;
    unsigned long int uli;
    unsigned long long ull;
    unsigned long long int ulli;

    ul;
    uli;
    ull;
    ulli;
}
---
In the example above spatch finds ull, ulli, but not ul and uli.
If you add int to unsigned long long, it won't find anything.

Regards
Andrzej
