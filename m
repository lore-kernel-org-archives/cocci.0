From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Tue, 20 Jan 2015 12:00:23 +0100
Subject: [Cocci] Possible to install on OSX?
In-Reply-To: <20150120083300.GA8575@pl-59055.rocqadm.inria.fr>
References: <0F92B6B9-47F3-4A44-8D5A-ED04BC698EF0@gmail.com>
 <alpine.DEB.2.10.1501172308080.2777@hadrien>
 <A2929B64-B34C-4910-8486-16F7E2D2573C@gmail.com>
 <20150119092140.GE1907@pl-59055.rocqadm.inria.fr>
 <71E56961-AF04-469A-8B8D-A3F9BB77C261@gmail.com>
 <20150119155110.GA24065@pl-59055.rocqadm.inria.fr>
 <DA6D9998-6B28-4982-BC25-04787C96111B@gmail.com>
 <20150120083300.GA8575@pl-59055.rocqadm.inria.fr>
Message-ID: <20150120110023.GA25368@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear Eliseo,

Attached to this e-mail is a patch that should fix the problem we had
with sed.

Would you mind trying it to make sure it works, please?

To test it, you'll have to make sure it is Mac's sed which is invoked by
make, rather than GNU sed, which may mean removing GNU sed completely to
be sure.

Many thanks!
S?bastien.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sed-script-fixup.patch
Type: text/x-diff
Size: 711 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150120/31ee857c/attachment-0001.bin>
