From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Tue, 20 Jan 2015 14:28:44 +0100
Subject: [Cocci] Possible to install on OSX?
In-Reply-To: <20150120132253.GA27243@pl-59055.rocqadm.inria.fr>
References: <0F92B6B9-47F3-4A44-8D5A-ED04BC698EF0@gmail.com>
 <alpine.DEB.2.10.1501172308080.2777@hadrien>
 <A2929B64-B34C-4910-8486-16F7E2D2573C@gmail.com>
 <20150119092140.GE1907@pl-59055.rocqadm.inria.fr>
 <71E56961-AF04-469A-8B8D-A3F9BB77C261@gmail.com>
 <20150119155110.GA24065@pl-59055.rocqadm.inria.fr>
 <DA6D9998-6B28-4982-BC25-04787C96111B@gmail.com>
 <20150120083300.GA8575@pl-59055.rocqadm.inria.fr>
 <20150120110023.GA25368@pl-59055.rocqadm.inria.fr>
 <5B67F95E-64BD-4C91-88FA-B632B69CBF94@gmail.com>
 <20150120132253.GA27243@pl-59055.rocqadm.inria.fr>
Message-ID: <85CD4387-710E-4369-BBA4-028126F58B02@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

There is no commons/.depend in the clean checkout state I start from.
Just in case, I run it again, checking there was no commons/.depend.
Same result. Logs attached.


> On 20 Jan 2015, at 14:22, S?bastien Hinderer <Sebastien.Hinderer@inria.fr> wrote:
> 
> Hi,
> 
>> I?ve removed gnused, and applied this last patch on top of the previous one you sent yesterday.
>> Still the error about wrong assumptions in bytes interface.
> 
> Can you please do
> 
> rm commons/.depend
> 
> and run make again?
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
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150120/5c49af87/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: make.log
Type: application/octet-stream
Size: 60952 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150120/5c49af87/attachment-0003.obj>
