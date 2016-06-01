From: iago.abal@gmail.com (Iago Abal)
Date: Wed, 1 Jun 2016 17:00:28 +0200
Subject: [Cocci] Linux scripts/coccinelle/locks/double_lock.cocci not
 working ?
In-Reply-To: <alpine.DEB.2.10.1606011653580.2875@hadrien>
References: <CAGbDTvoOPvqRYv9MeHst4Xp5oVGT-tRb9Mjnv3M5OhHh9rr+7Q@mail.gmail.com>
 <alpine.DEB.2.10.1605311134010.3420@hadrien>
 <CAGbDTvpA2hmH801q+jcizazYHyi0zCg2RzB2VCsUi-4VwEXeDg@mail.gmail.com>
 <alpine.DEB.2.10.1606011537300.2875@hadrien>
 <CAGbDTvquEFi0kiJETkgwSQ0h+xuOqqfM-2kpavr0XmR+MZ9abQ@mail.gmail.com>
 <alpine.DEB.2.10.1606011653580.2875@hadrien>
Message-ID: <CAGbDTvo0QYoPFdAF30JSJqiY=+M312nQSy8Z8bCh+daLs7oo7A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The error is generated at parsing_cocci/get_constants2.ml but in several
places within that file. How are virtual rules represented in parsing_cocci/
ast_cocci.ml?

Iago

On Wed, Jun 1, 2016 at 4:54 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:

>
>
> On Wed, 1 Jun 2016, Iago Abal wrote:
>
> > That would help, where do you check virtual rules?
>
> To my recollection, they are just checked on the interpretation of
> relevant depends ons.  But they could easily be checked for at the time of
> generating the message.
>
> julia
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160601/d896bea3/attachment-0001.html>
