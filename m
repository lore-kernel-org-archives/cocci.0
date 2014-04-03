From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 3 Apr 2014 12:16:37 +0200 (CEST)
Subject: [Cocci] spatch issue with C struct initialization
In-Reply-To: <1396513844.24348.13.camel@localhost.localdomain>
References: <1396513844.24348.13.camel@localhost.localdomain>
Message-ID: <alpine.DEB.2.10.1404031216060.2090@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 3 Apr 2014, Marcel Apfelbaum wrote:

> Hi,
> I tried to use the coccinellery/doubleinit/doubleinit.cocci script
> using the latest spatch version (1.0.0-rc20, I tried prev versions too).
>
> I received the following error:
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> 400 401
> Fatal error: exception Failure("minus: parse error:
>  = File "coccinellery/doubleinit/doubleinit.cocci", line 17, column 22,  charpos = 400
>     around = '.', whole content = struct I s =@p0 { ... .fld at p = E, ...};
> ")
>
> Am I missing something, am I doing something wrong?
>
> I need the following construct to work:
> struct I s =
> {
> ...
> .fld = E,
> ...
> };

Sorry, coccinellery versions may be out of date.  You need to put a comma
after the first ...

julia
