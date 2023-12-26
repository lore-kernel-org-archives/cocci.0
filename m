Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD33C46CD3
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=L9BqBsPFTMBAE3yobIpW3++U89geYYEM780d+Lmt71Q=;
  b=b7osBVFUVSjeKTcfBd+YLPdUEQzp3m3Lp2wv8kVhEk2BgfP9KDi0Chlv
   tSWpJ8NBPGfaRQ1K4dAuviWOGx1pNwRtHGtnqqIjkO7jnorz3iptyK0tB
   PvvrBr4JS//BoTHhPU33UsrPm54HlCJ0X7leN48oGQfGkC4yADWHBv0/q
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,307,1695679200"; 
   d="scan'208";a="144076477"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 21:42:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 78B22E0CCA; Tue, 26 Dec 2023 21:42:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B0789E004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 21:42:43 +0100 (CET)
IronPort-SDR: 658b3ac4_kDQ+c9VTL07kh2w3FwkzzHjZMrdF/FeM0Adp/gBnTLq+tNV
 VUeoGtflMlTLUu5P0zU/WQ7kwgsjZFOcG96imiA==
X-IPAS-Result: =?us-ascii?q?A0FGAAATOotl/wsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYI4B3hTMgQLSIRTj0GBdS2EPoc1h0yIb4FWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDcBgVOCdIc4Ah4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECgQYThWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdrBBkBA?=
 =?us-ascii?q?REmAS4BBQImAl4BEgIBAYJ8gisBAzEHryV/M4EBggoBAQavWB8sIlaBYAmBG?=
 =?us-ascii?q?i4BiBoBhWeDQYEhD4FVRIE8C4M2hAqEFIJoiRsHMoIdg1CRV30EAUFwGwMHA?=
 =?us-ascii?q?38PKwcEMCIGCRQtIwZQBCghCRMSQIMvCoEBPw8OEYI+YTYZSIJYFQw1BDURd?=
 =?us-ascii?q?RAqBBQXgQ9uGxIeNxEQBRINAwh0HQIRIzwDBQMEMwoSDQshBVYDQgZJCwMCG?=
 =?us-ascii?q?gUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADaR8YGgk8DwwaA?=
 =?us-ascii?q?hseDScjAixCAxEFEAIWAyQWBDYRCQsoAywGOAISDAYGCV0mBw8JBCUDCAQDE?=
 =?us-ascii?q?BspAyN0EQMECgMUBwsHUgMZKx1AAgELbT01BgMLGwY+AqZFB1MoE0wmggSwQ?=
 =?us-ascii?q?JRBNAeCNIFggWEMnysGEy+XJg4GklMBLpgfIKhGgWUBOoFZMxokgzZPAxkPj?=
 =?us-ascii?q?iA4g3OPR0A1OwIHCwEBAwmFRgEBgyY0gUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Wed+sqv5w4VDKh9Keal6W3dZ7skDrtV00zEX/kB9WHVpmwKj5q
 KTdYcgpHzJYVEqKRcdcLG7Sc69qBbnnqKdjrN/AV7PZniChILKFu9fBOnZrwEIcheWnoNgPM
 xbAsxD4bPLbWRSsea/xhWkGNA9x9S9/Lmvnvq29QYXcegnUcBdBxwSMHfjLqSafng/OXKzea
 D32vZ6
X-Talos-CUID: =?us-ascii?q?9a23=3Azzypp2i+j2H4h8sjIqhkJXFnHjJuYFP3j3X2AHC?=
 =?us-ascii?q?ECH9SRIyQQnyR9q5mjJ87?=
X-Talos-MUID: 9a23:Dg2iZwTbs7FvrFLLRXSxgDxjJNVD8ZiuS3A/zbY0hsXdCnx/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,307,1695679200"; 
   d="scan'208";a="144076475"
X-MGA-submission: =?us-ascii?q?MDEVQvbbo0urlavzBXg3c/FqViBSFtgdfYEzo0?=
 =?us-ascii?q?cy6G6WUDl6scKA5Ufloon93Fe7is0jsqTwoX1NzRQrLpWiBtQgsPVfFX?=
 =?us-ascii?q?B5XmWyb1eM5ucNAaxZcJdZABwqttlk6IOi66I1zxH03B+Tx1EjHv11jf?=
 =?us-ascii?q?VqF8f2iHLYXmQMr54I8gKKwg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 21:42:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703623343; x=1704228143; i=markus.elfring@web.de;
	bh=T6cDnr5hFtFbP2etPVzAZk5zoBQrCmisolCMkj0IYRQ=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=wSZwN0u9XxH3EuhHZr1KPy3ie4ZT3Qn0DIysbF/Sa9XZGwNtKE1rs3T3+MG6NzuK
	 N2Al1s1JXw04IVBYIhznOBCZyCl21qKgRzbT6vc0EEftw8kFHSo3JfZ6y/fFgcJQz
	 Jk0TxvJvgVgWmAx9+fS+dId4OuA/GowQE+FJKUgZU46Rjt7dA8sVLMBw6QNCuyKz/
	 wf3lSwD3ws2wrdxHcPPGsC3kmOt8ii1TXKVA3hrpXMO0xM5hVVbfqOcVwMMfkZaY+
	 NFz/Meask2Zjv22UKBytb9JBNOvlTatOTLtxb7ZbMQzZqGwFtcm6cMb/t/tyL/Va5
	 u1AFXvk6qyDj1wic/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjPPs-1qpAkn1qvK-00kp31; Tue, 26
 Dec 2023 21:42:23 +0100
