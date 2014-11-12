From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 12 Nov 2014 21:20:29 +0100
Subject: [Cocci] [PATCH v2 0/2] staging: rtl8188eu: Deletion of a few
 unnecessary checks
In-Reply-To: <alpine.DEB.2.10.1410311900201.2481@hadrien>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <544954FD.8040607@users.sourceforge.net>
 <20141029084702.GA18675@kroah.com> <5453CD0D.9010206@users.sourceforge.net>
 <alpine.DEB.2.10.1410311900201.2481@hadrien>
Message-ID: <5463C10D.6020409@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 12 Nov 2014 20:42:18 +0100

Another update suggestion was taken into account after patches were applied
from static source code analysis.

Markus Elfring (2):
  staging: rtl8188eu: Deletion of unnecessary checks before three
    function calls
  staging: rtl8188eu: Better memory clean-up in efuse_phymap_to_logical()

 drivers/staging/rtl8188eu/core/rtw_efuse.c   | 13 ++++++++-----
 drivers/staging/rtl8188eu/core/rtw_mlme.c    |  3 +--
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c |  3 +--
 drivers/staging/rtl8188eu/core/rtw_xmit.c    |  6 ++----
 drivers/staging/rtl8188eu/os_dep/usb_intf.c  |  6 +++---
 5 files changed, 15 insertions(+), 16 deletions(-)

-- 
2.1.3
