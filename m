From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 21 Jun 2014 08:27:11 +0200
Subject: [Cocci] Simple replacement of an expression of given type?
In-Reply-To: <87y4wrtam6.fsf@rustcorp.com.au>
References: <87y4wrtam6.fsf@rustcorp.com.au>
Message-ID: <53A525BF.5060205@metafoo.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 06/21/2014 01:38 AM, Rusty Russell wrote:
> Hi!
>
>          In my current project, I moved a field from a structure
> (struct block) into another network-endian structure.  I used the
> following patch.cocci to do the fixups:
>
>          @ rule1 @
>          struct block *b;
>          @@
>
>          - b->blocknum
>          + le32_to_cpu(b->hdr->depth)
>
> It got 99%, but it missed the two cases where b was actually in another
> structure, ie. "te->block->blocknum".
>
> I *think* this is because I want to substitute any expression of type
> struct block *, rather than only identifiers?
>
> But I couldn't understand the documentation enough to do this :(

This should work. But by default coccinelle does not parse global headers, 
so if the struct for te is defined in a global header it won't know that 
te->block is of type 'struct block *'. If that is the case try to run it 
with --all-includes

- Lars
