From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Tue, 14 Aug 2018 07:23:15 +0000
Subject: [Cocci] 2 basic question
In-Reply-To: <alpine.DEB.2.20.1808140739000.3326@hadrien>
References: <20180814032931.GA28344@osadl.at>
 <alpine.DEB.2.20.1808140739000.3326@hadrien>
Message-ID: <20180814072315.GA26428@osadl.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Aug 14, 2018 at 07:47:05AM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 14 Aug 2018, Nicholas Mc Guire wrote:
> 
> >
> > Hi !
> >
> >  Trying to do some verification of the coccinelle tool
> >  it self and one of the tasks was to estimate false
> >  negatives (so reliability not accuracy). To be able
> >  to do that the first task was to determin if a semantic
> >  patch specification would actually be looking at all
> >  instances. The following trivial cocci spec was used:
> >
> > <snip>
> > virtual report
> >
> > @found@
> > position p;
> > @@
> >
> >    kmalloc at p(...)
> >
> > @script:python depends on report@
> > p << found.p;
> > @@
> > msg = "kmalloc called"
> > coccilib.report.print_report(p[0],msg)
> > <snip>
> >
> > With this I run coccicheck on 4.18-rc8 (linux-stable)
> >
> >   make coccicheck COCCI=kmalloc1.cocci | tee kmalloc.log
> >
> > which gives me a line count of (wc -l kmalloc.log after
> > removing the header) 4722 instances
> >
> > But cscope reports 4746 kmalloc cases - so I??m wondering
> > if coccinelle is actually checking all cases or where
> > this difference would come from ?
> > Is the assumption that the above specification sould actually
> > report every usage of kmalloc correct ?
> 
> Coccinelle doesn't process code that it can't parse.  The amount of real
> function code that is not parsable should be very small, but it is
> possible that such code contains a call to kmalloc.

ok - will try to locate what this could be then

> 
> On the other hand, I don't know what cscope gives you.  Recently, I have
> seen for example a call to kmalloc and then an error message like "kmalloc
> failed".  So would it find both of them?

from my understanding of cscope no - and I just tried a trivial
example - if one searches for regeex then yes if for calls no - but
for trivial examples the counts do not differ :)

> 
> >
> > The second issue is that to simplify completness verification
> > I wanted to add simple counters like so:
> >
> >
> > <snip>
> > virtual report
> > @initialize:python@
> > @@
> > import sys
> >
> > count=0
> >
> > def show():
> >    print("Total %d" % count)
> >
> > @found@
> > position p;
> > @@
> >
> >    kmalloc at p(...)
> >
> > @script:python depends on report@
> > p << found.p;
> > @@
> >
> > count = count + 1
> > msg = "kmalloc called"
> > coccilib.report.print_report(p[0],msg)
> >
> > @finalize:python depends on report@
> > @@
> > show()
> > <snip>
> > this works when run with spach version (spatch --version):
> > spatch version 1.0.1 with Python support and with PCRE support
> >
> > And will give me the same as wc -l
> > Total 4722
> >
> > but not with a current git version (spatch --version):
> >  spatch version 1.0.7-00500-g97695d0 compiled with OCaml version 4.01.0
> >  Flags passed to the configure script: [none]
> >  OCaml scripting support: yes
> >  Python scripting support: yes
> >  Syntax of regular expresssions: PCRE
> >
> > where Total 0 is reported
> >
> > did the python interface change and my usage is obsolete
> > or is this a regression ?
> 
> I just tested it on drivers/usb and got 347.  Did you run it in parallel
> in the second case (or with make coccicheck, because by default that runs
> in parallel)?  If you do that, the counter will only get updated in the
> child processes, but the printing happens in the main process.  If you
> want to run in parallel, you need to merge the values.  See
> tests/merge_vars_python.cocci.  Basically, you write:
> 
> @finalize:python@
> l1 << merge.v1;
> l2 << merge.v2;
> l3 << merge.v3;
> @@
> 
> and then l1 l2 and l3 are lists of the values resulting from the various
> iterations.  You can then add them up.
>
works perfectly - I simply did not notice that on the one sysem
it was running single while on the other concurrent and that
was in fact the reason why it worked.

many thx!
hofrat 
