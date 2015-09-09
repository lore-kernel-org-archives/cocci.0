From: kieranbingham@gmail.com (Kieran Bingham)
Date: Wed, 9 Sep 2015 16:18:26 +0100
Subject: [Cocci] White space formatting
In-Reply-To: <CAB3z_RqDzy-OjJxuiXEaTGZg6M=jw7rrDQZy1Q4DdyPLpXJjSQ@mail.gmail.com>
References: <CAB3z_RouDi7OcMBM3nZx2SKv6NRR6wb0TLRLqzQ9_jE49AHGUg@mail.gmail.com>
 <alpine.DEB.2.10.1509091603370.2798@hadrien>
 <CAB3z_RpF=3hXRrEgNCpPS96FUBTYKCt9E+EmNQ_1qQ=jPrVD6w@mail.gmail.com>
 <55F04AD1.2040009@users.sourceforge.net>
 <CAB3z_RqDzy-OjJxuiXEaTGZg6M=jw7rrDQZy1Q4DdyPLpXJjSQ@mail.gmail.com>
Message-ID: <CAB3z_RreJKU2fzXaDOA=HJfBToquEauX_H_JURy42C-0sx0VxQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Markus,

On 9 September 2015 at 16:08, Kieran Bingham <kieranbingham@gmail.com> wrote:
> On 9 September 2015 at 16:05, SF Markus Elfring
> <elfring@users.sourceforge.net> wrote:
>>> Hmm.. This will be a self compile then.
>>
>> How do you think about to try the OPAM interface out for this purpose then?
>> https://opam.ocaml.org/packages/coccinelle/coccinelle.1.0.2/
>
> I'll give it a go now ...

That was relatively painless, I had to install a package as suggested
by  OPAM, and then retry - but after that :

spatch --version
spatch version 1.0.2 with Python support and with PCRE support


(with a sudo apt-get remove coccinelle to get rid of the existing
installation too)


Thanks for the pointer :)
--
Regards

Kieran
