Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5023EC77B73
	for <cocci@archiver.kernel.org>; Wed, 19 Apr 2023 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Icubf69FkqMsSjfXApiJ2/I+v2hD+U6xI3ZIDBwKtXY=;
  b=tJ03o/PLHVxb43c31swL7RXExfcQ2Y+m63YQlTGPykdwxLeB5lNAZHcL
   x7FNSCmsGNG2RC1Zt7KrLt1F0ZCviCxK2Ujojq/hNWvC1VldFOaDQt/ey
   v1JHjDZddP1bMtcgFVDlBDsm7ZwuFq7z4dXoujxum4cqw0ue7vUL2Jt8P
   s=;
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
X-IronPort-AV: E=Sophos;i="5.99,208,1677538800"; 
   d="scan'208";a="103863401"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Apr 2023 20:12:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3DF68E013D; Wed, 19 Apr 2023 20:12:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 605DEE004E
	for <cocci@sympa.inria.fr>; Wed, 19 Apr 2023 20:12:14 +0200 (CEST)
IronPort-SDR: 64402efe_A6NxuKvriUtEdDCaDw9HgBj0dNaQEBT8QQZPJcZOg9LE5dS
 wZVxND8mS69Z5xxBP8V/DJVEoyux/Bnz8YkmbBQ==
X-IPAS-Result: =?us-ascii?q?A0EJAAAnLkBkhw4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYItgUsvBAtGhFOIHYhoLgOEMIcujCWEA4FWgUA+DwEDA?=
 =?us-ascii?q?Q1BAQIEAQEDBDiBU4J0AoU8Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?QEBAQIBAQIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARICRz4DAyMEGQEBESYBDx8GAh8HAgJXBgEMBgIBAYJ6g?=
 =?us-ascii?q?igBAzEHqzh/M4EBgggBAQacCx8sIlSBXgmBFC0BjROEMCcPgVVEgTwMgzaEC?=
 =?us-ascii?q?4QUgmeSCIh1gTR2gSAOgTyBBAIJAhFrgRAIaoF5QAINZAsOcYFJY0yBewQCF?=
 =?us-ascii?q?EQOGAYeJQQOAxkrHUACAQs7Oj01BgMLHwZWawIJIxETBQMLFSpHBAg4Bhs0E?=
 =?us-ascii?q?QIIDxIPLEQMQjczEwZcASkLDhEDToFHBIELfAoGASYknlNSIAFSO0yCKo8cg?=
 =?us-ascii?q?x+xAzQHgiuBVoFZDJ8NBhMvlwkOBpIkAS6HMpAXIKd/gWM6gVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIAwNCRWDbo9IPzQ9AgcBCgEBAwmFRgEBgySCWQEB?=
IronPort-PHdr: A9a23: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
 yY=
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:9OMF5qD856ek5E/lHelW55DYdb4zR+YMi2TDt3obdfU1SKGlfq
 +V8sjzuSWftN9VYgBCpTn/AtjjfZqsz/JICOAqVN+ftUvd2VdAR7sM0WKN+V3d8lXFh4tg/J
 YlSLJmANn8SXBxkMb952CDYq8d6ejCy7qwjePSi09wQR1nL4Fshj0JbTqzIwlMXhBPAZd8Lp
 aG+cZdzgDQHUg/X4CAH3EAUqz5q8fWkY+OW29hOyIa
X-Talos-CUID: 9a23:HB26AWwpwCCkxPIfwhdkBgUtFf96TiHQ/kvrMk2DJzlHcbrKbGePrfY=
X-Talos-MUID: 9a23:2HUldQje1etHsPxOVrZrzsMpD5losrayNmk3v5A3/NeZLjwpH2ucg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,208,1677538800"; 
   d="scan'208";a="103863396"
X-MGA-submission: =?us-ascii?q?MDHQgeb8kE+9kLirM2AGwFoKVhij6JS4psu0zp?=
 =?us-ascii?q?lr7UOAi0TM8gr5dCV+Z3rqV6Nfq9YVf1mJ8UAMVdTIIO/Z9X87I/L5kr?=
 =?us-ascii?q?d+sZBNGvNqvThnnXzCCCD7EXdu1RHH7Xdd0AqLnyta0SASInuRsF2CN4?=
 =?us-ascii?q?CsHxSnppM9Xe+Fb4r2lboEVg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 20:12:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681927929; i=markus.elfring@web.de;
	bh=EjzcgocxNr5yHZ9nU3HyG3TvK4oY7RbcHZ3J/sJUeik=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=Fg9ct+VKWWPDSDsU48GZEo1wEm5vppAwWHjRK53RX4Z+N7b+QaAa7iL/aHV/fE+PD
	 sRwWg3LxaiTvmKReF3iePzQk2Cn1eyuMiTKFlgjR6KrgBJaY9rwbtDTWU3AOU8t6g6
	 X5Dtdrn4DC1AFnR/GBnaBH0BQOxfFeL9MKTaOQaWd/w8cmrBFw9zhlfhzC+stwzESX
	 5I9fDKFxPN233pty+BlWWlatgOCygDI/jb54w+2DIu+FFBwWVuHhkBX7LjEnofylxL
	 A65B106tKnxduY9KYVSXXWct+uCLfLH1AYIv1prJqFKrbNlkft0l7jq7dRtXcfcoKb
	 IMK6Vja2TRsag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuSe-1qU2oO41e0-00ezKA; Wed, 19
 Apr 2023 20:12:09 +0200
