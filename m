From: wagle@mac.com (Perry Wagle)
Date: Sun, 17 Jul 2016 15:44:23 -0700
Subject: [Cocci] Coccinelle vs Firefox
In-Reply-To: <alpine.DEB.2.10.1607170737330.3253@hadrien>
References: <009C7972-C7EB-4B7F-ABC5-A1C0C1CA5797@mac.com>
 <alpine.DEB.2.10.1607170737330.3253@hadrien>
Message-ID: <46E0A0AB-6D78-485E-8CEA-2F7639BF12AC@mac.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

If you took coccinelle and somehow retargeted it to ocaml, which I believe it?s implemented in, could you then turn around and use that version to automate excising/abstracting the AST out, and maybe automating the addition of a new/different AST?  In principle, I mean.  In practice, I can think of a few possible problems, but bootstrapping it might help.

This is the sort of transformation I?m looking to do, and, in any case, I want to do things to ocaml itself (and hence coq).

PS.  John Viega convinced me in 2001 (personal conversation) that trying to write your own C++ grammar was a PITA, and mostly futile to get perfect.  Since then, I?ve had the stance that using the compiler itself to do the parse was the way to go, but found that GCC was purposely designed not to allow you to do this.  The then new LLVM seemed the way to go, and now its finally matured.  What?s your take on using the compiler?s AST?  I did see a paper recently fly by about using approximation methods instead of full parsing with a compiler, but I can?t find it in my notes right now.  Anyone recognize what I?m talking about?



> On Jul 16, 2016, at 10:47 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> 
> 
> On Sat, 16 Jul 2016, Perry Wagle wrote:
> 
>> Hi ?
>> 
>> I need to comprehend the huge Firefox source, excise the bookmark
>> subsystem, turn it into an extension, hack on the extension to bring
>> back the functionality I need, and drop in the new extension.  Then, I
>> just need to replace the whole thing with something far more advanced
>> than the toy they want to turn it into.
>> 
>> My workflow depends on bookmark tags working thus and so, and I
>> anticipate that this yak shaving expedition will take me a year (since I
>> want to develop tools to do it for me, instead of brute forcing it,
>> which my ag?d brain doesn?t handle any more for programs of this size).
>> One of those tools involves my bookmark tags thing, so its a
>> bootstrapping thing too (fun!).
>> 
>> So my question is whether you guys think Coccinelle would be useful to
>> me in comprehending and doing MASS transformations of the firefox
>> source?  I get the impression from lightly skimming that you concentrate
>> on what I would describe as point fixes, which doesn?t seem the same.
>> But this couldn?t be it all, else you wouldn?t be interested?
>> 
>> The main problem is that firefox is written in a variety of programming
>> languages.  How hard would it be to retarget Coccinelle to those
>> languages?  And how useful for finding excision point for removing the
>> existing bookmarks subsystem might it be?
> 
> Coccinelle was originally designed for doing collateral evolutions.  Ie,
> an interface changes, so how to automate the updating of the users of the
> interface.  But it relies on the user to know what needs to be done.
> There has been a little work on inferring changes from examples (spdiff,
> http://www.diku.dk/~jespera/ <http://www.diku.dk/~jespera/>), but this tends to run "forever" on complex
> cases, and anyway the user still needs to know what to do to make the
> examples in the first place.
> 
> Coccinelle makes some effort to maintain type information, so it can be
> useful for things like finding out where is the function in the probe
> field of the platform_driver structure actually called.
> 
> If you want to know how a pair of functions is used together, then
> Coccinelle could be useful in searching for such uses.  This could be
> useful for counting how often a function is used when a lock is or is not
> held, to decide whether locking is needed.
> 
> But I don't think that Coccinelle would be useful as the main tool in a
> code understanding project.  It is more useful when you know what you want
> to do, but don't want to go through and do it everywhere by hand.
> 
> Coccinelle only works for C, and the part of C++ code that looks pretty
> much like C.  The implementation is based on an AST that is specific to C,
> so retargeting it for java, python, javascript, ruby, perl, whatever would
> probably require quite a bit of work.
> 
> julia
> 
>> At this point, I?m just trying to determine what order to do things in,
>> and where learning Coccinelle fits in, if at all.
>> 
>> Is this enough information for you all to give me an idea, from 20,000
>> feet, of whether Coccinelle makes sense for me or not?  If not, I?ll
>> return in a week with more details.
>> 
>> Thanks!
>> 
>> ? Perry
>> 
>> _______________________________________________
>> Cocci mailing list
>> Cocci at systeme.lip6.fr <mailto:Cocci@systeme.lip6.fr>
>> https://systeme.lip6.fr/mailman/listinfo/cocci <https://systeme.lip6.fr/mailman/listinfo/cocci>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160717/be24781c/attachment-0001.html>
