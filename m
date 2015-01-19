From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Mon, 19 Jan 2015 14:24:44 +0100
Subject: [Cocci] Possible to install on OSX?
In-Reply-To: <BDDE49CA-DC70-440D-8A55-385270F02580@gmail.com>
References: <0F92B6B9-47F3-4A44-8D5A-ED04BC698EF0@gmail.com>
 <alpine.DEB.2.10.1501172308080.2777@hadrien>
 <A2929B64-B34C-4910-8486-16F7E2D2573C@gmail.com>
 <20150119092140.GE1907@pl-59055.rocqadm.inria.fr>
 <71E56961-AF04-469A-8B8D-A3F9BB77C261@gmail.com>
 <20150119111940.GA8645@pl-59055.rocqadm.inria.fr>
 <BDDE49CA-DC70-440D-8A55-385270F02580@gmail.com>
Message-ID: <20150119132444.GA21550@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Eliseo,

> No luck :-(
> 
> New logs attached.

Yeah the situation has improved, actually.

The new problem has been resolved in coccinelle's development repository
but not yet released.

Could you please try to apply the attached patch to your code and let us
know the result?

Thanks,
S?bastien.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: remove-reinit.patch
Type: text/x-diff
Size: 1566 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150119/15655bbb/attachment.bin>
