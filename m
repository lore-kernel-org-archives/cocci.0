From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 14 Oct 2016 10:21:48 +0200 (CEST)
Subject: [Cocci] Replacing calls of general functions by more specific
 ones with SmPL
In-Reply-To: <8c2c37de-baee-8282-b5cc-ad6eea3bb66f@users.sourceforge.net>
References: <8c2c37de-baee-8282-b5cc-ad6eea3bb66f@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1610141019550.3002@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 14 Oct 2016, SF Markus Elfring wrote:

> Hello,
>
> I came during my software development activities along a few Linux source files
> where I got an advice by the script "checkpatch.pl" like the following.
>
> WARNING: Prefer seq_puts to seq_printf
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl?id=29fbff8698fc0ac1a1d74584b258e0bf18b469f9#n5610
>
>
> Joe Perches pointed out that the function "seq_putc" would be more appropriate
> at a specific source code place.
> https://patchwork.kernel.org/patch/9364455/
> https://lkml.kernel.org/r/<1475771699.1914.10.camel@perches.com>
>
>
> Now I am curious on how good the semantic patch language is applicable
> for advanced source code transformations in similar use cases.
> With which metavariables and corresponding programming interfaces can strings that
> are passed to such functions be checked in more detail by the Coccinelle software?

The simplest would be to use python or ocaml code to make the checks that
are needed.  You can use cocci.include_match(False) in python or
Coccilib.include_match false in ocaml when your test detects that
something is not suitable.  coccinelle/demos/first.cocci may be helpful.

julia
