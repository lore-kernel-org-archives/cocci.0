From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 15 Jan 2017 19:03:14 +0100 (CET)
Subject: [Cocci] More coccinelle problems
In-Reply-To: <c0a0b0eb-4573-1dea-385d-85daf02b7d8f@roeck-us.net>
References: <5c27cf78-f9b2-8306-4009-1e284ac8ee5c@roeck-us.net>
 <alpine.DEB.2.20.1701151817060.3751@hadrien>
 <c0a0b0eb-4573-1dea-385d-85daf02b7d8f@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1701151900320.3751@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I originally didn't want to do that because the actual transformation catches
> both
>
>     fn(&pdev->dev, ...) -> fn(dev, ...)
> and
>     x = &pdev->dev -> x = &dev
>
> but it turns out that was easy to solve.
>
> initfn at p(T *pdev, ...) {
>   ...
>   struct device *d = &pdev->dev;
> <...
> (
> - fn(&pdev->dev, es)
> + fn(d, es)
> |
> - &pdev->dev
> + d
> |
> - pdev->dev.i
> + dev->i
> )
> ...> }

I think that this is not quite perfect.  It will only reformat when
&pdev->dev is the in the first argument, and if &pdev->dev is the first
argument, then it won't transform occurrences of &pdev->dev in other
arguments.  I was thinking to just do the transformation as before, and
then have a separate reformat rule, but the reformat rule should depend on
the rule that does the transformation.  If the transformation doesn't
happen, there is no need for reformatting.

julia
