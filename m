From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 31 Mar 2017 22:22:22 +0200 (CEST)
Subject: [Cocci] Coccinelle for other languages
In-Reply-To: <CAJi=jad1w-H73utVzboT3nAgNa7ff1BxKC2WyFU_NN8EEHeWYw@mail.gmail.com>
References: <CAJi=jad1w-H73utVzboT3nAgNa7ff1BxKC2WyFU_NN8EEHeWYw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703312215530.2105@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 31 Mar 2017, Jamey Sharp wrote:

> Hi all! Coccinelle is such a fantastic tool that I want to be able to use it
> for programming languages besides C. So I have some questions about that. At
> the moment I particularly care about Rust, but I'm curious about how the
> answers would change for Java or JavaScript or Python or...
>
> What approach would you suggest taking to get a Coccinelle-like tool that
> operates on Rust syntax instead? For example, could just the parsers be
> replaced, leaving most of the rest of the implementation alone? Or are
> assumptions about C baked in throughout the code base, making it perhaps
> easier to rewrite from scratch?

There is a C AST that is used through most of the code base.  The C AST as
been extended to support some of C++.  Perhaps it could be extended to
support some other languages.  But there are many passes, most of which
iterate over the AST, so extending the AST may entail modifying a lot of
code.  We do it often, though, when people ask for new features, so it is
not completely impossible.

>
> How much work do you think is involved in the approach you'd recommend, and
> how much background knowledge is required to work on it? Could a half-dozen
> undergrad students pull it off in six months with sufficient mentoring, or
> does this plan need PhD candidates who already understand CTL? (I can pull
> together a half-dozen undergrads pretty easily; PhD candidates are harder to
> come by.)

The CTL is hidden in its own file, and independent of the language.  On
the other hand complex constructs, like if, while, etc, do need to be
encoded in CTL.

> Finally, are there papers besides the 2009 POPL paper by Brunel et al that I
> should read for background on how Coccinelle is implemented?

I think that is the only one.  This could help to understand the encoding
of if, while, etc.

Looking at this talk first: http://coccinelle.lip6.fr/cocci_internals.pdf
could make the paper more digestable.

julia

> Please Cc me on replies as I'm not subscribed to the list. Thanks for your
> time!
> Jamey
>
>
