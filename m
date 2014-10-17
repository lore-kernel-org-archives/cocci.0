From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 17 Oct 2014 22:24:00 +0200
Subject: [Cocci] sgen problems
Message-ID: <20141017202400.GA2576@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

so I was trying to convert my spatch from the platform-owner series to a
Kernel-cocci with sgen. However, that didn't work and produced a corrupt
cocci file (at least the name of the matching rules has been eaten). I
used a self-compiled sgen from the Debian rc22. I attach the cocci and
config file for easier reproducing. Does the sgen author read the list?
Probably it would be easy to fix the broken file, but it seems more
sustainable to me to fix the tool :)

Thanks,

   Wolfram

-------------- next part --------------
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

@fix1 depends on match1@
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

@fix2 depends on match2@
identifier match2.__driver;
@@
	static struct platform_driver __driver = {
		.driver = {
-			.owner = THIS_MODULE,
		}
	};
-------------- next part --------------
// Generated config
description = Remove .owner field if calls are used which set it automatically
confidence = Moderate
authors = Wolfram Sang. GPL v2.
fix2 =
  org:"No need to set .owner here"
  report:"No need to set .owner here"
fix1 =
  org:"No need to set .owner here"
  report:"No need to set .owner here"
-------------- next part --------------
/// Remove .owner field if calls are used which set it automatically
///
// Confidence: Moderate
// Copyright: (C) 2014 Wolfram Sang. GPL v2.

virtual patch
virtual context
virtual org
virtual report

@declarer name module_platform_driver;
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

@identifier __driver;
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

msg = "No need to set .owner here."
coccilib.org.print_todo(j0[0], msg)

@script:python fix2_org depends on org@
j0 << fix2_context.j0;
@@

msg = "No need to set .owner here."
coccilib.org.print_todo(j0[0], msg)

// ----------------------------------------------------------------------------

@script:python fix1_report depends on report@
j0 << fix1_context.j0;
@@

msg = "No need to set .owner here."
coccilib.report.print_report(j0[0], msg)

@script:python fix2_report depends on report@
j0 << fix2_context.j0;
@@

msg = "No need to set .owner here."
coccilib.report.print_report(j0[0], msg)
