From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 23 Aug 2017 11:09:22 +0200 (CEST)
Subject: [Cocci] parsing of C code
In-Reply-To: <34573683-9485-cc29-ee00-f9f1855d03f9@knosof.co.uk>
References: <alpine.DEB.2.20.1708222304510.2050@hadrien>
 <34573683-9485-cc29-ee00-f9f1855d03f9@knosof.co.uk>
Message-ID: <alpine.DEB.2.20.1708231104310.3150@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 22 Aug 2017, Derek M Jones wrote:

> Julia,
>
> > 1.  More aggressive inclusion of header files, combined with caching of
> > header files.  Now if there is only one occurrence of a header file with a
>
> Caching can be dangerous because macros may be defined differently
> for different includes of the same header.  An option to switch off
> caching could come in handy.

I can add such an option.

Actually, I noticed that unfolding macros can sometimes hurt more than it
helps.  When Coccinelle decides to unfold macros it unfolds them for all
the rest of the code, but it only unfolds one level of macro.  Sometimes
the one-level unfolding is weirder than the original and the parser error
that triggered unfoding is not related to macros anyway.  So then the
whole rest of the code has a weird semi-unfolded macro in it for no
purpose, whe it could have compiled normally.  At least for the Linux
kernel, though, this seems like a rare occurrence.

julia
