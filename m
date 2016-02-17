From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 17 Feb 2016 10:12:42 -0500 (EST)
Subject: [Cocci] keeping cast affects match?
In-Reply-To: <20160217150737.GB1769@katana>
References: <20160217144548.GA1769@katana>
 <alpine.DEB.2.10.1602170949460.4547@hadrien> <20160217150737.GB1769@katana>
Message-ID: <alpine.DEB.2.10.1602171010540.4547@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 17 Feb 2016, Wolfram Sang wrote:

> > The isomorphism that allows ignoring a cast only works when the type
> > metavariable is used only once.  You uare using it twice.  The fact that
> > you wanted to add it indicates that you really want it to be there.
>
> Aha, I understand. Thank you for the explanation!
>
> > I think that everything should be fine if you just move the (T) out of the
> > removed and added code.
>
> Much better! I still fall for thinking too much in terms of 'lines'
> instead of 'tokens'. Prompt and proper response (again) much
> appreciated. Thank you a ton!

It's worth thinking twice if you find yourself removing something to add
it back.  Sometimes it's just more convenient, or even useful, because
Coccinelle is pretty good now at inserting newlines in the right place for
long argument lists, but when it is at one end or another of the pattern
like this, it can be better to just pull the common part out into the
context.

julia
