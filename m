From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 18 Oct 2014 07:51:44 +0200
Subject: [Cocci] sgen problems
In-Reply-To: <alpine.DEB.2.02.1410180726100.2049@localhost6.localdomain6>
References: <20141017202400.GA2576@katana>
 <alpine.DEB.2.02.1410180726100.2049@localhost6.localdomain6>
Message-ID: <20141018055143.GA1266@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Oct 18, 2014 at 07:26:53AM +0200, Julia Lawall wrote:
> On Fri, 17 Oct 2014, Wolfram Sang wrote:
> 
> > Hi,
> > 
> > so I was trying to convert my spatch from the platform-owner series to a
> > Kernel-cocci with sgen. However, that didn't work and produced a corrupt
> > cocci file (at least the name of the matching rules has been eaten). I
> > used a self-compiled sgen from the Debian rc22. I attach the cocci and
> > config file for easier reproducing. Does the sgen author read the list?
> > Probably it would be easy to fix the broken file, but it seems more
> > sustainable to me to fix the tool :)
> 
> Two patches are attached.  Apply p1 and then p2.

Yay, this looks a lot better now. Thanks! I applied the output, looks
reasonable to me. Do you think it is okay, too? I am not sure about the
confidence level. It is a simple patch, so maybe it could be high as
well?

Thanks,

   Wolfram

===

/// Remove .owner field if calls are used which set it automatically
///
// Confidence: Moderate
// Copyright: (C) 2014 Wolfram Sang. GPL v2.

virtual patch
virtual context
virtual org
virtual report

@match1@
declarer name module_platform_driver;
declarer name module_platform_driver_probe;
identifier __driver;
@@
(
	module_platform_driver(__driver);
|
	module_platform_driver_probe(__driver, ...);
)

@fix1 depends on match1 && patch && !context && !org && !report@
identifier match1.__driver;
@@
	static struct platform_driver __driver = {
		.driver = {
-			.owner = THIS_MODULE,
		}
	};

@match2@
identifier __driver;
@@
(
	platform_driver_register(&__driver)
|
	platform_driver_probe(&__driver, ...)
|
	platform_create_bundle(&__driver, ...)
)

@fix2 depends on match2 && patch && !context && !org && !report@
identifier match2.__driver;
@@
	static struct platform_driver __driver = {
		.driver = {
-			.owner = THIS_MODULE,
		}
	};

// ----------------------------------------------------------------------------

@fix1_context depends on match1 && !patch && (context || org || report)@
identifier match1.__driver;
position j0;
@@

* 	static struct platform_driver __driver at j0 = {
		.driver = {
			.owner = THIS_MODULE,
		}
	};

@fix2_context depends on match2 && !patch && (context || org || report)@
identifier match2.__driver;
position j0;
@@

* 	static struct platform_driver __driver at j0 = {
		.driver = {
			.owner = THIS_MODULE,
		}
	};

// ----------------------------------------------------------------------------

@script:python fix1_org depends on org@
j0 << fix1_context.j0;
@@

msg = "No need to set .owner here. The core will do it."
coccilib.org.print_todo(j0[0], msg)

@script:python fix2_org depends on org@
j0 << fix2_context.j0;
@@

msg = "No need to set .owner here. The core will do it."
coccilib.org.print_todo(j0[0], msg)

// ----------------------------------------------------------------------------

@script:python fix1_report depends on report@
j0 << fix1_context.j0;
@@

msg = "No need to set .owner here. The core will do it."
coccilib.report.print_report(j0[0], msg)

@script:python fix2_report depends on report@
j0 << fix2_context.j0;
@@

msg = "No need to set .owner here. The core will do it."
coccilib.report.print_report(j0[0], msg)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141018/ec1384d7/attachment.asc>
