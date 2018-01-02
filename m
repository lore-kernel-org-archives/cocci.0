From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 2 Jan 2018 15:43:01 +0100 (CET)
Subject: [Cocci] =?utf-8?q?Rename_the_SmPL_script_=E2=80=9Ckzalloc-?=
	=?utf-8?b?4oCmLmNvY2Np4oCdPw==?=
In-Reply-To: <96aee198-15b2-dc96-a349-d8a70d06dc67@users.sourceforge.net>
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
 <ae67a02e-7257-c7e0-f4a1-bdf35a3bb2d0@users.sourceforge.net>
 <alpine.DEB.2.20.1801021528160.24055@hadrien>
 <96aee198-15b2-dc96-a349-d8a70d06dc67@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801021541070.24055@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 2 Jan 2018, SF Markus Elfring wrote:

> >> Now I find that it became more advanced than the previous version.
> >> How do you think about to update also the corresponding file name
> >> (instead of keeping the word ?simple? there)?
> >
> > Why not send a patch for it yourself?
>
> * I would like to check your views around renaming of such files.
>
> * I am unsure which name will be better finally.
>   Would we like to achieve another permalink here?

Actually, according to th original name choice it is stillsimple, becaue
it doesn't account for the possibility of many statement between the alloc
and the memset and it doesn't account for different ways of expressing the
size between the two calls.

If you want to be more general than kzalloc, then perhaps
zalloc-simple.cocci would be ok.

julia
