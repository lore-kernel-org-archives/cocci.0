From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 30 Sep 2018 19:11:27 +0200 (CEST)
Subject: [Cocci] =~ runtime improvements?
In-Reply-To: <CAGXu5jJD1H2LePxkRfZita7SphUb_EKkyAQLxCaDf-Xqr3yUOQ@mail.gmail.com>
References: <CAGXu5jLfBk6BAiQiKHJdxAFnP72xe_qtBDOizoSaAgYvsxTkVQ@mail.gmail.com>
 <c8d1021e-998c-2e55-e793-f787b2bca503@metafoo.de>
 <alpine.DEB.2.21.1809301739250.2863@hadrien>
 <CAGXu5jJD1H2LePxkRfZita7SphUb_EKkyAQLxCaDf-Xqr3yUOQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809301907270.2863@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 30 Sep 2018, Kees Cook wrote:

> On Sun, Sep 30, 2018 at 8:40 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> > On Sun, 30 Sep 2018, Lars-Peter Clausen wrote:
> >
> >> On 09/27/2018 08:51 PM, Kees Cook wrote:
> >> > Hi,
> >> >
> >> > This .cocci takes a VERY long time to run against the kernel, and I'd
> >> > love to know what I could do to improve it. I assume it's related to
> >> > the use of the "=~" operand:
> >> >
> >>
> >> Maybe I'm missing something, but do you need all of those variations? An
> >> expression should match an identifier. I'd expect ((ECOUNT)) *
> >> ((ESTRIDE)) * ((ESIZE)) matches the superset of all the other statements
> >> with ICOUNT, ISIZE and ISTRIDE in them. So you only need two rules one
> >> for array_size and one for array3_size.
> >
> > I agree about the indentifiers and expressions, although he also needs
> > some rules for the constant case.
>
> I had to go progressively to exclude cases in an attempt to isolate
> individual factors. For example:
>
> E1 * E2
>
> will match:
>
> var1 * var2 * var3

I think you could just do E1 * E2 * E3 before E1 * E2?

>
> In order to make a best-effort at extracting the multiplication
> factors, I need to go in order from constants (ignore) to identifiers
> (explicitly correct) to expressions (may overly match)
>
> But yes, it seems the problem is mainly the "..." part, which is unavoidable.

Maybe it would be good to have some special cases?  Are the
multiplications often right next to the allocation?  Or if there is
something that is often between them, then it could be useful to make a
special case for that.

julia
