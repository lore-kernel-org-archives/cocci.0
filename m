From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 22 Dec 2016 10:19:48 -0800
Subject: [Cocci] Converting DEVICE_ATTR to DEVICE_ATTR_{RO, RW,
 WO} and changing function names at the same time
In-Reply-To: <alpine.DEB.2.20.1612221634440.7817@hadrien>
References: <0bcce41c-88ce-09a0-2ddd-5ba2e406d482@roeck-us.net>
 <alpine.DEB.2.20.1612211434221.3084@hadrien>
 <20161221162926.GB6188@roeck-us.net>
 <alpine.DEB.2.20.1612212039090.2005@hadrien>
 <20161221214425.GA2315@roeck-us.net>
 <alpine.DEB.2.20.1612221326060.14381@hadrien>
 <83039af2-7b45-8b1f-d842-85a70b71ba11@roeck-us.net>
 <alpine.DEB.2.20.1612221634440.7817@hadrien>
Message-ID: <20161222181948.GA20516@roeck-us.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Dec 22, 2016 at 04:45:45PM +0100, Julia Lawall wrote:
> 
> 
> On Thu, 22 Dec 2016, Guenter Roeck wrote:
> 
> > On 12/22/2016 04:29 AM, Julia Lawall wrote:
> > >
> > >
> > > On Wed, 21 Dec 2016, Guenter Roeck wrote:
> > >
> > > > Hi Julia,
> > > >
> > > > On Wed, Dec 21, 2016 at 08:39:38PM +0100, Julia Lawall wrote:
> > > > >
> > > > >
> > > > > On Wed, 21 Dec 2016, Guenter Roeck wrote:
> > > > >
> > > > > > Hi Julia,
> > > > > >
> > > > > > On Wed, Dec 21, 2016 at 03:05:37PM +0100, Julia Lawall wrote:
> > > > > > > A solution is below: the semantic patch, an explanation of the
> > > > > > > semantic
> > > > > > > patch, and the results.  I have only tried to compile the results
> > > > > > > (make
> > > > > > > drivers/hwmon/).  Two affected files were not considered for
> > > > > > > compilation:
> > > > > > >
> > > > > > > drivers/hwmon/vexpress-hwmon.o
> > > > > > > drivers/hwmon/jz4740-hwmon.o
> > > >
> > > > I compile tested those two patches. If possible please drop
> > > > vexpress-hwmon.c
> > > > from the patch series; the changes in that file don't add any value.
> > > >
> > > > I compile tested all files, and reviewed the patch. It all looks good.
> > > > Please submit the series.
> > > >
> > > > Again, thanks a lot for your help!
> > >
> > > I have sent the patches.  I adjusted the semantic patch so that the
> > > indentation of function parameters/arguments would only change if the
> > > length of the function name changes.
> > >
> > > Do you think this could be of more general interest in the Linux kernel?
> > > Since the semantic patch works pretty well, I could add it to the
> > > scripts/coccinelle directory?  Previously, however, I got some negative
> > > feedback about this change, because people felt that the new names hid the
> > > actual behavior, so I didn't pursue it.
> > >
> >
> > I do think it would add a lot of value, if for nothing else as an excellent
> > example
> > of what can be done with coccinelle.
> >
> > I actually liked the name changes. I think it is a good idea if the function
> > name
> > reflects the sysfs attribute it serves (isn't that exactly what it does, ie
> > its
> > behavior ?). But, as you have experienced, some people inadvertently did not
> > like
> > it. Given that, I am not sure if it is worth adding it to the kernel source
> > tree.
> > Maybe you could submit it as RFC so it is at least on record.
> >
> > Anyway, for SENSOR_DEVICE_ATTR(), I'll have to be a bit more flexible since
> > the function _will_ be reused. I'll need something like
> > 	SENSOR_DEVICE_ATTR_{RO,RW,WO}(attr, func, param)
> 
> Chosen at random,
> 
> static SENSOR_DEVICE_ATTR_2(sf2_point4_fan1, S_IRUGO | S_IWUSR,
>                         show_sf2_point, store_sf2_point, 4, 1);
> 
> should become
> 
> static SENSOR_DEVICE_ATTR_2_RW(sf2_point4_fan1, sf2_point, 4, 1); ?
> 
> And the functions should be renamed with show and store at the end?
> 
Yes, exactly.  Of course, not all of them use "show_" at the beginning.
get_ and set_ are used as well. Essentially I would want to replace 
	[driver_prefix]{show_,get_,set_}func{_get,_show,_set}
with 'func'.

If you have an idea how to do that, any hints would be welcome.

> > Maybe Greg would be open to something like
> > DEVICE_ATTR_FUNC_{RO,RW,WO}(attr,func)
> > to accommodate the "I want my own function name" crowd ? That would also solve
> > the case where the function is reused for multiple attributes.
> 
> Actually, it was the DEVICE_ATTR_{RO,RW,WO} that wasn't liked.  It doesn't
> show the exact permission numbers.  The fact that not all DEVICE_ATTR uses


It should be obvious that using the {RO,RW,WO} variants is less error prone.
Can anyone seriously argue against that ?

> can be changed due to function reuse is awkward, though.  Greg, do you
> have any thoughts about that?
> 
> Currently, there are around 1100 calls to DEVICE_ATTR_{RO,RW,WO}.
> 

If the problem is that people need to see exact permission numbers instead
of "RO" to understand that an attribute is read only, I think the semantic
patch should really be added to the kernel.

Thanks,
Guenter