Message-ID: <71aebecb-ab59-4835-9320-10e849c04a5c@web.de>
Date: Tue, 26 Dec 2023 21:42:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-riscv@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PL5C36CURHSbdroEInCd+9jbMmVEKNPmO+AYoHaevTf15uMeyKZ
 pFuMaYZ1hpPtHyJWRqw7Vpd3q78MRXTrhGpFM23XLG6kHqPYd28ngv/y4hXj6yL6C1cKnV9
 Kg02EGUbMSdde9WK314m5C/vKNDR1/g+k6d4cgl8z4MPAN9EFiifXupWBYWn+NIykPuuSDD
 6tx9OomGmnXlsEZ+MhWug==
UI-OutboundReport: notjunk:1;M01:P0:zp7bCe/dVQE=;Kkt8nPqdlTEUtkFKrL/qlAx2nv1
 37s4PQyHu3QGIQuaKUwPVN3YAK9tktu9wHjxGsiLjm3A3F+KbTkjXZ4GtyyLg2nl4bvOY/fLc
 CH1o8NMtikYMHkTjlh19DYB8VKH697WMO0zR2eh7qmAqikVFRrEjpX/7HfgcjL3zHLaQMic5Q
 ZIL4I9ZMJj7jV+omwPi1WtcpOLTvUXs7MwISG27j/u5Y6LNR8BHz1FINNV0ZglKq14BepGsMj
 p9gSv7zvog/1/FhnzR4DHzsqKd2dPaG3FiFeCBegh9Jmn4wejiceFYb+JloFq3RIXFZr5CT5I
 jrpHqFIaIeui1Bb5e4Umf3VAU8oXoY9zohAhBlTqyyEXVQUFpJ8m1tKG3dYa18IKhFbUFZJ3C
 y3ALcxHf+q+r3/90UJ/3UaubUwDokOm7xUehk8GHsrF5QKzUy8cvEbAH51a7Zd1UUIOY7ERuU
 +COfiPrIeiuPdR4sWAF34WP+CkASRfdY973K7iemppyW724cuLeGcWfpkBHep6t7rsKFqQ72W
 IcoAWflcJudax6UOKi0ZGWXNACZjFShr4jH84lGN0gy+6piuxjMfSS7R+najnobBr0ykLxc9H
 Oohz2c3xQypnJ9M6ssVpKk/z2zvi18l23A+UDEQccIdlI+OBdpWHzE7TgIwfv9hPPt7uRft9E
 2TDxLyVDIkvsXSq7HGLoRz/GoX1JwwsWXIrRU8CBCN9Ckz2r42/kBgC5n9XMHv87yhiZSO7W9
 boPyQ8D9XUtsi2Ry2edktzor3eevFGcdaOQAanvRlt3dZOEmxakquOECf/omKLvVlYgImqH0a
 vc/sxzE2+Q35JzulTFtL7IXHGhT01yqr1EoqONMauNO7z+nbpYNHw+PZh6+71sUqrc/4y2EJ+
 WViGnkKWh3swDh947xq+P3e7hcJvlqr0kCShBp/Fx86rdBcKyQ/tOfjjRdjDyIKjBGZGEvGOG
 vpvTzQ==
Subject: [cocci] [PATCH] irqchip/sifive-plic: One function call less in
 __plic_init() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1406
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/71aebecb-ab59-4835-9320-10e849c04a5c%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 21:34:47 +0100

The kfree() function was called in one case by the
__plic_init() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use an other label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/irqchip/irq-sifive-plic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifiv=
e-plic.c
index 5b7bc4fd9517..e9e3ee2d6440 100644
=2D-- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -437,7 +437,7 @@ static int __init __plic_init(struct device_node *node=
,

 	priv->prio_save =3D bitmap_alloc(nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
-		goto out_free_priority_reg;
+		goto out_iounmap;

 	nr_contexts =3D of_irq_count(node);
 	if (WARN_ON(!nr_contexts))
=2D-
2.43.0

