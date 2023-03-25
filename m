Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE25EC6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QMi/FQqhevzme1El1VrhXdPKFsq8pNj+6AuGMpdDMdI=;
  b=t7xMTuf4dYRDG7CElIGIfzkSofrZtqo5EmmUjwa/z9gHvG4VNx/npKwz
   TRZ1VceB3jySLExMH1Ada7Q0YUwqaxmEc1dl/2ZfZPP9aKU92ONWHbe5Q
   1w5kB6h67VsLpa3mdVLV876aGUXzjmX0TjUn5H6/eCo+RBy2hmDSDIuKo
   g=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99073778"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 16:36:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1BFD9E0D45; Sat, 25 Mar 2023 16:36:37 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C5ADFE0D42
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 16:36:31 +0100 (CET)
IronPort-SDR: 641f1501_IPf+zdleqALDenGJ99ivuS+cczKZEFI7P4WMUV8YtlD2pWE
 dAYvDXHIqiO4/NHHzm0W0gPAd1i953bTxqRZDeg==
X-IPAS-Result: =?us-ascii?q?A0FoAAB3FB9khwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIH4hiLgOEL4csjCGEAoFWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4JzAoU6Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAEBAhABAQEaCRcHDhAFIoVoDQiCLykBEWSBCAEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBEgJHUz0DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDM?=
 =?us-ascii?q?QexJX8zgQGCCAEBBoJjmScfLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBFSeBFYIsi?=
 =?us-ascii?q?ByCZ4Ioh1aHJYgvCoE0dYEgDoE9gQQCCQIRa4ESCGuBfUACDWQLDm+BSgJkT?=
 =?us-ascii?q?CN7JQQOAxkrHUACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhw0EQIID?=
 =?us-ascii?q?xIPLEQOQjc0EwZcASkLDhEDUIFHBIEKgQEGASYkmnECAYJnAVIvDEwmP4EKL?=
 =?us-ascii?q?g2SWJJAng40B4IogVWBWQyfDAYTLpcIDgaSIy6HLZAPIKd6gWM6gVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIAwNCRWDbo8JAT1ANDsCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 wpoOWWcL48=
