From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 13 Feb 2015 08:31:45 +0100 (CET)
Subject: [Cocci] replace long in parameter with int32
In-Reply-To: <CAP6exYKebNpiP039k-TApNxMD=QBwAmK=QXj30efboabD=D4cw@mail.gmail.com>
References: <CAP6exYKebNpiP039k-TApNxMD=QBwAmK=QXj30efboabD=D4cw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1502130831130.2062@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 13 Feb 2015, ron minnich wrote:

> I've done some searching but have not found this
> I'd like to change all occurrences of things like this:
> t f(..., long x, ...) {...}
> 
> such that long becomes int32.
> 
> I've been trying and failing, and have given up :-)
> 
> I am able to change it everywhere else, just not in functions.

What happens exactly?

The following changes long to int32 everywhere:

@@
typedef int32;
@@

- long
+ int32

julia
