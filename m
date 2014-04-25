From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 25 Apr 2014 18:23:23 +0200 (CEST)
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1404251821570.3323@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 25 Apr 2014, Javier Martinez Canillas wrote:

> Hello,
>
> I'm a Linux kernel developer doing a big refactoring on the GPIO subsytem.
>
> I was wondering if the change I'm doing manually could be automated by
> using cocinelle but I've no experience neither writing semantic
> patches nor the SmPL language grammar.

It looks quite possible.  In looking at the code, though, I wasn't sure
what is your strategy for where to place the new structure definition, in
the case where there was no structure before.  Would it be OK to put it
next to the probe function?

julia