IronPort-Data: A9a23:muZSH6g08NKAc3Z3PxYgltInX161bBQKZh0ujC45NGQN5FlHY01je
 htvXG/XPauIZTTxcooiPYW2/E4DuZfSmNVgSQM9riowQipjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqieUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYpdDNEg06/gEk35q+q42lF5gVWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGIFsXYK8yw+BMJWRUy
 9pJJBdRTD2RiLfjqF67YrEEasULKc72IMUAt3smwTyx4fQOG8mZBf+QupkBgXFs7ixNNa62i
 84xTDN1bwnbJTBLNE0WDp0Wg+qiwHXyG9FdgAPE/fVsvDaPpOB3+Ljpc+jqQdiDf9gWuWSqn
 2/l9l3fCShPYbRzzhLcry7y37aR9c/hY6oZE7az99ZxkViLzyoSDgcXXB21u5GEZlWWXtVCN
 woL9yBooaVaGFGXosfVcweZ/Vyuhxgnf99KLctr5CbR6IfG7FPMboQbdQJpZNsjvc4wYDUl0
 F6Vgt/kbQBSXK2ppWG1q+7K9mLjUcQBBTNcPHVZJecQy4O7+OkOYgTzosFLNordYjfdKzzuz
 jaAoTIxirN7YSUji/rlpzgrbxqKoYLVTkYf/AzdV2S5hj6ViaagYJG0r0fW57BMIe51r2VtX
 lBUy6ByD8hXXPlhcRBhps1QTNlFAN7YYVXhbaZHRcVJythU0yfLkXpsyD9/Plx1Fc0PZCXkZ
 kTe0SsIusACYivwMvQvMt/gYyjP8UQGPYu1PhwzRoURCqWdiCfco0mCmGbNgj+2yRFEfV8XY
 MfDIJ/E4Ykm5VRPlWfqGb5Ej9fHNwhnizqbRJbnwg6h3KbWbXH9dFv2GAvmUwzN14vd+F+92
 48HaaOikkwDOMWjPHW/2dNNfDgicyJnbbio8JY/XrDYfWJb9JQJUKK5LUUJINA+wMy4V47go
 hmAZ6Ov4AGl3yeacVXQMysLhXGGdc8XkE/X9BcEZT6As0XPq672hEvGX8toJesU56Z4wORqT
 vIIXcyFD74dAn7E4jkRJ9215oBraB3h10rEMjuHcQoPWcdqZzXI3dv4ISrp1i0FVRSsueUE/
 raP6wL8QLg4fTpEMvr4UvyV8g6OjSAvo94qB0rsCftPSXro67lvenDQjOdoAsQiKifj5zq91
 iTNMyg5uNvino4R2/vKjJCisI2GPbZfHE1bPm+D9pewF3DQ0VSCyL96ctSjXG7iRkbr3p69d
 MNpz/3YG98WrmZg6oZTPe5i8vMj2oHJubRf8DVBIFzKSFaaUpVbPXiM2Jh0hJ1nn7N2l1O/Z
 ROSx4N8J76MBcLCFWwRLioDasCo96kduhvW3MQPDHTK3g1F15vZbhwKJDiJsjJXE5VtOoB8w
 esBht8f2zbitjUUaOS5ngJm3EXSCExYSKg2lIAoMKmygCoR91xyS5j9CCj33ZKxV+txInQae
 j+6uIeShpB35FbzTH4oJH2cgctfncsvvT5J/n8jJnOIuMbP3cFv+Btd9QU2Ewdn9TRc8udJI
 mMwHVZEFaaP2DZJhcZ4QGGnHT9aNiCZ4kDcz1golnXTaluBDEjhCXIbAvmc2nwZ/0Z3XClpz
 JvBxEnLCT/VLdzMhA0sUktbmtnfZN1W9Dyavvu4Hs6ATqIIURC8joCAPWM3+gbaW+Uvj0j6p
 M5vzuZ6SYv/EQUy+6QbKY2r5Y48eSC+Bl5pYK9epfsSPGTmZjuN9yCEKBmxduNzNvX6yxKEJ
 PI0FP1fdSaV9XionmgACL8uMo1EuqcjxOA/d4PBIU8EtLqirQRVjq/AyximhEIWR4RBrMVsD
 KLQaDOILUKIj1R2hWLmjZdJK0i4U/Y+dSz+2+G5qtsIM5c5tMBtbkAA/b+mtFqFMAZc3ky1v
 SGSQ4T03uBd2YBXsI+0KZp6BiKwMsHWeNmT1QKO7+R1ctLENPnRuzMvqlXIOxpcOZ0TUY9Vk
 YuhncHW3kSfmpoLSEHcxoe8EpdW6fWIXOZ4Ntz9KF9Yl3CgXO7u+x4yxHCqG6dWkd9y5tiVe
 CXgUZGeLeUqYtZ6wGFZTwN8EBxHUqT+UfrGlBOH9v+JDkAQ7BzDINaZ7kTWVGB8dBFZC62mX
 0Ww87yr68tDpYtBOA4cCrs0S9VkKVvkQu09e8e3qTCcCXKyj0ifvqf50yAt8izPFmLOBfOSD
 UgpnfQiXE/aVGD0INBlX0hauxoKEDBijON2ck91FxuaTdylJDZuEAjfGcxu5lJofujay5zyI
 j3ABIfnITuoRixKKH0Q//y6NjpyxYUy1hPROTEjuU+ZA8tz6EVsH5M5nhpdD7xKlvcPAQ1px
 RzyOpE9A/Rp/qxUeA==
