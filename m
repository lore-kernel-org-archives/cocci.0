From: Robert.Larice@t-online.de (Robert Larice)
Date: Sun, 29 Apr 2018 20:12:17 +0200
Subject: [Cocci] perhaps a bug
In-Reply-To: <alpine.DEB.2.20.1804292001030.3679@hadrien> (Julia Lawall's
 message of "Sun, 29 Apr 2018 20:03:47 +0200 (CEST)")
References: <kka7tm2na4.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1804291457570.3679@hadrien>
 <kk1sey2md2.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1804291515450.3679@hadrien>
 <kksh7e1621.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1804292001030.3679@hadrien>
Message-ID: <kklgd5ubjy.fsf@bora.foobar.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia Lawall <julia.lawall@lip6.fr> writes:

> On Sun, 29 Apr 2018, Robert Larice wrote:
>
>> Julia Lawall <julia.lawall@lip6.fr> writes:
>>
>> > On Sun, 29 Apr 2018, Robert Larice wrote:
>> >
>> >> Julia Lawall <julia.lawall@lip6.fr> writes:
>> >>
>> >> > On Sun, 29 Apr 2018, Robert Larice wrote:
>> >> >
>> >> >> Hello,
>> >> >>
>> >> >>   attached is a small example which does something strange
>> >> >>     to a  "int i, j;" within a "#ifdef..."
>> >> >>   Perhaps this points to a bug in coccinelle,
>> >> >>   Would you please check ?
>> >> >
>> >> > Thanks for the report.  It looks like a bug.  But everything is fine if
>> >> > you removed the --defined BOO.
>> >> >
>> >> > julia
>> >>
>> >> Yes, in this example it works without this --defined announcement.
>> >>
>> >> I stumbled on this with something more complex, which for some
>> >>  reason I don't understand yet ignores a wanted transformation
>> >>  in a #ifdef..#endif, except if I add such a --defined.
>> >> Only then it honours my transformation, but fails with this bug.
>> >
>> > I don't think the --defined option has been tested much.  Perhaps without
>> > the --defined there is a parse error on the function.
>> >
>> > julia
>>
>> Hello Julia,
>>
>>   I've attached a ripped down example to show the behaviour
>>     with regard to the #ifdef
>>   Without the --defined, nothing gets tranformed.
>>   I don't see a parsing problem so far.
>>   Perhaps you can have a look and get an idea why
>>     here the --defined is important.
>>   I've seen other transformations where this was not necessairy.
>
> OK, thanks for the example.  It is indeed not a parsing problem.  When
> #ifdefs are reasonably well behaved, Coccinelle internally considers them
> to have a control-flow structure like an if - the code in the #ifdef might
> be there or it might not.  On the other hand your rule requires that there
> is exactly one i = 0 on each control-flow path through the loop.  If you
> just want to remove any that happen to exist, you can instead write:
>
> <...
> - i = 0;
> ...>
>
> This will also remove cases where there are multiple initializations of i
> to 0 within the loop.
>
> julia

Thank You for your helpfull description,

  in face of this I can well understand the why,
  and how to work around.

Best Regards,
  Robert
