From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 10 May 2017 23:26:29 +0800 (SGT)
Subject: [Cocci] Coccinelle for other languages : Assembly
In-Reply-To: <CAMryFvRfDLaPH25=D57y4vqc_+C=VO-JGQgSaCwYW6ph22zd2w@mail.gmail.com>
References: <CAMryFvRfDLaPH25=D57y4vqc_+C=VO-JGQgSaCwYW6ph22zd2w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1705102324040.3019@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 10 May 2017, Nisal Menuka wrote:

> Hi,?I was able to successfully use coccinelle for C files, and was thinking
> on the possibility of using the platform for other languages. I have some
> questions regarding coccinelle.?
> 1. Is it possible to configure coccinelle to parse Assembly code??
> 2. Is it possible to integrate parsers from other languages in to
> coccinelle??

Sorry, but no on both counts.  Coccinelle is implemented as a series of
passes, like a compiler, and all of those passes use the abstract syntax
of C.  Unlike some other approaches, there is no more generic intermediate
language, because we want to be able to generate code that looks like
handwritten source code in the end.

For assembly code, maybe you could rewrite it to be C-like.  Eg

mov r1,r2

could become

mov(r1,r2);

And then you would have to undo the rewriting at the end.

julia
