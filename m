From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 31 May 2016 11:34:54 +0200 (CEST)
Subject: [Cocci] Linux scripts/coccinelle/locks/double_lock.cocci not
 working ?
In-Reply-To: <CAGbDTvoOPvqRYv9MeHst4Xp5oVGT-tRb9Mjnv3M5OhHh9rr+7Q@mail.gmail.com>
References: <CAGbDTvoOPvqRYv9MeHst4Xp5oVGT-tRb9Mjnv3M5OhHh9rr+7Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1605311134010.3420@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 30 May 2016, Iago Abal wrote:

> Hi,
>
> It seems that the script scripts/coccinelle/locks/double_lock.cocci distributed with Linux 4.7-rc1 is broken. I'm using using Coccinelle 1.0.4:
>
> Fatal error: exception Failure("False should not be in the final result.? Perhaps your rule doesn't contain any +/-/* code, or you have a failed dependency.? If the problem is not clear, try the option --debug-parse-cocci.")
>
> See https://github.com/torvalds/linux/blob/1a695a905c18548062509178b98bc91e67510864/scripts/coccinelle/locks/double_lock.cocci
>
> Could you confirm if that's the case?

It doesn't look broken.  Did you put either -D org or -D report on the
command line?  If not, it won't know what to do, and it will give a
message like the one you are seeing.

julia
