From: wagle@mac.com (Perry Wagle)
Date: Mon, 18 Jul 2016 04:34:14 -0700
Subject: [Cocci] Coccinelle vs Firefox
In-Reply-To: <alpine.DEB.2.10.1607180700380.3156@hadrien>
References: <009C7972-C7EB-4B7F-ABC5-A1C0C1CA5797@mac.com>
 <alpine.DEB.2.10.1607170737330.3253@hadrien>
 <46E0A0AB-6D78-485E-8CEA-2F7639BF12AC@mac.com>
 <alpine.DEB.2.10.1607180700380.3156@hadrien>
Message-ID: <4FC68D32-8853-4DDF-9A36-CAB93A4C16E2@mac.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> On Jul 17, 2016, at 10:11 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> On Sun, 17 Jul 2016, Perry Wagle wrote:
> 
>> If you took coccinelle and somehow retargeted it to ocaml, which I believe
>> it?s implemented in, could you then turn around and use that version to
>> automate excising/abstracting the AST out, and maybe automating the addition
>> of a new/different AST?  In principle, I mean.  In practice, I can think of
>> a few possible problems, but bootstrapping it might help.
> 
> I guess.  I would imagine that reimplementing the whole thing in a more
> generic way would be easier.  But neither is a priority for us.

By ?somehow?, I sorta left out who would do it (probably me).  Was curious as to whether you thought it a cool idea or not.  Appears to be not.  

But my main question was whether extracting and replacing the AST representation was something Coccinelle would help automate for a series of evolving source trees, such as Coccinelle, for this example, or Firefox, for my problem(s).  I?m hoping for a general purpose tool.

I was also wondering if object orientation threw Coccinelle off.  Probably not if you found a way to chase function pointers statically.  Oh wait, Buck Krasic did that for Synthetix.

I need Firefox bookmark tags to index my 2000 page wiki (aka research journal).  Firefox broke tags.  So, because of the way my brain does programming now, I?m stuck having to fix Firefox somehow to make progress on my real projects.

>> This is the sort of transformation I?m looking to do, and, in any case, I
>> want to do things to ocaml itself (and hence coq).
> 
> This person:
> 
> Th?ophane Hufschmitt <theophane.hufschmitt@polytechnique.org>
> 
> worked on something like Coccinelle for OCaml. It was just a summer
> project, but he may have come up with something usable.

Ok, will get in contact with him if I decide to do it this way.

>> PS.  John Viega convinced me in 2001 (personal conversation) that trying to
>> write your own C++ grammar was a PITA, and mostly futile to get perfect.
> 
> The nice part of Coccinele is that we have no need for the grammar to be
> perfect.  Our goal is to convert the source code to an AST, not to be sure
> that the source code is correctly formed.
> 
>>  Since then, I?ve had the stance that using the compiler itself to do the
>> parse was the way to go, but found that GCC was purposely designed not to
>> allow you to do this.  The then new LLVM seemed the way to go, and now its
>> finally matured.  What?s your take on using the compiler?s AST?
> 
> If you use someone else's AST, then you have to live with the information
> that they thought was useful.  Coccinelle needs information about the
> whitespace and commas around each token so that it is able to perform
> transformation, ie rebuild the code exactly as it was outside of the
> transformed parts.  Coccinelle also has the goal of parsing individual
> source code files without expanding macros, to limit the code size, to
> avoid the need to interpret make files, and so that the user can express
> transformations in terms of the code that he sees, ie macro uses.  I don't
> know if LLVM would support that.

I heard something out there tracked whitespace, but I?m not finding it on google.  My impression is that it was LLVM.  Also, there?s an LLVMLinux project <http://llvm.linuxfoundation.org/index.php/Main_Page> that might be interesting to you.  There?s a literature surrounding including documentation in AST?s etc that Andrew Black was surveying around 2003-2004, maybe he published something.

I guess I assume I?m strapping the compiler to a hybrid structure/program-text editor, so maintaining whitespace and comments isn?t an issue.  The trick is to ?connect? the editor?s AST to the compiler?s.  I has wild (probably intractable) notions of how to do that, lemme try that out before confusing people.

>>  I did see a
>> paper recently fly by about using approximation methods instead of full
>> parsing with a compiler, but I can?t find it in my notes right now.  Anyone
>> recognize what I?m talking about?
> 
> The concept of island grammars comes to mind:
> 
> https://en.wikipedia.org/wiki/Island_grammar <https://en.wikipedia.org/wiki/Island_grammar>
Wow..  $177 paywall there.  Darn.

> There was also recently a paper from the group of Dawson Engler about
> doing program analysis for lots of languages using approximate parsing.
> I'm not sure if either is connected to a compiler though.
> 
> Fraser Brown, Andres N?tzli, Dawson R. Engler:
> How to Build Static Checking Systems Using Orders of Magnitude Less Code.
> ASPLOS 2016: 143-157

Ah yeah, that?s the one.  Not finding actual code though.

> julia

? Perry

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160718/d8856f7e/attachment.html>
