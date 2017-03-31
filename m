From: jamey@minilop.net (Jamey Sharp)
Date: Fri, 31 Mar 2017 13:12:49 -0700
Subject: [Cocci] Coccinelle for other languages
Message-ID: <CAJi=jad1w-H73utVzboT3nAgNa7ff1BxKC2WyFU_NN8EEHeWYw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi all! Coccinelle is such a fantastic tool that I want to be able to use
it for programming languages besides C. So I have some questions about
that. At the moment I particularly care about Rust, but I'm curious about
how the answers would change for Java or JavaScript or Python or...

What approach would you suggest taking to get a Coccinelle-like tool that
operates on Rust syntax instead? For example, could just the parsers be
replaced, leaving most of the rest of the implementation alone? Or are
assumptions about C baked in throughout the code base, making it perhaps
easier to rewrite from scratch?

How much work do you think is involved in the approach you'd recommend, and
how much background knowledge is required to work on it? Could a half-dozen
undergrad students pull it off in six months with sufficient mentoring, or
does this plan need PhD candidates who already understand CTL? (I can pull
together a half-dozen undergrads pretty easily; PhD candidates are harder
to come by.)

Finally, are there papers besides the 2009 POPL paper by Brunel et al that
I should read for background on how Coccinelle is implemented?

Please Cc me on replies as I'm not subscribed to the list. Thanks for your
time!
Jamey
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170331/543c8de3/attachment.html>
