Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6267FCAC5B5
	for <cocci@archiver.kernel.org>; Mon, 29 Sep 2025 14:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IEof1C4UvQQWSlkSCfzXMvH7P9tr8IbovOk1WLKyr2M=;
  b=XXRcHMPYJHGCNP0oNoikoP3WSlMz+wHOxTeUoXK0Q2rmJADsgWQWX5ac
   tjFkNXpTJ0+veVNCw/6iFCUHFrRO0IbEygZCy3t0KrGZfhiu9hEXR5dKE
   Dn4UY49unlGHI8uu5rxnXmJ9ZnLz0NpN7gyZ3FaZU7Ck4Gpf6mpUm8G7N
   Y=;
X-CSE-ConnectionGUID: tiW0lnzCQvq0TuaV0KzzdQ==
X-CSE-MsgGUID: K3Rg/ghmS/G74vdYQfxAoA==
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
X-IronPort-AV: E=Sophos;i="6.18,301,1751234400"; 
   d="scan'208";a="241587391"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Sep 2025 16:18:50 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 08460E0B0D; Mon, 29 Sep 2025 16:18:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 89E75E0171
	for <cocci@sympa.inria.fr>; Mon, 29 Sep 2025 16:18:47 +0200 (CEST)
X-CSE-ConnectionGUID: 4Z9hFEvZTc60gPa2l+IOMg==
X-CSE-MsgGUID: zHPrDUomSVCWl2M/Z+Cx8Q==
IronPort-SDR: 68da9547_zfNninS0Tia+KB7k5kFT8cAayMhrs+2q/4Gz5yC4p4wCRDe
 S9aElIZ0SHVK4BfhT1tPOm176GQ8lm54NSiZoBg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HbCQBclNpogAQP49RaHgEBCxIMQIFIC4JAZSNUMwQLS?=
 =?us-ascii?q?YRVj1CCJIQ7hzyHVYxLAg8BAwENTgECBAEBAwSCDIJ0AoxGAh4HAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCjGGTw2CW?=
 =?us-ascii?q?4EsgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYbAQGCf?=
 =?us-ascii?q?oIjAQYQAQMPJge1RoEygQGCDAEBBoJp13YfLCJZgWQJgRsuhWyCZAGKYycPg?=
 =?us-ascii?q?VVEgTyCUjE+hENNgw6CaYImgRaBVYIDkQiKBlJ4HANZLAFVExcLBwWBIEMDg?=
 =?us-ascii?q?Q8jDzwFLR2BJ3eDB4ENhB0rT4IccoF0PhlBg1MeBmsPBoEVGUkCAgIFAkM+g?=
 =?us-ascii?q?WsiBh8SAgMBAgI6Vw2BeAICBIIvgRKBXUBAAgELbT03CQsbBj2YNIJKLoQwk?=
 =?us-ascii?q?yCzKTQHgjiBZ4FkDJ9sBhMvl1IOBpMFmQapQYF+JIFcMxokgzZPAxkPjiGEM?=
 =?us-ascii?q?8dxQTU8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 8SJi6/5bjtPoYq8FS40GMXebs6KYiJJDA==
IronPort-Data: A9a23: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
 4T4qaCojXxXkXLMLPs=
IronPort-HdrOrdr: A9a23:TEE/76wxpE98Aw0i8q9jKrPw8r1zdoMgy1knxilNoG9uA6ilfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8X3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 JdmsNFaOEYY2IK7/rS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:zkl4RWO7blEnpO5DBBs29GA5BPIZeSOFw0/ZeUv7KEFMR+jA
X-Talos-MUID: 9a23:MpBkNAt4Zbpnnj62ps2nlhFaLutV5KGVNmsylc8j/PvHHjwgAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,301,1751234400"; 
   d="scan'208";a="126846946"
X-MGA-submission: =?us-ascii?q?MDFGUW2jXCVreo8An75mQ3wUE0XdcjnrTb8r6f?=
 =?us-ascii?q?vaNaVlzlbXeG7vEfTFWjLwre8re7ViaEpYhklF9F+OtPSAPxGBzI4cDI?=
 =?us-ascii?q?q7i5a9xaxwtrLwRV+ZYldD8RhS8t+zyUAUJ2oCLVllvAMdqRrW2W3zxD?=
 =?us-ascii?q?tcjTzlY+4FYA6ElfeKZ7vA8g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 16:18:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759155525; x=1759760325; i=markus.elfring@web.de;
	bh=IEof1C4UvQQWSlkSCfzXMvH7P9tr8IbovOk1WLKyr2M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rJhjHMHK714AQ815v2d0xayqOwI61KsAYeURBBMzIwGIiyiSk1uILvGNytbq52TA
	 mJspIcBUAZQRMt8FichMJKB7wsgS7jCtRxFpFrUR9h9Xd6cMA7UmviDiv45ZcT49V
	 c4Z5tThN7fritoge641MaEWqvplBZQO/JotjNHVvLlDfmBg1gjA+vqa11BVQ4ht0t
	 ibgsODH20l0xWYBO/YGtMU0wEnEW0JazWJUT3vAVLKfpYd5uUqLorrdaRCr6Cxvr/
	 K3pHG//2iKF7YabREiSUkjUb8umjEnS2kpyb1BeErv99PM3ypD/H5YZzV4d6U19Ym
	 RX9tSZOKppXW3Zn6Qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.245]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPaII-1ugk1H32xO-00PfX1 for
 <cocci@inria.fr>; Mon, 29 Sep 2025 16:18:45 +0200
Message-ID: <58be2182-270a-4d2b-93b3-35e737d68841@web.de>
Date: Mon, 29 Sep 2025 16:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <61f326c5-7c60-4390-bcb7-20707fc68b6f@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <61f326c5-7c60-4390-bcb7-20707fc68b6f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UAdb8vZDJpCmfce/OFpah/6j4AqjuYwgGvMUdVb5uM/KZo72DbI
 EdBbyyC1GR2ShKUFvp9+0VyI6cuorQQZ70zaZ87MEeM6wqzpBGDjI9P36+Cxl94kcmNRAo+
 QtqkSNjPL8GxilqP08ayBgxnmJbZnPujcaM8wjeQHvvYNHaHVt0Y2XmhSv+ol3XM4DP9+3E
 1GwSpr8BM90wJOVmNs0Cw==
UI-OutboundReport: notjunk:1;M01:P0:H1Ppz10PYHU=;sXb5M/F59ItH4U3EuPf0+0KUuxK
 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
Subject: Re: [cocci] Improving handling of position information for SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3053
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/58be2182-270a-4d2b-93b3-35e737d68841%40web.de>

> Some data processing results can be observed then also according to
> the software combination =E2=80=9CCoccinelle 1.3.0=E2=80=9D.

It seems that the printout of generated computation tree logic terms
might not be so helpful so far.

Thus I imagine that another development idea can influence software evolut=
ion
in desirable directions.

SmPL variables are available to be filled with data.
They can get useful contents
* after a source code search was performed
  or
* values were set by a supported scripting interface.

Position metavariables have got special properties.
They can be connected to selected source code places.
I am looking for further clarifications also according to corresponding
implementation details:
1. It can be determined if position information is actually reused.
   May any additional variables be omitted from data processing?

2. If position data are inherited, they are attached to found items.
   I assume that these items do eventually not need to be researched again
   because code places were marked already.
   Would position metavariables suppress any data evaluation for companion=
 items?


Regards,
Markus
