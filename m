From: lists@eitanadler.com (Eitan Adler)
Date: Mon, 22 Oct 2012 12:58:48 -0400
Subject: [Cocci] licensing concerns with cocci patches
Message-ID: <CAF6rxgkr4aQ-b8HpxJ9w8FMOTL63w7GFJqF5FD5MOwaJ3Kni5w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I am interested in adding cocci scripts to the FreeBSD tree as a suite
of scripts that can be used to help find bugs.  I have some concerns
about the license of the "semantic patches" I found.  In particular
quite a few of them are GPLv2 (andand.cocci, ifaddr.cocci,
isnull.cocci, etc). Ordinarily the product of GPL software isn't GPLed
but these seem different as the result is merely a transformation of
patch template.

Is the output of spatch + a GPL semantic patch GPL or can we license
it under a free software license?

-- 
Eitan Adler
