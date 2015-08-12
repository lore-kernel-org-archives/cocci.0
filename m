From: kborer@gmail.com (Kris Borer)
Date: Wed, 12 Aug 2015 10:53:41 -0400
Subject: [Cocci] [RFC] coccinelle: add style check for assignment in if
In-Reply-To: <55CB543A.70007@suse.cz>
References: <1439387500-11183-1-git-send-email-kborer@gmail.com>
 <55CB543A.70007@suse.cz>
Message-ID: <CAMy_N63pADkvb4vP=1ReMPpmR7e32TmEE91hELKXTsYnPP+GZA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Aug 12, 2015 at 10:12 AM, Michal Marek <mmarek@suse.cz> wrote:

> On 2015-08-12 15:51, Kris Borer wrote:
> > Add a semantic patch for fixing some cases of checkpatch.pl error:
> >
> > ERROR: do not use assignment in if condition
>
> There is a gcc warning for this already.
>
> Michal
>
>
?My intention was not to create another way to uncover problems but rather
to ?provide a tool for people to use to fix them. Let me know if I am
misunderstanding the purpose of this subsystem.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150812/cc990076/attachment.html>
