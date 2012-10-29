From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Mon, 29 Oct 2012 09:28:00 +0100
Subject: [Cocci] semantic patches for C preprocessing constructs?
In-Reply-To: <508D5711.9060402@users.sourceforge.net>
References: <CAP6exYJCAAPUyc4K8dYfLG23Aekb1nEC=O4Cv-R2AL4TEEtABw@mail.gmail.com>
 <alpine.DEB.2.02.1210251318530.1955@hadrien>
 <508A6C2C.5030608@users.sourceforge.net>
 <alpine.DEB.2.02.1210260646230.1977@hadrien>
 <508CF786.7050503@users.sourceforge.net>
 <alpine.DEB.2.02.1210280511160.1952@hadrien>
 <508D5711.9060402@users.sourceforge.net>
Message-ID: <CAAxaTiNPSj=xexkp90cu-8asVbMxnt04O39hmXrQN4zoZHutgQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

On Sun, Oct 28, 2012 at 5:02 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> Huh?  Coccinelle is written in Ocaml.  Matching C preprocessing code
>> requires pervasive changes to its implementation.  Thus it requires
>> knowing the language in which the code is implemented.
>
> I suggest to raise the abstraction level a bit. I see chances to get some
> contributions then from developers who are still more familiar with other
> programming languages. How do you think about model-driven development?
> Can this software design approach improve idea exchange?
> http://en.wikipedia.org/wiki/Model-driven_engineering

Coccinelle should not become a rosseta stone. There is a language OCaml.
You can script in either Python or OCaml.
If you need to improve Coccinelle, learn OCaml.
If you want to script in *YourFavoriteLanguage*, learn OCaml and add
an extension of it.

Model-driven development will not help you to deal with the legacy
which is in OCaml.

One of the ways to make Coccinelle "language-independant" would be to
add an network API.
Feel free to add it and use it in *YourFavoriteLanguage*. But this
extension must be in OCaml too.

Regards,

>
> Regards,
> Markus
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Nicolas Palix
