From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Mon, 19 Jan 2015 12:42:24 +0100
Subject: [Cocci] Possible to install on OSX?
In-Reply-To: <20150119111940.GA8645@pl-59055.rocqadm.inria.fr>
References: <0F92B6B9-47F3-4A44-8D5A-ED04BC698EF0@gmail.com>
 <alpine.DEB.2.10.1501172308080.2777@hadrien>
 <A2929B64-B34C-4910-8486-16F7E2D2573C@gmail.com>
 <20150119092140.GE1907@pl-59055.rocqadm.inria.fr>
 <71E56961-AF04-469A-8B8D-A3F9BB77C261@gmail.com>
 <20150119111940.GA8645@pl-59055.rocqadm.inria.fr>
Message-ID: <BDDE49CA-DC70-440D-8A55-385270F02580@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

No luck :-(

New logs attached.


> On 19 Jan 2015, at 12:19, S?bastien Hinderer <Sebastien.Hinderer@inria.fr> wrote:
> 
> Dear Eliseo,
> 
> Many thanks for the information.
> 
> Is it correct that the version of sed you are using is not GNU sed?
> In that case, would it be possible for you to try installing gnu sed,
> please?
> 
> Once it's done and you are sure that simply running
> sed
> runs gnu SED, can you please make a
> make distclean
> ./configure
> make
> and see whether that works?
> 
> Thanks,
> S?bastien.
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.log
Type: application/octet-stream
Size: 29423 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150119/e33e226c/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: make.log
Type: application/octet-stream
Size: 10865 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150119/e33e226c/attachment-0003.obj>
