Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFFBCA1012
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 09:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=50j5nmDi/veO4RseCwYkDEJYZoLPqDn3o/bI+g2uucc=;
  b=pXFR2qDK60EFF0FC2Y9pacin0jtfTzMSIXAQ0cbJbbZ3W1FIzNnuB+/C
   wGGzhTTLJIDkK8C8uKqie1GxQ4C02wP/L5aOJE9SD7hA73g+9OzHgARKB
   KQ9i52VaoyMhKl3UDZmG6Bfm6PX0P+xXoI1Vf+x386BXYtu3mjwGIw2UX
   o=;
X-CSE-ConnectionGUID: X7nHn3gQSDqZ36Up5XsScg==
X-CSE-MsgGUID: vuz7w1uITIWCJX5f0PU8bA==
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
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="237806764"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 11:11:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0FC53E0172; Sat,  6 Sep 2025 11:11:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CAEE7E0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 11:11:29 +0200 (CEST)
X-CSE-ConnectionGUID: oXYXQcSNQ2aLhnaefEEkDw==
X-CSE-MsgGUID: DVUBlxWNRIO8A23+2+/ZlQ==
IronPort-SDR: 68bbfac1_AqZ5cgXUkia1qG6fvEUQ96oLGTPE7/zvHTqFPLWwIr67Ltw
 Du0/Y1vCe3hqhq1CHVE5wFS0vRaOfecjy/PUxUw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ERAABT+btog07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYI/gQdUMwQLSYRViByHNIIkhDuHPIdViHmBVYF9Ag8BA?=
 =?us-ascii?q?wENTgECBAEBAwSCDIJ0AowpAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAQEBD?=
 =?us-ascii?q?QEBBQEBAQIBAQIEBgECEAEBASEZBw47hk8NgmIBgSSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARcCR0QBAQECASMdAQERJw8LGgImAgJWBgEUAQGCfoIjAQYQAQMPJ?=
 =?us-ascii?q?gexRIEygQGCDAEBBtpfHywiWYFkCYEbLgGFa4JkAYYnCYQzJw+BVUSBPAuCe?=
 =?us-ascii?q?D6IHoJpgiaBFoNYjwhHiEVSeBwDWSwBVRMXCwcFgSBDAyo0MSNLBS0dgSd5g?=
 =?us-ascii?q?weBDYQdK0+CGnKBdD4ZQINTHgZrDwaBFRlJAgICBQJDPoFtIgYfEgIDAQICO?=
 =?us-ascii?q?lcQgX0CAgRLQAIBC209NwkLGwY9lXKHGsZJNAeCOIFngWQMn2wGEy+XUg4Gk?=
 =?us-ascii?q?wWZBiKpH4FoOoFcMxokgzZPAxkPjiEMDQmEEboyQTU8AgcLAQEDCYVGAQGMV?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
 w==
IronPort-Data: A9a23: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
 QAIeIyPfK13pYMd3yqtl7651Sz1ZA/S8gg=
IronPort-HdrOrdr: A9a23:PW1jnq6eTvCx5jNemAPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3AMOh1NGqbjVvc/42nrBOAc/3mUccVQ03kx0z2GhW?=
 =?us-ascii?q?xLWZvQbCbZHKT1Lwxxg=3D=3D?=
X-Talos-MUID: 9a23:28Y39AifeDuE8AXQfVMO7cMpGPlVyaC+N2Y3sLJWkpPfdnYzfAWZtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="237806763"
X-MGA-submission: =?us-ascii?q?MDHs3uWWHJLHVkPIhbXgUvWue2PFPJa0KN5uKQ?=
 =?us-ascii?q?SilWI+yVP76dQY4aNud27PAPv1aItcszX0bRBTqZRSJt7XVcBIXQMP0D?=
 =?us-ascii?q?L0KNc5FQ5xpIKX2tUh3RYr935ukt1KqWYJBwhSOtvfOGJbQS6z5MwWML?=
 =?us-ascii?q?SSkDXqUZ9ACIJvsMm3T9+A1g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 11:11:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757149888; x=1757754688; i=markus.elfring@web.de;
	bh=50j5nmDi/veO4RseCwYkDEJYZoLPqDn3o/bI+g2uucc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UroaKy3R2lWBu5fH+X27FQ3YpHG1mDqzloIL2Lkdi/OkAJC67J1C1HVDIVHr/re8
	 /7Z6uEvVzEfXrS74Mz3ZYWr45wh+QYXGsnZX0YOOvx2McE75s5+ylvna/aUs4ozWP
	 MCVQdsQZVs54A1uz8qE2kSXRMc7VFNwUdSvIIJMR60287acKkYlSdILntIVZeBAkE
	 8yldYFTORBw3phY001F1HEPAx79VWv3RpeX7bh9+IFKR4PFrsq5DSXL024MqDrhBu
	 Bz9tWI3f8fWIt6/R6oz8x14TCNF+fUfbDbqHt6tx1rW8Oi5dV2HW/WNV6MUr0nduM
	 lmQ7jHvRS+6br47OFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6pUK-1uokQA280E-006i0K; Sat, 06
 Sep 2025 11:11:28 +0200
Message-ID: <d28c6f76-6708-4dba-a446-910170e27572@web.de>
Date: Sat, 6 Sep 2025 11:11:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de>
 <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr>
 <b0221946-43a5-43c0-8573-32c12e149681@web.de>
 <ba87aeca-594d-10b6-960-cd4aa1fcd1e6@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ba87aeca-594d-10b6-960-cd4aa1fcd1e6@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pBUvtshDxFxf+Oxsw1F2uojEUk7vcVSEm3GyFsF06VyOz/0NAZv
 /hjLVmDq99AKzedZeSJCaIrZwiumDh5H2o5ngTvb+poFoqUJpk+GRd5ulTWVoC7zu+PWjFZ
 T485SaBTBgjHrCJFu+MXBCdojdQAJmj9V3KOTXNJHbT2OMsSiyEJWaFiHiDHTAXPF3KOFPO
 nEbZ5xbkWYfOReq2dCiXQ==
UI-OutboundReport: notjunk:1;M01:P0:F2K/LajcWTs=;QZbFtL1FuSMv9fW46u4dcCRxV2I
 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
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3000
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/d28c6f76-6708-4dba-a446-910170e27572%40web.de>

>> Do I indicate a desirable extension for the Coccinelle software?
>=20
> No you asked for a feature, I said that that is already what happens.
> So I don't know what you would see as an extension.

Would you get further development ideas from an SmPL script variant
like the following?


@find1@
expression e;
position place;
type t;
t * pointer;
@@
 pointer =3D e(...);@place

@display1@
position find1.place;
statement s;
type find1.t;
t * find1.pointer;
@@
*;@place
 if (!pointer)
    s
 ... when !=3D pointer

@find2@
expression e;
position find1.place, place2;
type t;
t * pointer;
@@
 ;@place
 ... when !=3D pointer
 pointer =3D e(...);@place2

@display2@
position find2.place2;
statement s;
type find2.t;
t * find2.pointer;
@@
*;@place2
 if (!pointer)
    s
 ... when !=3D pointer


Regards,
Markus
