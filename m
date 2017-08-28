From: keescook@google.com (Kees Cook)
Date: Sun, 27 Aug 2017 23:15:09 -0700
Subject: [Cocci] Automatic replacement of function declarations
Message-ID: <CAGXu5jKhUYEMLNvmStT-x-h4UKKQkuEpFVxn4H8PPVfecUnzqg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

 Hi,

So, I noticed that if I replace argument types in a function,
coccinelle will normally replace them in any forward declarations too.
However, this:

@change_callback
 depends on patch@
identifier _callback;
type _origtype;
identifier _origarg;
type _handletype;
identifier _handle;
@@

 void _callback(
-_origtype _origarg
+struct timer_list *t
 )
 {
        ... when != _origarg
        _handletype *_handle =
-(_handletype *)_origarg;
+TIMER_CONTAINER(_handle, t, timer);
        ... when != _origarg
 }

run against drivers/net/wireless/ray_cs.c will fix join_net and
start_net correctly:

-static void join_net(u_long local);
-static void start_net(u_long local);
+static void join_net(struct timer_list *t);
+static void start_net(struct timer_list *t);

but misses  verify_dl_startup and authenticate_timeout.

The difference is the latter have forward declarations without an argument name:

static void authenticate_timeout(u_long);
static void verify_dl_startup(u_long);

Is this a bug, or did I write my rule in some way that excludes these
forward declarations?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
