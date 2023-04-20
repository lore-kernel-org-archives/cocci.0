Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0570C77B72
	for <cocci@archiver.kernel.org>; Thu, 20 Apr 2023 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FmSSQc4bR0Qo7n88qq9NjUT4kepUoR0Qu36M4esq3FA=;
  b=deKUe/s7RJGbiNnhvehRV5ZlgNghkMOLDbPOF9Jspf+nFpvfBzjELRAv
   HV/AzK7S8KD9S0UNmE81s7TWbDrfvrpc2ULGDrmdwBasEaVlYsHDedDEq
   g40Ls7p50/AhCl9DVklcG1p1vbjjFHa3+rpcUDx4F3FH2KsRKl6OHZvH8
   4=;
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
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="104014127"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Apr 2023 16:34:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 234E4E0269; Thu, 20 Apr 2023 16:34:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4C3BEE019E
	for <cocci@sympa.inria.fr>; Thu, 20 Apr 2023 16:34:24 +0200 (CEST)
IronPort-SDR: 64414d6f_VX8yuPhxaIHs2J0GE+W3gyko5Q3AOJCjglvfBKPNHK+hHA+
 aPRwUNLKDFvh1GJyFVSEAfwXAoIPGZAe6dw38/A==
X-IPAS-Result: =?us-ascii?q?A0EIAAD/S0FkhwQP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE8BAEBAQELAYItgUsvBAtGhFORNoQwhy6HPoRnhAOBVoFAP?=
 =?us-ascii?q?g8BAwENQQECBAEBAwQ4gzOBFAKFPQIdBwEEMQgOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQESAkc+AwMjBBkBAREmAQ8fBgIfBwICVwYBDAYCA?=
 =?us-ascii?q?QGCeoIoAQMxB6sPfzOBAYIIAQEGnAwfLCJUgV4JgRQtAYxVP4M2eicPgVVEg?=
 =?us-ascii?q?TyCU2+EC4QUgmeVT0WBM3SBJ4EzgQQCCQIRa4EQCGg4gTtAAg1kCw5ugUVgR?=
 =?us-ascii?q?oFyBAIUQgwYBTUlBA4DGSsdQAIBCzs6PTUGAwsfBkQCJ4FaHwYEJGR8BgEmJ?=
 =?us-ascii?q?JggAYENgnbDPjQHgiuBVoFZDJ8NBhMvlwkOBpIlLocykBcgp3+BZAE4gVwzG?=
 =?us-ascii?q?iRWggJeTwMZD44gGR6Dbo9IPzQ9AgcBCgEBAwmFRgEBgySCWQEB?=
IronPort-PHdr: A9a23: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
 chXIoI=
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:FT1ODa1hU/1utS0cslKqwwqjBCMkLtp133Aq2lEZdPU0SKelfq
 eV7ZImPH7P+VEssR4b9OxoVJPufZq+z+8Q3WByB9eftWDd0QPDEGgF1+XfKlbbehEWmNQw6U
 5ISdkaNDSJNykZsS+A2njaL/8QhOKc6aitiKP3xWpsSwYCUdAZ0y5JTj2AC0VzSU1+HpZ8L5
 aH+s9bzgDQA0g/X4CBHGAMW+WGn8HGiJ6jQRNuPW9b1CC+yQiz8bb/Hlyj0gwAXygn+8ZYzU
 H11zbh7qGv98q20APYygbonu1rpOc=
X-Talos-CUID: 9a23:T7XgLWxgZI+RHxiDC9dzBgU0XeFmVnzW3U3MMmqROEpoU+S7F36prfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AiTLxdg+8jmnqrvgkJE8s7wyQf8xmu7+kGl4Xq45?=
 =?us-ascii?q?c+OvdCnJ7OSq2pzviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="53879787"
X-MGA-submission: =?us-ascii?q?MDE+KGUuG992UgJbJemem+qoI0QzjSih6fNi+k?=
 =?us-ascii?q?yy9x+aE75xtnSdvgt7zUhlmdJeq0YbZ1MdvsSWZwyGaUoHfzFOdmRlcr?=
 =?us-ascii?q?Xa4iKGKbE3SyJ8MexvCFhtVg9rqfBSOhDSc4h2Z+NL4cpgIswbCa8QE8?=
 =?us-ascii?q?Hn3lVfyoIbqqMysbXVg2E2KA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:34:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682001262; i=markus.elfring@web.de;
	bh=uAeIY80p5MhUuLcqefnnFblRiL2V9PhZBf8nL2GOy+g=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=bXO4YOi5cGQ3vNuSM9l4llV9N81CabYe1YziQfd2pa1/0C1inOES5KHp9M/lTkYt2
	 vVrLCa0DxCPLZCL04BToZoDuQKlb1qVwDVgHuEmQM0d1gOqw/WuD1JB3JG8hGJTWAe
	 X770mN3k2sr8Cy2nqb515oH1IWgWfHJqxFtJjsxu1exlMFtekMWgkLom0qPDOnLriQ
	 1HND9KVhbpyvO5eldE/N7xYlfP6BEfpEAk9I9UIQqwLxamdNXrRLi15fhAOlTcOGz9
	 A0FGxlwOCKNfQqkcizOh+tsggp6etAKTXhYKagPsQFrATQBKiImdNtpFsUcO8X6XHM
	 q868b6t8vCB6A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79RI-1qNi661JBE-017g3b; Thu, 20
 Apr 2023 16:34:22 +0200
