Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D6DCCA476
	for <cocci@archiver.kernel.org>; Mon, 13 Oct 2025 13:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7m2oV/ozhVetE9TfAosLrhAU86Ea1Fd8PjJVaXUk0Zs=;
  b=h6aInBjNv9+4lCBOoJyhZbBoGaDSuaqeNcTbYBit/VFOjPkWIZ0ZOKhM
   w9WWbEUKeoj7xvQlyRxKZxK7RoPawZmfvwdLtY5zxlS5NILkKHAs6H5rH
   cmstKabtoffM4z7MD+Lu1zmZyla3LeEe6nJPKPnPDrfgSiY80J1pXznj+
   o=;
X-CSE-ConnectionGUID: +U8dZzD8SVaOgu2yrfO1TQ==
X-CSE-MsgGUID: 4Nxi4Rk5Tbm7KMkZ+AKk1g==
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
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="243899169"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Oct 2025 15:05:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6A5D5E0C55; Mon, 13 Oct 2025 15:05:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D5A37E0171
	for <cocci@sympa.inria.fr>; Mon, 13 Oct 2025 15:05:24 +0200 (CEST)
X-CSE-ConnectionGUID: EMWstyTzTHC3RUO1esuzgA==
X-CSE-MsgGUID: SzcxpfaqSQaZkh2xX6UFQw==
IronPort-SDR: 68ecf913_ypjF7LPtiNK8qbBiAgUarX5mGONmMs/EDQBtLu7wR3r2njy
 vEMIQyjzgbL+n2CAtLgXJVJX+1emRoUacO3w9zg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F7BgDF9+xogAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VCCQGUjWDMEC0mEVY9SgiSEO4c8h1WIeYFWgXwCDwEDAQ1OAQIEAQEDBIUAA?=
 =?us-ascii?q?oxKAh4HAQRHAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?TsHDgoxhhUHMw2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmA?=
 =?us-ascii?q?QQLCxoCJgICSwsGARQBAYJ+giMBBhABAw8nB68YgTKBAYIMAQEG2l8fLCJZg?=
 =?us-ascii?q?WQJgRwuhW2CZAGFXEuDQ3onD4FVRIE8C4J4PoRDg1uCaYImgQ6WSVJ4HANZL?=
 =?us-ascii?q?AFVExcLBwWBIEMDKjQtI0sFLR2BJyIhHhNgPRdAg0kbBmgPBoETGUkCAgIFA?=
 =?us-ascii?q?kI6gWoGHAYfEgIDAQICOlcNgXcCAgSCMYESgioPhEsCAQttPTcJCxsGPZJBg?=
 =?us-ascii?q?xB4gTFAxzU0B4I4gWeBZAyfbAYTL4NxE40ThjsOBpMFg1eCS4RzjXEiqR82g?=
 =?us-ascii?q?UwBH4FcMxokgzZPAxkPiTaEa4QzuRpBNTwCBwEKAQEDCQGBVYNwAQGMVoFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 t3SRDNKNBgRlgiovfkxDBoPk+tf6iEz1g/FGwEU
IronPort-HdrOrdr: A9a23:/SXv86+s++fQhcnswEpuk+DoI+orL9Y04lQ7vn2ZLiY4TiX4ra
 +TdZEgviMc5wx+ZJheo6HkBEDtexLhHPxOkOos1MaZPDUO0VHAROsO0WKI+UyDJ8SRzJ866Y
 5QN4R4Fd3sHRxboK/BkXCF+g8bsb26GXaT9IDj80s=
X-Talos-CUID: =?us-ascii?q?9a23=3AvorSBGr70sGIBsGC1yets4zmUe0ATWbB3UvCH2+?=
 =?us-ascii?q?TUlxUb+SYUkKC94oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ALTu9oA+Bh9X5t5DMYuUFiwiQf/x66LS2BkkUqqw?=
 =?us-ascii?q?PicqEbzxAZQqztSviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="128033567"
X-MGA-submission: =?us-ascii?q?MDFGZ/c0LkcvKZX/ay9pjzMscwj1rKz/ZjMAUS?=
 =?us-ascii?q?IGWTbF8B1+GQy8CmmmzKj7XIGcCNO43dd6KWe5HijH2GGQqOWXwsxNSA?=
 =?us-ascii?q?TKHubvZXMxcZ2vPO+gPVt3iVmbSnHXc5SBxL9QaWhWkZx0ZkQv7CdNpj?=
 =?us-ascii?q?NvxUyax45hodRCu1QCqCxBXA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:05:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760360722; x=1760965522; i=markus.elfring@web.de;
	bh=7m2oV/ozhVetE9TfAosLrhAU86Ea1Fd8PjJVaXUk0Zs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gtTll6UkL88A9VnC77lsqSgaafRjCqqr8nmE18fLQwyEH1cvARfm5Q4yPSPLIh26
	 QWlB/5S22vzifWenTgjtctoGI+qFXfitn+rtsBswcP1eSgfU8b8vSS6Pxw+rX0imU
	 ti78GjsWCxCgi2aMtJvvOLDM0VfDi1Oi18MgFOx1hb+xDJt0YcgmXDHIYgz3lN3VW
	 sRCyRJyRHU1l9bBJxdeqcV7HPVaer0TylN5YXLX5514ziIW/1f0QtbLk89CNvg4dA
	 +R4v5TUKUnsBzeXdned9NZBCTLqfWVgDPA4nz3qY5lzhmrcyJ4UrTAuv7ghburE7g
	 DPpjJ/upMVyw+8JUHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTfkf-1uelJ91cej-00OqMS; Mon, 13
 Oct 2025 15:05:22 +0200
Message-ID: <4a37e90c-f008-4094-91db-7e284e974a5b@web.de>
Date: Mon, 13 Oct 2025 15:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: linux-cifs@vger.kernel.org
References: <335b0fe9-313f-4e3d-a01d-1954f3c46489@web.de>
 <805f36f6-ea15-cbc9-f510-45856eb6f6d7@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <805f36f6-ea15-cbc9-f510-45856eb6f6d7@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z0/IpucWK8TNE1EGf+djkIskU9+SxV3oYO7loYEXPsS/0yrp43A
 YLSXaP0yCn/4Or/JJxPgidsWSyt2uUTbV8PAX5ePobMvYwPf9qMDbrjnhyUyIUBQjA1hvGf
 LRkfagruBwiUO/yqJphxVMkeyxr3UOECIg4sYaw576PY4qMvomGJmAbmtBFEZu/dywuhqUt
 2DW97scyrFR+17fzx6h9A==
UI-OutboundReport: notjunk:1;M01:P0:l6Jvkcwx3zQ=;6sP0Q8FrY4Kv0I3RFHo4uVVAjiD
 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
 DqvJPOKSQT8kmDP0zvIslbHZrwOPxgOeJqA=
Subject: Re: [cocci] Improving source code parsing for =?UTF-8?Q?=E2=80=9C?=
 =?UTF-8?Q?fs/smb/client/dir=2Ec=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3069
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/4a37e90c-f008-4094-91db-7e284e974a5b%40web.de>

> If you want the problem to be solved, please make some effort to narrow =
it
> down to a smaller number of lines. =E2=80=A6

Can other data parsing technology help more here?

Why are the following source file parts marked as =E2=80=9Cbad=E2=80=9D so=
 far?

1. Complete implementation of the function =E2=80=9Ccifs_do_create=E2=80=
=9D

2. Comment line between two function implementations

3. Blank lines

4. Closing curly bracket from the function =E2=80=9Ccheck_name=E2=80=9D


Regards,
Markus
