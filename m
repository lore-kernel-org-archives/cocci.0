From: Robert.Larice@t-online.de (Robert Larice)
Date: Sun, 29 Apr 2018 15:43:50 +0200
Subject: [Cocci] perhaps a bug
In-Reply-To: <alpine.DEB.2.20.1804291515450.3679@hadrien> (Julia Lawall's
 message of "Sun, 29 Apr 2018 15:16:37 +0200 (CEST)")
References: <kka7tm2na4.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1804291457570.3679@hadrien>
 <kk1sey2md2.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1804291515450.3679@hadrien>
Message-ID: <kksh7e1621.fsf@bora.foobar.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia Lawall <julia.lawall@lip6.fr> writes:

> On Sun, 29 Apr 2018, Robert Larice wrote:
>
>> Julia Lawall <julia.lawall@lip6.fr> writes:
>>
>> > On Sun, 29 Apr 2018, Robert Larice wrote:
>> >
>> >> Hello,
>> >>
>> >>   attached is a small example which does something strange
>> >>     to a  "int i, j;" within a "#ifdef..."
>> >>   Perhaps this points to a bug in coccinelle,
>> >>   Would you please check ?
>> >
>> > Thanks for the report.  It looks like a bug.  But everything is fine if
>> > you removed the --defined BOO.
>> >
>> > julia
>>
>> Yes, in this example it works without this --defined announcement.
>>
>> I stumbled on this with something more complex, which for some
>>  reason I don't understand yet ignores a wanted transformation
>>  in a #ifdef..#endif, except if I add such a --defined.
>> Only then it honours my transformation, but fails with this bug.
>
> I don't think the --defined option has been tested much.  Perhaps without
> the --defined there is a parse error on the function.
>
> julia

Hello Julia,

  I've attached a ripped down example to show the behaviour
    with regard to the #ifdef
  Without the --defined, nothing gets tranformed.
  I don't see a parsing problem so far.
  Perhaps you can have a look and get an idea why
    here the --defined is important.
  I've seen other transformations where this was not necessairy.

Best Regards,
  Robert

-------------- next part --------------
A non-text attachment was scrubbed...
Name: ex3.c
Type: text/x-csrc
Size: 372 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180429/ac526743/attachment-0001.bin>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ex3.cocci
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180429/ac526743/attachment-0001.ksh>
