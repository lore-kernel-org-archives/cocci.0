From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Tue, 20 Jan 2015 13:24:18 +0100
Subject: [Cocci] Possible to install on OSX?
In-Reply-To: <20150120110023.GA25368@pl-59055.rocqadm.inria.fr>
References: <0F92B6B9-47F3-4A44-8D5A-ED04BC698EF0@gmail.com>
 <alpine.DEB.2.10.1501172308080.2777@hadrien>
 <A2929B64-B34C-4910-8486-16F7E2D2573C@gmail.com>
 <20150119092140.GE1907@pl-59055.rocqadm.inria.fr>
 <71E56961-AF04-469A-8B8D-A3F9BB77C261@gmail.com>
 <20150119155110.GA24065@pl-59055.rocqadm.inria.fr>
 <DA6D9998-6B28-4982-BC25-04787C96111B@gmail.com>
 <20150120083300.GA8575@pl-59055.rocqadm.inria.fr>
 <20150120110023.GA25368@pl-59055.rocqadm.inria.fr>
Message-ID: <5B67F95E-64BD-4C91-88FA-B632B69CBF94@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

No luck. 
I?ve removed gnused, and applied this last patch on top of the previous one you sent yesterday.
Still the error about wrong assumptions in bytes interface.
Logs attached.



> On 20 Jan 2015, at 12:00, S?bastien Hinderer <Sebastien.Hinderer@inria.fr> wrote:
> 
> Dear Eliseo,
> 
> Attached to this e-mail is a patch that should fix the problem we had
> with sed.
> 
> Would you mind trying it to make sure it works, please?
> 
> To test it, you'll have to make sure it is Mac's sed which is invoked by
> make, rather than GNU sed, which may mean removing GNU sed completely to
> be sure.
> 
> Many thanks!
> S?bastien.
> <sed-script-fixup.patch>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.log
Type: application/octet-stream
Size: 29423 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150120/1c80eafc/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: make.log
Type: application/octet-stream
Size: 60952 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150120/1c80eafc/attachment-0003.obj>
