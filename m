Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2850ECA0EE4
	for <cocci@archiver.kernel.org>; Sat, 23 Aug 2025 06:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mAtEoIuWx9LvKD4QPIhqJafW5E2ph55oiVPD/XwCPy4=;
  b=eg64ZQJI/ZvJaIHoFADTDTGIZuGW1gDLjN9ClD/uEA3aSxmNIdiyLXct
   tqwGEBvkzhb9UAysIlOC36a2VAW1wuMhNDSsWglrPlkbyPVM3XPb48HNo
   ZUJx//a9LLp5WEWnPWg2oTwCbLkbOkrZ7BWulwiYbQv3uyOe6T1HtbmuK
   Q=;
X-CSE-ConnectionGUID: JF7AY5g4Rnm1GqCdky2Eaw==
X-CSE-MsgGUID: AIA77SJdTrynTBcL4zOOVQ==
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
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="235830595"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Aug 2025 08:08:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D78DFE0172; Sat, 23 Aug 2025 08:08:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 79E0AE0172
	for <cocci@sympa.inria.fr>; Sat, 23 Aug 2025 08:08:43 +0200 (CEST)
X-CSE-ConnectionGUID: 3W0lW/frRJ+e1k8gmobqNw==
X-CSE-MsgGUID: xJ5c77KITWuuslhRejYplA==
IronPort-SDR: 68a95aea_RIRIlcl4n7aVZ5pZu+roK/FMOjx+tuyULcXELFEsup7K4As
 Q0vXLJnoR1JAA/swRBrnIk8i8TQs7fYOATAXzFg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HDEABMWqlofgwR49RaHgEBCxIMQIFIC4JAgQEGVDMEC?=
 =?us-ascii?q?0mEVY9QgiSEO48Rik6BfQIPAQMBDUQKAQIEAQEDBIUAAowmAh4HAQQxCA4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOCQExhk8Ng?=
 =?us-ascii?q?luBLIEmAQEBAQEBAQEBAQEBAQEBAQEBFwINOkQBAQECASMEGQEBEScECwsaA?=
 =?us-ascii?q?iYCAlYbAQGCfgGCIgEGEAEDDyYHDQaxcn8zgQGCDAEBBoJp13UfLCJZgWQDB?=
 =?us-ascii?q?oEbLoVsgmQBimMnD4FVRIE8C4JHMT6CYQSCK4MOgmmCJoEWg16XE1J4HANZL?=
 =?us-ascii?q?AFVExcLBwWBIEMDgQ8jDzwFLR2BJ3qDC4EOhCYrT4IidYF3QRk/g1MeBmsPB?=
 =?us-ascii?q?oEVGR0uAgICBQJDPoFcFyQGHxICAwECAoEWEAIzQAIBC209NwkLGwY9lGCEa?=
 =?us-ascii?q?IIxpQShRTQHgjiBZ4FkDIoulT4GEy+DcZNhDgaTBZkGjgibOYFqAjaBXDMaJ?=
 =?us-ascii?q?IM2TwMZD44hhAAzuCNBNQIBOQIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 4T4qaCojXxXkXLMLPs=
IronPort-HdrOrdr: A9a23:0np+cKGRUio+Mm75pLqENseALOsnbusQ8zAXPjNKOHhom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK+yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4tgPM
 xbE5SWZueAb2RSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:C20tXGAeyd2Gwn76E3JYrEorXc4/SF+ewS7Tc0C9DmxwbqLAHA==
X-Talos-MUID: 9a23:jnNa1QakW48RsOBTpx2xj249F+ZU3LmzE0QNq5gEitGAHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="123737863"
X-MGA-submission: =?us-ascii?q?MDH/TQgDSehU89aRTHxkfij1Ti0xREirJ6cZ4p?=
 =?us-ascii?q?u/GHUu/GPSsSqX8aMf+8S77y1JIoHLKs11wx8PRW23M/DzDmmanQGtN7?=
 =?us-ascii?q?4+RSZuOdpCxistaP1hcTJTyRNE0GXFoJRkIfiMslSoTpdPCdHdw4DjlJ?=
 =?us-ascii?q?BcMe8Yv5vLuSq9H48PVNtrlA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 08:08:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755929321; x=1756534121; i=markus.elfring@web.de;
	bh=mAtEoIuWx9LvKD4QPIhqJafW5E2ph55oiVPD/XwCPy4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BR/DnuwsZkwSW8LPUOYv6GGftmjbMD1qYg6TNnDqzuM/pfZ8mTQ5WglExD4saOAX
	 yt4e44ciXwv5FKwm4gFK+fTx1+GsrB3+V7EvhZsbJZyw8Z87T5sYZjH25/spia+4c
	 /9dQcq8fNQrweuXqBRdy2NlvWvTh/g0dH1pY7qmzw+CjYptCrfHzfyFsOkKWp7GLF
	 HX1K9QMNun5n+i1+LuxcACb8q3T+hm/VyttF4nnkUjIaT+2RfU++CkQh/5/fqVZF4
	 yKCLAcwCTjg2Zxi/3dB0vQtFJft23V/M7aWcOxqEZqQA0jOut/jOdEkxmk5rM/NP8
	 hjgHMksBI92VGI8E2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.194]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2SP7-1uOZaY1WYx-00vg5A for
 <cocci@inria.fr>; Sat, 23 Aug 2025 08:08:41 +0200
Message-ID: <cb904f74-22a7-49e3-8999-34fc06b1054f@web.de>
Date: Sat, 23 Aug 2025 08:08:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <ae674fb5-8cc6-4807-97f7-92e2c4208149@web.de>
 <ba58f313-5edb-4ff1-91fc-1682321e4d61@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <ba58f313-5edb-4ff1-91fc-1682321e4d61@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IjI7JMET7hIHac8XwcGIlB6tQwoFWCCqBJEtOFWyWCpUUjWQcnZ
 4uX9UGli5BWEcZrhXAAh8xJufVD8ZrNacq69JFPdjvd+P4jdtviHAt7D8AFywrA7H5DIg5f
 Qy9ULs9FzlbB5bQ6JtiqJSfl3Bl89J9VUvN9fOFml5VW6TVQUxHfFxxPGU1+kU7Nu24mLnm
 a8mcT/GGtuYhapZhwcwPA==
UI-OutboundReport: notjunk:1;M01:P0:qHbJPMR/+28=;y/fa6+wO6JREN3Yl7eTrH6NEBog
 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
 86nKRgT4d8rLksKyu113EI8zCDniEPCnfbEnG
Subject: Re: [cocci] Reducing the scope for a selected variable with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2976
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/cb904f74-22a7-49e3-8999-34fc06b1054f%40web.de>

> An interesting difference display can be generated then.
> Do such script variants indicate data processing difficulties
> for the handling of SmPL exclusion specifications in combination with
> a selected variable declaration?

I guess that another SmPL script example will influence corresponding development ideas.

// See also:
// pci_bridge_release_resources()
// https://elixir.bootlin.com/linux/v6.17-rc2/source/drivers/pci/setup-bus.c#L1711-L1767
@adjustment@
identifier var;
@@
-unsigned int old_flags;
 ... when exists
     when != old_flags
+unsigned int old_flags;
 var = old_flags = r->flags & PCI_RES_TYPE_MASK;


Regards,
Markus
