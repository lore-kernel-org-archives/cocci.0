From: hlovdal@gmail.com (=?UTF-8?B?SMOla29uIEzDuHZkYWw=?=)
Date: Thu, 11 Jul 2013 13:31:07 +0200
Subject: [Cocci] metavariables for initialize/finalize
In-Reply-To: <1371730453.3207.16.camel@zamolxis.metaware.tm.fr>
References: <mailman.1.1371722402.18703.cocci@systeme.lip6.fr>
 <1371730453.3207.16.camel@zamolxis.metaware.tm.fr>
Message-ID: <CAACXqO9ZUFrURiE-tFOLr31G_MzTk3K5o0iN_bt1JbvOGx3t3A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 20 June 2013 14:14, Nic Volanschi (R&D) <volanschi@metaware.fr> wrote:

> **
> Personally, I think that adapting old patches to add the second @@ in any
> initialization & finalization rule is very easy to do, even automatically.
> So I see no problem for breaking the backward compatibility on this matter,
> if it simplifies the implementation.
>
>
I think having a simpler language is more important than backwards
compatibility in this case,
so I do not mind either, just make sure that the error message generated
when parsing "old" files
is clear and understandable.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130711/8441e90f/attachment.html>
