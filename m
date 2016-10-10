From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 10 Oct 2016 06:54:37 +0200 (CEST)
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <87wphhz1x5.fsf@vostro.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien> <8760p3jwr3.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610080727090.3176@hadrien>
 <87ponay35u.fsf@vostro.rath.org> <alpine.DEB.2.10.1610082317180.3373@hadrien>
 <87wphhz1x5.fsf@vostro.rath.org>
Message-ID: <alpine.DEB.2.10.1610100653510.3148@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 9 Oct 2016, Nikolaus Rath wrote:

> On Oct 08 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >> > Write separate rules for that.  You would need one case for a local
> >> > variable and one case fora parameter.  You can actually probably just drop
> >> > the rule you have currently.  I would imagine something like the
> >> > following:
> >> >
> >> > @@
> >> > symbol f, se; // avoid unneeded warnings from Coccinelle
> >> > @@
> >> >
> >> > struct fuse_session *
> >> > -f
> >> > +se
> >> >  ;
> >> > <...
> >> > -f
> >> > +se
> >> > ...>
> >> > @@
> >> > identifier fn;
> >> > @@
> >> >
> >> > fn(...,struct fuse_session *f,...) { <...

Oops, the first line should be:

fn(...,struct fuse_session *
-f
+se
  ,...) { <...

The rule works fine even when f is the first argument.

julia

> >> > -f
> >> > +se
> >> > ...> }
> >> >
> >> > I think that the symbol declaration has effect in the rest of the semantic
> >> > patch, and does not have to be repeated.  If you get warnings for the
> >> > second rule, just copy it down.
> >>
> >> I don't get Coccinelle warnings, but if I just use the two rules as
> >> you gave them, then it looks as if the second one isn't working:
> >>
> >> @@ -584,9 +584,9 @@ static struct fuse_ll_pipe *fuse_ll_get_
> >>
> >>  static void fuse_ll_clear_pipe(struct fuse_session *f)
> >>  {
> >> -	struct fuse_ll_pipe *llp = pthread_getspecific(f->pipe_key);
> >> +	struct fuse_ll_pipe *llp = pthread_getspecific(se->pipe_key);
> >>  	if (llp) {
> >> -		pthread_setspecific(f->pipe_key, NULL);
> >> +		pthread_setspecific(se->pipe_key, NULL);
> >>  		fuse_ll_pipe_free(llp);
> >>  	}
> >>  }
> >>
> >>
> >> Is the problem that "...," does not match nothing, i.e. *f must not be
> >> the first argument of the function?
> >
> > It should match nothing.  What version of Coccinelle do you have?
>
> I used 1.0.0-rc22 (from Debian stable). However, I just downloaded the
> pre-compiled version from http://coccinelle.lip6.fr/download.php and it
> gives the same result.
>
> In case you want to try yourself: the sources that I'm running this on
> are available at https://github.com/libfuse/libfuse.
>
>
> Best,
> -Nikolaus
>
> --
> GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
> Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>
>              ?Time flies like an arrow, fruit flies like a Banana.?
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
