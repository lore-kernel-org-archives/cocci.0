From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 26 Apr 2013 16:52:17 +0300
Subject: [Cocci] junk output
Message-ID: <1366984337.3603.34.camel@sauron.fi.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia, Richard,

not sure if this was already reported, but the latest Fedora 18
coccinelle produces a lot of junk. Just an example using the linux
kernel scripts:

$ spatch -sp_file ./scripts/coccinelle/free/clk_put.cocci drivers/gpio/gpio-sch.c

init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: drivers/gpio/gpio-sch.c
No matches found for clk_get clk_put
Skipping:drivers/gpio/gpio-sch.c
left
left
left
left
left
left
left
right
right
right
right
right
right
left
left
left
left
left
left
left
left
left
left

Notice these lefts and rights.

$ rpm -q coccinelle 
coccinelle-1.0.0-0.rc14.6.fc18.x86_64

Any suggestions?

Thanks!

-- 
Best Regards,
Artem Bityutskiy
