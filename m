From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 16 Jan 2015 19:10:03 +0100 (CET)
Subject: [Cocci] Find all variables/parameters of a given type.
In-Reply-To: <54B950A6.1040707@users.sourceforge.net>
References: <528DE554-4455-43F3-86D0-A4A1BE677755@gmail.com>
 <54B950A6.1040707@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1501161908570.2549@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 16 Jan 2015, SF Markus Elfring wrote:

> > But I get parse errors no matter what I try.
>
> I guess that I can not really help with parsing difficulties
> in your case.
>
>
> > Where?s my error?
>
> I find that your SmPL disjunction can also be written in
> a slightly different way.
> Would you like to try out the following semantic filter approach?
>
> @find_big_integers@
> identifier func, var;
> @@
> (
> *long var
>  ... ;
> |
>  func(...,
> *     long var,
>       ...);
> |
>  func(...,
> *     long var,
>       ...)
>  { ... }
> )

This does not work either, for the same reason previously mentioned.  You
cannot put a function definition in a disjunction.

Including function prototypes seems redundant, but may be useful if the
function definition has a parsing problem, but the prototype does not.

julia
