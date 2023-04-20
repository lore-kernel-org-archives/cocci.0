Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FC9C77B73
	for <cocci@archiver.kernel.org>; Thu, 20 Apr 2023 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=B87HhOCIva4tMmNvDNDAuVZDdIuymFNwgd8s9+rTQrU=;
  b=gLLU3CI4LIb73s9vltkgxPxixEH16nqY1TfgvbniCd+i9C4GDO+8Qx1j
   W7tRGxNfQJpVBS5l4WtSpB5MUtDFXtSTy/TglZUHRtEiInrxR9v9Y0chS
   cULZxzQsEP4mcnh69ZXIsgFO3KeFBO3U+SyP3OyoY41d+oJk+PrtZ0pSk
   o=;
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
   d="scan'208";a="104012196"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Apr 2023 16:28:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 925C9E0269; Thu, 20 Apr 2023 16:28:21 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6EA25E019E
	for <cocci@sympa.inria.fr>; Thu, 20 Apr 2023 16:28:18 +0200 (CEST)
IronPort-SDR: 64414c01_NbjTwco3/sWjfCxgKuN9wj78hbZQwYhc5z6+o1M4YGoRnoh
 9H+eue7zDcXcA230Ca4FYYX/+LmTtZ3ffmbjckg==
X-IPAS-Result: =?us-ascii?q?A0EFAADpSkFkhw4P49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYItgUsvBAtGhFOIHYkZhDCHLoc+hGeEA4FWg?=
 =?us-ascii?q?UA+DwEDAQ1BAQIEAQEDBDiDM4EUAoU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBARICRz4DAyMEGQEBESYBDx8GAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgnqCKAEDMQerEX8zgQGCCAEBBpwMHywiVIFeCYEULQGMVT+DNnonD4FVR?=
 =?us-ascii?q?IE8glNviB+CZ5VPRYEzdIEngTOBBAIJAhFrgRAIaDiBO0ACDWQLDm6BRWBGH?=
 =?us-ascii?q?4FTBAIUQgwYBTUlBA4DGSsdQAIBCzs6PTUGAwsfBkQCJ4FaHwYEJGR8BgEmJ?=
 =?us-ascii?q?JggAYENgnYEwzo0B4IrgVaBWQyfDQYTL5cJDgaSJS6HMpAXIKd/gWM6gVwzG?=
 =?us-ascii?q?iRWggJeTwMZD44gGR6Dbo9IPzQ9AgcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 fLmq5deU0EpUOwXAAJpEY5aSKo=
IronPort-Data: A9a23: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
 u3yNpE90tZdD32pqSsuCiSHvNpa
IronPort-HdrOrdr: A9a23:bfUaN63yx9E7VFLJWJnnFAqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPjUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyWMbEQt6bHCWeDYrMd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AT1fw+mlNpzKhXgjPec6QyuB8QiTXOSOazVvbLVS?=
 =?us-ascii?q?ZNWl4C6K/bFyooIxgmsU7zg=3D=3D?=
X-Talos-MUID: 9a23:jlJ8HAmZxIsZsiruUzpkdnpuF+Irz/SCK3oRqoQHtfOoOiwtMAeC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,212,1677538800"; 
   d="scan'208";a="53879097"
X-MGA-submission: =?us-ascii?q?MDHJ19R4pWCsBBsTXDXBzE67E5BndWEmupetK/?=
 =?us-ascii?q?JInSXCaAbFEy7SIGXEmpvERqYL5EVFpAZ8u/wiZqwcqjt5NcFC0VFyJ3?=
 =?us-ascii?q?7ziXVF+0v03CSZEOqLOIC8OreVxDavm7x3CbEoTpcj22eUQHxCPS4IBw?=
 =?us-ascii?q?rRL63rGbqeWwg/8w8EJJB40Q=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 16:28:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682000896; i=markus.elfring@web.de;
	bh=Nat07+foseHEeoLG9kBdXBlDYseS8WWy52TkkvH8H9U=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=abZE+M5Rv6X21W4KUWrzzpFlcVouRg2bEb6ie1HeX3YM6vwtjHI+09F9+SMHFj+SN
	 xWaHvJGb3SZ09s4J8CwUm/X46B3YcE5ae0eC8EXolcO+o8PbAU6jH6238x3gKYTyAq
	 G0zXhVrfvGMGKy385djk+zUwJSR003yZyqqwHWJWmFxc36h/sKml830fdN39QHQdUC
	 Yr14XYPkA0SRRq4qg4jAkO73aTbcKJkrvYYCzKPmODomcxpwtTRy/nivzzru4bFUd6
	 rORWDA3Y81jWEGAjpswYNTLihMxcsmtirRy5gZ2xsUEs51TCbL5concAG/Z25Su9wc
	 9Wo+C3mlZEwyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXGOI-1povfl3f3u-00ZAnB; Thu, 20
 Apr 2023 16:28:15 +0200
