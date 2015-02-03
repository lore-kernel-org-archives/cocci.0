From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 3 Feb 2015 19:59:09 +0100 (CET)
Subject: [Cocci] Some spatch questions
In-Reply-To: <87a90vhr95.fsf@rasmusvillemoes.dk>
References: <87a90vhr95.fsf@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.10.1502031953400.4323@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 3 Feb 2015, Rasmus Villemoes wrote:

> Hi Julia et al
>
> As you may have seen, I've put a bunch of coccinelle scripts on github
> (https://github.com/Villemoes/linux-cocci); I still have some more I
> want to clean up before making them public.
>
> Now, I'm having some trouble with some of these. For the sake of
> threading [and because this turned out to be rather long], I'll try to
> just post one question per thread.
>
> The first is a performance problem. I wrote a perl script pcoc
> (pronounced 'peacock', found in the root of the repository) to overcome
> a few problems with the 'make coccicheck' approach:
>
> (1) I've often seen garbled output, since nothing coordinates the access
> to stdout between the spatch instances. That's especially annoying when
> it took several minutes to complete.
> (2) The output is not neatly sorted by subsystem, so running 'git apply
> --stat' can't be used to get an overview of where there's most to gain.
> (3) It's not easily applicable for projects other than the kernel.
> (4) I grew tired of typing "make coccicheck COCCI=/some/file.cocci MODE=patch
> M=sub/system/"; bash completion couldn't help with most of this. I
> wanted to be able to just say 'pcoc /some/file.cocci sub/system/'.
>
> As such, it works perfectly. But I've noticed something slightly
> odd: The time required sometimes scales almost linearly with the number
> of files each spatch instance is given; also, the memory use as seen in
> top goes through the roof. If anything, I would expect the total time to
> go down if each instance handles more files (since the semantic patch
> would need to be parsed fewer times).

OK, I'm not sure to understand everything the script does, but could it be
that you are passing all of the file names individually on the command
line?   That is, are you trying to do something like

spatch foo.cocci one.c two.c three.c four.c

If that is the case, then the memory usage is normal.  Putting multiple
files on the command line means that you want them all to be handled at
once.  For example, there may be some function in one.c whose properties
should influence the transformation of four.c.  So it holds the parsed
versions of all of the files in memory at once.

Fortunately, we have finally implemented parallelism inside Coccinelle.
If you take version 1.0.0-rc24 from the web page, which I haven't had time
to properly announce, you can use the argument -j NNN with spatch on a
complete directory and it will work on the different files in parallel
(with NNN instances).  The name of the semantic patch without an extension
will be used as a temporary directory to hold the intermediate results.
In the end, the complete output will be printed on standard output, and
the complete errors will be printed on standard error.  There will be no
mixing of results.

julia


> For example, running
>
>   pcoc ~/projects/linux-cocci/wtf/ifelse.cocci --mode=context fs/ --popt '-L 100'
>
> takes 55 seconds on my 8-core machine (with total time being 5m15.900s),
> while
>
>   pcoc ~/projects/linux-cocci/wtf/ifelse.cocci --mode=context fs/ --popt '-L 50'
>
> takes 34 seconds (total time 3m51.802s).
>
> In the former case, I see one of the spatch instances reach over 1G of
> memory before finishing. When I do the equivalent
>
>   make coccicheck COCCI=~/projects/linux-cocci/wtf/ifelse.cocci MODE=context M=fs/
>
> it finishes in 28 seconds (2m32.598s total user time), and no spatch
> instance uses more than 200 M of memory.
>
> The only thing I can imagine would explain this is that when one passes
> files explicitly on the command line, there is some ever-growing data
> structure which is repeatedly traversed. Is this is a bug in spatch or
> in my use of the tool? Is there a work-around?
>
> Best,
> Rasmus
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
