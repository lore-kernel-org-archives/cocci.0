Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679CFC3ABC9
	for <cocci@archiver.kernel.org>; Wed, 21 May 2025 12:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=68lGL4yHD+u4Ztwi6S19i8cjIEtvKAiXtAs/dtY5Q6g=;
  b=ld0s0knXng5HCSLJgNJXpBEfaPW3paFblNZ1xjKF5l3Cxo3KWZ0oTGRE
   12/+BhBa0D2ncFMd8IPKRIY9fyWetYQsO5if9+IeuKt5P4VtyVC6TDDpq
   tJxHUA/wZv24fSaynltLM2UVwVKu7i91go9uBXNyUQDgghqDFpoRicW16
   M=;
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
X-IronPort-AV: E=Sophos;i="6.15,303,1739833200"; 
   d="scan'208";a="223174478"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 May 2025 14:18:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E0136E0AF6; Wed, 21 May 2025 14:18:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E9368E0131
	for <cocci@sympa.inria.fr>; Wed, 21 May 2025 14:18:31 +0200 (CEST)
IronPort-SDR: 682dc497_f3OFbQ5FNrhTNfcK0q2f17TRHHqiMRpchBhvDvVB2G4Wtq2
 AWhWqu4W0ovk5HxZJ590MVcGLi0xuijxTfHfyRg==
X-IPAS-Result: =?us-ascii?q?A0ELAACvwy1ogAwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQAUBAQELAYJDgVgzBAtJhFWPUIIkhDuHPIdTiHeBVYF+DwEDAQ1OA?=
 =?us-ascii?q?QIEAQEDBDiBVIJ0AotRAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBA?=
 =?us-ascii?q?QIBIx0BAREmAQQLCxoCJgICVgYBFAEBgn6CIhUBAw4kB7IzgTKBAYIMAQEG2?=
 =?us-ascii?q?l4fLCJXgWUJgRsuAYVsgmMBhieDQnonD4FVRIEVJwuCRzE+hEODW4Jpgi+BF?=
 =?us-ascii?q?oQkhCqESkuCX48DUnscA1ksAVUTFwsHBYEmQwMqNDEjDzwFLR2CDYUZgg+BX?=
 =?us-ascii?q?AMDFg8BgxNxHINAgSOESitPgySBfkwZQYM2QAIBC209NwkLGwY9l2GEe0wCg?=
 =?us-ascii?q?hujNaJ2NAeCOIFmgWQMn2cGEy+XSg4GkwKZAyKpFYFpATiBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hhDPICkE1PAIHAQoBAQMJhUYBAYp2gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 XcdHQh5fa1wdaI9/QuMtZKY9NH1cQ4DFwkVUBo=
IronPort-HdrOrdr: A9a23:9Bc7bq/7WRo4p+4B+vduk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AqsoM52pjxzsGXnD3GU0moavmUdw7KWGEzEfvGFK?=
 =?us-ascii?q?xCGVSdLicTA6t/bwxxg=3D=3D?=
X-Talos-MUID: 9a23:6NvIVwRo8nyIku6CRXS3tmFtP8M46Z+1S1pczJdf5MCfKGtZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,303,1739833200"; 
   d="scan'208";a="223174463"
X-MGA-submission: =?us-ascii?q?MDEECVM3KlYSaLCmpXB4zEvwjjQ8w2xWRH1WAi?=
 =?us-ascii?q?MjrzDarUVI9Hn1nRsC3g4BW1OgUUlrbBJv5+S99Wt0OnoqabhNWQJqSW?=
 =?us-ascii?q?3l9sc9gEcJbFQr0YGnPzoOX+MCkk/KOaNGyYoTumxeYbWkudL2qaqPWF?=
 =?us-ascii?q?OicS7dpgB/rvL1f/wURjEcyw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:18:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747829911; x=1748434711; i=markus.elfring@web.de;
	bh=68lGL4yHD+u4Ztwi6S19i8cjIEtvKAiXtAs/dtY5Q6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D6T738IORQ4kPtm/015a5G1WQGzxV4wfR5i9O8ofubWBptsDmdcR20zuh7vQIaQh
	 O5X7nFc9BtT2Ffs/djy/xTIF9fS6/lycpRzB8p/ulQp2UZp2YYdTfuNaK9DyPLC16
	 ykiTLrxGXOjCTxPtGuyjddIdl5MHtUmC3dPpOOW3IyMp3/rB4tDfNztYHSF+hda9R
	 +jB71005GiFdAOn2TQJMVmBCknq7N0IZfrBkjEkoCD2LDT98Heu8gBgLn+KBq3SGS
	 /7B8W4gWWBhyl47L5qeos7Fmh8B9u21hNWe1+nswpv31IkNeSqYz7aV99/YMhEtjW
	 Xwf+4oYtwvrq5h7TvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.179]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCA5-1vD0573tbP-00ujXz; Wed, 21
 May 2025 14:18:30 +0200
Message-ID: <3a81929c-b254-4648-a210-1d5d25a4bb4f@web.de>
Date: Wed, 21 May 2025 14:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
Cc: Olaf Hering <olaf@aepfle.de>
References: <55052f14-dbe4-467c-a7a4-41ce5fc1cc99@web.de>
 <6007e0f7-3d15-4490-a000-b10797c9d579@inria.fr>
 <fdc8e894-1d4c-4d55-bb5d-12cd0fbceac1@web.de>
 <ed4c614b-82da-41c9-bd28-1bd5e57f3b2b@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ed4c614b-82da-41c9-bd28-1bd5e57f3b2b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MAyDq+wqg2/mFp5lbb+8o+v2K5LPgCqTNbebDazufHF+Y7tIo3P
 3GgBZs1HsWSRBjoaJycnAKOKEAxYcG7ryvnmVNBACMy3OmQbN4enasKyVHW7pS4DGIGLEB1
 OIl1MzSMvZshnvSoiIaoE0f3Qznlqs3lXggblWRVrOQHJ1gI8RTBZz0sKEFR4YCNSqTen7R
 xTLsc4BgHI76JMehAKHaw==
UI-OutboundReport: notjunk:1;M01:P0:u4y3V1p15WM=;d7eH2/HnOCOJ1irnLTxvCV3bG06
 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
 dvCY=
Subject: Re: [cocci] Reconsider software dependencies for PCRE support (with
 SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2745
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/3a81929c-b254-4648-a210-1d5d25a4bb4f%40web.de>

> I'm thinking the issue is simply due to weird dependency issues

Something is questionable here.
Further software build configuration challenges can be reconsidered.

Markus_Elfring@Sonne:~> opam show pcre2

<><> pcre2: information on all versions <><><><><><><><><><><><><><><><><>=
<><><>
name         pcre2
all-versions 7.5.1  7.5.2  8.0.1  8.0.2  8.0.3
=E2=80=A6
Markus_Elfring@Sonne:~> rpm -qi ocaml-pcre2-devel
=E2=80=A6
Source RPM  : ocaml-pcre2-8.0.3-2.1.src.rpm
Build Date  : Fr 04 Apr 2025 06:04:04 CEST
=E2=80=A6


> that are documented in the file I mentioned.
The software documentation is probably improvable.
Do you plan any releases accordingly?

Regards,
Markus
