From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 21 Dec 2016 13:44:25 -0800
Subject: [Cocci] Converting DEVICE_ATTR to DEVICE_ATTR_{RO, RW,
 WO} and changing function names at the same time
In-Reply-To: <alpine.DEB.2.20.1612212039090.2005@hadrien>
References: <0bcce41c-88ce-09a0-2ddd-5ba2e406d482@roeck-us.net>
 <alpine.DEB.2.20.1612211434221.3084@hadrien>
 <20161221162926.GB6188@roeck-us.net>
 <alpine.DEB.2.20.1612212039090.2005@hadrien>
Message-ID: <20161221214425.GA2315@roeck-us.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On Wed, Dec 21, 2016 at 08:39:38PM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 21 Dec 2016, Guenter Roeck wrote:
> 
> > Hi Julia,
> >
> > On Wed, Dec 21, 2016 at 03:05:37PM +0100, Julia Lawall wrote:
> > > A solution is below: the semantic patch, an explanation of the semantic
> > > patch, and the results.  I have only tried to compile the results (make
> > > drivers/hwmon/).  Two affected files were not considered for compilation:
> > >
> > > drivers/hwmon/vexpress-hwmon.o
> > > drivers/hwmon/jz4740-hwmon.o

I compile tested those two patches. If possible please drop vexpress-hwmon.c
from the patch series; the changes in that file don't add any value.

I compile tested all files, and reviewed the patch. It all looks good.
Please submit the series.

Again, thanks a lot for your help!

Guenter
