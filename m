From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 3 Nov 2016 20:26:00 +0100 (CET)
Subject: [Cocci] Manipulate identifier like a string ?
In-Reply-To: <CAHKzcENGfx+Q9fUQ_47waCMaJ6nC88Uip7uuF1nZ7=kPdEkUpQ@mail.gmail.com>
References: <CAHKzcENGfx+Q9fUQ_47waCMaJ6nC88Uip7uuF1nZ7=kPdEkUpQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1611032025050.2433@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 3 Nov 2016, Waldemar Rymarkiewicz wrote:

> Hi,
>
> Wondering if there is a quick solution in cocci to replace a suffix in
> a group of identifiers?
>
> I need something like this
>
> @@
> identifier  id  =~ "^XXX_.*";       // say it matches XXX_foo and XXX_bar
> fresh identifier xx =  "YYY" ##  id[3:]      // where id[:3]  takes
> string starting at position 3
>
> @@
> -id
> +xx
>
>
> or is that possible to manipulate identifier in python  and pas it
> back to cocci ?

Yes, the latter is the solution.  Look at demos/pythontococci.cocci.
Write back if anything is not clear.

julia


>
>
> Thanks,
> /Waldek
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
