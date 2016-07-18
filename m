From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 18 Jul 2016 17:39:23 +0200 (CEST)
Subject: [Cocci] Coccinelle vs Firefox
In-Reply-To: <4FC68D32-8853-4DDF-9A36-CAB93A4C16E2@mac.com>
References: <009C7972-C7EB-4B7F-ABC5-A1C0C1CA5797@mac.com>
 <alpine.DEB.2.10.1607170737330.3253@hadrien>
 <46E0A0AB-6D78-485E-8CEA-2F7639BF12AC@mac.com>
 <alpine.DEB.2.10.1607180700380.3156@hadrien>
 <4FC68D32-8853-4DDF-9A36-CAB93A4C16E2@mac.com>
Message-ID: <alpine.DEB.2.10.1607181724100.3217@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 18 Jul 2016, Perry Wagle wrote:

>
>       On Jul 17, 2016, at 10:11 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> On Sun, 17 Jul 2016, Perry Wagle wrote:
>
>       If you took coccinelle and somehow retargeted it to ocaml, which I believe
>       it?s implemented in, could you then turn around and use that version to
>       automate excising/abstracting the AST out, and maybe automating the addition
>       of a new/different AST? ?In principle, I mean. ?In practice, I can think of
>       a few possible problems, but bootstrapping it might help.
>
>
> I guess. ?I would imagine that reimplementing the whole thing in a more
> generic way would be easier. ?But neither is a priority for us.
>
>
> By ?somehow?, I sorta left out who would do it (probably me). ?Was curious as to whether you thought it a cool idea or not. ?Appears to be not. ?

Well, don't let me discourage you :)  I'm more interested in what can be
done with the Linux kernel than what can be done with Coccinelle in
general, so it's more just my perspective than anything else.

> But my main question was whether extracting and replacing the AST representation was something Coccinelle would help automate for a series of evolving source trees, such as Coccinelle, for this example, or Firefox, for my problem(s).
> ?I?m hoping for a general purpose tool.
>
> I was also wondering if object orientation threw Coccinelle off. ?Probably not if you found a way to chase function pointers statically. ?Oh wait, Buck Krasic did that for Synthetix.

No, we don't chase function pointers, or anything else.  Coccinelle
doesn't do any static analysis internally beyond type inference.  The rest
you have to express yourself.  The idea is to favor predictability and it
is hard for a user to predict what results an arbitrary program analysis
will give.  However, if you have analysis information available
externally, it should be possible to use it, although I don't know the
exact status of that feature.

>       If you use someone else's AST, then you have to live with the information
>       that they thought was useful. ?Coccinelle needs information about the
>       whitespace and commas around each token so that it is able to perform
>       transformation, ie rebuild the code exactly as it was outside of the
>       transformed parts. ?Coccinelle also has the goal of parsing individual
>       source code files without expanding macros, to limit the code size, to
>       avoid the need to interpret make files, and so that the user can express
>       transformations in terms of the code that he sees, ie macro uses. ?I don't
>       know if LLVM would support that.
>
>
> I heard something out there tracked whitespace, but I?m not finding it on google. ?My impression is that it was LLVM.

Probably LLVM indeed.  I had a student once who looked into whether the
analysis information maintained by LLVM could be used by Coccinelle, and
he found that the overall AST design strategy was too different for it to
be useful.  But that was quite a number of years ago, and he time was
somewhat limited.

>?Also, there?s an?LLVMLinux project?that might be interesting to you.
>?There?s a literature surrounding including
> documentation in AST?s etc that Andrew Black was surveying around 2003-2004, maybe he published something.
>
> I guess I assume I?m strapping the compiler to a hybrid structure/program-text editor, so maintaining whitespace and comments isn?t an issue. ?The trick is to ?connect? the editor?s AST to the compiler?s. ?I has wild (probably
> intractable) notions of how to do that, lemme try that out before confusing people.
>
>             ?I did see a
>             paper recently fly by about using approximation methods instead of full
>             parsing with a compiler, but I can?t find it in my notes right now. ?Anyone
>             recognize what I?m talking about?
>
>
>       The concept of island grammars comes to mind:
>
>       https://en.wikipedia.org/wiki/Island_grammar
>
>
> Wow.. ?$177 paywall there. ?Darn.

Strange.  Googling for island grammars gives me several pdfs from citeseer
that are immediately accessible.  I think I read this one:

Robust Multilingual Parsing Using Island Grammars. Nikita Synytskyy, James
R. Cordy

julia

>       There was also recently a paper from the group of Dawson Engler about
>       doing program analysis for lots of languages using approximate parsing.
>       I'm not sure if either is connected to a compiler though.
>
>       Fraser Brown, Andres N?tzli, Dawson R. Engler:
>       How to Build Static Checking Systems Using Orders of Magnitude Less Code.
>       ASPLOS 2016: 143-157
>
>
> Ah yeah, that?s the one. ?Not finding actual code though.
>
>       julia
>
>
> ? Perry
>
>
>
