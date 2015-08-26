From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 26 Aug 2015 11:11:22 +0200 (CEST)
Subject: [Cocci] release: 1.0.2: Software evolution around
 parallelisation support
In-Reply-To: <55DD53B8.1010205@users.sourceforge.net>
References: <alpine.DEB.2.10.1508220653050.2531@hadrien>
 <55DA0DFD.8090005@users.sourceforge.net>
 <alpine.DEB.2.10.1508231227480.2916@hadrien>
 <55DD53B8.1010205@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1508261109060.2334@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 26 Aug 2015, SF Markus Elfring wrote:

> > There is no shared memory in ocaml.
>
> How do you think about to reuse any other application programming interfaces
> for inter-process communication?
> https://ocaml.github.io/ocamlunix/sockets.html
>
>
> Can it be determined from the content of a semantic patch language script
> if the spawned subprocesses need any more data exchange (with the parent process)
> besides the usual files like standard output and standard error?

In the short term, there is no improvement planned in this direction.  It
is important that Coccinelle does not know anything about the script code
- we don't want to include parsers for other languages, and it would
further raise the barrier for adding other scripting languages.  If you
need initialize and finalize, just use the current parallelism solution.
You will get n results instead of 1 result, but it is better than getting
15 000 results, as would happen with parmap.

julia
