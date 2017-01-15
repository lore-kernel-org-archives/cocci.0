From: guenter@roeck-us.net (Guenter Roeck)
Date: Sun, 15 Jan 2017 11:28:59 -0800
Subject: [Cocci] More coccinelle problems
In-Reply-To: <alpine.DEB.2.20.1701151900320.3751@hadrien>
References: <5c27cf78-f9b2-8306-4009-1e284ac8ee5c@roeck-us.net>
 <alpine.DEB.2.20.1701151817060.3751@hadrien>
 <c0a0b0eb-4573-1dea-385d-85daf02b7d8f@roeck-us.net>
 <alpine.DEB.2.20.1701151900320.3751@hadrien>
Message-ID: <98e50bcf-b844-6141-c1be-dd50a3f62338@roeck-us.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 01/15/2017 10:03 AM, Julia Lawall wrote:
>> I originally didn't want to do that because the actual transformation catches
>> both
>>
>>      fn(&pdev->dev, ...) -> fn(dev, ...)
>> and
>>      x = &pdev->dev -> x = &dev
>>
>> but it turns out that was easy to solve.
>>
>> initfn at p(T *pdev, ...) {
>>    ...
>>    struct device *d = &pdev->dev;
>> <...
>> (
>> - fn(&pdev->dev, es)
>> + fn(d, es)
>> |
>> - &pdev->dev
>> + d
>> |
>> - pdev->dev.i
>> + dev->i
>> )
>> ...> }
> I think that this is not quite perfect.  It will only reformat when
> &pdev->dev is the in the first argument, and if &pdev->dev is the first
> argument, then it won't transform occurrences of &pdev->dev in other
> arguments.  I was thinking to just do the transformation as before, and
I noticed. I "solved" that by running the script twice ;-).
> then have a separate reformat rule, but the reformat rule should depend on
> the rule that does the transformation.  If the transformation doesn't
> happen, there is no need for reformatting.
Let me try.

Thanks,
Guenter
