From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 13 Nov 2014 00:14:38 +0300
Subject: [Cocci] [PATCH v2 2/2] staging: rtl8188eu: Better memory
 clean-up in efuse_phymap_to_logical()
In-Reply-To: <5463C373.5050804@users.sourceforge.net>
References: <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <544954FD.8040607@users.sourceforge.net>
 <20141029084702.GA18675@kroah.com>
 <5453CD0D.9010206@users.sourceforge.net>
 <alpine.DEB.2.10.1410311900201.2481@hadrien>
 <5463C10D.6020409@users.sourceforge.net>
 <5463C373.5050804@users.sourceforge.net>
Message-ID: <20141112211438.GI6749@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Nov 12, 2014 at 09:30:43PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>

Please fix your email client instead.

> +		goto cleanup1;

1) Don't use GW-BASIC label names.  Label names should reflect what the
label does such as free_fuse_word or free_fuse_tabel.

2) Don't use do-nothing labels.  Just return directly.

regards,
dan carpenter