IronPort-HdrOrdr: A9a23:XNN+pay1Yv+85T2oZiYoKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99073764"
X-MGA-submission: =?us-ascii?q?MDEnYGHXItoduokgar/1k11VaxaDh+WYxUh7Tr?=
 =?us-ascii?q?WaQpEVl1uc+8a0o/LZ3F/RNdgqoAf1J/uBY1bXn3KSBExaOa0gHmnDlI?=
 =?us-ascii?q?PZmgoZi6Cc+xkPXBhdzmDBDtH2+oYyLYLCNMPoSwf6qXxZfxdvtOHx1M?=
 =?us-ascii?q?QTg0vR82B0YIQcHkvoKfxw0w=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 16:36:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679758582; i=markus.elfring@web.de;
	bh=3T3x2IiqtePG6a2K2YwrZN0zdBtVdk10Z/2w/+1ZNX8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=IFfqcAnBptR45OruH46cjNFBy9TnpqO2/+0uYI2nbggCjqq6LZqAq6/iRJZ13BSWO
	 TfKpepyr2ibZ8X9/SebJau2ztI9ORLhuPCnnH9a+LjMi3o5WxEjkMDXZY0nvLma2IS
	 JOiN593yefpPP6e2e4MxQWujtrM0V7IKOZpbpMbZli2C1Lkoc/OL60KDHY/PHKW1zz
	 FENZ8h5iB52s2zypKhG9opV/grXjAUyv9se36TEE6oW1HtyWc6ojdc6JVoTDbnI7fh
	 J+JTSuFJ2hmq9ypgbGn9JUvq2EGAsRISldVszUJW8pyESnOkq1PXSvnNxZIuihZRlJ
	 8WLtSTulercdQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnG2C-1qN9us2BAS-00jHDw; Sat, 25
 Mar 2023 16:36:22 +0100
Message-ID: <e68a714b-32f2-de9f-066e-99a3f51a264f@web.de>
Date: Sat, 25 Mar 2023 16:36:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Stefan Roese <sr@denx.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <72a7bfe2-6051-01b0-6c51-a0f8cc0c93a5@web.de>
 <ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de>
In-Reply-To: <ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ktlSQ5xHwcIT9HhmqAcovoQ6C+E1PCS8pcrBNmY/zwI3O0DE6kp
 fbFTLAvYePWbZt/Pq8SVkSs2sT6nRsL0QIs3LgR6IObXvnX38qwcuRwmeE2+haB8ysYUuq7
 WXQFADTm6n5evGFpxvYbhrBa2uTdLtFQUKZOUqT2dFlRoAf6l0NYNDEK/rTC2IDHmMh14BG
 YaDbNeElwWVPsVwGSsWUA==
UI-OutboundReport: notjunk:1;M01:P0:Vs4lXJFFUoQ=;vaUVJv0AaACH4LlSg7rQ0M/GepR
 y6XMdPCXTDoNeLUiAzTt4jPbAvkfUc0BGO1i7LYzzpnx7/nDX6KahYMy50hWapK+83tmGYZhk
 uAKx/yEpSyGz6cgNjxrV9W/bCO0BmPRqwpghVnVtwlZxSP7fWd928fmtQV4hZyumR01vIeL9C
 FsKmlLRiDBScEch5QEPazr30RtO5qbwPme/6djmCd7lKSn8gNaiKnNjiP8oRuGe7cjz1inDf1
 /WUlIdpE1SVEb1zSkduBpxYDX2vTKOjXyns6ycNdnxFfBoj7VqIcvn/iBTqujXyXuVnpEigcX
 DxIJAJ2WQ0j5qqkY3AgPjb/qhpZkgHuh63vsg7kjku429kAIFH93S3XaUHKk0rqPTWFAW/NoH
 AuC3InyCHXZ0NNT9obi+Dbb23/iWLJdWJGNgpA1q2l4y6t396Esv3bQZNkJIVCADQ6Q5hdKlA
 x0UuO17Tc8pb87QbBrOa0sRXXJ0oI1K3vPwKnL5X1gIh+F8Oq8xFsEU4brjfBzUHpboCmpvij
 NJGELK42/dtHfuj4TqJlFGlY0J1H7PpADn6CRfFJILUkSdXaN1DIs9eeNv2RBucuR3vZlpDrn
 u6PDDzPryV74Dy0hTmJQxtY9WZkLttnNc0SY/zDJfNfCRQ230/0l+pwdrBmeBQZhW8G5dGFh+
 dR4xkeZjG9y5EqsAYYctP4DxDIaa8uqzoKMZ986Sb45j8FVly0ANwm54Dh/QnHRbhcrh0YoCt
 yO6iI2lLaRFdcN6YtqRKMcwl+mXM8CgGB+yJ4/kPAMz19pBSH1pyqBpdMtihWtbMWPxfKg4UV
 mM4cnBbOK9uoaSrPHNlnNjRtS7vnr9xuHpeY4z6WnLn2jXXNxtAZwz3AiOy35w7zNMc4Drg1f
 Orqxra6mc+PcR1hOp/i6NfSJRZN0Q1TtfER5/gCBhuT0yMNN8Ryil1ylu
