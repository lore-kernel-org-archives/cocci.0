From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 31 Aug 2013 09:00:22 +0200 (CEST)
Subject: [Cocci] "already tagged token"
In-Reply-To: <CAP6exYKDFuKbmqRjRmtkq1p2Oou06bVpwLt5cGgcp=7TJSJcqw@mail.gmail.com>
References: <CAP6exYKDFuKbmqRjRmtkq1p2Oou06bVpwLt5cGgcp=7TJSJcqw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1308310859160.1977@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 30 Aug 2013, ron minnich wrote:

> I have this rule:
> 
> @@
> typedef Conv;
> @@
> -Conv
> +struct conv
> 
> And this file:
> 
> static Chan*
> ipopen(Chan* c, int omode)
> {
>         Conv *cv, *nc;
> }
> 
> And this error:
> 
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: /tmp/die.c
> 
> previous modification:
> MINUS
>   >>> struct conv
> 
> According to environment 0:
> 
> 
> current modification:
> MINUS
>   >>> struct conv
> 
> According to environment 0:
> 
> 
> Fatal error: exception Failure("rule starting on line 7: already tagged token:
> C code context
> File "/tmp/die.c", line 4, column 1,  charpos = 43
>     around = 'Conv', whole content =    Conv *cv, *nc;")
> 
> and zero clue :-)
> 
> is there a simple way out of this one?

Upgrade your version of Coccinelle.  It works fine for me, but I have done 
some work on multi-variable declarations recently (before the release of 
rc18).

julia
