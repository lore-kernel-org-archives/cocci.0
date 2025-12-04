Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5D6D1CDBF
	for <cocci@archiver.kernel.org>; Thu,  4 Dec 2025 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5hR8NPpmxQWoEjAvip75nfzuTe6o2sQpAhcRg9AtUvk=;
  b=S1dT8KjBTMGXKwg3LksK58NV6UCSUyjaiQXIW6HA+ZZC/2q/f/JFNM6Q
   wNRT8mXDeu7om7CcIem749YClagJZHKZxbfnIsV3Z2D/535/HIxNo2f5M
   BoRpQfP2MVOWouttrFeEumBEquWg6cfdHETiCKpxHeNo0Ad9+KFD2Mf1c
   Q=;
X-CSE-ConnectionGUID: sViNpw5zS4Kqhm4jDSjN9w==
X-CSE-MsgGUID: jjIdo2DRSMqT3az3Li5obQ==
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
X-IronPort-AV: E=Sophos;i="6.20,248,1758578400"; 
   d="scan'208";a="252688760"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2025 09:50:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B4112E0137; Thu,  4 Dec 2025 09:50:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BCFE9E00A5
	for <cocci@sympa.inria.fr>; Thu,  4 Dec 2025 09:50:17 +0100 (CET)
X-CSE-ConnectionGUID: V8c+A3bSRpGegmp9AWSLAA==
X-CSE-MsgGUID: pP4LPjG4TgSixsNC5pNt2w==
IronPort-SDR: 69314b4a_sirEmq81nuaFeBlpE7HeCKvyQ5JcBEbeQ5K1WDZWoRW1iL9
 eATnePGjuHRfwfVbUVj3y1j44GHf7/a0r08st7Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FBBgBvSjFpgAwR49RaHgEBCxIMQIFFC4JAZR0GWTMEC?=
 =?us-ascii?q?0mEVY9TgiSEO48OA4xLAg8BAwENPREBAgQBAQMEgUxAgnQCjGcCHgcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPD?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg06RAEBAQIBIx0BAREmAQ8JA?=
 =?us-ascii?q?hoCJgICVgYVAQGCfgGCIgEGEAEDDycHDZU0nEeBMoEBggwBAQaBWAMPL9hIH?=
 =?us-ascii?q?ywiWYFkAwaBHS6FboJlAYpmJw+BVUSBPAuCeD6CYQKBYINbgmmCJoEOmVlSe?=
 =?us-ascii?q?BwDWSwBVRMXCwcFgSBDA4ELI0sFLR2BIyEdFxNgPRdAg0kYBmcPBoERGUkCA?=
 =?us-ascii?q?gIFAkA6gWYGHAYcEgIDAQICOlUMgXcCAgSCFX2CCg+IAoEIBS57JwIBC209N?=
 =?us-ascii?q?wkLGwY9lRNPgisIYFnIejQHgjiBZ4FkDIoulT4GEy+DcQGTYA4GkwWZBo4Im?=
 =?us-ascii?q?ziBfiSBXDMaJIMCATMSPQMZD44hhAAzu3ZCNTwCBwEKAQEDCYVGAQGMVoFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 jMXzLm+IYlBbuUTOmRnbURm2pvHEQzcUIIVyhA=
IronPort-Data: A9a23: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
 Qw=
IronPort-HdrOrdr: A9a23:GNMbQKhfYteXbCSTo5aTpXINKnBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726QtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykZsS+Q2mmF+rgbsbq62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3AcRrE4WoxcDChtQogkpRAD17mUf51eT70l33rGVe?=
 =?us-ascii?q?XBGlsUOy8dmS00Yoxxg=3D=3D?=
X-Talos-MUID: 9a23:SEI9FAb/8gzsbOBTrwewoAlgG5tU7J+vGFsrusgendXeKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,248,1758578400"; 
   d="scan'208";a="252688752"
