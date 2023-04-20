Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5E4C77B73
	for <cocci@archiver.kernel.org>; Thu, 20 Apr 2023 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=T78WHOs/Kd7raAtDSWpanvbjeuN7CMIcRib9k5YIfBc=;
  b=V6P4X+z6IowKzXOGlNbZBgjEtQYaVX+rwZ0iVvwQSPMbhgYNYEpZYEoi
   DfsVK2pGRcp/KUsflgInzzp3gXvY6OGjyvGaMg14HQeqbW++XFN+YXX/j
   T4BVo2CX1lYuUoGczucoisdIR5TummC9jd6ml7tbkOLvgWI18iFjoLKh7
   Y=;
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
   d="scan'208";a="104013507"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Apr 2023 16:32:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A1BD9E0235; Thu, 20 Apr 2023 16:32:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1856BE019E
	for <cocci@sympa.inria.fr>; Thu, 20 Apr 2023 16:32:09 +0200 (CEST)
IronPort-SDR: 64414ce9_30q2OkJxLYHXOsTu5EBKG5avxyR5Bf5BTuve6rUevofsJc0
 kfPfksjreJ+GqktRDA03qWQ9AVZ8RgtBsIP9nIw==
X-IPAS-Result: =?us-ascii?q?A0EIAAD/S0FkhwQP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE8BAEBAQELAYItgUsvBAtGhFORNoQwhy6HPoRnhAOBVoFAP?=
 =?us-ascii?q?g8BAwENQQECBAEBAwQ4gzOBFAKFPQIdBwEEMQgOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQESAkc+AwMjBBkBAREmAQ8fBgIfBwICVwYBDAYCA?=
 =?us-ascii?q?QGCeoIoAQMxB6sPfzOBAYIIAQEGnAwfLCJUgV4JgRQtAY0UgzZ6Jw+BVUSBP?=
 =?us-ascii?q?AyDNoQLhBSCZ5YUgTN0gSeBM4EEAgkCEWuBEAhogXNAAg1kCw5ugUVgRoFyB?=
 =?us-ascii?q?AIUQgwYBTUlBA4DGSsdQAIBCzs6PTUGAwsfBkQCJ4F/BIEIfAYBJiSYIIEOg?=
 =?us-ascii?q?nbDPjQHgiuBVoFZDJ8NBhMvlwkOBpIlLocyilmFPiCnf4FlAzWBXDMaJFaCA?=
 =?us-ascii?q?l5PAxkPjiAZHoNuj0g/ND0CBwEKAQEDCYVGAQGDJIJZAQE?=
IronPort-PHdr: A9a23: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
 Kc=
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:RN3Fm6qlWWmv3TOmzqnT7ywaV5q6eYIsimQD101hICG9Evbyqy
 nIpoV86faUskd3ZJhOo7290cW7Lk80lqQFhbX5X43DYOCOggLBRr2Ki7GN/9SKIUzDH4BmuZ
 uIWpIObeEYdWIK7/oSmzPIcOoI8Z296rmhgeqb531xTQdsApsQlztRO0KhCFR/QAQDPIE0UK
 GR/NZDulObCA4qR/X+PWMdV+zP4+XWmI7rJT4KbiRXlTWmvHeS8qfzFxXd5BsETD9VqI1Sil
 TtokjC/62mvrWBxgXB0nK71eUupOfc
X-Talos-CUID: =?us-ascii?q?9a23=3A9dTK/mps0YecaC4ddPKGbmnmUYcuVVqEx3rOGAy?=
 =?us-ascii?q?1UmFKep2SdESC45oxxg=3D=3D?=
X-Talos-MUID: 9a23:2ncBywWLQRbOfrjq/CXIuC8/KsQv2byJCGsUtoxY49eeLhUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="104013460"
X-MGA-submission: =?us-ascii?q?MDEGXjrDeRiLoXqJ4ZJqgufIOULlC0lovuGcP4?=
 =?us-ascii?q?DjrLW5yUkOcNw6sqAmuWDRxYmWC4LCmDaOjrgn32VW71kpo/E6bIzygk?=
 =?us-ascii?q?KcZqfbxPQIDrPyo3BE8zn1c0fZU2s25l5GVsOcIylw8Ozs0ZHbOvuoZw?=
 =?us-ascii?q?qmMOdro6lR+L3Colc/CSiexw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:32:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682001127; i=markus.elfring@web.de;
	bh=qo+bG1q0U33/ld0dMM3MRlRvSbwgrbkLHvDLzo4qX10=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=G9JEsqdX068ZHqDiZsy8mJ/kvHHeEETJeRRzqF7gVQj0mtbSjUDgmjN3lAZS7t9y3
	 Ecmu4sK91jhjVgMpj0P3wz4EkFeiYBuRxtfcs5PWCB5PoOJ2Gf4e9FU+sc6Eadcd9S
	 J/cBjJE25C/rgA0PYOCZ6VM28suq4KnkYym6dtCvEIs2V+rmF8M5nUv3zOVhXNjJGG
	 qaJLmfEVPZHvnNLhy1BnzFeyE77ZSd/vheE22CL5U7w3ynbleQhtQaoOERzdiJLUFd
	 5c0aPvOadEKt8vjZsSWlokSNk6fnYqiXuX3y9eQ/+9++r6wclpWT7hSJgPeokCqaqF
	 MuVJksGu5HyvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqqTV-1qboda1OUL-00mUTO; Thu, 20
 Apr 2023 16:32:07 +0200
