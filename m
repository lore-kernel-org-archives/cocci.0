From: rjones@redhat.com (Richard W.M. Jones)
Date: Fri, 26 Apr 2013 14:57:30 +0100
Subject: [Cocci] junk output
In-Reply-To: <1366984337.3603.34.camel@sauron.fi.intel.com>
References: <1366984337.3603.34.camel@sauron.fi.intel.com>
Message-ID: <20130426135730.GE1381@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Apr 26, 2013 at 04:52:17PM +0300, Artem Bityutskiy wrote:
> Hi Julia, Richard,
> 
> not sure if this was already reported, but the latest Fedora 18
> coccinelle produces a lot of junk. Just an example using the linux
> kernel scripts:
> 
> $ spatch -sp_file ./scripts/coccinelle/free/clk_put.cocci drivers/gpio/gpio-sch.c
> 
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: drivers/gpio/gpio-sch.c
> No matches found for clk_get clk_put
> Skipping:drivers/gpio/gpio-sch.c
> left
> left
> left
[...]

I can confirm this happens.  I have filed a bug:

https://bugzilla.redhat.com/show_bug.cgi?id=957169

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
