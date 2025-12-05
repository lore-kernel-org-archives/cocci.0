Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67E2D2E035
	for <cocci@archiver.kernel.org>; Fri,  5 Dec 2025 08:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qlXRAkoxZd0kmrHxzHRLDAy32jML2yxA7Mh+ROo/sAc=;
  b=aV3G+0fEJvGydykbMmR8FVcm5O19qDmyoXz2Lx8b7rZ92kC91UsF6F5T
   9Z/mNw9YKbnhNq7dYWmYvxq41wJa0y5bQh4CartHFRpMbnfMtlwcYZOGd
   42u4yKKNnhBQ4PpSz8NN7Y2IHonRWhu5AysqRwi4dRiM4QOOqML8us37f
   8=;
X-CSE-ConnectionGUID: 2H/XqfH6TbuGRyKtYVfHPg==
X-CSE-MsgGUID: HwThcybrR22DY+z64Z3Rgw==
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
X-IronPort-AV: E=Sophos;i="6.20,251,1758578400"; 
   d="scan'208";a="252908300"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Dec 2025 09:30:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7B0C6E0AF1; Fri,  5 Dec 2025 09:30:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2D79DE00A5
	for <cocci@sympa.inria.fr>; Fri,  5 Dec 2025 09:30:41 +0100 (CET)
X-CSE-ConnectionGUID: xRTNa8d+RiuvciKB4Sla/A==
X-CSE-MsgGUID: n8JCREaQQ1u+hMC/6BoLiQ==
IronPort-SDR: 69329830_HvFOtlf2ONwu5ei7FdDtsVO/mnZo4tyI8opNQOyIFvsGa+q
 dkYqkYtvG20s6C+gnyaROmHGd5TcBLnBEfOSxcQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GUAACclzJpgAwR49RaHQEBAQEJARIBBQUBQIE9BwELA?=
 =?us-ascii?q?YI/Zx8GWTMEC0kIhE2PU4IkhDuPEYpOgX0CDwEDAQ1ECgECBAEBAwMBgUxAg?=
 =?us-ascii?q?nQCjGcCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQE7Bw47hk8NgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAkdEAQEBAgEjHQEBESYBBAsLGgImAgJWBhUBAYJ+A?=
 =?us-ascii?q?YIiAQYQAQMPJwcNBrE1gTKBAYIMAQEGgVhB2EgfLCJZgWQDBoEdLgGFbYJlA?=
 =?us-ascii?q?YpmJw+BVUSBPAuCRzE+gmEEgV6DW4JpgiaBDplXUngcA1ksAVUTFwsHBYEgQ?=
 =?us-ascii?q?wOBCyNLBS0dgSMhHRcTYD0XQINJGAZoDwaBERlJAgICBQJAOoFoBhwGHBICA?=
 =?us-ascii?q?wECAjpVDIF3AgIEghV9ggoPh2eBCAUuezECAQttPTcJCxsGPZUPT4MTWZVRs?=
 =?us-ascii?q?yk0B4I4gWeBZAyKLpU+BhMvg3GTYQ4GkwWICpB8jgibOIFpATiBXDMaJIM2T?=
 =?us-ascii?q?wMZD44hhDOBC7sxQjUCOgIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 klQqVsXBZsePMv31h47ArGftJvHEQzcUIIVyhA=
IronPort-Data: A9a23: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
 OnxUVYf
IronPort-HdrOrdr: A9a23:NYdUQa0XrpsHiE7XhxPglQqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:SJ0RzW750iQrc+lrbtss5HQoPMl1fj7nzWrOKE6bIzpSTLTSYArF
X-Talos-MUID: 9a23:rk8ROgRw41jwBPbXRXTq1BNJDuph2p33FQMNtL5B5eODES1JbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,251,1758578400"; 
   d="scan'208";a="252908267"
X-MGA-submission: =?us-ascii?q?MDFxI5P/qMOPqszX/sZ7lBxx25RCFAaabne4Vs?=
 =?us-ascii?q?2K8pxTmEPMf711EOlJa87VEG9J5FIX+1u0E1MAh8O2spNDUl5sZEpr46?=
 =?us-ascii?q?JbBR0oucWDmOzLiEeHaGySubySbAmoNYJWIvA6+iEkvOabuf0/QbJj5F?=
 =?us-ascii?q?3uGkR1RABqmBqBqUGwhS8wmA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 09:30:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764923439; x=1765528239; i=markus.elfring@web.de;
	bh=qlXRAkoxZd0kmrHxzHRLDAy32jML2yxA7Mh+ROo/sAc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=vdP9fz8nbNKkGqBsgfWvwtZ+DZrEJ9ma72mlUxYFIpMsaCAkzFIiSyy/XaZcCHVC
	 Y5TYAbJ1DF4xTOaczppCSUIzMR5MQCb60lmWYSG2Ye4zHXeBA6eNLTllxY4YqseV1
	 K4Mcd5rnh4k/3rNnk33gqd9QnwMDhlteadiazdQF5pLswooCqNH9u0oejYmP4fOvJ
	 ZgkwdOv1RmBAewZL3bLHIcq7GTgWyU6G21vRccibbCN9vvoWERQwgXmca7VYayJoa
	 2fXZx3oDoeUCd066ab40e7pSEQC7pnYxWeL9Mz73Qih2Wi9516Q4+Vht1k01ZltK4
	 rmlX0D0LH+RA8lCGsg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.211]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8n08-1w5Xb71c9u-0103vz; Fri, 05
 Dec 2025 09:30:39 +0100
Message-ID: <aa35bb47-5190-42a6-bebb-fbf4d43bf735@web.de>
Date: Fri, 5 Dec 2025 09:30:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>
References: <1b8dad8151ef1409adc8cb24c728907a@posteo.de>
 <9ab63cb6ee4a0354c053f22fb0934317@posteo.de>
 <1534c930-426e-4939-8fcb-ad4a32c3e23c@web.de>
 <b5b21fa8f7d361142b60027d84edd34c@posteo.de>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b5b21fa8f7d361142b60027d84edd34c@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oa+Wuo9o80w8KIDwsmfP4jPey245rLVrHmSGYVyO6TTTe5+OuxS
 esw04l3WcGlNc5c8AHteTOIx19VQO5dC7Hw8pick10gQXyaXqDuOSqai5QeVKZ3QiFWPiKM
 PRG7niwmw1+28uc5mvnv9+Gt10wloX6eu5lWYkGx4FZton/lymEc6cvi9un+lAmLxqGZyIY
 4Eu6mCwdGop30NLVhH47Q==
UI-OutboundReport: notjunk:1;M01:P0:cCM3Lnmpzzc=;NbFBcRG9QEdYGlZ+BF/g330iP0c
 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
 cdEqJHf9i5b0fCRgCDF1gC0kZSI1Qkid7+9Rm9
Subject: Re: [cocci] Searching for device attributes with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3243
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/aa35bb47-5190-42a6-bebb-fbf4d43bf735%40web.de>

> The=C2=A0linux=C2=A0tree=C2=A0was=C2=A0searched=C2=A0in=C2=A044=C2=A0s=
=C2=A0locally,=C2=A0which=C2=A0is=C2=A0fine=C2=A0for=C2=A0me.

You might be looking for further refinements accordingly.

* Would you like to point any command parameters out for the discussed sof=
tware tests?

* How do you think about to distinguish implementation details better
  also for the usage of serial or parallel data processing?


See also:
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/master/docs/manual/sp=
atch_options.tex#L771-795

Regards,
Markus
