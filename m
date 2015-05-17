From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 May 2015 15:11:57 +0200 (CEST)
Subject: [Cocci] Fatal error: exception Failure("not supported")
In-Reply-To: <20150517120807.GA13779@pema>
References: <20150517061803.GA32427@opentech.at> <20150517120807.GA13779@pema>
Message-ID: <alpine.DEB.2.02.1505171511410.2077@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

do while is not supported.  Sorry.

julia

On Sun, 17 May 2015, S?bastien Hinderer wrote:

> Hi Nicholas,
> 
> Nicholas Mc Guire (2015/05/17 08:18 +0200):
> > 
> > Hi !
> > 
> >  Writing some simple checks for user-space sample code to check that a 
> >  read loop has some error checking in it - the read loop should look 
> >  something like this:
> > 
> >         do {
> >                 len = read(fd, buff + off, BUFFSIZE);
> >                 if (len < 0 && len != -EAGAIN) {
> >                         perror("read failed");
> >                         exit(-1);
> >                 }
> >                 off += len;
> >         } while (len > 0);
> 
> I know it is not relevant for your problem, but the last argumentof the
> read system call looks suspiscious to me. I'd rather write BUFFSIZE-of
> but perhaps you wrote it that way just to simplify.
> 
> > to check this the following cocci spatch was intended 
> > 
> > <snip>
> > virtual report
> > virtual org
> > 
> > @check_open@
> > identifier f,retval;
> > idexpression int fd;
> > idexpression int l;
> > idexpression int o;
> > idexpression char * b;
> > position p;
> > @@
> > 
> > f(...) {
> > <+...
> >  do {
> >  ...
> >  l = read at p(fd,b+o,...);
> >  if (l < 0 && l != -EAGAIN) {
> > ? perror(...);
> > (
> >   exit(...);
> > |
> >   return ...;
> > )
> > }
> >  l = l + o;                                                                                               
> > } while ( l > 0);
> > return retval;
> > ...+>
> > }
> > 
> > 
> > @script: python@
> > p<<check_open.p;
> > fn<<check_open.f;
> > @@
> > print "OK: read loop in %s:%s line %s checking errors" % (p[0].file,fn, p[0].line)
> > <snip>
> > 
> >  spatch --parse-cocci gives no errors and the output looks fine (just the iso
> >  expansions basically) - but when run with:
> >   spatch --sp-file check_read_loop.cocci open_read_ok.c
> >  its giving me:
> >   init_defs_builtins: /usr/local/share/coccinelle/standard.h
> >   Fatal error: exception Failure("not supported")
> > 
> > how can I figure out what is "not supported" here ?
> 
> just try this:
> 
> export OCAMLRUNPARAM=b
> And then re-run the spatch that caused the exception. You should get a
> backtrace that you can post here.
> 
> In case you do not get it, it will probably mean that you have compiled
> a native-code version of coccinelle. We will have to get a byte-code one
> to be able to have a backtrace.
> 
> And by the way, do you really need <+... and ...+> ? Wouldn't two mere
> ... be enough?
> 
> hth,
> S?bastien.
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
