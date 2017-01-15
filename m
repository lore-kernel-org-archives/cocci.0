From: guenter@roeck-us.net (Guenter Roeck)
Date: Sun, 15 Jan 2017 09:56:16 -0800
Subject: [Cocci] More coccinelle problems
In-Reply-To: <alpine.DEB.2.20.1701151817060.3751@hadrien>
References: <5c27cf78-f9b2-8306-4009-1e284ac8ee5c@roeck-us.net>
 <alpine.DEB.2.20.1701151817060.3751@hadrien>
Message-ID: <c0a0b0eb-4573-1dea-385d-85daf02b7d8f@roeck-us.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On 01/15/2017 09:30 AM, Julia Lawall wrote:
>
> On Sun, 15 Jan 2017, Guenter Roeck wrote:
>
>> Hi Julia,
>>
>> I got another script which hangs for me. It actually works on almost all
>> files,
>> but hangs in drivers/input/keyboard/gpio_keys_polled.c. The hang does not
>> happen
>> if I remove the 'reformat' rule.
>>
>> In case you wonder, the idea is to reformat the code if another rule touched
>> function parameters. I stripped the context to make the problem easier to
>> reproduce.
>>
>> If you have an idea what might cause the hang, please let me know.
> Dropping the <+... ...+>, I don't get the hang any more, but I get a
> number of already tagged token errors.  This is due to nested calls.  It
> formats eg the inner one, and then when it goes to work on the outer one,
> the token has already been modified.  All but one of them is solved by
> putting identifier fn != dev_name;
>
> The remaining one is due to the collowing code in
> drivers/input/misc/rotary_encoder.c
>
>         device_init_wakeup(dev,
>                             device_property_read_bool(dev, "wakeup-source"));
>
> Actually, this code already has dev, not &pdev->dev, so there should be no
> need to reformat it.  It could help to put the two transformations in one
> rule, so that you only reformat in functions where the transformation has
> been performed.
I originally didn't want to do that because the actual transformation catches both

     fn(&pdev->dev, ...) -> fn(dev, ...)
and
     x = &pdev->dev -> x = &dev

but it turns out that was easy to solve.

initfn at p(T *pdev, ...) {
   ...
   struct device *d = &pdev->dev;
<...
(
- fn(&pdev->dev, es)
+ fn(d, es)
|
- &pdev->dev
+ d
|
- pdev->dev.i
+ dev->i
)
...> }

Thanks again!

Guenter