Message-ID: <03e39afd-f588-6201-cce0-46faef9deb8d@web.de>
Date: Thu, 20 Apr 2023 16:32:06 +0200
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
X-Provags-ID: V03:K1:kA/0AaqPUba7hec/pzDaLlzetU05R6/6ygc/N4ehh1n1BrOkWZF
 PutBrf26Ve7hoPi219s/otplM9WWQ3YG+7OlQswgR56SJBKgw8YK/0LMZrRu5alzhmJusZ4
 oPR36ar+j8SzhgruyFc343820ZRGiv+XLVXg6EAAlF2utmyRdaqTGhnaGWNuigDLEPyWav4
 M5waOz/OOMjWdyPf7MlIA==
UI-OutboundReport: notjunk:1;M01:P0:764KsoPQonU=;/4cCV5wxJKNMPSa5oxBuBGhpCI+
 gXqDIK5WFJaAPyVQeGbwaRmK4IH56I15VzshvIf2arAKQRd/e8xvyYYrGE09ti1atoE0AxCy0
 wApUiDlnVEalfaHZSPMiZ6TaK/+iWgyCsUhafC6/fNfw/MCsRRSC5uYXAYrD3+WBtWsqVmA6F
 1YfpIwn3HCmMCRKOFggQrD5+N4l3LDB0CJaDXZLPWlbusuElHs2wmWxOq3qcpXM/4HJ56L+cp
 TAOvCdyF2KI3x6J4Kfln4Yf4bAe9Ip8e/QILqEif1/yNJXJW4Am0saJg/4T1rIvkNFO94KL8n
 bSwETEdHNEMVGuvW0aNnWSr1ARvZ0SJ5pNTrn3oUAdK4iwCBlE20k+YFfuUbZKWa1NzKeVMEE
 +FfeDF9AjINCMYq+xr2XRbIejB3EOiEuiVuQfkIhbfFKQPSGK3xC8/rjdEX4rgGfnJGX9BRDR
 j7+UIAg9DVjKb5JacLxd6kahl3Thi7zdDL3SJfT5/7z0NqMjUzl8y5lLyrvgmFdNmwi/g0CG8
 BUuilJitZF3rjQ+lLGI1VHnRrVAoNBlgbsbVCQqK8qnLt0d2F6XyIqBHGp6LZAFwG+tNMNX+2
 OvO7ygNRJB9sgmZfz7Md1dfQ8ByMwt68W08UvKxAF0EYKJ9mBBnq90STtgnpQqDNTqyKaZm8n
 UL4CoAXYQC1euy/+2uTemO08ItkvApDuiriVhN5ekAzwmDxCW4XY9PfNXpQlKh0tbPiR8IeBk
 gLMA3nKTjUTVKiF19TRJWwJo5tPoVJnEuaDuSmDerVenLoBY/LZ7D4jmXmsJjXNXfQ7oA8ZIH
 qQAF4R7kfdd+mpLNMxWMFWYPo0uzjt/vx5Yyllwljql6kcqSW6xL4ed3/SPLTZTCtzBmQpzcf
 HoUieHPsLX4/jyr4ZYl4O8vnU/3Y/5ecok9Y5z9gECvWh4GtIPcmyC1NW
Subject: [cocci] [PATCH 3/4] staging: rtl8723bs: Delete an unnecessary
 variable initialisation in rtw_set_802_11_bssid_list_scan()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1107
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/03e39afd-f588-6201-cce0-46faef9deb8d%40web.de>

Date: Thu, 20 Apr 2023 15:55:48 +0200

The variable =E2=80=9Cres=E2=80=9D will eventually be set to an appropriat=
e value
a bit later.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/stag=
ing/rtl8723bs/core/rtw_ioctl_set.c
index 0c2df854afe7..0716b704106d 100644
=2D-- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -369,7 +369,7 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapte=
r)
 u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_8=
02_11_ssid *pssid, int ssid_max_num)
 {
 	struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
-	u8 res =3D true;
+	u8 res;

 	if (!padapter->hw_init_completed)
 		return false;
=2D-
2.40.0

