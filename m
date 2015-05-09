From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 9 May 2015 14:29:06 +0200 (CEST)
Subject: [Cocci] Checking for null pointers
In-Reply-To: <CABBGRWt7k-3xxFVgeYcPwdjAVxJ6jfUuEdKrcDk8_2BQ06+PGg@mail.gmail.com>
References: <CABBGRWueC78515AqDfkX4buzjipbkNhAvZ5G5OAkWhX+4WwAuA@mail.gmail.com>
 <554DB33D.2000000@users.sourceforge.net>
 <CABBGRWvwuuVAyB_re1h-W4p2Gye-r195x5yjaxnURzuZX2Gaqg@mail.gmail.com>
 <554DE908.5060009@users.sourceforge.net>
 <CABBGRWtb1aectYA8M62QwdScdPjBnDaK+GrT0PDtx1ach0a=SA@mail.gmail.com>
 <554DF181.5070707@users.sourceforge.net>
 <CABBGRWt7k-3xxFVgeYcPwdjAVxJ6jfUuEdKrcDk8_2BQ06+PGg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1505091427300.2098@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

When there are things you are interested in and things you are not 
interested in, you can use a disjunction:

(
uninteresting
|
uninteresting
|
uninteresting
|
* interesting
)

In the place of uninteresting you could put for example *x = y, if you 
consider that to be uninteresting.  And in the place of interesting, you 
could put for example *x.

julia
