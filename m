From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 4 May 2016 22:31:21 -0700
Subject: [Cocci] python iteration
In-Reply-To: <CAB=NE6Via6M4yJRZRkWekJ=PXOYoSSD8Ox7k8UMuAnXac2vALA@mail.gmail.com>
References: <alpine.DEB.2.10.1604291843590.3222@hadrien>
 <alpine.DEB.2.10.1604291922561.3222@hadrien>
 <CAB=NE6Via6M4yJRZRkWekJ=PXOYoSSD8Ox7k8UMuAnXac2vALA@mail.gmail.com>
Message-ID: <CAB=NE6UFv8hW7+0ySjBhQATtGbTEM-D=dE3D_pa_93oeB0aL+Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Apr 29, 2016 at 11:20 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>
> * Add support to Coccinelle built-in test infrastructure to allow for
> tests to run against not only C files but also header files, so right
> now we have have:
>
> test.c
> test.cocci
> test.res
>
> This does not allow for header file changes to be tested. We should
> have perhaps instead:
>
> test.c
> test.cocci
> test.c.res
>
> Then allow support also for:
>
> test.c
> test.cocci
> test.c.res
> test.h.res

I actually think we have a generic tool already available to help with
this, I had written SmPL patch equivalence proof support and
integrated that into tools/pycocci.I just posted patches as a proof of
concept.

  Luis