Message-ID: <159910bf-dae8-5f09-3ef3-86d522916cf1@web.de>
Date: Thu, 20 Apr 2023 16:28:15 +0200
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
X-Provags-ID: V03:K1:Wj7aghoTytYPnSy+nlg/fF7y1m9gHzyF+wU0Qhm6MVdORGtjwCs
 gtaJqoWyvjMkafRDBE6YI/Pl2sA8OxXY/xAi8meqRoAHR+S4fTyjMHospzCnkO18ggpq37Q
 44U1NWnXK9bCijxTH4iRA8o5dPJ84qnIoG4BAwVP2xhm1TquS/dl1hngAolvniNjYt8sjjL
 nNLBANsAG+XKcsEsj23rg==
UI-OutboundReport: notjunk:1;M01:P0:BQdCSr4Gt8Y=;BsE6HNWqEtgPYuDCaVASs3z7nqS
 KWK9j8KmJl7BlKjp5aXgVMZn2EO8AtfWrJp5cJFMoqXOS2WcSFv7OWc2UicXMuLbxgL7MEYGD
 RzgMjbvAgm5vX6dEl68D7vGAY+tjGxNdXfsUYploZGYMm/8kOvUThgVAWXXiOMiHw8AD+yIwd
 H7Q0dXdzzgWFrfERFilDy+LR+5mNXhuhC8hyiIFctgJpyKWX597hoO94fMNtQhHWafqtOEiyY
 Ipn954ze36WjfK2qvPqiXcMq96V2RB/p4WKUKTVJYc06nqbV/Edae8M5uESFDYVEZhYHEkSRp
 oo7kmGO1ZvVtvwtBFz7mTTzWF1XOnU9xhA0ifeMCJIbuUxxTuyUq/TYopYtuNJIZyqBbkqazV
 VtvwDCm/z0q8cwTeGnnU/SbWbYVe/SORxix/DT+Ih2Y6qMCcSrRdKkN6XnRnanhDEl8LgS1I1
 BON8ukgXWsFYNdooRjkopDH7/2ZbukDnsp4oohOQfdD7u0KwE2Lmul+z1WCrxZQ7DplZwpcWY
 t6NVLka9IVRLmZWm8fXSAM+VR6QNtwxjSrs89HDb31d3a4OeCqm9egR7+QRfR5zs6CRku7R81
 u1rdgMDLrs2RWnxxqCod7yJVqMxkVEEROL6gV0HZLTi4SYpOgdEIRg0fUJWkakb48H9Ou27jE
 tEGkNyNNHzm/yJqQttWDKJEMAlzr1LCSZNKAM/B02R+xY+3q/EH8y1GcW6plq7S9vl4simV4I
 /IkrUFl/0bzdNbXCKBadyBgsyoYxZtlgxhDMSX32UNw+xB2Z4NkII91A2ryy6hS96kuH0/Ino
 uGbr59AGlbg9EZySdJ0AaJM5Gh7ulGh2bHD6PjiozaB9i3ety+BAnf/nzXgQZiE5J/z+gq3dW
 KwvgZJ2iz4NVMytlx8fbE0wSYWNoNaFm4PXAi3fDnwwd+jejrgFD7N8hj
Subject: [cocci] [PATCH 1/4] staging: rtl8723bs: Delete a null pointer check
 in rtw_set_802_11_bssid_list_scan()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1105
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/159910bf-dae8-5f09-3ef3-86d522916cf1%40web.de>

Date: Thu, 20 Apr 2023 15:30:23 +0200

Omit an extra null pointer check for the input parameter =E2=80=9Cpadapter=
=E2=80=9D
in the implementation of the function =E2=80=9Crtw_set_802_11_bssid_list_s=
can=E2=80=9D
because it should be called only with a valid pointer.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/stag=
ing/rtl8723bs/core/rtw_ioctl_set.c
index 3b44f0dd5b0a..7c902f50d38b 100644
=2D-- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -371,10 +371,6 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *pad=
apter, struct ndis_802_11_s
 	struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
 	u8 res =3D true;

-	if (!padapter) {
-		res =3D false;
-		goto exit;
-	}
 	if (padapter->hw_init_completed =3D=3D false) {
 		res =3D false;
 		goto exit;
=2D-
2.40.0

