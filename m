From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Thu, 3 Dec 2015 20:26:31 +0100
Subject: [Cocci] how to find missing initializer
In-Reply-To: <56603DC3.8040609@hurleysoftware.com>
References: <56603DC3.8040609@hurleysoftware.com>
Message-ID: <20151203192631.GA20409@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Dec 03, 2015 at 08:04:03AM -0500, Peter Hurley wrote:
> Hi all,
> 
> I'm struggling with the grammar necessary to find struct definitions
> missing an initializer.
> 
> The background is that many tty interfaces include a method/operations
> table (named fields of function ptrs). For example, given a declaration
> like,
> 
>     struct tty_operations {
>             int (*install)( /* ... */ );
>             int (*remove)( /* ... */ );
>             void (*cleanup)( /* ... * );
>     ...
>     };
> 
> a tty driver might define its method table like,
> 
>     static const struct tty_operations ops = {
>             .install = uart_install,
> 	    .remove = uart_remove,
>             .cleanup = uart_cleanup,
>     ...
>     };
> 
> 
> (actually, this is a common pattern throughout the kernel)
> 
> Many operations are optional; a NULL method is simply not executed.
> For example,
> 
>     if (tty->ops->cleanup)
>             tty->ops->cleanup(tty);
> 
> So trying to find those in-tree drivers which _do not_ define a cleanup
> method with coccinelle, led to this fragment which has a parse error.
> 
> Apologies if my question is obvious or trivial; I'm still learning
> coccinelle.
> 
> Regards,
> Peter Hurley
> 
> --- >% ---
> virtual context
> 
> @ depends on context @
> identifier fops;
> identifier fn;
> @@
> * struct tty_operations fops = {
>   ... when != .cleanup = fn,
> ...
> };

I think you need to use an identifier for the callback routine name but I could
be wrong. There's two ways I would do this, one with context as you originally
used, and the second with python. Results for missing tty driver without
cleanup below, and after that, the ones that do have a cleanup callback.

The way I like to think of these hunts is first doing a needle in the haystack
search, and then tooling around that.

drivers/tty/synclink.c:4305:35-43: ERROR: tty driver with missing cleanup callback line 4305.
drivers/tty/metag_da.c:561:35-46: ERROR: tty driver with missing cleanup callback line 561.
drivers/tty/serial/serial_core.c:2341:35-43: ERROR: tty driver with missing cleanup callback line 2341.
drivers/tty/synclinkmp.c:3890:35-38: ERROR: tty driver with missing cleanup callback line 3890.
drivers/tty/ipwireless/tty.c:562:35-42: ERROR: tty driver with missing cleanup callback line 562.
drivers/tty/serial/68328serial.c:1133:35-41: ERROR: tty driver with missing cleanup callback line 1133.
drivers/tty/serial/crisv10.c:4144:35-41: ERROR: tty driver with missing cleanup callback line 4144.
drivers/tty/amiserial.c:1633:35-45: ERROR: tty driver with missing cleanup callback line 1633.
drivers/tty/synclink_gt.c:3725:35-38: ERROR: tty driver with missing cleanup callback line 3725.
drivers/tty/vt/vt.c:3028:35-42: ERROR: tty driver with missing cleanup callback line 3028.
drivers/tty/goldfish.c:170:35-51: ERROR: tty driver with missing cleanup callback line 170.
drivers/tty/serial/ifx6x60.c:613:35-53: ERROR: tty driver with missing cleanup callback line 613.
drivers/tty/mips_ejtag_fdc.c:872:35-57: ERROR: tty driver with missing cleanup callback line 872.
drivers/tty/rocket.c:2347:35-45: ERROR: tty driver with missing cleanup callback line 2347.
drivers/tty/ehv_bytechan.c:592:35-45: ERROR: tty driver with missing cleanup callback line 592.
drivers/tty/mxser.c:2317:35-44: ERROR: tty driver with missing cleanup callback line 2317.
drivers/tty/isicom.c:1282:35-45: ERROR: tty driver with missing cleanup callback line 1282.
drivers/tty/hvc/hvsi.c:1039:35-43: ERROR: tty driver with missing cleanup callback line 1039.
drivers/tty/bfin_jtag_comm.c:213:35-46: ERROR: tty driver with missing cleanup callback line 213.
drivers/tty/cyclades.c:4035:35-41: ERROR: tty driver with missing cleanup callback line 4035.
drivers/tty/moxa.c:408:35-43: ERROR: tty driver with missing cleanup callback line 408.

A similar rule that catches the ones with a cleanup callback:

drivers/tty/nozomi.c:1867:35-42: ERROR: tty driver with cleanup callback line 1867.
drivers/tty/hvc/hvc_console.c:835:35-42: ERROR: tty driver with cleanup callback line 835.
drivers/tty/n_gsm.c:3183:35-45: ERROR: tty driver with cleanup callback line 3183.
drivers/tty/serial/kgdb_nmi.c:319:35-51: ERROR: tty driver with cleanup callback line 319.
drivers/tty/hvc/hvcs.c:1442:35-43: ERROR: tty driver with cleanup callback line 1442.
drivers/tty/pty.c:510:35-53: ERROR: tty driver with cleanup callback line 510.
drivers/tty/pty.c:684:35-49: ERROR: tty driver with cleanup callback line 684.
drivers/tty/pty.c:701:35-49: ERROR: tty driver with cleanup callback line 701.
drivers/tty/pty.c:525:35-52: ERROR: tty driver with cleanup callback line 525.

It'd be nice to just do:

virtual context                                                                 
                                                                                
@ is_tty @                                                                      
identifier fops;                                                                
@@                                                                              
struct tty_operations fops = {                                                  
        ...                                                                     
};                                                                              
                                                                                
@ tty_has_cleanup depends on is_tty && context @                                
identifier is_tty.fops;                                                         
identifier fn;                                                                  
identifier tty_op =~ "(cleanup)";                                               
@@                                                                              
* struct tty_operations fops = {                                                
  ... when !=  .tty_op = fn,                                                    
}; 

But that does not seem to parse.

The context rule that worked:

virtual context

@ is_tty @                                                                                                                                                          
identifier fops;                                                                                                                                                                
@@                                                                                                                                                                              
struct tty_operations fops = {                                                                                                                                                
	...
};

@ tty_has_cleanup depends on is_tty @
identifier is_tty.fops;
identifier fn;
identifier tty_op =~ "(cleanup)";
@@
struct tty_operations fops = {
	.tty_op = fn,
};

@ depends on is_tty && !tty_has_cleanup && context @
identifier is_tty.fops;
@@
* struct tty_operations fops = {
	... 
};

----

then the one with python:

virtual report
virtual context

@ is_tty @
identifier fops;
position p1;
@@                                                                                                                                                                              
struct tty_operations fops at p1 = {
	...
};

@ tty_has_cleanup depends on is_tty @
identifier is_tty.fops;
identifier fn;
identifier tty_op =~ "(cleanup)";
@@
struct tty_operations fops = {
	.tty_op = fn,
};

@script:python depends on is_tty && !tty_has_cleanup && report @
p1 << is_tty.p1;                                                      
@@

msg="ERROR: tty driver with missing cleanup callback line %s." % (p1[0].line)
coccilib.report.print_report(p1[0], msg)

--

Perhaps there are better ways.

  Luis
