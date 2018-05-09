From: mcuddie@gmail.com (Mitchell Cuddie)
Date: Wed, 9 May 2018 11:48:09 -0400
Subject: [Cocci] Blocks Support?
In-Reply-To: <alpine.DEB.2.20.1805052015060.2553@hadrien>
References: <CADZ9DPx6=rs2vBrauhsLeBbrjT6798KkgAYnRLr16eu_UsKKJA@mail.gmail.com>
 <alpine.DEB.2.20.1804171639391.4631@hadrien>
 <alpine.DEB.2.20.1805052015060.2553@hadrien>
Message-ID: <1EE6577B-3846-4B45-AB1A-C9A1CBD28A58@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia,

The original patch I was looking at uses nested functions heavily and required modifying them. I will look for a different strategy on this patch and see if there is a better example elsewhere.

Mitchell

> On May 5, 2018, at 2:16 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> 
> 
> On Tue, 17 Apr 2018, Julia Lawall wrote:
> 
>> 
>> 
>> On Tue, 17 Apr 2018, Mitchell Cuddie wrote:
>> 
>>> Has anyone looked at supporting the blocks extension in Coccinelle?
>>> https://clang.llvm.org/docs/BlockLanguageSpec.html
>>> 
>>> There are a number of large projects like WebKit that could make use of
>>> Coccinelle if it could parse the code. Any thoughts?
>> 
>> Looking extremely quickly it looks like it could be possible.  Do you just
>> want the parser not to crash or to change this kind of code.  Could you
>> send a small typical example?
> 
> Currently, Coccinelle doesn't support nested function definitions.
> 
> Are these blocks used heavily in the code you are interested in?  If
> Coccinelle can't parse one function, it will just move on to the next one.
> 
> julia
