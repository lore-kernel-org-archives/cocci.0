From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 19 Aug 2016 15:26:34 +0200
Subject: [Cocci] Coccinelle: Script to replace allocate and memset with
 zalloc functions
In-Reply-To: <CA+5yK5HNhcYV+OWhvvgax-fvbtSXEHgPh0mxzWFPFc6-ubzJEQ@mail.gmail.com>
References: <20160801070233.GA19102@amitoj-Inspiron-3542>
 <d3dde65e-a1d5-54ba-d65f-9e996bb4f8f5@users.sourceforge.net>
 <CA+5yK5HNhcYV+OWhvvgax-fvbtSXEHgPh0mxzWFPFc6-ubzJEQ@mail.gmail.com>
Message-ID: <33c75c5f-59d5-5fd4-6767-6144b4f245bc@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I suggest to take another look at a few implementation details.
>>
>> 1. Would it make sense to merge such SmPL rules into one
>>    so that code duplication could be reduced a bit
>>    in such a script?
>>
>> 2. How do you think about to extend the shown check list
>>    with the function "kvm_kvzalloc"?
?
> kvm_kvzalloc function doesn't fit the same pattern as the other
> functions in this semantic patch, and is kvm specific,

Has this one got a similar function property?

Do you prefer to exclude such functions which belong to subsystems
so far generally?


> so the semantic patch looks fine as is.

How do you think about to express the shown source code repetition
as an aspect by an other script format?

Regards,
Markus
