From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 6 Nov 2014 21:04:03 +0100 (CET)
Subject: [Cocci] matching "..." va_list args
In-Reply-To: <545BAC12.90402@nosuchfail.org>
References: <545BAC12.90402@nosuchfail.org>
Message-ID: <alpine.DEB.2.02.1411062102460.2062@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 6 Nov 2014, Jonathan Klee wrote:

> Dear all,
> 
> Since "..." basically means anything, I was wondering if we can match "..."
> va_list kind of arguments in a function prototype.
> I would like to do something like :
> 
> @@
> identifier f, a;
> type T, A;
> @@
> -T f(A a, ...);
> +T f(A a, ...) { va_list args; va_start(args, a); va_stop(args); }

It is currently not supported, but someone is working on it.  I hope that 
it could be available in a couple of weeks (the person only works on 
Coccinelle part time).

julia
