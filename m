From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 31 Oct 2014 19:11:30 +0100 (CET)
Subject: [Cocci] [PATCH resent] staging: rtl8188eu: Deletion of
 unnecessary checks before three function calls
In-Reply-To: <5453D013.9000007@users.sourceforge.net>
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
 <5453D013.9000007@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1410311911070.2481@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 31 Oct 2014, SF Markus Elfring wrote:

> >> The functions kfree(), rtw_free_netdev() and vfree() test whether their
> >> argument is NULL and then return immediately. Thus the test around the call
> >> is not needed.
> >>
> >> This issue was detected by using the Coccinelle software.
> >>
> >> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >> ---
> >>  drivers/staging/rtl8188eu/core/rtw_efuse.c   | 3 +--
> >>  drivers/staging/rtl8188eu/core/rtw_mlme.c    | 3 +--
> >>  drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 3 +--
> >>  drivers/staging/rtl8188eu/core/rtw_xmit.c    | 6 ++----
> >>  drivers/staging/rtl8188eu/os_dep/usb_intf.c  | 5 ++---
> >>  5 files changed, 7 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c
> >> b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> >> index 7006088..77f7552 100644
> >> --- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
> >> +++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> >> @@ -212,8 +212,7 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16
> >> _size_byte, u8  *pbuf)
> >>  exit:
> >>  	kfree(efuseTbl);
> >>
> >> -	if (eFuseWord)
> >> -		kfree(eFuseWord);
> >> +	kfree(eFuseWord);
> >
> > I think that this code has been updated already.  It would be better to
> > add labels so that kfree is only executed when needed.
>
> Are there any chances to achieve the suggested fine-tuning for jump labels
> also with another semantic patch approach?

No, I don't think so.  The pattern is not regular enough.

julia
