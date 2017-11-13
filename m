From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 13 Nov 2017 17:44:04 +0100 (CET)
Subject: [Cocci] [PATCH v2] coccinelle: fix parallel build with
 CHECK=scripts/coccicheck
In-Reply-To: <CAK7LNATBizoVPcvAodovEtPVzo3pKq20Ps5qNtzuOiD043rYwg@mail.gmail.com>
References: <1510210850-28866-1-git-send-email-yamada.masahiro@socionext.com>
 <alpine.DEB.2.20.1711101634225.3187@hadrien>
 <alpine.DEB.2.20.1711110826330.2161@hadrien>
 <CAK7LNATBizoVPcvAodovEtPVzo3pKq20Ps5qNtzuOiD043rYwg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1711131734420.20292@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 14 Nov 2017, Masahiro Yamada wrote:

> Hi Julia,
>
>
> 2017-11-11 16:30 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
> >
> >
> > On Fri, 10 Nov 2017, Julia Lawall wrote:
> >
> >>
> >>
> >> On Thu, 9 Nov 2017, Masahiro Yamada wrote:
> >>
> >> > The command "make -j8 C=1 CHECK=scripts/coccicheck" produces lots of
> >> > "coccicheck failed" error messages.
> >>
> >> The question is where parallelism should be specified.  Currently, make
> >> coccicheck picks up the number of cores on the machine and passes that to
> >> Coccinelle.
> >>
> >> OPTIONS="$OPTIONS --jobs $NPROC --chunksize 1"
> >>
> >> On my 80 core machine with hyperthreading, this runs 160 jobs in parallel,
> >> while in practice that degrades the performance as compared to 40 or 80
> >> cores.
> >>
> >> On the other hand, if we use the make command line argument (-j), then we
> >> will only get parallelism up to the number of semantic patches.  Since
> >> some finish quickly, there will be a lot of wasted cycles.
> >>
> >> The best would be that the user knows what works well for his machine, and
> >> specifies it on the command line, and then that value gets propagated to
> >> Coccinelle, eg so that -j8 would cause not 8 semantic patches to run in
> >> parallel but instead would cause Coccinelle to run one semantic patch on 8
> >> files in parallel.  But I don't know if that can be done.
> >
> > Sorry for these fairly nonsensical comments.  make -j is going to consider
> > every file, then parse and run every semantic patch on that file.  If the
> > parallelism is pushed down into Coccinelle, each semantic patch will be
> > parsed only once, and then Coccinelle will choose the files for which it
> > is relevant.  If indexing is used (idutils, glimpse), then for semantic
> > patches that focus on specific keywords, Coccinelle will efficiently
> > ignore files that are not relevant.  I don't think there would be many
> > cases where make -j would win.  Perhaps it would be possible to detect
> > its used and abort with an appopriate message?
>
>
> I am afraid you and I are talking different things.
>
>
> For a usual usage of coccicheck, only one thread runs scripts/coccicheck
> even if -j is passed from the command line.
>
> coccicheck provides "J" to specify parallelism.
>
> if [ -z "$J" ]; then
>         NPROC=$(getconf _NPROCESSORS_ONLN)
> else
>         NPROC="$J"
> fi

Even if J is not specified, then it still runs with the maximum number of
threads:

Coccinelle parallelization
---------------------------

By default, coccicheck tries to run as parallel as possible.

Indeed, J= does set the number of threads speficied.

> My patch addresses a problem where coccicheck is used as CHECK.
> The default of CHECK is "sparse", but you can use any checker tool.
>
> In CHECK=scripts/coccicheck case, if -j is passed, all tasks run in parallel
> under control of GNU Make, so scripts/coccicheck is also invoked from
> multiple threads.
> Passing --jobs to spatch is not sensible because it checks only one file.

OK.  I tried a simple make coccicheck -j4 and indeed it does not seem to
be complaining.  The number of spatch processes goes over 160 though.

julia
