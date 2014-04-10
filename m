From: johannes@sipsolutions.net (Johannes Berg)
Date: Thu, 10 Apr 2014 19:51:29 +0200
Subject: [Cocci] [PATCH] coccinelle: add pycocci wrapper for
 multithreaded support
In-Reply-To: <1397152097-315-1-git-send-email-mcgrof@do-not-panic.com>
 (sfid-20140410_194829_100293_32EF0060)
References: <1397152097-315-1-git-send-email-mcgrof@do-not-panic.com>
 (sfid-20140410_194829_100293_32EF0060)
Message-ID: <1397152289.4757.28.camel@jlt4.sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2014-04-10 at 10:48 -0700, Luis R. Rodriguez wrote:

> You just pass it a cocci file, a target dir, and in git environments
> you always want --in-place enabled. Experiments and profiling random
> cocci files with the Linux kernel show that using just using number of
> CPUs doesn't scale well given that lots of buckets of files don't require
> work, as such this uses 10 * number of CPUs for its number of threads.
> For work that define more general ruler 3 * number of CPUs works better,
> but for smaller cocci files 3 * number of CPUs performs best right now.
> To experiment more with what's going on with the multithreading one can enable
> htop while kicking off a cocci task on the kernel, we want to keep
> these CPUs busy as much as possible. 

That's not really a good benchmark, you want to actually check how
quickly it finishes ... If you have some IO issues then just keeping the
CPUs busy trying to do IO won't help at all.


> Since its just a helper I toss it into the python directory but don't
> install it. Hope is that we can evolve it there instead of carrying this
> helper within backports.

If there's a plan to make coccinelle itself multi-threaded, what's the
point?

johannes
