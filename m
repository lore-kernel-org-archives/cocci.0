From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 13 Nov 2014 01:05:40 +0300
Subject: [Cocci] [PATCH v2 2/2] staging: rtl8188eu: Better memory
 clean-up in efuse_phymap_to_logical()
In-Reply-To: <5463D62D.3010206@users.sourceforge.net>
References: <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <544954FD.8040607@users.sourceforge.net>
 <20141029084702.GA18675@kroah.com>
 <5453CD0D.9010206@users.sourceforge.net>
 <alpine.DEB.2.10.1410311900201.2481@hadrien>
 <5463C10D.6020409@users.sourceforge.net>
 <5463C373.5050804@users.sourceforge.net>
 <20141112211438.GI6749@mwanda>
 <5463D62D.3010206@users.sourceforge.net>
Message-ID: <20141112220540.GK5351@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Nov 12, 2014 at 10:50:37PM +0100, SF Markus Elfring wrote:
> >> +		goto cleanup1;
> > 
> > 1) Don't use GW-BASIC label names.  Label names should reflect what the
> > label does such as free_fuse_word or free_fuse_tabel.
> > 
> > 2) Don't use do-nothing labels.  Just return directly.
> 
> Does the document "CodingStyle" need any extensions for special cases?

I don't understand.

> Are there any update candidates in the chapter "7: Centralized exiting of functions"?

CodingStyle says:

"If there is no cleanup needed then just return directly."

What is not clear about that?

regards,
dan carpenter
