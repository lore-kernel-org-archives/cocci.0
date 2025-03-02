Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CEAC19F32
	for <cocci@archiver.kernel.org>; Sun,  2 Mar 2025 20:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=j8978AGK4OcGB6MWNg+Th/WIqtnKJPRM1f6P4S0eQJs=;
  b=rbOzlbUNlpNN+s/ScmQNJuzwytl+rwtepvP+KebsyQ6LRdfLH5IPkrhd
   T9no3WiCgyV8gbINoIvnBeaUHJSQ1Sv7t4oJnucQmvs696Xt0HY6GT4TE
   gOD1zQpCNk4CQ7Px6JzY6TvRVf0dLeEyYYljdfK5dTT+qDBU+wysPnfUv
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,328,1732575600"; 
   d="scan'208";a="210754809"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2025 21:00:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 34184E0260; Sun,  2 Mar 2025 21:00:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0EFC4E0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 21:00:25 +0100 (CET)
IronPort-SDR: 67c4b8d8_Gw/k+KM7o9Cro/wR4T/b/pQdNYYV87n3F7mJpGboBrRcDIp
 AIJhHTB77NxRWdyQfSUsdg3yqvYdjmx5upDKofQ==
X-IPAS-Result: =?us-ascii?q?A0E9AQBLt8Rnfg4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDYnUzBAtIhFaPT4F0LQOEO4c7jEKEBoFWgX4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIFUgnQCixUCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4JATGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAyMEG?=
 =?us-ascii?q?QEBESYBDx8BBQIfBwICVgYBEgIBAYJ+gjABAzEHryJ/M4EBggwBAQbaXB8sI?=
 =?us-ascii?q?leBZQmBGi4BhWuCYwGFazuEPCcPgVVEgTwLgzaECoQUgmmDbi+DPahYgU0cA?=
 =?us-ascii?q?1ksAVUTFwsHBYE5OAMgCjQUBBkCFBwQBhAEakM3gkVpSToCDQI1gh4kWIIra?=
 =?us-ascii?q?gQFg1uEPYRAgj9RgkKCEXGBF4gCgS2Eah1AAgELbT03BgMLGwY9oW46g09SI?=
 =?us-ascii?q?AFSO0yCKo9HgyizIzQHgjiBZoFjDJ9eBhMvl0UOBpJ8AS6HZZBqIqkPgW4LK?=
 =?us-ascii?q?IFcMxokgzZPAxkPjiEMFhaDdcg7QjU8AgcBCgEBAwmFRgEBiiA0gUsBAQ?=
IronPort-PHdr: A9a23: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
 Z0TVvlEWVZzGv5IUixY
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:EavlHKwodj+W+oBgVS4kKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZMmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bAYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:Rjmywm+zsykBLwQFQmqVv14fGP48Kk3h8G3Ve2uVSmRzRZe2UXbFrQ==
X-Talos-MUID: 9a23:teMIzAsFn6CVI9MzjM2nwwNMK/ZZ2eOSIns1iLMZoZmqGyB9EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,328,1732575600"; 
   d="scan'208";a="210754807"
X-MGA-submission: =?us-ascii?q?MDG5vBj1Tmr/bZRhzFuykEhdaF+/BucSn10bZ8?=
 =?us-ascii?q?YTokIBSf5UdyIZbhb0Z5R1bLk6T6OiizUsBkYsRFdumWRE7jDa1B3jYt?=
 =?us-ascii?q?7zi6b8QTqeFt3v6JOJHjMK/gt+QEn3PDeKkNJsRIKLRRq1qvIswWEwAC?=
 =?us-ascii?q?sycAoAgpJkcpIDbVajw82xSw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 21:00:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740945612; x=1741550412; i=markus.elfring@web.de;
	bh=j8978AGK4OcGB6MWNg+Th/WIqtnKJPRM1f6P4S0eQJs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TjUD8dAlKI/EZfWuj+uvbI73b1JtsALaP3ZYRqmru9UTTWBr+4TCOiMEL8zuhJfe
	 NfALfXKiirp0eXUKs5A8fQIX2cRD+2IC+txPOaouKhPSw171e8T4rxJsb5MWA532H
	 BsD147SAfJJjCbKvj+RUjSVxdUndGceZtnNvcW2PzldwLHoyfYFtXUgKu5V7DuBzB
	 81ESLxKcAXlsCem7uhyeWHULJ4cuNMebH1cN3K3ymQnoi1/UmSIIFf9ZMFg8QgPDM
	 3kbd4YuSHLeOQDgeG6fVJr3rTSrGPxfBGSLs9P7igoFCyvdb9chG43azfAozkqtDc
	 vv7cqnYevrm1GvBMYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MG996-1u34Zb3Xqu-00Cw1n; Sun, 02
 Mar 2025 21:00:11 +0100
Message-ID: <774e0b8b-5013-422f-a9aa-4f8c4d5ed17d@web.de>
Date: Sun, 2 Mar 2025 21:00:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-usb@vger.kernel.org,
 Ben Dooks <ben@simtec.co.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Minas Harutyunyan <hminas@synopsys.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <10e10996-d53d-0733-6d90-a04f251812ba@web.de>
Content-Language: en-GB
In-Reply-To: <10e10996-d53d-0733-6d90-a04f251812ba@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PVLaUZ7MZzsJHTPMWeyqNci21CUz7+lc4RwBkiERpobTfFK1Rp2
 P7q0rPRSFIFxRRAE/B1dn71jJyPUl3pmTUeZ1JUxLJ4g1BbF34zy+AFH3qkNJJQh+72NzFA
 70cU8Lu0ZLMlRdaoJFml01vhhybjPjaF5DlRpTf/Cl6lRjxc66saooBaehARDoB/0ENtgEv
 Yue5V4rt4gCDEnpwC+eDw==
