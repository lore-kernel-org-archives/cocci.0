From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sat, 26 Apr 2014 18:31:41 +0200
Subject: [Cocci] Extract an interface with SmPL
In-Reply-To: <alpine.DEB.2.10.1404261758330.2022@hadrien>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <alpine.DEB.2.10.1404251821570.3323@hadrien>
 <CABxcv==diNNJ+5ZovQb+kmVrWO1v1sc59GeO2nXAs=i2b1gq0Q@mail.gmail.com>
 <alpine.DEB.2.02.1404252324460.2176@localhost6.localdomain6>
 <CABxcv=mEHrg0=VSRYAtMJq_papbLYQa4Y1y8j+38n7-3=V6SsQ@mail.gmail.com>
 <535B6EB3.9070705@users.sourceforge.net>
 <CABxcv=nOLP3mR1jWf_k=ahdQ=5Y-O=CimmKUWACVuAmzGpOsHQ@mail.gmail.com>
 <535BD64F.4000700@users.sourceforge.net>
 <alpine.DEB.2.10.1404261758330.2022@hadrien>
Message-ID: <CABxcv=kSmmEHrO+hfj_1ku=g2C+C1xGXiJK8u7QQSzCVd+cEJA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Apr 26, 2014 at 6:06 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> Would you like to extend it with approaches for source code refactoring?
>
> I think it would be best that he stick to the problem at hand.
>

Agreed, I prefer to first finish this task and maybe add the spatch to
the scripts/coccinelle/api/ directory in the linux kernel source code
and also your git repo as an example and then I can work on making it
more general if that is useful. I think your project is great so I'll
be very glad to contribute as much as possible.

>> > Probably the only change that will have to be made in the spatch is
>> > the regular expression to filter the function names and the name of
>> > the two data structures.
>>
>> I imagine that there are some software development challenges for the
>> implementation with the semantic patch language.
>>
>> 1. You refer to designated initializers from the standard "ISO/IEC 9899:1999".
>>    http://thevirtualmachinist.blogspot.de/2012/03/c99-designated-initializers.html
>>
>>    Do you need to consider the case when they are not used in a source file?
>
> No idea what this question means.  One can either use an initializer or
> initialize the fields of some structure in a function.  Both are
> illustrated by the example patches.  But the case where there is already
> an initializer seems simpler for starting.
>

I think what Markus meant is if a driver could not be using designated
initializers but instead do something like this:

static struct gpio_chip foo_chip = {
        "foo",
        THIS_MODULE,
         foo_request,
         foo_free,
         foo_direction_in,
         foo_get,
         foo_direction_out,
         foo_set,
         foo_to_irq,
         true,
};

In that case then this is a bug for many reasons (structures fields
can be added or removed, there is no guarantee that the fields will be
initialized in the right order, etc) and this should have been found
on review when the driver was posted. So I even prefer this driver to
not build anymore so we can spot this issue and fix it during the
release candidate cycle.

>> 2. You mentioned a few variations already. How difficult or interesting will the
>> handling of optional elements become?
>
> I think that one should focus on what is easy and hopefully what is
> frequently useful first.  One can expand later, or just do the rest by
> hand,
>

Exactly, I understood that very well from your previous emails. Thanks
a lot again for your suggestions.

>> 3. Initialisation and assignment statements can vary in their number and order
>> generally. How would you like to treat differences here?
>
> I don't think this is an issue.  The goal is just to preserve existing
> behavior in this regard.  If the old structure is missing something, the
> new structure will be missing it as well.
>
> Basically, the idea would be to create the outline of the new structure,
> and then fill it one by one with the fields from the old structure one by
> one, if they are found.
>

Right, also most fields are optional so the driver is already using
only the subset that it needs. i.e: a GPIO chip could only support
output lines or input lines so it does not need to set all the
function pointers.

> I would imagine that there would be a number of sets of rules to move each
> field from one structure to another.  This would lead to a good amount of
> repeated code, but it has the benefit that the fields will end up all in
> the same order, ie in the order of the rules.  Also, it seems hard to
> generalize, because there is one field of function pointer type that
> should not be moved.
>

Exactly, the new gpio_chip_ops structure is defined using the const
type qualifier since the GPIO operations functions should not change
at runtime with the only exception of the .to_irq field that and is
usually modified at runtime.

>> 4. Do you need to introduce unique names for variables and involved data structures?
>
> I think this was discussed already.
>

Yes.

> julia

Best regards,
Javier
