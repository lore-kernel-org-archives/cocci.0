From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 22 Dec 2016 13:29:57 +0100 (CET)
Subject: [Cocci] Converting DEVICE_ATTR to DEVICE_ATTR_{RO, RW,
 WO} and changing function names at the same time
In-Reply-To: <20161221214425.GA2315@roeck-us.net>
References: <0bcce41c-88ce-09a0-2ddd-5ba2e406d482@roeck-us.net>
 <alpine.DEB.2.20.1612211434221.3084@hadrien>
 <20161221162926.GB6188@roeck-us.net>
 <alpine.DEB.2.20.1612212039090.2005@hadrien>
 <20161221214425.GA2315@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1612221326060.14381@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 21 Dec 2016, Guenter Roeck wrote:

> Hi Julia,
>
> On Wed, Dec 21, 2016 at 08:39:38PM +0100, Julia Lawall wrote:
> >
> >
> > On Wed, 21 Dec 2016, Guenter Roeck wrote:
> >
> > > Hi Julia,
> > >
> > > On Wed, Dec 21, 2016 at 03:05:37PM +0100, Julia Lawall wrote:
> > > > A solution is below: the semantic patch, an explanation of the semantic
> > > > patch, and the results.  I have only tried to compile the results (make
> > > > drivers/hwmon/).  Two affected files were not considered for compilation:
> > > >
> > > > drivers/hwmon/vexpress-hwmon.o
> > > > drivers/hwmon/jz4740-hwmon.o
>
> I compile tested those two patches. If possible please drop vexpress-hwmon.c
> from the patch series; the changes in that file don't add any value.
>
> I compile tested all files, and reviewed the patch. It all looks good.
> Please submit the series.
>
> Again, thanks a lot for your help!

I have sent the patches.  I adjusted the semantic patch so that the
indentation of function parameters/arguments would only change if the
length of the function name changes.

Do you think this could be of more general interest in the Linux kernel?
Since the semantic patch works pretty well, I could add it to the
scripts/coccinelle directory?  Previously, however, I got some negative
feedback about this change, because people felt that the new names hid the
actual behavior, so I didn't pursue it.

julia
