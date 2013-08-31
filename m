From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 31 Aug 2013 08:57:52 +0200 (CEST)
Subject: [Cocci] very simple transformations
In-Reply-To: <CAP6exYKho8Ano_a82RFj=EzEK6Zfk=5Kz1=SJfomF77CDUKoag@mail.gmail.com>
References: <CAP6exYKho8Ano_a82RFj=EzEK6Zfk=5Kz1=SJfomF77CDUKoag@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1308310853450.1977@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 30 Aug 2013, ron minnich wrote:

> I've got a file with the following sorts of things
> 
> void f(uint x)
> {
>   uint z;
> }
> 
> I'd like to transform all instances of uint to unsigned int. Doable
> with coccinnelle?

This seems straightforward:

@@
typedef uint;
@@

- uint
+ unsigned int

Perhaps you were missing the typedef.

> Also:
> IPhdr x;
> needs to become
> struct iphdr x;
> in all parameters and declarations. Also likely trivial, I can't seem
> to get anything to work.

This should be the same.

> Now a really harder one:
> Plan 9 C to C
> I have things like
> void x(char *, int, int i)
> {
> ...
> }
> 
> The unnamed params are how we indicate in plan 9 that the parameter is
> unused. But coccinnelle throws an error, as it's not really valid. Any
> thoughts on this one?

At the moment, that's not possible.  I don't think the C parser will 
parse the code, and I'm sure that the SmPL parser won't parse the semantic 
patch that you would need.  But I think it would be easy to add.  I can 
try to do that when I finish with Nic's if problems.

julia
