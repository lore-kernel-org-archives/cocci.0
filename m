From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 29 Oct 2014 16:47:02 +0800
Subject: [Cocci] [PATCH 1/1] staging - rtl8188eu: Deletion of
 unnecessary checks before three function calls
In-Reply-To: <544954FD.8040607@users.sourceforge.net>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <544954FD.8040607@users.sourceforge.net>
Message-ID: <20141029084702.GA18675@kroah.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Oct 23, 2014 at 09:20:29PM +0200, SF Markus Elfring wrote:
> >From 45970693cad6c12da2d5ac7da3d2bd7a566170d7 Mon Sep 17 00:00:00 2001
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 23 Oct 2014 20:55:13 +0200
> Subject: [PATCH] staging - rtl8188eu: Deletion of unnecessary checks before
>  three function calls

Why is this here?  Please use git send-email to send a patch, so I don't
have to hand-edit the text in it.

Also, your Subject is a bit odd, it has a "Re:" in it for no reason, and
your From: doesn't match the name you used here.

Please fix up and resend.

thanks,

greg k-h
