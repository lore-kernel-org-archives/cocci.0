From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 8 Oct 2016 07:31:01 +0200 (CEST)
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <8760p3jwr3.fsf@vostro.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien> <8760p3jwr3.fsf@vostro.rath.org>
Message-ID: <alpine.DEB.2.10.1610080727090.3176@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 7 Oct 2016, Nikolaus Rath wrote:

> On Oct 05 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >>
> >> 2. ..and how would I go about if instead of the type, I want to replace
> >>    a variable name? (my_type *ptr --> my_type *pointer).
> >
> > I'm not completely sure what the issue is here.  Do you specifically want
> > to convert ptr to pointer?  Is the type important?  To make exactly what
> > you have written, you could put:
> >
> > @@
> > typedef my_type;
> > idexpression mytype * p1;
> > @@
> >
> > - ptr at p1
> > + pointer
> >
> > This checks for the word ptr, and also checks that it is an identifier of
> > the right type.  I haven't tested it, so let me know if there is any
> > problem.
>
> It workes somewhat... but not completely.
>
> Here's what I wanted to do: I merged two structures (struct fuse_session
> and struct fuse_ll) into one (struct fuse_session). I've first replaced
> all the type names, and then manually fixed the cases where this
> resulted in bogus/redundant code (typically in functions that used to
> work with both structs).
>
> Now my project compiles and runs fine, but I the variable naming is
> inconsistent: in some cases the struct fuse_session pointer is called
> *se (these were the variables that were always of type struct
> fuse_session), and in other cases the pointer is called *f (these were
> the variables that were previously of type struct fuse_ll).
>
> I'd like to fix this too, and always refer call fuse_session pointers
> "se" (except where this name is already used for something else, but
> I'll just fix this up by hand afterwards). I tried the following patch:
>
> $ cat se-name.cocci
> @@
> idexpression struct fuse_session *p1;
> @@
> - f at p1
> + se
>
> but it resulted in these changes:
>
>  	struct fuse_session *f = req->se;
> -	struct cuse_data *cd = f->cuse_data;
> -	size_t bufsize = f->bufsize;
> +	struct cuse_data *cd = se->cuse_data;
> +	size_t bufsize = se->bufsize;
>
> So it seems to replace the variable where its used, but not where it's
> defined.
>
> Is there a way to catch the definitions too?

Write separate rules for that.  You would need one case for a local
variable and one case fora parameter.  You can actually probably just drop
the rule you have currently.  I would imagine something like the
following:

@@
symbol f, se; // avoid unneeded warnings from Coccinelle
@@

struct fuse_session *
-f
+se
 ;
<...
-f
+se
...>

@@
identifier fn;
@@

fn(...,struct fuse_session *f,...) { <...
-f
+se
...> }

I think that the symbol declaration has effect in the rest of the semantic
patch, and does not have to be repeated.  If you get warnings for the
second rule, just copy it down.

julia