X-MGA-submission: =?us-ascii?q?MDEzeHtjahbbnFjMVmutZJ2CE7WJlQkCxMv8xs?=
 =?us-ascii?q?4/tlCugIR0SAqX571FjAFuLJMjUm0Ft8vlkGrTAuwuEWSD+O4Rucj9Hz?=
 =?us-ascii?q?VXv5J3jZfgEjQErqdbAigBDKvJihv6TdmV5dv14ESBm8aqVr5W0kKaZx?=
 =?us-ascii?q?VZjQbie2kUpRl02QqiKaDNvw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 09:50:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764838216; x=1765443016; i=markus.elfring@web.de;
	bh=5hR8NPpmxQWoEjAvip75nfzuTe6o2sQpAhcRg9AtUvk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YSPpLF6VGXfqZ2z0Z4vjGE4RWj9Z5DOQ+RaFS5jRwgF8TZ47jaArtiFYsnK+lsgy
	 lbMpzpA1eSgVtzDP6vYgigE9R9jVtZJ+1MhnQ+/OQ9KvQMTQ3t3hY5itaufYgqN20
	 VO2yYzMC35FFqK4Aln70CLJ3g8EojZJymAC1SN+UOaWagGmxgRqT67Xz9Rys1eo5A
	 DAQ3vWnNjL5dvGYAmMyg70lNYQqCwlD4vronQBfHycYslWnr7VHoy82hbPBnIK4OS
	 ai4c8gvAx5XlxKhipR/keVJKJaHNdC7beYZF70JR18eWT6dJkAubOyo/YYrm9YcM7
	 JQiM1LPDMmSTu/cvfA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7WH-1vdPdP20ER-00W01m; Thu, 04
 Dec 2025 09:50:16 +0100
Message-ID: <431d6a18-cca0-4a98-8033-49309b81f53c@web.de>
Date: Thu, 4 Dec 2025 09:50:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
 <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
 <67f9e0f2-fa4e-c7a-d388-3732d8aec1e6@inria.fr>
 <67d1e00d2e22a4655cb10ec55d1a99db@posteo.de>
 <83c8a7aa-9b98-8ac1-d563-e8fe2588f9a@inria.fr>
 <fd7307f8024706d4bd128d0b7f43bb96@posteo.de>
 <29c204aa0f1f08074279425b7de42dd7@posteo.de>
 <825ab32a-2544-d2a8-bc48-38f26c62bc@inria.fr>
 <ded004b275d73e35c46c3d30c057d58e@posteo.de>
 <e88c503c-b2a1-454b-a4a4-ae2dedd79daf@web.de>
 <893abd46009f5e07e55f6b3f36645eda@posteo.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <893abd46009f5e07e55f6b3f36645eda@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QHvcyU9G/Ug0RuwdxnKs4DyKqUvKZwYjWCQfZ1Sfm4dTE6Zdc+H
 Z6VZdW0QNGxQ09Rik/VhQ3vbvP7hk8db6vnjw6rwMltKFQEO/GkYeIFsQYPCF2Fg6NBj22/
 ICXw9bPB7z1KJDFL7JU21lisYBswd3Dl3qmfdq49WSqrHd0ukr/zUSSSEPVwEqBAAz+XgIj
 q1yWmNJn4YzpSorRbXthw==
UI-OutboundReport: notjunk:1;M01:P0:a3X6sNRheV8=;NTopYDPzsTk4w3y43vN9Xgdt1x9
 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
 tlyh471VQ76l/G4Ro=
Subject: Re: [cocci] Searching for system call implementations?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3240
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/431d6a18-cca0-4a98-8033-49309b81f53c%40web.de>

>> There=C2=A0are=C2=A0promising=C2=A0software=C2=A0tools=C2=A0available.
>=20
> Probably=C2=A0=F0=9F=99=82=C2=A0Do=C2=A0you=C2=A0have=C2=A0other=C2=A0su=
ggestions?

Would you become interested to check if your use case would be supported a=
lso
by the programming interface =E2=80=9CCodeQL=E2=80=9D?
https://codeql.github.com/docs/codeql-language-guides/codeql-for-cpp/

Regards,
Markus

