From: peter@hurleysoftware.com (Peter Hurley)
Date: Thu, 3 Dec 2015 08:04:03 -0500
Subject: [Cocci] how to find missing initializer
Message-ID: <56603DC3.8040609@hurleysoftware.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi all,

I'm struggling with the grammar necessary to find struct definitions
missing an initializer.

The background is that many tty interfaces include a method/operations
table (named fields of function ptrs). For example, given a declaration
like,

    struct tty_operations {
            int (*install)( /* ... */ );
            int (*remove)( /* ... */ );
            void (*cleanup)( /* ... * );
    ...
    };

a tty driver might define its method table like,

    static const struct tty_operations ops = {
            .install = uart_install,
	    .remove = uart_remove,
            .cleanup = uart_cleanup,
    ...
    };


(actually, this is a common pattern throughout the kernel)

Many operations are optional; a NULL method is simply not executed.
For example,

    if (tty->ops->cleanup)
            tty->ops->cleanup(tty);

So trying to find those in-tree drivers which _do not_ define a cleanup
method with coccinelle, led to this fragment which has a parse error.

Apologies if my question is obvious or trivial; I'm still learning
coccinelle.

Regards,
Peter Hurley

--- >% ---
virtual context

@ depends on context @
identifier fops;
identifier fn;
@@
* struct tty_operations fops = {
  ... when != .cleanup = fn,
...
};
