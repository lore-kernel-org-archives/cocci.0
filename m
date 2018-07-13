From: asmadeus@codewreck.org (Dominique Martinet)
Date: Fri, 13 Jul 2018 18:11:38 +0200
Subject: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
 strlcpy
In-Reply-To: <alpine.DEB.2.20.1807130647460.3063@hadrien>
 <20180713091412.GA11250@himanshu-Vostro-3559>
Message-ID: <20180713161138.GA17418@nautica>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Himanshu Jha wrote on Fri, Jul 13, 2018:
> Try this:
> 
> $ spatch -D patch --sp-file strlcopy.cocci --very-quiet drivers/net/wireless/ti/wl1251/acx.c
> 
> ---------------------------------------------------------------------
> virtual patch
> 
> @depends on patch@
> expression dest, src, sz; 
> identifier f;
> @@
> 
> (
> - strncpy(
> + strlcpy(
>   dest, src, sizeof(sz));
> - dest[sizeof(sz) - 1] = '\0';
> |
> - strncpy(
> + strlcpy(
>   dest, src, f); 
> - dest[f - 1] = '\0';
> )
> ---------------------------------------------------------------------
> 
> This eliminates that case because expression is generic metavariable and
> it somehow matched whole "min(len, sizeof(...)..", so it better to
> divide the rules as done above to be more specific about the matching
> pattern.
> 
> I thought to replace "identifier f" with "constant F" but that misses
> few cases.

My first test started with 'constant sz' as well and I found expression
to be better.
If I understand this correctly, it just makes sure not to match the
'min(...)' expression so the problem doesn't arise, but it's not really
a solution as it is really a chance that this comment comes here for
this more complex expression.
I'd rather just advise to pay attention to comments and drop the
confidence level

> Also, it is advised to put a space affer '+/-'

Ok, thanks

Julia Lawall wrote on Fri, Jul 13, 2018:
> For the file drivers/net/wireless/ti/wl1251/acx.c, the following keeps the
> comment before the buf update and moves the strlcpy call below it.  It
> does however drop the comment just before the original call to strncpy.

Nice, doing it in two passes does the trick; it even keeps the comment
before strncpy if there was no comment in between.

I'm sorry to write that after being provided with such a nice
work-around though, now that I'm a bit less tired I've had a look at the
comments again and it does not make sense to keep the second comment as
is -- the whole point of using strlcpy (or now strscpy as per feedback
elsewhere) is that the string will be null terminated properly after the
call, so I'll stick to the original version.


I also see the position does not seem to be useful for the patch phase,
spatch automatically only applies only to what was matched earlier in
report mode?

>>> +-strncpy at p
>>> ++strlcpy
>>> +        (dest, src, sz);
>>
>> This also came from the example I picked, but if this does not make a
>> difference as it sounds like I will update to that.
>
> Probably not removing something just to add it back would be a good
> idea.

Actually playing with your example made me realize that removing and
re-adding argument does fix the indentation issue in the original code I
had noticed for mptctl, so it might actually unexpectedly be a good idea
to go in the opposite direction and make coccinelle remove/add arguments
in the general case (e.g. if strncpy and strlcpy hadn't been the same
length)

The jury is still out for this one :)


Thanks for all the feedbacks,
-- 
Dominique Martinet
