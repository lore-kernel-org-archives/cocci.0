From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Aug 2017 22:42:38 +0200 (CEST)
Subject: [Cocci] __init macro and Coccinelle
In-Reply-To: <09ca6ffb-26db-b025-9ac7-dfb84726a1ae@embeddedor.com>
References: <d2d75cb0-c297-ba65-d7cd-84ff21e5d409@embeddedor.com>
 <alpine.DEB.2.20.1708152222450.2049@hadrien>
 <09ca6ffb-26db-b025-9ac7-dfb84726a1ae@embeddedor.com>
Message-ID: <alpine.DEB.2.20.1708152241390.2049@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 Aug 2017, Gustavo A. R. Silva wrote:

>
>
> On 08/15/2017 03:24 PM, Julia Lawall wrote:
> >
> >
> > On Tue, 15 Aug 2017, Gustavo A. R. Silva wrote:
> >
> > > Hello everybody,
> > >
> > > I have the following script:
> > >
> > > @r@
> > > identifier f_init;
> > > position p;
> > > @@
> > >
> > >
> > > * __init f_init at p(...)
> > >
> > > I want to spot __init functions, but it doesn't seem to work. I get a
> > > parse
> > > error around the __init macro:
> > >
> > > around = '__init',
> > >   whole content = * __init f_init at p(...)
> > >
> > > I wonder if there is a way to work around that issue?
> >
> > If you want to match a function, you have to put something that will match
> > the whole function, not just the top part.  So it would be
> >
> > __init f(...) { ... }
> >
>
> That worked, thanks. :)
>
> But now if I combine it in the following way:
>
> @r1@
> identifier s_type;
> identifier f_init;
> identifier s;
> position p;
> type T;
> @@
>
> (
> * struct s_type s = {.init = f_init at p};
> |
> * __init f_init at p(...) { ... }
> )
>
> I get the same error parse error:
>
>   around = '__init',
>   whole content = __init f_init at p(...) { ... }

Don't do it :)

There are some parsing hacks to differentiate function calls from function
definitions.  Adding the disjunction defeats them.  Just make two separate
rules.

julia