Message-ID: <e988a5e2-31d7-051e-b818-58f9f40f26a8@web.de>
Date: Thu, 20 Apr 2023 16:34:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-staging@lists.linux.dev,
 Emily Peri <eperi1024@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <1f72786d-7ef2-80fa-58d2-98e379dd8ad7@web.de>
In-Reply-To: <1f72786d-7ef2-80fa-58d2-98e379dd8ad7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:APVPZD2CDY++TX90TXRFW+9fXJfnlZm6neOTRsveKteYrwTnm80
 SDBSETchc0vSyrS4wUcwBhFAUCuCDgnDm6glwFQXgXBM+ZZF7HNXdiT0X5mt+mtg4EbvNe6
 dYKZrk1RD1BucC7wKVWQYKblVthFyT/TKpcBHPMA8djTVD3jXGALnjF3cF24QQE/o88Xs1+
 CcQKEb/QGMhEyuuQpZ8lg==
UI-OutboundReport: notjunk:1;M01:P0:wVbcBAyKbuQ=;puXYyQXaxICD0sCOx1srurG149Z
 yPzQvDDvoBKxWwAHrMvZLkDZDn5o7NvccYXGg5oD0V9/WzNgslhRau+bo5qsKSFJglATSvivs
 Vst/lXnl1ibMmUtmSDU7GPnkFcvl6JMRRj0sm8hoNfDItLnm8qmsJ2PaMbjm1lF53TsPyfNiZ
 8/8lr3Y6PAjuA655SPEJU0SWwaD6E4SnHf084GNr79eJWs0MhUy/YPvVJ8SBsQ5uUI029QczI
 KzaQbkjDQUYsVqAx5agfLmN2ZcfD6gvEyogS9nRT0S4ccLZ6gkmalLewTdq7FruZpM70uakbu
 /s+WyN4M4SVlV+5FRilJ2IqxvO2pnJ18jPzmxNY+Oji5LLPiG/QVVsYRR6fyPeqsi1wYMM3jO
 HsLz87lXdcsVfQN1Eed8fvt7+WhwOsUugzOVMGQ/SRj5bywP/AGc27uY09GsBHZjDzEJ+woCU
 OVnoupMV4nykgjcTWY6t0Ty9gXDktjvJRSm3XyrZNzF6Uu8HqpHHKlbAjK6GugF09FLxcpUk7
 wyrerDBg3VQysjtcXw+FR/ArulNzflYksU3rJj5sn1plBoS4OVuR37zAjHUWbDakS85ApkF4t
 Q5JMn2v2UzpiynmwKWw5y7EzBlaWUbdFc1iMM17/ftbfN89TZsLjeJPX29geUUopR4+Y3DyWY
 0GNc0mWIObDMRSY2mKX9uGVpUpn9X3rDTZclAJ18tAkGdQiNoU0clrB3PZi/7ut7pCYOSYEln
 Ih3pBk104xwg1W9484nl7Nrlt8PYuHHL7tbYho6FeVcfJC6bDOIpKMmyq3v/vG9//1DSLSvg7
 RMgZLYekFSwlSlaXYyQu8Q0+J5l8uwEtwi0Nys8SuhhKwtgbWqScflE+aiyYfvmwG9OBPWpzz
 I3iiHGFhB1ouU6yfk1Q0Y29q4Tvk/Z2viHAU+YrJe/VRvfhnXun/nUhG0
Subject: [cocci] [PATCH 4/4] staging: rtl8723bs: Move a variable assignment
 behind a condition check in rtw_set_802_11_bssid_list_scan()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1108
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/e988a5e2-31d7-051e-b818-58f9f40f26a8%40web.de>

Date: Thu, 20 Apr 2023 16:06:08 +0200

Convert the explicit initialisation of the local variable =E2=80=9Cpmlmepr=
iv=E2=80=9D
at the beginning to an assignment statement directly before
the source code place where this pointer is used.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/stag=
ing/rtl8723bs/core/rtw_ioctl_set.c
index 0716b704106d..fc6875b4697e 100644
=2D-- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -368,12 +368,13 @@ u8 rtw_set_802_11_disassociate(struct adapter *padap=
ter)

 u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_8=
02_11_ssid *pssid, int ssid_max_num)
 {
-	struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv;
 	u8 res;

 	if (!padapter->hw_init_completed)
 		return false;

+	pmlmepriv =3D &padapter->mlmepriv;
 	if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) =3D=3D=
 true) ||
 		(pmlmepriv->LinkDetectInfo.bBusyTraffic =3D=3D true)) {
 		/*  Scan or linking is in progress, do nothing. */
=2D-
2.40.0

