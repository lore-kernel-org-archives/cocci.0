From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 12 Jan 2018 19:50:13 +0100 (CET)
Subject: [Cocci] Support for macro expansion
In-Reply-To: <CALt5rJt=t1iHb42+hMPEoxqV12EMt+jge2e5AXaASAFGzpt_Ew@mail.gmail.com>
References: <CALt5rJt=t1iHb42+hMPEoxqV12EMt+jge2e5AXaASAFGzpt_Ew@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1801121947510.3042@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 12 Jan 2018, Martijn Coenen wrote:

> Hello,
> I can't find a clear-cut answer on whether macro expansion is supported in
> Coccinelle. There's a "--preprocess" option which says it runs the C
> preprocessor before doing the match, but it didn't appear to do anything
> when I tried it.
>
> Background: I'm trying to do a semantic patch that is only applied when a
> certain function is called or assigned. Unfortunately in some cases, the
> function call is embedded in a macro, and so Coccinelle will not find it.
> I'm aware I can manually define a macros file and have it expanded this way,
> but I want to make this as generic as possible and have it work for any
> function in the linux kernel - which means I'd have to put *lots* of macros
> in there :)
>
> Any suggestions?

Is it possible to parse the macro? That is, is the body a legal C
statement or expression?

Normally, macros are only unfolded when doing so is necessary to parse the
context in which the macro occurs.  But when a macro is unfolded for that
reason, it is not possible to transform the unfolded code, although it is
possible to match it.

It is indeed possible that the --preprocess argument does not do anything.

julia
