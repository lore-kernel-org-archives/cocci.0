From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Fri, 25 Jan 2013 23:28:21 -0200
Subject: [Cocci] Prepending '*' to an expression (Was: [PATCH V2]
 scripts/coccinelle/misc/memcpy-assign.cocci: Replace memcpy with struct
 assignment)
In-Reply-To: <510173B3.9090002@redhat.com>
References: <1358978790-2990-1-git-send-email-peter.senna@gmail.com>
 <510173B3.9090002@redhat.com>
Message-ID: <CA+MoWDq-Ne6GYUHe-OtrF1MvUv1ou+xPZZfid+TvndLgbpF5Dg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Michael,

Thank you for testing.

I made changes on the semantic patch. I believe it fixed the problem.
Can you test it?

[]'s

Peter

On Thu, Jan 24, 2013 at 3:47 PM, Michael Stefaniuc <mstefani@redhat.com> wrote:
> Hello,
>
> On 01/23/2013 11:06 PM, Peter Senna Tschudin wrote:
>> There are error-prone memcpy() that can be replaced by struct
>> assignment that are type-safe and much easier to read. This semantic
>> patch looks for memcpy() that can be replaced by struct assignment.
> thanks for the script by Peter this script as it proved useful for Wine
> too. Though in one case it generated the wrong patch.
>
> @@
> struct struct_name to;
> struct struct_name from;
> @@
>
> 'to' and 'from' above are expressions and not identifiers; that's a
> feature. The bug happened in the replacement
> - memcpy(foos + count, &foo, sizeof(struct foo_t));
> + *foos + count = foo;
>
> Shouldn't cocinelle automatically add the parenthesis when prepending a
> '*' or '&' to an expression which isn't an identifier?
>
>
> The script itself is "safe" as the compiler will error out on that
> patch. And the people that just take generated patches and submit them
> without even compiling them deserve the public tar and feathering ;)
>
> bye
>         michael
>
>>
>> Inspired by patches sent by Ezequiel Garcia <elezegarcia@gmail.com>
>>
>> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
>> ---
>> Changes from V1:
>>  Updated commit message
>>  Changed Confidence comment to High on the semantic patch
>>
>>  scripts/coccinelle/misc/memcpy-assign.cocci | 103 ++++++++++++++++++++++++++++
>>  1 file changed, 103 insertions(+)
>>  create mode 100644 scripts/coccinelle/misc/memcpy-assign.cocci
>>
>> diff --git a/scripts/coccinelle/misc/memcpy-assign.cocci b/scripts/coccinelle/misc/memcpy-assign.cocci
>> new file mode 100644
>> index 0000000..afd058b
>> --- /dev/null
>> +++ b/scripts/coccinelle/misc/memcpy-assign.cocci
>> @@ -0,0 +1,103 @@
>> +//
>> +// Replace memcpy with struct assignment.
>> +//
>> +// Confidence: High
>> +// Copyright: (C) 2012 Peter Senna Tschudin, INRIA/LIP6.  GPLv2.
>> +// URL: http://coccinelle.lip6.fr/
>> +// Comments:
>> +// Options: --no-includes --include-headers
>> +
>> +virtual patch
>> +virtual report
>> +virtual context
>> +virtual org
>> +
>> + at r1 depends on !patch@
>> +identifier struct_name;
>> +struct struct_name to;
>> +struct struct_name from;
>> +struct struct_name *top;
>> +struct struct_name *fromp;
>> +position p;
>> +@@
>> +memcpy at p(\(&(to)\|top\), \(&(from)\|fromp\), \(sizeof(to)\|sizeof(from)\|sizeof(struct struct_name)\|sizeof(*top)\|sizeof(*fromp)\))
>> +
>> + at script:python depends on report@
>> +p << r1.p;
>> +@@
>> +coccilib.report.print_report(p[0],"Replace memcpy with struct assignment")
>> +
>> + at depends on context@
>> +position r1.p;
>> +@@
>> +*memcpy at p(...);
>> +
>> + at script:python depends on org@
>> +p << r1.p;
>> +@@
>> +cocci.print_main("Replace memcpy with struct assignment",p)
>> +
>> + at depends on patch@
>> +identifier struct_name;
>> +struct struct_name to;
>> +struct struct_name from;
>> +@@
>> +(
>> +-memcpy(&(to), &(from), sizeof(to));
>> ++to = from;
>> +|
>> +-memcpy(&(to), &(from), sizeof(from));
>> ++to = from;
>> +|
>> +-memcpy(&(to), &(from), sizeof(struct struct_name));
>> ++to = from;
>> +)
>> +
>> + at depends on patch@
>> +identifier struct_name;
>> +struct struct_name to;
>> +struct struct_name *from;
>> +@@
>> +(
>> +-memcpy(&(to), from, sizeof(to));
>> ++to = *from;
>> +|
>> +-memcpy(&(to), from, sizeof(*from));
>> ++to = *from;
>> +|
>> +-memcpy(&(to), from, sizeof(struct struct_name));
>> ++to = *from;
>> +)
>> +
>> + at depends on patch@
>> +identifier struct_name;
>> +struct struct_name *to;
>> +struct struct_name from;
>> +@@
>> +(
>> +-memcpy(to, &(from), sizeof(*to));
>> ++ *to = from;
>> +|
>> +-memcpy(to, &(from), sizeof(from));
>> ++ *to = from;
>> +|
>> +-memcpy(to, &(from), sizeof(struct struct_name));
>> ++ *to = from;
>> +)
>> +
>> + at depends on patch@
>> +identifier struct_name;
>> +struct struct_name *to;
>> +struct struct_name *from;
>> +@@
>> +(
>> +-memcpy(to, from, sizeof(*to));
>> ++ *to = *from;
>> +|
>> +-memcpy(to, from, sizeof(*from));
>> ++ *to = *from;
>> +|
>> +-memcpy(to, from, sizeof(struct struct_name));
>> ++ *to = *from;
>> +)
>> +



-- 
Peter
-------------- next part --------------
A non-text attachment was scrubbed...
Name: memcpy-assign.cocci
Type: application/octet-stream
Size: 2740 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130125/82b7bb92/attachment.obj>