Message-ID: <10e10996-d53d-0733-6d90-a04f251812ba@web.de>
Date: Wed, 19 Apr 2023 20:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-usb@vger.kernel.org,
 Ben Dooks <ben@simtec.co.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Minas Harutyunyan <hminas@synopsys.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:22sRV3B01z85Ahz5bdh02Kwhn9ASvxXUM/EmN1LJVFBPkLpDBV/
 8TALheZKooAVCjyc+FryV6u/2OK3F+t2w/NJl7m401/ztLYWy8ETCWvWLRVvyJHcvWF/ETy
 EGzu03SQIwo3CGgbwX4fZ9sm25b6Me3aZPxpamysfZdDGsr/5Cf3v7kw31txjvWvWHMithV
 mK/133uc+/W2RfuIrm9WQ==
UI-OutboundReport: notjunk:1;M01:P0:6MtnEfHMdmo=;tPosrSNFgLl9NBBTGMjA4kCo7+X
 hm3fVdKZaoeVcNinRB0IQN4CxhamTXCKQldPrT+iDiTZWTZ41jp4LXF9gjGUZutvf2NEdGvvU
 1cdj3KAntEM3pQeYawS9+Rs3kP/0DeZJfx0AJxrTrbYce+37bCHnkgRF8o5sorAcJ32DMK7CR
 djMhSGIZ1pUxtT0pf/KtB3nMMqxm6JnvCm0do7L5xS93in+lvE5+JaIoaggNrI3pAS87R/JeB
 UdQcU72o+antTGJD2Mje+XD9eWYXpIb9Yzc5FYU3itlIyOVOk9y1CCdKs7sCfKWyZ4v3f1OZl
 R5fVEYwSaggrtdKaIYb7yfkphYNGMn69ooZLpryBeV2Yve9tcX7Q0My+15empcFszQyEyp2bH
 B33v9lzq+hF7fMwpj6ZRkYNia+YbEMpA77ozZe0WPUTCpMib+fFoBSOC3OV4/Gg/SIkSl0VJK
 pHUE28iuUtSYB1Sh61dnlVbUJbBB6uWtUxZTVeWMZ3WWKKtDz5GeT3whYzy5Jkr+ovx90qtqq
 m5g5huy8AsEfMGJUzun42tuVk9dw7TpZRhDHEWqIlf3xiWfxDZLq5DXN9YT7U681x8Wsm4Xwb
 6J3dcSqCQt8Or1574N1pGhsieIJtd2pddhY6u05bPOiRdoOiu7GHJXsGx63+41wFIcBCmggiq
 NBAFuCfNz7u1Tw4srKh6zSUUlR+CSwGJXQZq9pZwqEbI5d68qc3Mt8UVFjyhUYxLTmNj60OLh
 DuWsmbK+zfLqvjoFLsQvHqgS6DAERqr4HzVm9wkWzFnuzJuc2eMLaiGJosPNFlv+ZHDTbevPT
 mdz3Y6i6f9fU0KeRq7bcOHsotquF0ed7r0tyqADXtW2M+f9qWzs+lyK5oxXKrvYJ4603CRnqF
 ISrHVRvmp3P9voGK7uPSAA+l+FFoxW3mEjNF9I+hY2UB5x4yC/Pcnei8b
Subject: [cocci] [PATCH] usb: dwc2: gadget: Move a variable assignment
 behind condition checks in dwc2_hsotg_handle_outdone()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1097
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/10e10996-d53d-0733-6d90-a04f251812ba%40web.de>

Date: Wed, 19 Apr 2023 20:06:25 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cdwc2_hsotg_handle_outdone=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Creq=E2=80=9D behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: 5b7d70c6dbf2db786395cbd21750a1a4ce222f84 ("USB: Gadget driver for S=
amsung HS/OtG block")
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

