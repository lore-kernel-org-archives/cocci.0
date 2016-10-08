From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Oct 2016 23:21:10 +0200 (CEST)
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <87ponay35u.fsf@vostro.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien> <8760p3jwr3.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610080727090.3176@hadrien>
 <87ponay35u.fsf@vostro.rath.org>
Message-ID: <alpine.DEB.2.10.1610082317180.3373@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 8 Oct 2016, Nikolaus Rath wrote:

> On Oct 08 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > On Fri, 7 Oct 2016, Nikolaus Rath wrote:
> >
> >> On Oct 05 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >> >>
> >> >> 2. ..and how would I go about if instead of the type, I want to replace
> >> >>    a variable name? (my_type *ptr --> my_type *pointer).
> >> >
> >> > I'm not completely sure what the issue is here.  Do you specifically want
> >> > to convert ptr to pointer?  Is the type important?  To make exactly what
> >> > you have written, you could put:
> >> >
> >> > @@
> >> > typedef my_type;
> >> > idexpression mytype * p1;
> >> > @@
> >> >
> >> > - ptr at p1
> >> > + pointer
> >> >
> >> > This checks for the word ptr, and also checks that it is an identifier of
> >> > the right type.  I haven't tested it, so let me know if there is any
> >> > problem.
> >>
> >> It workes somewhat... but not completely.
> >>
> >> Here's what I wanted to do: I merged two structures (struct fuse_session
> >> and struct fuse_ll) into one (struct fuse_session). I've first replaced
> >> all the type names, and then manually fixed the cases where this
> >> resulted in bogus/redundant code (typically in functions that used to
> >> work with both structs).
> >>
> >> Now my project compiles and runs fine, but I the variable naming is
> >> inconsistent: in some cases the struct fuse_session pointer is called
> >> *se (these were the variables that were always of type struct
> >> fuse_session), and in other cases the pointer is called *f (these were
> >> the variables that were previously of type struct fuse_ll).
> >>
> >> I'd like to fix this too, and always refer call fuse_session pointers
> >> "se" (except where this name is already used for something else, but
> >> I'll just fix this up by hand afterwards). I tried the following patch:
> >>
> >> $ cat se-name.cocci
> >> @@
> >> idexpression struct fuse_session *p1;
> >> @@
> >> - f at p1
> >> + se
> >>
> >> but it resulted in these changes:
> >>
> >>  	struct fuse_session *f = req->se;
> >> -	struct cuse_data *cd = f->cuse_data;
> >> -	size_t bufsize = f->bufsize;
> >> +	struct cuse_data *cd = se->cuse_data;
> >> +	size_t bufsize = se->bufsize;
> >>
> >> So it seems to replace the variable where its used, but not where it's
> >> defined.
> >>
> >> Is there a way to catch the definitions too?
> >
> > Write separate rules for that.  You would need one case for a local
> > variable and one case fora parameter.  You can actually probably just drop
> > the rule you have currently.  I would imagine something like the
> > following:
> >
> > @@
> > symbol f, se; // avoid unneeded warnings from Coccinelle
> > @@
> >
> > struct fuse_session *
> > -f
> > +se
> >  ;
> > <...
> > -f
> > +se
> > ...>
>
> Could you explain how this works (in particular the effect of the angle
> brackets)? I also can't resist to point out that "symbol" is not
> included in the list of metavariable types from the tutorial slides :-).

<... P ...> is called a nest.  It means that the pattern can appear 0 or
more times.  You can put a transformation on the pattern.  It will happen
as many times as the thing appears.

The list on the slides is not exhaustive.  The list in the language
grammar should be exhaustive:
http://coccinelle.lip6.fr/docs/index.html

Symbol also just exists to quiet a warning message; it's not essential.

>
> > @@
> > identifier fn;
> > @@
> >
> > fn(...,struct fuse_session *f,...) { <...
> > -f
> > +se
> > ...> }
> >
> > I think that the symbol declaration has effect in the rest of the semantic
> > patch, and does not have to be repeated.  If you get warnings for the
> > second rule, just copy it down.
>
> Not sure what you mean with "copy it down".

Put the symbol declaration in both rules.

> I don't get Coccinelle
> warnings, but if I just use the two rules as you gave them, then
> it looks as if the second one isn't working:
>
> @@ -584,9 +584,9 @@ static struct fuse_ll_pipe *fuse_ll_get_
>
>  static void fuse_ll_clear_pipe(struct fuse_session *f)
>  {
> -	struct fuse_ll_pipe *llp = pthread_getspecific(f->pipe_key);
> +	struct fuse_ll_pipe *llp = pthread_getspecific(se->pipe_key);
>  	if (llp) {
> -		pthread_setspecific(f->pipe_key, NULL);
> +		pthread_setspecific(se->pipe_key, NULL);
>  		fuse_ll_pipe_free(llp);
>  	}
>  }
>
>
> Is the problem that "...," does not match nothing, i.e. *f must not be
> the first argument of the function?

It should match nothing.  What version of Coccinelle do you have?

julia

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
