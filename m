From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 3 Feb 2015 22:57:55 +0100 (CET)
Subject: [Cocci] Some spatch questions
In-Reply-To: <877fvyvf43.fsf@rasmusvillemoes.dk>
References: <87a90vhr95.fsf@rasmusvillemoes.dk>
 <alpine.DEB.2.10.1502031953400.4323@hadrien>
 <877fvyvf43.fsf@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.02.1502032253390.2026@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 3 Feb 2015, Rasmus Villemoes wrote:

> On Tue, Feb 03 2015, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> > OK, I'm not sure to understand everything the script does, but could it be
> > that you are passing all of the file names individually on the command
> > line?   That is, are you trying to do something like
> >
> > spatch foo.cocci one.c two.c three.c four.c
> >
> 
> Yes, that's how GNU parallel works (it's mostly xargs with lots of bells
> and whistles), and the only way I could find to pass files to spatch
> without letting it discover the files itself.
> 
> > If that is the case, then the memory usage is normal.  Putting
> > multiple files on the command line means that you want them all to be
> > handled at once.  For example, there may be some function in one.c
> > whose properties should influence the transformation of four.c.  So it
> > holds the parsed versions of all of the files in memory at once.
> 
> That kind of makes sense. But I would very much like an option to turn
> off that behaviour, and make it process each file individually.
> 
> > Fortunately, we have finally implemented parallelism inside
> > Coccinelle.  If you take version 1.0.0-rc24 from the web page, which I
> > haven't had time to properly announce, you can use the argument -j NNN
> > with spatch on a complete directory and it will work on the different
> > files in parallel (with NNN instances).
> 
> Sounds good, but I think it would be nice with a somewhat more flexible
> way of choosing the files to process, the most obvious being passing the
> files explicitly, and for that an option as above seems to be absolutely
> essential if one passes more than around 100 files. Moreover, I will
> probably continue to use a wrapper script around spatch, to handle
> tedious things such as passing appropriate -I options, extracting the //
> Options: line etc. Handling the parallelism in that wrapper is then no
> big deal.

The advantage of the new solution is that it does dynamic scheduling.  So 
you don't get a bunch of files that are stuck behind one slow one.

I can add an option to give the behavior you want, though.

julia
