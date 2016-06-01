From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 1 Jun 2016 15:39:02 +0200 (CEST)
Subject: [Cocci] Linux scripts/coccinelle/locks/double_lock.cocci not
 working ?
In-Reply-To: <CAGbDTvpA2hmH801q+jcizazYHyi0zCg2RzB2VCsUi-4VwEXeDg@mail.gmail.com>
References: <CAGbDTvoOPvqRYv9MeHst4Xp5oVGT-tRb9Mjnv3M5OhHh9rr+7Q@mail.gmail.com>
 <alpine.DEB.2.10.1605311134010.3420@hadrien>
 <CAGbDTvpA2hmH801q+jcizazYHyi0zCg2RzB2VCsUi-4VwEXeDg@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1606011537300.2875@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 1 Jun 2016, Iago Abal wrote:

> Passing -D indeed it works, thanks! Sorry for the confusion, I didn't know
> about virtual rules.
>
> Perhaps Coccinelle could be a bit more informative in this case? It suggests
> that there was a parse error. Something like "I don't know what to do,
> please note that rules @script:python depends on org@ and @script:python
> depends on report@ are disabled" would have given me a better chance of
> finding the solution myself.
>
> Is it difficult to do that diagnosis or is just that nobody had the time so
> far?

It did tell you to use --debug-parse-cocci :)  But if you didn't know
about virtual rules at all, the result might not be clear.  Perhaps it
could just detect that some virtual rules are declared and none are
selected?  That would be quite simple.

julia


>
> Iago
>
> On Tue, May 31, 2016 at 11:34 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>       On Mon, 30 May 2016, Iago Abal wrote:
>
>       > Hi,
>       >
>       > It seems that the script
>       scripts/coccinelle/locks/double_lock.cocci distributed with
>       Linux 4.7-rc1 is broken. I'm using using Coccinelle 1.0.4:
>       >
>       > Fatal error: exception Failure("False should not be in the
>       final result.? Perhaps your rule doesn't contain any +/-/* code,
>       or you have a failed dependency.? If the problem is not clear,
>       try the option --debug-parse-cocci.")
>       >
>       > Seehttps://github.com/torvalds/linux/blob/1a695a905c18548062509178b98bc91e6751
>       0864/scripts/coccinelle/locks/double_lock.cocci
>       >
>       > Could you confirm if that's the case?
>
>       It doesn't look broken.? Did you put either -D org or -D report
>       on the
>       command line?? If not, it won't know what to do, and it will
>       give a
>       message like the one you are seeing.
>
>       julia
>
>
>
>
