From: rusty@rustcorp.com.au (Rusty Russell)
Date: Sat, 21 Jun 2014 09:08:41 +0930
Subject: [Cocci] Simple replacement of an expression of given type?
Message-ID: <87y4wrtam6.fsf@rustcorp.com.au>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!

        In my current project, I moved a field from a structure
(struct block) into another network-endian structure.  I used the
following patch.cocci to do the fixups:

        @ rule1 @
        struct block *b;
        @@
        
        - b->blocknum
        + le32_to_cpu(b->hdr->depth)

It got 99%, but it missed the two cases where b was actually in another
structure, ie. "te->block->blocknum".

I *think* this is because I want to substitute any expression of type
struct block *, rather than only identifiers?

But I couldn't understand the documentation enough to do this :(

Clues appreciated!
Rusty.
