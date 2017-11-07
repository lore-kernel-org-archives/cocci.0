From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 7 Nov 2017 09:32:28 +0900
Subject: [Cocci] [PATCH] Coccinelle: use false positive annotation
In-Reply-To: <alpine.DEB.2.20.1710301151210.2632@hadrien>
References: <1509234189-26916-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAK7LNASBEvt6Ef3fJ=twQmV4LKSd_nbLd2BxmLtKEV8eYf3HBw@mail.gmail.com>
 <alpine.DEB.2.20.1710301151210.2632@hadrien>
Message-ID: <CAK7LNASAbYj0Dm+wDSCQaqyqucBHisOa4QcJKL3Ar9DeoWH8tw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2017-10-30 12:52 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
>
>
> On Mon, 30 Oct 2017, Masahiro Yamada wrote:
>
>> Hi Julia,
>>
>>
>> 2017-10-29 8:43 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
>> > /// is to describe the semantic patch, while //# indicates reasons
>> > for false positives.
>> >
>> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>> >
>> > ---
>> >  scripts/coccinelle/misc/ifcol.cocci |    6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/scripts/coccinelle/misc/ifcol.cocci b/scripts/coccinelle/misc/ifcol.cocci
>> > index d0d00ef..30b248b 100644
>> > --- a/scripts/coccinelle/misc/ifcol.cocci
>> > +++ b/scripts/coccinelle/misc/ifcol.cocci
>> > @@ -3,9 +3,9 @@
>> >  /// Sometimes, code after an if that is indented is actually intended to be
>> >  /// part of the if branch.
>> >  ///
>> > -/// This has a high rate of false positives, because Coccinelle's column
>> > -/// calculation does not distinguish between spaces and tabs, so code that
>> > -/// is not visually aligned may be considered to be in the same column.
>> > +//# This has a high rate of false positives, because Coccinelle's column
>> > +//# calculation does not distinguish between spaces and tabs, so code that
>> > +//# is not visually aligned may be considered to be in the same column.
>> >  ///
>>
>> Just a nit.
>>
>> The last /// should be turned into //
>> if you want to avoid two blank lines in a series
>> after the semantic patch information.
>>
>> (I can fix it locally if you agree with it and I am supposed to pick up this.)
>
> Thanks for detecting the problem.  It would be great if you could pick it
> up, since I haven't heard confirmation from Michal that he will start this
> again.  The change seems fine.  Thanks for your help.
>
> julia
>
>>

Fix up the second ///
and applied to linux-kbuild/misc.





-- 
Best Regards
Masahiro Yamada
