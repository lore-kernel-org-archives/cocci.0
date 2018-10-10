From: timur@kernel.org (Timur Tabi)
Date: Wed, 10 Oct 2018 11:02:35 -0500
Subject: [Cocci] Dummy rule for simplifying "depends on" clauses?
In-Reply-To: <alpine.DEB.2.20.1810101735550.3396@hadrien>
References: <CAOZdJXUWj-U87j6p-AK8wx_V4qRPD2ogyLyOgLE7pSFofzQ_Gw@mail.gmail.com>
 <alpine.DEB.2.21.1810100741210.2477@hadrien>
 <CAOZdJXXgW3SOgiVOKijaooPipwDNUqMm3ScZ0XUU2d3F4Yok8A@mail.gmail.com>
 <alpine.DEB.2.20.1810101735550.3396@hadrien>
Message-ID: <CAOZdJXW8Ve+Rwhg_xjrQR49=0vt1xLfqWWmOp3Z5ieT0fFKnbw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 10, 2018 at 10:37 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
> You can't put multiple @@'s at the beginning of a rule.  This should be
> just:
>
> @r depends on rules@
> ...
> @@

I'll admit, I don't really understand any of the @ syntax.  I must
have copy/pasted too aggressively.  Thanks, it works now.
