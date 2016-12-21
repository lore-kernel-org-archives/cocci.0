From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 21 Dec 2016 20:39:38 +0100 (CET)
Subject: [Cocci] Converting DEVICE_ATTR to DEVICE_ATTR_{RO, RW,
 WO} and changing function names at the same time
In-Reply-To: <20161221162926.GB6188@roeck-us.net>
References: <0bcce41c-88ce-09a0-2ddd-5ba2e406d482@roeck-us.net>
 <alpine.DEB.2.20.1612211434221.3084@hadrien>
 <20161221162926.GB6188@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1612212039090.2005@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 21 Dec 2016, Guenter Roeck wrote:

> Hi Julia,
>
> On Wed, Dec 21, 2016 at 03:05:37PM +0100, Julia Lawall wrote:
> > A solution is below: the semantic patch, an explanation of the semantic
> > patch, and the results.  I have only tried to compile the results (make
> > drivers/hwmon/).  Two affected files were not considered for compilation:
> >
> > drivers/hwmon/vexpress-hwmon.o
> > drivers/hwmon/jz4740-hwmon.o
> >
> > All the other affected files obtained .o files with no compiler errors or
> > warnings.
> >
> > There are a few cases that are not handled:
> >
> > 1. Calls like the following, where the attribute name is not an
> > identifier:
> >
> > adm1026.c:static DEVICE_ATTR(temp##offset##_crit_enable, ...)
> >
> > 2.  Calls like the following, where the function name is constructed using
> > a macro:
> >
> > gl518sm.c:static DEVICE_ATTR(in0_min, S_IWUSR|S_IRUGO, show_in_min0,
> > set_in_min1);
> >
> > 3.  Calls, like the following, where a function name is reused:
> >
> > adm1026.c:static DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, pwm1_show,
> > pwm1_store);
> >
> > In the third case, it does treat one use, but not the others.  For
> > example, DEVICE_ATTR_RW(pwm1); is generated in this case.  Another
> > approach would be to do no transformation, ie not transform the pwm1 case
> > as well.
> >
> > It is possible that the transformation will change the number of
> > characters in a function name, causing the parameter or argument list to
> > become unaligned.  The semantic patch thus removes and adds back the
> > argument or parameter list, using the Coccinelle defaults for indentation.
> > This means that the arguments are parameters are lined up with the right
> > side of the (.  Another option would be to leave the argument or parameter
> > list as is.  In particular, it seems that the original code often just
> > puts a few tabs for the continuation line, rather than trying to align the
> > arguments or parameters, so perhaps the Coccinelle defaults are not what
> > is wanted.  It is easy to remove what Coccinelle does, but then some code
> > may need to be adjusted by hand.
> >
> > I haven't checked the resulting patch very carefully, so this is more a
> > request for comments rather than a patch submission.  I can also break up
> > the patch by file or by set of maintainers, if that would be useful.
> >
> This is amazing - thanks a lot! I'll run it through my test system to see
> if it finds any problems.
>
> For a real patch series, it would be great if you can split it up by file.
> This way it would be easier to handle file specific problems later on,
> and/or to apply a patch to an earlier release if it turns out to be necessary
> to backport a subsequent (unrelated) bug fix.

Sure, just let me know when it seems ok.

julia

>
> > I guess it would be easy to adapt all this to the SENSOR case.
> >
> Yes, I hope so. This should give me a pretty good start.
>
> Again, thanks a lot!
>
> Guenter
>
