From: toralf.foerster@gmx.de (=?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?=)
Date: Mon, 28 Jul 2014 19:21:27 +0200
Subject: [Cocci] Fwd: Re: sizeof (struct tYpO *) : it is just a typo or
 rather a bug ?
In-Reply-To: <20140725112038.GA401@khazad-dum.debian.net>
References: <20140725112038.GA401@khazad-dum.debian.net>
Message-ID: <53D68697.9030504@gmx.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Dear cocci,

may I forward to you this email from the LKML, Henrique thinks, that that issue worth a coccinelle patch
:-D


-------- Original Message --------
Subject: Re: sizeof (struct tYpO *) : it is just a typo or rather a bug ?
Date: Fri, 25 Jul 2014 08:20:39 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Toralf F?rster <toralf.foerster@gmx.de>
CC: linux-ia64 at vger.kernel.org, ceph-devel at vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Thu, 24 Jul 2014, Toralf F?rster wrote:
> Inspired by this "typo" fix 
> http://article.gmane.org/gmane.linux.kernel/1754640
> I grep'ed the current git tree of linus for similar issues.

I wonder if we couldn't use Coccinelle to do that?  I would say it would be
not as cool as deep grep magick, but Coccinelle is cool by definition and
therefore immune from any such comparisons :-)

> Nevertheless I was told, that gcc doesn't complain about such things due
> to eventually evaluating it to "sizeof(null)". I'm however curious if at
> least a warning should be emitted in such a case, or?

Well, it cannot become a real bug because the moment the code changes to
actually access/derreference such a typo, it will cause the compiler to
abort with an error.  If gcc will have to waste a measurable amount of time
to issue such a warning, it is not worth it.

OTOH, such typos could confuse someone reading the code into thinking
they're dealing with a different structure or something, and it _is_
incorrect code no matter how harmless, so it makes sense to fix all such
typos eventually.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
