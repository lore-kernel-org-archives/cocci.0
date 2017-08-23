From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 23 Aug 2017 18:07:50 +0200 (CEST)
Subject: [Cocci] parsing of C code
In-Reply-To: <7e9b2398-24fb-859a-b989-04701a823725@knosof.co.uk>
References: <alpine.DEB.2.20.1708222304510.2050@hadrien>
 <34573683-9485-cc29-ee00-f9f1855d03f9@knosof.co.uk>
 <alpine.DEB.2.20.1708230827550.3212@hadrien>
 <7e9b2398-24fb-859a-b989-04701a823725@knosof.co.uk>
Message-ID: <alpine.DEB.2.20.1708231800390.3150@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 23 Aug 2017, Derek M Jones wrote:

> Julia,
>
> > The Linux kernel has some declarations like
> >
> > type fn(a1, a2) >
> > with no trailing ; followed by a function definition.  This gives a parse
> > error on a1.  In the previous version, Coccinelle was able to recover an
>
> The K&R style.  Perfectly legal C.

I don't think that is what it is.  The declarations are eg:

static inline __printf(2, 3)
void _dev_info(const struct device *dev, const char *fmt, ...)
{}

I guess that the whole first line is part of the declaration of _dev_info,
but Coccinelle can't cope with the __printf(2, 3).

>
> > Basically the recovery process is focused on finding a { in column 0 and
> > then a } in column 0, and then it goes on after that.  But it can go
> > backwards sometimes, because a parsing problem can cause a parsing attempt
> > to read too far, into the next function.
>
> Skip to ; is a remarkably effective syntax error recovery strategy.

The parser needs to restart at a top-level declaration.  It's a yacc-based
parser.  We can't recover within the parsing process.  Perhaps it would be
possible to remove what was betwen two ;s around the line and column with
the error, but it seems like there could be a risk of making things worse.

julia

>
>
> --
> Derek M. Jones           Software analysis
> tel: +44 (0)1252 520667  blog:shape-of-code.coding-guidelines.com
>
