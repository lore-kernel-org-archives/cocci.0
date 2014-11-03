From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 03 Nov 2014 15:10:40 +0100
Subject: [Cocci] [PATCH resent] ALSA: emu10k1: Deletion of unnecessary
 checks before three function calls
In-Reply-To: <s5ha94839dx.wl-tiwai@suse.de>
References: <5307CAA2.8060406@users.sourceforge.net>	<alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>	<530A086E.8010901@users.sourceforge.net>	<alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>	<530A72AA.3000601@users.sourceforge.net>	<alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>	<530B5FB6.6010207@users.sourceforge.net>	<alpine.DEB.2.10.1402241710370.2074@hadrien>	<530C5E18.1020800@users.sourceforge.net>	<alpine.DEB.2.10.1402251014170.2080@hadrien>	<530CD2C4.4050903@users.sourceforge.net>	<alpine.DEB.2.10.1402251840450.7035@hadrien>	<530CF8FF.8080600@users.sourceforge.net>	<alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>	<530DD06F.4090703@users.sourceforge.net>	<alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>	<5317A59D.4@users.sourceforge.net>	<54567788.9060008@users.sourceforge.net>
 <s5ha94839dx.wl-tiwai@suse.de>
Message-ID: <54578CE0.1090201@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Your patch can't be applied cleanly due to your MUA breaking the
> lines.  Please fix your MUA setup, or use an attachment if it's
> impossible, and resend the patch.

Thanks for your feedback.

Does this example show a conflict between long comments like
"snd_emu10k1_ctl_private_free( ... *kctl)" after patch ranges and line length
limitation for email eventually?


> Also, try to align the subject line with the relevant commits.  See
> "git log sound/pci/emu10k1"

I have attached my update suggestion with a slightly different commit title as
before. Is this variant acceptable?

Regards,
Markus
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ALSA-emu10k1-Deletion-of-unnecessary-checks-before-t.patch
Type: text/x-patch
Size: 2120 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141103/7a73952b/attachment.bin>
