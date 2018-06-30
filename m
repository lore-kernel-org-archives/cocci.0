From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 30 Jun 2018 13:30:24 +0200
Subject: [Cocci] Increasing usage of array allocation functions with SmPL
In-Reply-To: <CAGXu5j+XA87CBA9Xbqb4C-wLndaNW+usPgA9043m4TDeFUcxpw@mail.gmail.com>
References: <CAGXu5j+XA87CBA9Xbqb4C-wLndaNW+usPgA9043m4TDeFUcxpw@mail.gmail.com>
Message-ID: <4e2c98c2-0411-ff79-143b-3be2b9930913@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I've been doing some large treewide changes to the allocators,

I find your update suggestion ?mm: Use overflow helpers in kmalloc_array*()? interesting.

https://lkml.org/lkml/2018/5/31/877
https://patchwork.kernel.org/patch/10442283/
https://lkml.kernel.org/r/<20180601004233.37822-7-keescook@chromium.org>


It seems that corresponding work became noteworthy news ?4.18 Merge window, part 2?.
https://lwn.net/Articles/757187/


Now I am curious on how software evolution will be continued according to such
a transformation pattern.
https://patchwork.kernel.org/project/LKML/list/?state=*&q=alloc_array


> and I notice that Coccinelle does something odd for a specific case.

Will there happen any more evolution in this software area?

Regards,
Markus
