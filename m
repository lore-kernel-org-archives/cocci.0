From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 19 Aug 2016 09:30:01 -0400 (EDT)
Subject: [Cocci] Coccinelle: Script to replace allocate and memset with
 zalloc functions
In-Reply-To: <33c75c5f-59d5-5fd4-6767-6144b4f245bc@users.sourceforge.net>
References: <20160801070233.GA19102@amitoj-Inspiron-3542>
 <d3dde65e-a1d5-54ba-d65f-9e996bb4f8f5@users.sourceforge.net>
 <CA+5yK5HNhcYV+OWhvvgax-fvbtSXEHgPh0mxzWFPFc6-ubzJEQ@mail.gmail.com>
 <33c75c5f-59d5-5fd4-6767-6144b4f245bc@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1608190928520.3078@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 19 Aug 2016, SF Markus Elfring wrote:

> >> I suggest to take another look at a few implementation details.
> >>
> >> 1. Would it make sense to merge such SmPL rules into one
> >>    so that code duplication could be reduced a bit
> >>    in such a script?
> >>
> >> 2. How do you think about to extend the shown check list
> >>    with the function "kvm_kvzalloc"?
> ?
> > kvm_kvzalloc function doesn't fit the same pattern as the other
> > functions in this semantic patch, and is kvm specific,
>
> Has this one got a similar function property?

Do you have any example where XXX followed by memset is converted to this
function?

>
> Do you prefer to exclude such functions which belong to subsystems
> so far generally?

Yes, because it would introduce unwanted dependencies.

>
> > so the semantic patch looks fine as is.
>
> How do you think about to express the shown source code repetition
> as an aspect by an other script format?

It is fine as it is.

julia
