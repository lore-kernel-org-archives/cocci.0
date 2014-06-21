From: rusty@rustcorp.com.au (Rusty Russell)
Date: Sat, 21 Jun 2014 16:36:29 +0930
Subject: [Cocci] Simple replacement of an expression of given type?
In-Reply-To: <alpine.DEB.2.02.1406210822590.2074@localhost6.localdomain6>
References: <87y4wrtam6.fsf@rustcorp.com.au>
 <alpine.DEB.2.02.1406210822590.2074@localhost6.localdomain6>
Message-ID: <87fviyu4ga.fsf@rustcorp.com.au>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia Lawall <julia.lawall@lip6.fr> writes:
> On Sat, 21 Jun 2014, Rusty Russell wrote:
>
>> Hi!
>> 
>>         In my current project, I moved a field from a structure
>> (struct block) into another network-endian structure.  I used the
>> following patch.cocci to do the fixups:
>> 
>>         @ rule1 @
>>         struct block *b;
>>         @@
>>         
>>         - b->blocknum
>>         + le32_to_cpu(b->hdr->depth)
>> 
>> It got 99%, but it missed the two cases where b was actually in another
>> structure, ie. "te->block->blocknum".
>> 
>> I *think* this is because I want to substitute any expression of type
>> struct block *, rather than only identifiers?
>> 
>> But I couldn't understand the documentation enough to do this :(
>
> You are already working on expressions.  The problem is that sometimes 
> Coccinelle doesn't know what is the type of te->block.  To give it the 
> most possible amount of informations, you can give the options
>
> --recursive-includes --relax-include-path

Ah, thanks for the explanation, and indeed, that worked perfectly.

And thanks Julia and Lars for your quick responses!

Cheers,
Rusty.
