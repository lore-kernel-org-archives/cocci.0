From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Thu, 12 Jun 2014 18:04:03 -0700
Subject: [Cocci] systemd m4 library complex systemd example,
	and coccinelle conversion
Message-ID: <CAB=NE6VSdCxNXWa0QsyrqF7iCBSR3vq+r1NJoZrX=-ADdmTvnw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hey folks,

so I've been working on getting systemd support on xen for a bit now
and thanks to the last suggestion about the launcher here on
systemd-devel I think we're on the final stretch now. I'll be
submitting a v6 PATCH series shortly which I think should be the last
if not close to the last set we need. It turns out though that I ran
into quite a few issues though, what I consider corner cases with
systemd, and in order to help I've tried to put together a simple
package example source code which exemplifies the complexities I found
but more importantly provide the resolutions to those issues. At the
same time xen also is a good example of a complex piece of software
with multiple OS requirements and on the Linux font you may or may not
want systemd, it also happened to use autoconf, but not automake, and
in one iteration of patches I even worked on systemd support with the
dynamic link loader (dlopen() and dlsym()). Adding proper support for
systemd into xen turned out to be a bit of a mini project. In order to
try to help other though I've generalized as much as I can the
autotools functionality I wrote given I was unable to find a library
to easily add systemd. I'd like your review of this piece of code and
wanted to see if perhaps at least the LGPL m4 libraries might be
welcomed.

  * src/m4/systemd.m4

    - AX_ENABLE_SYSTEMD(): enables systemd by default and requires an
      explicit --disable-systemd option flag to configure if you want to
      disable systemd support.

    - AX_ALLOW_SYSTEMD(): systemd will be disabled by default and requires
      you to run configure with --enable-systemd to look for and enable systemd

    - AX_AVAILABLE_SYSTEMD(): systemd will be disabled by default but if your
      build system is detected to have systemd build libraries it will be
      enabled. You can always force disable with --disable-systemd

    - If you want to use the dynamic link loader you should use
      AX_AVAILABLE_SYSTEMD() but must then ensure to use -rdynamic -ldl
      when linking, if using automake autotools will deal with this for you,
      otherwise you must ensure this is in place on your Makefile.

  * src/m4/paths.m4 - AX_LOCAL_EXPAND_CONFIG() path expansion helper
    Helper to allow us to use @VAR@ replacements with AC_CONFIG_FILES() on the
    Makefiles and target service unit files. This is particularly useful for
    systemd deaemons using autotools given that systemd ExectStart does not
    allow variables to be used for the binary specification. AC_CONFIG_FILES()
    will only parse variables already set with AC_SUBST(), this requires
    expansion on some variables that depend on $(prefix) but this isn't set
    until after running configure, so preset that variable with the autoconf
    default. To use this expansion helper just call AX_LOCAL_EXPAND_CONFIG()
    after AC_PROG_CC() and before AC_OUTPUT(). Note that although this example
    doesn't use AC_CONFIG_FILES() substituations on c / header files this is
    is indeed appropriate for some cases, in funkd' case it should be using
    it for the /var/run/funkd/ socket path.

The example code also then provides example code of how to use with
with automake, and just autoconf, it also provides an example
implementation for both for using the shared libraries and also using
the dynamic link loader. It also provides an example use case of
multiple daemon options, and multiple sockets with different
permissions on them, all of which I had to handle for xen.

Lastly -- I was curious if anyone has looked into writing Coccinelle
SmPL grammar rules to convert legacy init systems with systemd
support. I suspect most unix daemons are rather simple and SmPL rules
might be able to transform quite a bit of them. I don't expect
Coccinelle might be able to catch the crazy daemons with corner cases
as with xen, but you never know, coccinelle is always surprising me
with its capabilities.

Finally the code:

https://github.com/mcgrof/funk-systemd

  Luis
