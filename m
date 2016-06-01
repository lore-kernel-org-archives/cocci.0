From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 1 Jun 2016 16:54:50 +0200 (CEST)
Subject: [Cocci] Linux scripts/coccinelle/locks/double_lock.cocci not
 working ?
In-Reply-To: <CAGbDTvquEFi0kiJETkgwSQ0h+xuOqqfM-2kpavr0XmR+MZ9abQ@mail.gmail.com>
References: <CAGbDTvoOPvqRYv9MeHst4Xp5oVGT-tRb9Mjnv3M5OhHh9rr+7Q@mail.gmail.com>
 <alpine.DEB.2.10.1605311134010.3420@hadrien>
 <CAGbDTvpA2hmH801q+jcizazYHyi0zCg2RzB2VCsUi-4VwEXeDg@mail.gmail.com>
 <alpine.DEB.2.10.1606011537300.2875@hadrien>
 <CAGbDTvquEFi0kiJETkgwSQ0h+xuOqqfM-2kpavr0XmR+MZ9abQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1606011653580.2875@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 1 Jun 2016, Iago Abal wrote:

> That would help, where do you check virtual rules?

To my recollection, they are just checked on the interpretation of
relevant depends ons.  But they could easily be checked for at the time of
generating the message.

julia
