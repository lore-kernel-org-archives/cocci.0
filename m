From: timur@kernel.org (Timur Tabi)
Date: Wed, 17 Oct 2018 07:15:45 -0500
Subject: [Cocci] __asm statements confuse spatch
In-Reply-To: <alpine.DEB.2.21.1810170720110.2985@hadrien>
References: <CAOZdJXWvGOK3M0w_2N3ZXoLWSeJaJfC-UeHhfo6cG_qyLOFxJw@mail.gmail.com>
 <alpine.DEB.2.21.1810170720110.2985@hadrien>
Message-ID: <6ad4f5bb-9aee-d243-46ef-36ec5a5e6508@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 10/17/18 12:25 AM, Julia Lawall wrote:
> Linux uses __asm__ ( ... ), which is what Coccinelle recognizes.  I can
> probably add _asm and __asm with the braces.  On the other hand, the
> second case, with no delimiter seems awkward.  Does that occur a lot?
> Basically it's not clear how to parse it.  I could have __asm eat up
> everything until the end of the line, but then the third case won't work.

Well, it doesn't occur *a lot*, since it's only one set of files that 
has this problem for me.  I believe this code isn't compiled with gcc, 
which is why the syntax is non-standard.

I don't know if it's worth updating spatch for it.  For now, I just 
manually comment-out the offending code in the C file and then run spatch.

>> Another problem I've having with the source file is that it has
>> inconsistent usage of braces, and sometimes spatch wants to add
>> unnecessary braces that look off.  For example, this:
>>
>>          if (...)
>>              DBG_PRINTF((...));
>>          else
>>              DBG_PRINTF((...));
>>          }
>>
>> (the } belongs to some if-statement much earlier in code somewhere) becomes:
>>
>>          if (...) {
>>              NV_PRINTF(...);
>>          }
>>          else {
>>              NV_PRINTF(...);
>>          }
>>          }
>>
>> I really don't want spatch to add the braces.

> I don't think this has anything to do with the trailing }.  

Sorry, I didn't mean to imply that it does.  My point was that the 
trailing } is in an awkward position already, and when spatch adds its 
own brace, the result looks weird.

> Coccinelle
> knows which brace goes with what, independent of the indentation.
> Something about your rule is making it unsure whether the changed code is
> in a branch by itself, or whether you have added multiple statements.
> 
> For example, if your rule is
> 
> - A;
> + B;
> + C;

Hmmm....  I run some tests with my script to see if anything stands out, 
but the whole purpose of my script is to replace DBG_PRINTF with 
NV_PRINTF.  I never add a second line.

> and the code is if (x) A;, then the braces are needed.  Spatch is a bit
> conservative about this, ie it adds brace unless it is clear that there is
> a replacement of a single statement by another one.
> 
> You could try to track down the problem by making a minimal semantic
> patch and C code that show the problem, or just add some rules to clean
> up afterwards.

What would a clean-up rule look like? Something like this?

-{
NV_PRINTF2(...)
-}
