From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 22 Jan 2015 07:58:03 +0200 (SAST)
Subject: [Cocci] Matching functions with attributes
In-Reply-To: <02347CD6-6A31-41A9-B4EE-58163C49368C@gmail.com>
References: <D59A6A6F-9D60-44DE-9B6C-8B615B776EA8@gmail.com>
 <54BFD099.8030002@users.sourceforge.net>
 <F6392E9E-0D22-4398-8173-DD84FFEBAB98@gmail.com>
 <alpine.DEB.2.10.1501212342170.2599@hadrien>
 <02347CD6-6A31-41A9-B4EE-58163C49368C@gmail.com>
Message-ID: <alpine.DEB.2.10.1501220756220.2622@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 21 Jan 2015, Eliseo Mart?nez wrote:

> > I'm not following the goal here.
>
> I have a list of functions that I know can?t return NULL.
> I want to look for places where after invoking one of those functions, returned value is (unnecessarily) checked for being null or non-null.
>
> I have a working spatch now:
> ```
> @@ identifier func =~ "^(vim_strsave|list_alloc)$"; statement S; @@
>
> (
> * if (func(...) == NULL)
>     S
> |
> * if (func(...) != NULL)
>     S
> )
>
> @@ identifier func =~ "^(vim_strsave|list_alloc)$"; identifier var; statement S; expression E; @@
>
>   var = func(...);
>   ... when != var = E
> (
> * if (var == NULL)
>     S
> |
> * if (var != NULL)
>     S
> )
> ```
>
> That was basically my first approach in previous messages, but there were 2 minor issues:
> - The extra semicolon you warned against. This is, I had to replace ?S;? with ?S?.
> - A second, weird thing:
>     If I put ?S? on the same line as the ?if?, it finds nothing.
>     If I put ?S? on a separated line, then it works.
>     Is this a bug? I thought whitespace was never significant?

The difference would be whether the S is under the * or outside it.  But I
don't see why it would matter.  I will check.

If you replace your if by

if (x == NULL) S1 else S2

then it should catch everything, including the != case and the one branch
case.  This is due to various isomorphisms, as described in standard.iso.

julia
