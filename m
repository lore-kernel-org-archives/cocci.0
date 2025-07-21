Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215A3C83F27
	for <cocci@archiver.kernel.org>; Mon, 21 Jul 2025 05:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mdLHRt+wwmA67pLref2Hsc56fI2J1fzMVxWsi13zxuY=;
  b=UZmzgIpGT6fVF7ClNIPyVIoXQUmm6tKCDjE8By7VDfiXbStu7IGSPysG
   dKomN3xWfxNkdJ6wf8xFnM04rIyoCoJ8PYCu+p/6SP3fAIb1YvqhB0YIk
   +fOLAvAczj8nOCzpyMkfzVJ5FumY+/TZrO32eNTAqEYH52tyTzulGfrLg
   U=;
X-CSE-ConnectionGUID: O0uKOMt9Q9iexSFy91AxQw==
X-CSE-MsgGUID: d7RadB9rRuSH1ZqLYINU1Q==
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
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232387597"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jul 2025 07:31:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1EF3EE0CD6; Mon, 21 Jul 2025 07:31:00 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C2DBEE0171
	for <cocci@sympa.inria.fr>; Mon, 21 Jul 2025 07:30:55 +0200 (CEST)
X-CSE-ConnectionGUID: ZkCenQveQa6nEaYETQl+OQ==
X-CSE-MsgGUID: C6Fct6ZmQeqOskDxSBrFCA==
IronPort-SDR: 687dd08f_KkNdHPUSAhil2hheM85C/CkS7FQlNLpoOdOm7TVYE/7tO/3
 W3Fvd1BJB+S51yc3lR+ulG6v16TkVORdUIt5oIA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GfBAD+z31ogwsR49RaHgEBCxIMQIFIC4JEgQAGVDMEC?=
 =?us-ascii?q?0mEVY9QgiSEO48QiHiBVYFAFicCDwEDAQ09EQECBAEBAwSFAAKMEwIeBwEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw4KM?=
 =?us-ascii?q?YV7DYJiAYEkZQk4AQEBAQEBAQEBAQEBAQEBAQEBARYCDTAKRAEBAQIBIx0BA?=
 =?us-ascii?q?REnBAsLGgImAgJWBgEUAQGCfgGCIQEGEAEDDiQHDQavEoEygQGCDAEBBtpeH?=
 =?us-ascii?q?ywiWYFkAwaBGy6FbYJkAYYnhDwnD4FVRIE8C4J4PoJhAgECgTQpg1uCaYImg?=
 =?us-ascii?q?RaDZJUGUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMKgQ6EJytPgiIBd?=
 =?us-ascii?q?YF5QRk/g1UeBm0PBoEYGkoCAgIFAkNFd0ACAQttPTcJCxsGPZJihF4CT4Fux?=
 =?us-ascii?q?js0B4I4gWeBZAyKLpU9BhMvl1EOBpMEmQYijWabN4FoOoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iEZg2czhGC8XEE1AjoCBwEKAQEDCYVGAQGMXzSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:jjivFq69b2wlnBpQXwPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:k9Aif2yAFDwUn5pJ/1p2BgUmGesodETDwU7ZfUmVAFdEdISRCniprfY=
X-Talos-MUID: 9a23:h8p3NAUPEcB/PR/q/BSyqjp+avVt2qm3L1sOvYU9kdOqHgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,328,1744063200"; 
   d="scan'208";a="232387591"
X-MGA-submission: =?us-ascii?q?MDHBPLbKypDp1LxG5R8lyVHqawPaDH5WtDMWxh?=
 =?us-ascii?q?EbEE49OrF+SfEOlDtUm+piN74MZ22SFgwXVwdFx1pak5rUgWH2gAyNjp?=
 =?us-ascii?q?Xc1v/Ww9AEJ4TevY0x2OfqSnpMS+92h3NhhBgC8WRYK1dR55XyW+mvsq?=
 =?us-ascii?q?1hf1MzFjv7tcExvIa20CI4fw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 07:30:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753075854; x=1753680654; i=markus.elfring@web.de;
	bh=mdLHRt+wwmA67pLref2Hsc56fI2J1fzMVxWsi13zxuY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cRy83MetRNUNjSJ6j+brV0MZydQ//VG3mE61+8XtyxWksEcIKwGZucEyG/ihYlNa
	 Zqo4N2c74HbUI3ZWCzlEbRLFZqdkgWzhqBB+8eLLSRaDdTD7aEgyj2YiJfjgptWiV
	 gqohcMimBEJBCxMM6qwFjjK2zlis6ONr605Cupdt9miUauTcQnJg0oaFwno7MeTIK
	 kpDXf0+y1rglPZBWFH6Mh/bHg/ZlOpvG3PPQlTx4Yr+FnNmQNJ8LxDxagz81xqq/R
	 mJbbqMu2Va/nDnBr2BSlAyDLH/PeOawGHw7/35QjfjCD/WPVIMxiPavbu0UmT8PP8
	 lY4tbe+N9tUI6Fg3lQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N14pE-1ukiNo0IAs-00tda7; Mon, 21
 Jul 2025 07:30:54 +0200
Message-ID: <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
Date: Mon, 21 Jul 2025 07:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de>
 <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr>
 <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de>
 <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2507201608390.3477@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B/SCsOK4IdAbFDxVlKk3+XGDCwQjyySkBASqmi5sRoOwjGAyY0q
 emZVierN3Z/tAP/VQo/t5+9AvCV73KSEBQy9BPJqcrm0Rzvq7041BtpXsTczVY/jcOf7+rp
 f47gulgqV7B7u+JNppZX2iAhm+8gy5C9Zx269Yg0GVDLGkt5JJVhIPVtLSL4lW5/sA2gTMA
 HngqoFOOWHnmlX/9Yp/VA==
UI-OutboundReport: notjunk:1;M01:P0:oH0RTgVCe5U=;hgTIMY/pesQGZOAUDlwhDTQvIpX
 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
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2881
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/bf7d6619-92c5-4471-a6fd-df4af8b97e39%40web.de>

> It's not clear whether you want to reduch parentheses in the semantic
> patch (the only thing that is affected by an isomorphism) or in the C co=
de.

We got used to the order of operations to some degree.

https://en.wikipedia.org/wiki/Order_of_operations
https://en.cppreference.com/w/c/language/value_category.html


How will the support evolve further for safe transformations of expression=
s?

The entity =E2=80=9Cexpression=E2=80=9D is supported by the semantic patch=
 language in
a limited way so far.
It is mapped to a single metavariable type. Metavariables matter at differ=
ent places.

* They can match some source code from context (or minus slice) specificat=
ions.

* Metavariable contents can be reused for plus slice specifications.
  Desirable source code adjustments should be =E2=80=9Cexpressed=E2=80=9D =
here.
  Which control can we get on the advanced handling of parentheses then?


Regards,
Markus
