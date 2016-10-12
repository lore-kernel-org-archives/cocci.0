From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 12 Oct 2016 22:37:10 +0200 (CEST)
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <87a8e9zjtg.fsf@thinkpad.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien> <8760p3jwr3.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610080727090.3176@hadrien>
 <87ponay35u.fsf@vostro.rath.org> <alpine.DEB.2.10.1610082317180.3373@hadrien>
 <87wphhz1x5.fsf@vostro.rath.org> <alpine.DEB.2.10.1610100653510.3148@hadrien>
 <877f9gqjsn.fsf@vostro.rath.org> <87shs4oxeh.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610102144590.3438@hadrien>
 <87k2dfq4i8.fsf@vostro.rath.org> <alpine.DEB.2.10.1610102329470.3438@hadrien>
 <87h98jq06v.fsf@vostro.rath.org> <alpine.DEB.2.10.1610110848320.3322@hadrien>
 <87a8e9zjtg.fsf@thinkpad.rath.org>
Message-ID: <alpine.DEB.2.10.1610122235060.3412@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 12 Oct 2016, Nikolaus Rath wrote:

> On Oct 11 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > On Mon, 10 Oct 2016, Nikolaus Rath wrote:
> >
> >> On Oct 10 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >> >> Ok, we're getting there. I've removed the second 'symbol' line, and
> >> >> (permanently) updated to 1.0.6. However, now it seems to simply run
> >> >> forever:
> >> >>
> >> >> $ ../coccinelle-1.0.6/spatch.opt --sp-file
> >> >> ~/in-progress/libfuse/se-rename.cocci --in-place lib/ include/ test/
> >> >> example/ util/
> >> >> init_defs_builtins: /home/nikratio/tmp/coccinelle-1.0.6/standard.h
> >> >> warning: patch output can only be created when only one
> >> >> directory is specified or when the -patch flag is used
> >> >> HANDLING: lib/fuse.c
> >> >> (ONCE) Expected tokens fuse_session f
> >> >> Skipping:lib/fuse_opt.c
> >> >> HANDLING: lib/helper.c
> >> >> Skipping:lib/mount_bsd.c
> >> >> Skipping:lib/fuse_loop_mt.c
> >> >> Skipping:lib/fuse_loop.c
> >> >> HANDLING: lib/cuse_lowlevel.c
> >> >> diff =
> >> >> [...]
> >> >> HANDLING: lib/fuse_lowlevel.c
> >> >>
> >> >> At this point it has been hanging for about 15 minutes now, steady
> >> >> eating CPU time.
> >> >>
> >> >> Is it supposed to take that long? The fuse_lowlevel.c file is 74k with
> >> >> 2465 lines of code.
> >> >
> >> > You can use --show-trying to see what function it is getting stuck on.  If
> >> > the function has a lot of ifs and loops, it may indeed take a long
> >> > time.  ... follows possible paths in the execution graph and a sequence of
> >> > ifs makes the number of paths grow exponentially.
> >> >
> >> > A solution is to add a timeout, eg --timeout 120 (120 seconds).  You will
> >> > need to check a file on which there is a timeout manually.
> >> >
> >> > Tracing paths around loops is not really relevant in your case, so you can
> >> > also safely use the option --no-loops, which will avoid taking the back
> >> > edges.
> >>
> >> I tried doing both, but it still gets stuck:
> >>
> >> init_defs_builtins: /home/nikratio/tmp/coccinelle-1.0.6/standard.h
> >> HANDLING: lib/fuse_lowlevel.c
> >> -----------------------------------------------------------------------
> >> rule starting on line 1 =
> >> -----------------------------------------------------------------------
> >> [...]
> >> -----------------------------------------------------------------------
> >> rule starting on line 13 =
> >> -----------------------------------------------------------------------
> >> [...]
> >>    trying function: do_init: fuse_lowlevel.c:1812
> >>
> >>
> >> The do_init() function doesn't seem all that terrible to me though:
> >> https://github.com/libfuse/libfuse/blob/58273972f0b20/lib/fuse_lowlevel.c#L1812
> >
> > Yes it does.  Look at lines 1852-1877.  There are 2^13 execution paths
> > there, and there is another such stack of ifs later in the function.
> >
> > So you did add a timeout and it is still getting stuck?  Try a very short
> > timeout just to see what happens.
>
> Sorry for the confusion. No, when I add the timeout then it aborts. But
> I thought that with --no-loops it would not trace out all the different
> paths and should complete more quickly.

--no-loops just eliminates the back edges of loops.  That is not your
problem, so it won't help.

> Also, it seems that with --timeout it aborts completely (instead of just
> going to the next function):
>
>      trying function: do_fallocate: fuse_lowlevel.c:1798
>      trying function: do_init: fuse_lowlevel.c:1812
> timeout (we abort)
> Fatal error: exception Common.Timeout
>
> $
>
> Is that intended?

Yes.  In general, there can be (both positive and negative) dependencies
between rules, and incompletely processing one function could lead to an
inconsistent state.  Coccinelle could perhaps analyze the dependencies in
the specific semantic patch at hand, and firgure out whether there could
be a problem, but for now it doesn't do that.

julia