UI-OutboundReport: notjunk:1;M01:P0:KQb1UWhkZEM=;JEJ25Nhe7DhuYtqdRJ36Pf/j15d
 Xb0TZMJsYDSVfImiNprrxurJpbxhQLJnsmUDX/cpGlj9gldTtGtlmYUlcIn3KllgryObmxlXs
 va5NZYdeV8sMBRSkOuVv3bD8SqTnHlOSfxlDSHYdwqDGUr8zehynZsdzh5blOWAAq5tL7g6LR
 9lVlXGPKoD5d/0GZV5kSGrFiMS+gyg6zld9bG5D++A9riWmeERKrTuc0bPiDUtG00Iz1hXH1a
 +KRAVasJr6M2tLTrGrRd3kheLUE2BcU+C88FRslmLxW4sFfoabw6oROUstnmlnihrJnxZRjo7
 axm93qw0svEdodUcbUPDaunxmh0z3440bBDaLn/EKJM7e7qf7gI8JlsYVR2nNsBuulEUwScIO
 p7R2E0EbFIhvG7nbDa8vKxIhWKAEr/39Z2ldTO5jDTLiHINygRrE+91B++pbPuAAUi3OEJ3Vr
 Hhk8QYX0pGtw1QFS8Wy+ZnV9nW3yUf4wsqehiamOZSIHaz3qLPiKbRDJdSelHMLcn5F83zTr6
 FNSBn3xkMJ6KfBTwHS+7/6qGjAqb9I7NQcUcGKJq05KWqak3LU3RU2ZHhsyvT3xA5bMNsDZiQ
 T+nKQyufJBwjohWlpj8Mlb0jSZWRcO6GH9ncn/l4rGnccyB19RcUYW6r//tyergv2nPe57z7I
 +/2FJMqxSLoKq6i6Qe2Dk5aO6gyDTFUtoAsKsKSJ3lDqrxXPE/GrHdQ6yRAxk9EHi2NcanZHQ
 6jhiTy0J1s1uRSIP8uAsRSROoLPEEclWe6jXGBCdzcGzvpeJ64jHN2ZdSEoGR9k+GzNHdgwjm
 iJzGVPfl3eQdyVpH2km/dpbukEGtmSEqhW4SkxKUB3Sb9iGdP6S4S6FwLo5tvKbu79IY5h7yD
 Jcnv426lHQbUGWlyVpl+qMwCliY5d9CZuoDGXow7xg1We9glooCDjsE/F42hvVY5DLLSleEfe
 AoQ2xQ60JCAujba9uOIYTXrBWvN8asxYAr3nGYAjCUHr/77qXdKyl5Ql7n76tPHPAq4ZH57gD
 LdXUbEgTAyd1HCFd8WjXmG/A0tcbuV+ctqNnERdvVkhlO6KUIcJTTK6RyHGUvTK9dNDv6b1UW
 DAFdfEi00RR8k+t9ySFqRbTZjQkT+HuRFchErn7yQDXbD5qgvpwMu6dK3n4Vi18CW65qKIAxn
 t2FwVfCn3Cp21QaSp4safsgTQ0agGNDE9NFKgvARHpCDOeVmAZk95GNF3Ls4GOaIi3o6DyR+S
 33mRSQYxJrnmZ6dEYKU9mbVY84AjM+U01nRJyswnwX7Yp3Zvyl3VfDHmb0fFfmAbTWoN8T3lG
 VPMgIyrZegV8cZiGvXQ4IrHpuCFovZXIcu0tcqZB28C2xi7cdIOymd8Lm9asg0azJouG6lm+W
 WBD6ywmpmSfcx2k9XXB18vK4Ck4A02J8c3N1HXLjXYgGYy/g1QpsTbb+Chxo7WJ46vYjQD/SO
 tpY/L4z1h83QJakWYogNdeALisvI=
Subject: [cocci] [PATCH RESEND] usb: dwc2: gadget: Move a variable
 assignment behind condition checks in dwc2_hsotg_handle_outdone()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2471
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/774e0b8b-5013-422f-a9aa-4f8c4d5ed17d%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 19 Apr 2023 20:06:25 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cdwc2_hsotg_handle_outdone=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Creq=E2=80=9D behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: 5b7d70c6dbf2 ("USB: Gadget driver for Samsung HS/OtG block")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/usb/dwc2/gadget.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 8b15742d9e8a..cab04816dd6c 100644
=2D-- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -2389,7 +2389,7 @@ static void dwc2_hsotg_handle_outdone(struct dwc2_hs=
otg *hsotg, int epnum)
 	u32 epsize =3D dwc2_readl(hsotg, DOEPTSIZ(epnum));
 	struct dwc2_hsotg_ep *hs_ep =3D hsotg->eps_out[epnum];
 	struct dwc2_hsotg_req *hs_req =3D hs_ep->req;
-	struct usb_request *req =3D &hs_req->req;
+	struct usb_request *req;
 	unsigned int size_left =3D DXEPTSIZ_XFERSIZE_GET(epsize);
 	int result =3D 0;

@@ -2408,6 +2408,8 @@ static void dwc2_hsotg_handle_outdone(struct dwc2_hs=
otg *hsotg, int epnum)
 	if (using_desc_dma(hsotg))
 		size_left =3D dwc2_gadget_get_xfersize_ddma(hs_ep);

+	req =3D &hs_req->req;
+
 	if (using_dma(hsotg)) {
 		unsigned int size_done;

=2D-
2.40.0

