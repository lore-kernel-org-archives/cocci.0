From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 29 Jun 2015 15:10:36 +0200 (CEST)
Subject: [Cocci] Embedded Python Reference count
In-Reply-To: <623657CD9C4EC04888E24CFF07E08211E13DB9F9@DKAAR-EXDB02.BEUMER.com>
References: <623657CD9C4EC04888E24CFF07E08211E13DB9F9@DKAAR-EXDB02.BEUMER.com>
Message-ID: <alpine.DEB.2.10.1506291509260.2330@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 29 Jun 2015, Aaen, Andreas.Bach wrote:

>
> Hi,
>
> ?
>
> I use Python embedded in a huge legacy C base. The python code calls
> functions in C which then return
>
> The result in Python structures. to build up these structures I use
> functions as PyDict_SetItemString and PyList_Append which insert an item
> into a dictionary or a list. Normally I don't use the inserted item any
> longer and must therefore remember by hand to decrement the reference
> counter to the python item.
>
> ?
>
> have success in finding bugs with this script:
>
> ?
>
> @perfect@
>
> expression E1, E2, E3;
>
> position p;
>
> @@
>
> PyDict_SetItemString at p(E1,E2,E3);
>
> ...
>
> Py_DECREF(E3);
>
> @rule2@
>
> expression E1, E2, E3;
>
> position p != perfect.p;
>
> @@
>
> PyDict_SetItemString at p(E1,E2,E3);
>
> +Py_DECREF(E3);

Do you just want to put

... when != E3
    when strict

here?  The when strict ensures it checks everything, including things that
it interprets as error exits.

julia


>
> ?
>
> ?
>
> This all goes well, except that the script isn't clever enough to see if E3
> actually is referenced later on. Any clues to ensure this script doesn't
> provide me with false positives?
>
> ?
>
> BR
>
> Andreas Bach Aaen
>
>
>
