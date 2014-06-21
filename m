From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 21 Jun 2014 08:28:16 +0200 (CEST)
Subject: [Cocci] Simple replacement of an expression of given type?
In-Reply-To: <87y4wrtam6.fsf@rustcorp.com.au>
References: <87y4wrtam6.fsf@rustcorp.com.au>
Message-ID: <alpine.DEB.2.02.1406210822590.2074@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 21 Jun 2014, Rusty Russell wrote:

> Hi!
> 
>         In my current project, I moved a field from a structure
> (struct block) into another network-endian structure.  I used the
> following patch.cocci to do the fixups:
> 
>         @ rule1 @
>         struct block *b;
>         @@
>         
>         - b->blocknum
>         + le32_to_cpu(b->hdr->depth)
> 
> It got 99%, but it missed the two cases where b was actually in another
> structure, ie. "te->block->blocknum".
> 
> I *think* this is because I want to substitute any expression of type
> struct block *, rather than only identifiers?
> 
> But I couldn't understand the documentation enough to do this :(

You are already working on expressions.  The problem is that sometimes 
Coccinelle doesn't know what is the type of te->block.  To give it the 
most possible amount of informations, you can give the options

--recursive-includes --relax-include-path

The first means that it will take into account include files that are 
referenced from other include files rather than just those referenced 
directly in the C file.  The second means that if it doesn't find xyz.h in 
the include path but it does find exactly one xyz.h somewhere else in the 
source tree, then it will use that xyz.h, since it has to be the right 
one.

This will probably take more time than it is taking now, because it has to 
parse more code.  You may want to use the option --use-cache so that it 
will cache already parsed code.

julia
