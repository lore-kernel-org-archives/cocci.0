From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 14 Jan 2018 14:05:33 +0100 (CET)
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <a0a4aa2c-56c7-a7b8-f1ec-77c5fc1a8150@users.sourceforge.net>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
 <68dd2f4a-7921-922c-399d-284d3506415d@users.sourceforge.net>
 <alpine.DEB.2.20.1801141003270.7902@hadrien>
 <2fd51b6d-75d8-ee9a-b52f-beab2299d9b0@users.sourceforge.net>
 <alpine.DEB.2.20.1801141056190.7902@hadrien>
 <0ca5933b-6973-8273-2646-3241157058cf@users.sourceforge.net>
 <alpine.DEB.2.20.1801141126290.7902@hadrien>
 <8649d987-c6f2-f36d-3a6f-cfda02557362@users.sourceforge.net>
 <20180114112844.GA2649@himanshu-Vostro-3559>
 <5e10af93-14cd-371d-2262-bef2fb2ca387@users.sourceforge.net>
 <alpine.DEB.2.20.1801141344350.7902@hadrien>
 <a0a4aa2c-56c7-a7b8-f1ec-77c5fc1a8150@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801141402000.7902@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 14 Jan 2018, SF Markus Elfring wrote:

> >> 4. Is is more efficient to use the Python key word ?in? to look for
> >>    a short string instead of fiddling with the programming interface
> >>    for regular expressions?
> >
> > If you test it and find that it is significantly more efficient,
> > then please send a patch accordingly.
>
> Should the support for a specific key word in this programming language
> be generally faster or just more direct than invoking a component
> from another software library?
>
> Do we need to start an official benchmarking session to achieve
> another decision in any software design direction?

I have no idea about python.  If you find a performance improvement, send
a patch,  If you don't find a performance improvement, I don't care about
the issue.  In any case, the ball is entirely in your court.  There is no
"we".


>
>
> >> 5. Please omit the variable ?msg? in the last SmPL rule.
> >>    The need data can be passed directly instead.
> >
> > The use of the msg variable is common in the semantic patches in the kernel.
>
> Can this implementation detail be adjusted?
>
>
> > Ampng other things it increases the chance that the line will fit
> > in 80 characters.  It is not completely a success here, but at least it is
> > more of a success than it would be otherwise.
>
> Such data can also be passed as function parameters (in a scripting language)
> without storing them into variables before in some use cases.

But then, if a pleasant indentation scheme is followed, the very long
string will be further to the right and will even more exceed the 80
column boundary.  If python is so sensitive that it cares about the
introduction of a variable that is only used immediately afterwards, then
it would seem that the problem is with python.

julia
