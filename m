From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 3 Sep 2015 07:56:33 +0200 (CEST)
Subject: [Cocci] [RFC] firmware: annotate thou shalt not request fw on
 init or probe
In-Reply-To: <20150903013533.GO8051@wotan.suse.de>
References: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
 <alpine.DEB.2.02.1508291812350.2057@localhost6.localdomain6>
 <20150903013533.GO8051@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1509030753140.2037@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 3 Sep 2015, Luis R. Rodriguez wrote:

> On Sat, Aug 29, 2015 at 06:18:20PM +0200, Julia Lawall wrote:
> > > +@ defines_module_init exists @
> > > +declarer name module_init;
> > > +identifier init;
> > > +@@
> > > +
> > > +module_init(init);
> > > +
> > > +@ has_probe depends on defines_module_init @
> > > +identifier drv_calls, drv_probe;
> > > +type bus_driver;
> > > +identifier probe_op =~ "(probe)";
> > > +@@
> > > +
> > > +bus_driver drv_calls = {
> > > +	.probe_op = drv_probe,
> > > +};
> > 
> > I'm not sure that this is enough.  For example, there is the macro
> > platform_driver_probe that initializes probe fields.  There is likewise
> > module_platform_driver, which is a top-level declaration that encapsulates
> > the module_init and the definition of the module_init function, which in
> > turn calls platform_driver_probe.  There is also module_platform_driver,
> > which encapsulates the module_init, but not the initialization of the probe
> > field.  Are you concerned with any of these cases?
> 
> Yes, and also it would seem this would only capture simple one level of
> routine indirection, for instance if probe called bar() and it was within
> bar() that the driver code called a fw request call, that would not be picked
> up, correct?

By default, Coccinelle is not interprocedural.  You can encode that in the 
script, though.

Probably the most convenient approach would be to start with the the call, 
and then work backward to the entry point.  I have code to do this, if and 
when it turns out to be useful.

julia


> If true then the hunt is yet even more complex. The discussion that prompted me
> to send this is still unfolding though [0] and it seems we may want to allow
> for these type of calls within probe in the end but in order to vet for drivers
> that fw is available through the direct filesystem lookup we may need help from
> userspace. As that discussion unfolds it will be good to keep in mind what
> effort we'd need to hunt all users down for now.
> 
> [0] http://lkml.kernel.org/r/CAB=NE6UBRa0K7=PomJzKxsoj4GzAqkYrkp=O+UfVvu2fwM25pA at mail.gmail.com
> 
>   Luis
> 