Subject: [cocci] [PATCH v2 1/4] powerpc/4xx: Fix exception handling in
 ppc4xx_pciex_port_setup_hose()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 953
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/e68a714b-32f2-de9f-066e-99a3f51a264f%40web.de>

Date: Thu, 16 Mar 2023 19:00:57 +0100

The label =E2=80=9Cfail=E2=80=9D was used to jump to another pointer check=
 despite of
the detail in the implementation of the function =E2=80=9Cppc4xx_pciex_por=
t_setup_hose=E2=80=9D
that it was determined already that the corresponding variable contained
a null pointer (because of a failed function call in three cases).

1. Thus return directly after a call of the function =E2=80=9Cpcibios_allo=
c_controller=E2=80=9D failed.

2. Use more appropriate labels instead.

3. Reorder jump targets at the end.

4. Delete two questionable checks.


This issue was detected by using the Coccinelle software.

Fixes: a2d2e1ec07a80946cbe812dc8c73291cad8214b2 ("[POWERPC] 4xx: PLB to PC=
I Express support")
Fixes: 80daac3f86d4f5aafc9d3e79addb90fa118244e2 ("[POWERPC] 4xx: Add endpo=
int support to 4xx PCIe driver")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/4xx/pci.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/pci.c b/arch/powerpc/platforms/4xx=
/pci.c
index ca5dd7a5842a..7336c7039b10 100644
=2D-- a/arch/powerpc/platforms/4xx/pci.c
+++ b/arch/powerpc/platforms/4xx/pci.c
@@ -1930,7 +1930,7 @@ static void __init ppc4xx_pciex_port_setup_hose(stru=
ct ppc4xx_pciex_port *port)
 	/* Allocate the host controller data structure */
 	hose =3D pcibios_alloc_controller(port->node);
 	if (!hose)
-		goto fail;
+		return;

 	/* We stick the port number in "indirect_type" so the config space
 	 * ops can retrieve the port data structure easily
@@ -1962,7 +1962,7 @@ static void __init ppc4xx_pciex_port_setup_hose(stru=
ct ppc4xx_pciex_port *port)
 		if (cfg_data =3D=3D NULL) {
 			printk(KERN_ERR "%pOF: Can't map external config space !",
 			       port->node);
-			goto fail;
+			goto free_controller;
 		}
 		hose->cfg_data =3D cfg_data;
 	}
@@ -1974,7 +1974,7 @@ static void __init ppc4xx_pciex_port_setup_hose(stru=
ct ppc4xx_pciex_port *port)
 	if (mbase =3D=3D NULL) {
 		printk(KERN_ERR "%pOF: Can't map internal config space !",
 		       port->node);
-		goto fail;
+		goto recheck_cfg_data;
 	}
 	hose->cfg_addr =3D mbase;

@@ -2007,7 +2007,7 @@ static void __init ppc4xx_pciex_port_setup_hose(stru=
ct ppc4xx_pciex_port *port)

 	/* Parse inbound mapping resources */
 	if (ppc4xx_parse_dma_ranges(hose, mbase, &dma_window) !=3D 0)
-		goto fail;
+		goto unmap_io_mbase;

 	/* Configure outbound ranges POMs */
 	ppc4xx_configure_pciex_POMs(port, hose, mbase);
@@ -2064,13 +2064,14 @@ static void __init ppc4xx_pciex_port_setup_hose(st=
ruct ppc4xx_pciex_port *port)
 	}

 	return;
- fail:
-	if (hose)
-		pcibios_free_controller(hose);
+
+unmap_io_mbase:
+	iounmap(mbase);
+recheck_cfg_data:
 	if (cfg_data)
 		iounmap(cfg_data);
-	if (mbase)
-		iounmap(mbase);
+free_controller:
+	pcibios_free_controller(hose);
 }

 static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
=2D-
2.40.0

