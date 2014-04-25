From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 25 Apr 2014 23:58:58 +0200
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <alpine.DEB.2.02.1404252324460.2176@localhost6.localdomain6>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <alpine.DEB.2.10.1404251821570.3323@hadrien>
 <CABxcv==diNNJ+5ZovQb+kmVrWO1v1sc59GeO2nXAs=i2b1gq0Q@mail.gmail.com>
 <alpine.DEB.2.02.1404252324460.2176@localhost6.localdomain6>
Message-ID: <CABxcv=mEHrg0=VSRYAtMJq_papbLYQa4Y1y8j+38n7-3=V6SsQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Julia,

On Fri, Apr 25, 2014 at 11:25 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Fri, 25 Apr 2014, Javier Martinez Canillas wrote:
>
>> Hello Julia,
>>
>> On Fri, Apr 25, 2014 at 6:23 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> > On Fri, 25 Apr 2014, Javier Martinez Canillas wrote:
>> >
>> >> Hello,
>> >>
>> >> I'm a Linux kernel developer doing a big refactoring on the GPIO subsytem.
>> >>
>> >> I was wondering if the change I'm doing manually could be automated by
>> >> using cocinelle but I've no experience neither writing semantic
>> >> patches nor the SmPL language grammar.
>> >
>> > It looks quite possible.  In looking at the code, though, I wasn't sure
>> > what is your strategy for where to place the new structure definition, in
>> > the case where there was no structure before.  Would it be OK to put it
>> > next to the probe function?
>> >
>> > julia
>>
>> Thanks a lot for taking the time to look at this!
>>
>> I've been adding the new structure definition right after all the
>> functions have been defined since that is a common pattern found in
>> other kernel subsystems.
>>
>> But since this is a cleanup and if is going to be easier to define the
>> semantic patch by placing the structure before the probe function then
>> that works for me too and later drivers maintainers can send
>> incremental patches to change wherever they find more suitable.
>
> Well, you could also put it after the probe function.
>
> You could also find the ending position of all of the functions and put it
> after the last one, but that could be a bit complicated.
>

Besides moving the function pointers assigned to the structure
gpio_chip fields to the new struct gpio_chip_ops, a pointer to the new
struct gpio_chip_ops has to be assigned to the struct gpio_chip .ops
field.

So where to put the new structure is constrained by where struct
gpio_chip fields are set. If is easier we can define to be just before
the function where the assignments were made but I don't know if it
can be generalized.

But I don't want to waste your time since I still didn't have time to
get familiar with cocinelle/spatch syntax to get into the details.
I'll figure out and let you know if I have any issues.

Thanks a lot and best regards,
Javier
