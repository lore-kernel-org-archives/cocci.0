From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 20 Apr 2016 20:03:06 +0100
Subject: [Cocci] Splitting a function in two with SmPL
In-Reply-To: <alpine.DEB.2.02.1604202057360.2223@localhost6.localdomain6>
References: <CAB=NE6XnxL_xMXKZYQtcqWdSmnfAtg2-MhXz5TcgR9a=TmEf6A@mail.gmail.com>
 <alpine.DEB.2.02.1604202057360.2223@localhost6.localdomain6>
Message-ID: <CAB=NE6Ugvu39rSib2sFozYMro2ygMx=pMzLHz6+-TcLgS24Hzg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Apr 20, 2016 at 7:57 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Wed, 20 Apr 2016, Luis R. Rodriguez wrote:
>
>> Is there a way to split a function in 2 with SmPL? For example, let's
>> say I've created a helper routine which accepts a callback to be set,
>> it will then use the callback. The code that goes into the callback
>> will be the code you had below an old API call.
>>
>> For instance I'm writing a new firmware API for the kernel and I'd
>> like to help developers to do conversion by supplying a transformation
>> set of SmPL rules for them, so their work is minimized, and so the
>> changes on the API can also more easily be understood. The firmware
>> API has to types of calls, async and sync calls, for the async
>> functionality I believe I have a good solution already given that a
>> callback is always expected so we can re-use that. For sync mechanism
>> the old firmware API never required one, but I'd like to do that now.
>> I do this to help the API do more work for the users, to help avoid
>> bugs. This borrows some ideas from the devm functionality, so for
>> instance it does the free'ing of the firmware for you now.
>>
>> So for instance, this works really well, but it does not let me move a
>> section of statements below the old API to a new routine. I take it,
>> that this would probably be hard to do as Coccinelle would need to
>> somehow figure out on its own all the required declarations it may
>> need. Since a human can do it, I'm confident we can figure this out,
>> however I'd like to know if this is a known limitation or if I can get
>> this to work as-is already with the engine.
>>
>> Here's the rule I have so far:
>>
>> http://drvbp1.linux-foundation.org/~mcgrof/2016/04/20/convert-sysdata-sync-v1.cocci
>>
>> It works but that's because I haven't tried / figured out how to lift
>> the statement S1 out from f() and into the new sync_found_cb() I'm
>> adding.
>
> Do you have some test data?

Sure, the target I'm using right now, as an example is:

spatch --sp-file convert-sysdata-sync-v1.cocci --in-place
--recursive-includes --relax-include-path --dir
drivers/net/wireless/intersil/p54/ --jobs 4 --use-coccigrep

That should get the engine going on:

drivers/net/wireless/intersil/p54/p54spi.c

  Luis
