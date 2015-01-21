From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 21 Jan 2015 23:46:17 +0200 (SAST)
Subject: [Cocci] Matching functions with attributes
In-Reply-To: <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
 <54BFD099.8030002@users.sourceforge.net>
 <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
Message-ID: <alpine.DEB.2.10.1501212342170.2599@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 21 Jan 2015, Eliseo Mart?nez wrote:

>
> > Then, would there be any way to match functions having the
> >> literal ?FUNC_ATTR_NONNULL_RET? in their declaration/definition?
> >
> > Would you like to try it out how many source code places can be found
> > with your macro name?
>
> This approach
> ```
> @nonnullfuncs@ identifier func; @@
>
> * func
>   (...)
>   ... FUNC_ATTR_NONNULL_RET ...
>   {...}
> ```
> matches nothing.

I'm surprised that it parses.  Matching of attributes is not supported.
Parsing them in C code is too (or at least very) difficult, and they are
all shifted into comments.

> >> @@ identifier func =~ "^(transstr|list_alloc|listitem_alloc| [...] |concat_str)$"; [...] @@
> >>
> >>  var = func(...);
> >>  ... when != var = E
> >> (
> >> * if (var == NULL) S;
> >> |
> >> * if (var != NULL) S;
> >> )
> >
> > Does this kind of SmPL disjunction make sense?

You don't want the semicolon after S.  That means a statement followed by
a semicolon, which could match something like x = 3;;, that is the
statement x = 3; followed by another semicolon.

Only use regular expressions if you absolutely have to.  They are not
interpreted when preselecting files, so they drasticaly hurt performance.

> I don?t see why not. AFAIK, Disjunctions can contain a full term
> (identifier/expression/statement). Regarding meaning, well, I?m looking
> for places where var is checked for nullness/non-nullnes. That?s the
> most obvious way I?ve found to express that?
>
> >> As you see, I have to replicate the list.
> >>
> > I would also appreciate if such repetition could be avoided for
> > SmPL constraints.
>
> I?ve tried with rule inheritance, but don?t know what to put in a first
> rule that just ?selects? the functions. This is:
>
> ```
> @r@ identifier func =~ ??list of names? ? @@
>
>   ? What here???
>
> @@ identifier r.func @@
>
> (
> * if (func(?) == NULL) S;
> |
> * if (func(?) != NULL) S;
> )
> ```

I'm not following the goal here.

julia
