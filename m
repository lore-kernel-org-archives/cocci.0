From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Aug 2017 22:24:13 +0200 (CEST)
Subject: [Cocci] __init macro and Coccinelle
In-Reply-To: <d2d75cb0-c297-ba65-d7cd-84ff21e5d409@embeddedor.com>
References: <d2d75cb0-c297-ba65-d7cd-84ff21e5d409@embeddedor.com>
Message-ID: <alpine.DEB.2.20.1708152222450.2049@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 Aug 2017, Gustavo A. R. Silva wrote:

> Hello everybody,
>
> I have the following script:
>
> @r@
> identifier f_init;
> position p;
> @@
>
>
> * __init f_init at p(...)
>
> I want to spot __init functions, but it doesn't seem to work. I get a parse
> error around the __init macro:
>
> around = '__init',
>   whole content = * __init f_init at p(...)
>
> I wonder if there is a way to work around that issue?

If you want to match a function, you have to put something that will match
the whole function, not just the top part.  So it would be

__init f(...) { ... }

julia
