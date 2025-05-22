Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E69CC54756
	for <cocci@archiver.kernel.org>; Thu, 22 May 2025 06:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Rt0cQRssKAEOSWTH2wgfYvsaWYiWk1hpdjPc4XnFfiI=;
  b=aqE7Qwtk57Hw60VtNWdh61Uy8A+rySnITwbiLWQry2CPf66L44CymV9f
   km75a2jt4HT1QV3yKkUAaokHGFphRTeNt4089un7RkhRFXzb1Dc/sAbrP
   pLATI01Dbwh1U1tyvJot0jdCPQwOe9ygaUJw23YpSH0cXe8vjeM206gwC
   8=;
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
X-IronPort-AV: E=Sophos;i="6.15,305,1739833200"; 
   d="scan'208";a="223280988"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 May 2025 08:47:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6A24EE0CCC; Thu, 22 May 2025 08:47:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0938DE0131
	for <cocci@sympa.inria.fr>; Thu, 22 May 2025 08:47:06 +0200 (CEST)
IronPort-SDR: 682ec869_KDtBUttAFIMYa6UYSUOAZ4xGtejYNg2KMR99sUaXuhv8/5R
 SFaxjoRbnTE1RWRhJGhI0Z78r2vU0MsctgL0XZg==
X-IPAS-Result: =?us-ascii?q?A0HsCQAXxy5ofgMP49RaHQEBAQEJARIBBQUBQIFTgkR+B?=
 =?us-ascii?q?lQzBAtJhFWDT4wBgiSEO48PiHeDUw8BAwENNxcBAgQBAQMBA4IMgnQCi1ICH?=
 =?us-ascii?q?gcBBEcBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCQExh?=
 =?us-ascii?q?XsNgmIBM3GBJQEBAQEBAQEBAQEBAQEdAg06RAEBAQIBIx0BAREnBAsLGgImA?=
 =?us-ascii?q?gJWBgEUAQGCfgGCIRUBAw4kBw2xcIEygQGCDAEBBoEI2VYfLCJXgWUDBoEbL?=
 =?us-ascii?q?oVtgmMBhieEPCcPgVVEgRUnC4JHMT6EQ4NbgmmCL4EWjRuSQVJ7HANZLAFVE?=
 =?us-ascii?q?xcLBwWBJhAzAyo0MSMPPAUtHYINgi1Pgh2CEXBsAwMWDwGDE3Ecg0OBI4RKK?=
 =?us-ascii?q?0+DJIEDe0wZQYNJQAIBC209NwYDCxsGPZduhScgAoIbxis0B4I4gWaBZAyKL?=
 =?us-ascii?q?ZU6BhMvg3EBk1gOBpMCmQMijWWbMIIigVwzGiSDNk8DGQ+OIYQzhGDEWkE1P?=
 =?us-ascii?q?AIHAQoBAQMJhUYBAYp2gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QXZKzKrN7ko31aks0HfrBGkaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:arp41W62bNAKtMzGNtssxnwdXcEdVF7m52aNCmqyIF1xZqSycArF
X-Talos-MUID: =?us-ascii?q?9a23=3AWIPy2w1r+k+gKXYIGX9Iwz9C7zUj85atEkRdoZc?=
 =?us-ascii?q?/lsyuGh51G2qenReZa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,305,1739833200"; 
   d="scan'208";a="117235225"
X-MGA-submission: =?us-ascii?q?MDFRA8/bwareWkptzkXmJjMvIjLpJ8tQDlmibS?=
 =?us-ascii?q?4ocDnwpmJObCJ9OCwsxZBLET+t8sRqGKb7SmfJ7mqN9OuBLD8wf9hfHK?=
 =?us-ascii?q?QLLO1NKIRVZF8v/+Htuxc0OMVBej932i/DT1oHhtgXIg3rJcOfDfwSmQ?=
 =?us-ascii?q?lVNY38npQVtMEiaRSqdDLD3g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 08:47:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747896423; x=1748501223; i=markus.elfring@web.de;
	bh=Rt0cQRssKAEOSWTH2wgfYvsaWYiWk1hpdjPc4XnFfiI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VGWGDs1VsmPLlODVAgCJxVUejCEjSrcGvQQJ5pfJ26PvRrwckG4BJhrQDPZa31/2
	 bwsE66NKj0W9ttzqXdg+2ZUt8qWJ7PLCKAltM4PUNFNIj54gEwlGFyx3aC+YqfIsP
	 ciT2lFwirMmrpkLrjchsMQ8KYTAEpV8gcxXnMv5wUWm6SKHLFePGdzWSHcmfkQYHQ
	 U0uQiELMk8QD8rJr3jLjiN1/nUxR0ulUUhbIOICft2A7YhRwbNaJs7FxeQhts8aD8
	 ZJNta7zRZqWUaiNSVHNLlcsVXBnn3mGSj8+r0G+kT1mkesZjlVh6fR+bDVmND8xTI
	 dN5XxV3CpRHbeY4+ZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3Ez3-1uExy62OFR-004iKD; Thu, 22
 May 2025 08:47:03 +0200
Message-ID: <313cfa01-9f78-4491-8306-dd80543d6d39@web.de>
Date: Thu, 22 May 2025 08:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, Olaf Hering <olaf@aepfle.de>,
 cocci@inria.fr
References: <55052f14-dbe4-467c-a7a4-41ce5fc1cc99@web.de>
 <6007e0f7-3d15-4490-a000-b10797c9d579@inria.fr>
 <fdc8e894-1d4c-4d55-bb5d-12cd0fbceac1@web.de>
 <ed4c614b-82da-41c9-bd28-1bd5e57f3b2b@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ed4c614b-82da-41c9-bd28-1bd5e57f3b2b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mlVTIEPLxiX3wTcMqM6VxEK8OiymnPZw4GF7ITQlEUSBJ2HHVQ8
 QRYOXxzF/QsnC/HW53zRZph0JJ3G5faFLWay6AB4w5WDOswrF4k4C0nC9bftjqtM2fl2DZH
 8gztYtUJu0/CNFVqPDxXJiim9H+bX0SJ8EpzlMKAjXmJoWGnKX0Pt7ZFTM0gB0rUF66wujh
 23V2WwlUwiYe7daJZ5BSQ==
UI-OutboundReport: notjunk:1;M01:P0:c7kh3p7FhEo=;2tu2f4nhEZ7cB3ZcOn809t0o9Xv
 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
Subject: Re: [cocci] Reconsider software dependencies for PCRE support (with
 SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2748
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/313cfa01-9f78-4491-8306-dd80543d6d39%40web.de>

> I'm thinking the issue is simply due to weird dependency issues =E2=80=
=A6

How do you expect that known software dependencies should be resolved here=
?
https://opam.ocaml.org/packages/pcre2/

Which installation sources would be preferred for involved components?

Are you looking for any adjustments according to software build systems?

Regards,
Markus
