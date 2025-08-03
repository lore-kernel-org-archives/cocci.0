Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C58DC87FCA
	for <cocci@archiver.kernel.org>; Sun,  3 Aug 2025 05:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rLPcLZNWZms0uXLGk11vCpnNZ9f1ojRBmceLWYccVy8=;
  b=ZrOCTEsWxXqfL2Lkj8REGqrsw+M6JlU0XFwhWQ6Zi67tachAHzVrBRhE
   kaLKcJSw7DJm6cqs1fpxXWWGe2QcWtc98bCoOUNDt3Sel73vIlpX9OMQ4
   byQ3Jw5lGykfL2zusFkfHASdadZM88jsQ4K1wO/edBRP2rXfRCP4iLpYt
   M=;
X-CSE-ConnectionGUID: opTs9t2GQYmYwemBQhz24w==
X-CSE-MsgGUID: If7wtKAOTuSAcWBk86Ru4w==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233991461"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Aug 2025 07:24:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CEACAE0BE9; Sun,  3 Aug 2025 07:24:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F17C3E0171
	for <cocci@sympa.inria.fr>; Sun,  3 Aug 2025 07:24:34 +0200 (CEST)
X-CSE-ConnectionGUID: 4XecCD0ZQqyctVi7Q/RbXA==
X-CSE-MsgGUID: 56+Ucj9tTNyH+gGUuuAXEg==
IronPort-SDR: 688ef292_cZfYAZKDPQvwQXLLVmJaoWAaZYtds6ivhxE86oHQW//DU0J
 kz/DU4Pp2V/0J/CngpfYAUSPvQ989suaTa39Ivg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FIAwBd8Y5ogAQP49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDgQZUMwQLSYRVj1CCJIQ7hzyHVYh5g1ICDwEDAQ1OAQIEAQEDBIUAAowaA?=
 =?us-ascii?q?h4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgn6CIgEGEAEDDiQHr3WBMoEBggwBAQbaXh8sIlmBZAmBG?=
 =?us-ascii?q?y4BhWyCZAGGJ4NCeicPgVVEgTwLgkcxPoRDg1uCaYImgRaDY40EiHBSeBwDW?=
 =?us-ascii?q?SwBVRMXCwcFgSBDAyo0MSNLBS0dgSd9gw2BDoQnK0+CInWBeUEZP4NTHgZtD?=
 =?us-ascii?q?waBFRoeLQICAgUCQ0WBYBkGGkACAQttPTcJCxsGPZNUgyGCFYEplxGvbDQHg?=
 =?us-ascii?q?jiBZ4FkDJ9sBhMvg3GTYQ4GkwWZBiKpH4F+JIFcMxokgzZPAxkPjiGEM70OQ?=
 =?us-ascii?q?TU8AgcLAQEDCYVGAQGMN4FLAQE?=
IronPort-PHdr: A9a23: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
 klRqVsZBYEUK5G9xEFoLFV3ztyiJg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:yRSXxKggwfn+/UitZK2M4HVhEHBQXg4ji2hC6mlwRA09TyVXrb
 HNoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:2XkHdG1Pezr1WXM4LcLbTLxfRvAoeVbxlEXpOl6zFVhoF4TSc1Wg0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AJkreXg6+VYFTj/sYFAFt9O+exow1veeTA0Jcjak?=
 =?us-ascii?q?gqunHOgNNJiq0vBm4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="122678899"
X-MGA-submission: =?us-ascii?q?MDHzGj8HEfNBPFeByX3Jzje4xF5DlmpCGGsM0K?=
 =?us-ascii?q?7OCkE5J4pwjlCvzxK4H8hQRBudmnI1mOpcrA0Afnbw5cCaJajkndh3UI?=
 =?us-ascii?q?vc+SmPZ4NOQF++rKa6X2UN5MLfatozU0/QejOEtZb1PBcqjSOA93NH8a?=
 =?us-ascii?q?dhMY5MVAYUCELnt+lWrRG26w=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 07:24:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754198672; x=1754803472; i=markus.elfring@web.de;
	bh=rLPcLZNWZms0uXLGk11vCpnNZ9f1ojRBmceLWYccVy8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rN5YtarCxGQGU2l8hOSWq1ZJn42/w5xBwQkD0S/zT/7kDp4m2Z6HMjRrZ+Tvm8yJ
	 mcWHP8zYW/TSNz70oPvVWLRq7teVBv6/FoHr5l9QMn+z0nw/vDo8xgkLMCcydamEv
	 ZNKr8ZihinjyrQU9VxsXvkn4ZcRfDB2QGq/4+aG0ZNh2vH5eDT1tLBqgmc5e0Dqrp
	 GKM03jcnznSPUn9d6YeHT+9QYhHxs+qGiEFprlqVEDDmk9gVTKkbhuCKdQUt4WFkK
	 vu7WGsvtjEkd3dF+Tgw+oCZC1HcqJK4viRmVMHEVeznXfOrBXF/1rYJ3zdy2Q2FBx
	 hOoYpqyC2i7vVRZTzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MActo-1up0nI270S-007TRE; Sun, 03
 Aug 2025 07:24:32 +0200
Message-ID: <74b74c33-22d9-4282-bb2c-1c475d715e5d@web.de>
Date: Sun, 3 Aug 2025 07:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
 <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
 <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
 <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
 <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de>
 <alpine.DEB.2.22.394.2508021745180.3428@hadrien>
 <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de>
 <alpine.DEB.2.22.394.2508021803360.3428@hadrien>
 <51664351-746c-4d7a-ae45-2a610ba45176@web.de>
 <alpine.DEB.2.22.394.2508021822490.3428@hadrien>
 <5e8e1f8a-6832-49af-bca5-41d2a13b1322@web.de>
 <alpine.DEB.2.22.394.2508021935250.3428@hadrien>
 <a86ce687-61a5-4e52-92fa-6a0d53db9360@web.de>
 <alpine.DEB.2.22.394.2508022111230.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508022111230.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xf+nFLnzSW+upt8vT6pb03a7b61MU2OsyIrDKCjrdM/3JkE7l7B
 llclbVKYci8kh9ObSdmCB62uEGPe/1oNDcJROhTxAG82yfQbltszKlvHCqVAVMX9WBI5tk1
 gBY8LLa1dLj+dsczxIVC3DLDZl2Ug7RY5C2d7tPb1YEaQV6Emn6bBmzQQi4rNHlyPkhK6Ey
 2SKT29jYNX7xRMA2A+h+g==
UI-OutboundReport: notjunk:1;M01:P0:CIsyLRNTT5Y=;nUVJIO8TBAR6uTrEmzIqP5jUipr
 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
 FLTEMPN4zu0bF17YTDYGw2M=
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2952
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/74b74c33-22d9-4282-bb2c-1c475d715e5d%40web.de>

> You do know that
>=20
> @@
> expression x;
> @@
>=20
> - a(x);
>=20
> would remove all three calls. right?

We tend to adjust all affected source code places.



>                                       Why do you expect * to do somethin=
g different?

One of the recurring source code analysis tasks can be to point the beginn=
ing
of a sequence out.
Thus there are corresponding case distinctions relevant.

* Presenting only the first hit

* Reconsidering subsequent repetitions


Regards,
Markus
