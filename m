From: lennart@poettering.net (Lennart Poettering)
Date: Mon, 23 Jun 2014 15:19:30 +0200
Subject: [Cocci] [systemd-devel] systemd m4 library complex systemd
 example, and coccinelle conversion
In-Reply-To: <CAB=NE6VSdCxNXWa0QsyrqF7iCBSR3vq+r1NJoZrX=-ADdmTvnw@mail.gmail.com>
References: <CAB=NE6VSdCxNXWa0QsyrqF7iCBSR3vq+r1NJoZrX=-ADdmTvnw@mail.gmail.com>
Message-ID: <20140623131930.GA25903@tango.0pointer.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 12.06.14 18:04, Luis R. Rodriguez (mcgrof at do-not-panic.com) wrote:

> Hey folks,
> 
> so I've been working on getting systemd support on xen for a bit now
> and thanks to the last suggestion about the launcher here on
> systemd-devel I think we're on the final stretch now. I'll be
> submitting a v6 PATCH series shortly which I think should be the last
> if not close to the last set we need. It turns out though that I ran
> into quite a few issues though, what I consider corner cases with
> systemd, and in order to help I've tried to put together a simple
> package example source code which exemplifies the complexities I found
> but more importantly provide the resolutions to those issues. At the
> same time xen also is a good example of a complex piece of software
> with multiple OS requirements and on the Linux font you may or may not
> want systemd, it also happened to use autoconf, but not automake, and
> in one iteration of patches I even worked on systemd support with the
> dynamic link loader (dlopen() and dlsym()). Adding proper support for
> systemd into xen turned out to be a bit of a mini project. In order to
> try to help other though I've generalized as much as I can the
> autotools functionality I wrote given I was unable to find a library
> to easily add systemd. I'd like your review of this piece of code and
> wanted to see if perhaps at least the LGPL m4 libraries might be
> welcomed.
> 
>   * src/m4/systemd.m4
> 
>     - AX_ENABLE_SYSTEMD(): enables systemd by default and requires an
>       explicit --disable-systemd option flag to configure if you want to
>       disable systemd support.
> 
>     - AX_ALLOW_SYSTEMD(): systemd will be disabled by default and requires
>       you to run configure with --enable-systemd to look for and enable systemd
> 
>     - AX_AVAILABLE_SYSTEMD(): systemd will be disabled by default but if your
>       build system is detected to have systemd build libraries it will be
>       enabled. You can always force disable with --disable-systemd
> 
>     - If you want to use the dynamic link loader you should use
>       AX_AVAILABLE_SYSTEMD() but must then ensure to use -rdynamic -ldl
>       when linking, if using automake autotools will deal with this for you,
>       otherwise you must ensure this is in place on your Makefile.

Hmm, so, I don't think systemd should really be treated differently from
other pkg-config-enabled modules. What precisely does this add that
pkg-config doesn't support? And wouldn't it be possible to improve
pkg-config upstream instead?

I don't think we want to support the dlsym() stuff in systemd
directly. I mean, if people want to do things like that, that's fine,
but I really doubt we should encourage that from upstream.

Also note that pretty much any Linux distributions (modulo
Gentoo/Slackware) uses systemd already or announced plans to do so, I am
not sure it's worth really investing so much time in making systemd
optional beyond the usual what pkg-config supports.

> Lastly -- I was curious if anyone has looked into writing Coccinelle
> SmPL grammar rules to convert legacy init systems with systemd
> support. I suspect most unix daemons are rather simple and SmPL rules
> might be able to transform quite a bit of them. I don't expect
> Coccinelle might be able to catch the crazy daemons with corner cases
> as with xen, but you never know, coccinelle is always surprising me
> with its capabilities.

Note that distribuitions like Fedora have already pretty much converted
all their daemons (with exceptions), so I figure this in many ways is
too late... 

Thanks,

Lennart

-- 
Lennart Poettering, Red Hat
