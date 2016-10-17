From: afd@ti.com (Andrew F. Davis)
Date: Mon, 17 Oct 2016 16:08:26 -0500
Subject: [Cocci] [PATCH v2] Coccinelle: Add misc/boolconv.cocci
In-Reply-To: <alpine.DEB.2.20.1610172254330.2186@hadrien>
References: <20161017165224.17093-1-afd@ti.com>
 <alpine.DEB.2.20.1610172254330.2186@hadrien>
Message-ID: <01267522-ce8d-9fe8-2ec3-e466f24b8492@ti.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 10/17/2016 03:54 PM, Julia Lawall wrote:
> On Mon, 17 Oct 2016, Andrew F. Davis wrote:
> 
>> Add a script to check for unneeded conversions to bool.
> 
> What changed since the previous version?
> 

Nothing, just a resend, forgot to label it as such.

Andrew

> julia
> 
> 
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>> ---
>>  scripts/coccinelle/misc/boolconv.cocci | 90 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>  create mode 100644 scripts/coccinelle/misc/boolconv.cocci
>>
>> diff --git a/scripts/coccinelle/misc/boolconv.cocci b/scripts/coccinelle/misc/boolconv.cocci
>> new file mode 100644
>> index 0000000..33c464d
>> --- /dev/null
>> +++ b/scripts/coccinelle/misc/boolconv.cocci
>> @@ -0,0 +1,90 @@
>> +/// Remove unneeded conversion to bool
>> +///
>> +//# Relational and logical operators evaluate to bool,
>> +//# explicit conversion is overly verbose and unneeded.
>> +//
>> +// Copyright: (C) 2016 Andrew F. Davis <afd@ti.com> GPLv2.
>> +
>> +virtual patch
>> +virtual context
>> +virtual org
>> +virtual report
>> +
>> +//----------------------------------------------------------
>> +//  For patch mode
>> +//----------------------------------------------------------
>> +
>> + at depends on patch@
>> +expression A, B;
>> +symbol true, false;
>> +@@
>> +
>> +(
>> +  A == B
>> +|
>> +  A != B
>> +|
>> +  A > B
>> +|
>> +  A < B
>> +|
>> +  A >= B
>> +|
>> +  A <= B
>> +|
>> +  A && B
>> +|
>> +  A || B
>> +)
>> +- ? true : false
>> +
>> +//----------------------------------------------------------
>> +//  For context mode
>> +//----------------------------------------------------------
>> +
>> + at r depends on !patch@
>> +expression A, B;
>> +symbol true, false;
>> +position p;
>> +@@
>> +
>> +(
>> +  A == B
>> +|
>> +  A != B
>> +|
>> +  A > B
>> +|
>> +  A < B
>> +|
>> +  A >= B
>> +|
>> +  A <= B
>> +|
>> +  A && B
>> +|
>> +  A || B
>> +)
>> +* ? true : false at p
>> +
>> +//----------------------------------------------------------
>> +//  For org mode
>> +//----------------------------------------------------------
>> +
>> + at script:python depends on r&&org@
>> +p << r.p;
>> +@@
>> +
>> +msg = "WARNING: conversion to bool not needed here"
>> +coccilib.org.print_todo(p[0], msg)
>> +
>> +//----------------------------------------------------------
>> +//  For report mode
>> +//----------------------------------------------------------
>> +
>> + at script:python depends on r&&report@
>> +p << r.p;
>> +@@
>> +
>> +msg = "WARNING: conversion to bool not needed here"
>> +coccilib.report.print_report(p[0], msg)
>> --
>> 2.10.1
>>
>>
