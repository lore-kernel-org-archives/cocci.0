Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460A1CFD376
	for <cocci@archiver.kernel.org>; Tue,  2 Dec 2025 09:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uuKL8Cr2r4d0v2S6WC+IYY271H+016R8ncswcBko/sE=;
  b=ebuykXdKF27FoDpm2jRxfm1qPk3DVIHCFtkKO/oUwV0hC+vb4l4O6ltN
   pe6SysT5FkhVpkHIhaPlIOzap1zHryqgDS1ni+iM8DKxZqubbgKPwGfdp
   U6T71wnhdn+Wv9xkPlF71zNnrZF4lMxdGocDIfWa8BcaLj6ipuVKKv3uy
   0=;
X-CSE-ConnectionGUID: Jlm6JUl0Sxm41gvJG6m7mg==
X-CSE-MsgGUID: mcm8YBRpQKWB6BWCI1U3Kw==
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
X-IronPort-AV: E=Sophos;i="6.20,242,1758578400"; 
   d="scan'208";a="252295849"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Dec 2025 10:46:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F317E0AF1; Tue,  2 Dec 2025 10:46:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 869E7E0157
	for <cocci@sympa.inria.fr>; Tue,  2 Dec 2025 10:45:55 +0100 (CET)
X-CSE-ConnectionGUID: TqOIGxsjQDW2SX5cQVitAQ==
X-CSE-MsgGUID: Svl9ubC/TCmTN1rQ1lCW9Q==
IronPort-SDR: 692eb552_4ys2/Ew9CRECi5Sum100yetqPR/jatcbFn4oUBVZM3NcBpE
 ARarwoZxHngDCWYiKRiVsnMICf+AzIvW61MckYQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ErAADUsy5pg07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwMBAQELAYI/ZR0GWDMEC0mEVY9TgiSEO48RiHmBaYFpAg8BAwENS?=
 =?us-ascii?q?gQBAgQBAQMDAYFMQIJ0AoxmAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAQEBD?=
 =?us-ascii?q?QEBBQEBAQIBAQIEBgECEAEBAToHDjuGTw2CYgGBJIEmAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR0QBAQECASMdAQERJwQLC?=
 =?us-ascii?q?xoCERUCAlYGARQBAYJ+AYIiAQYQAQMPJwcNBrB9gTKBAYIMAQEGgVhB2EYfL?=
 =?us-ascii?q?CJZgWQDBoEcLgGFbYJlAYYpCYQ0Jw+BVUSBPIMDPoJhAQOBF0c/gxyCaYImg?=
 =?us-ascii?q?Q6GIpMxUngcA1ksAVUTFwsHBYEgQwMqNC0jDzwFLR2BIyEdGBNgPRdAg0kYB?=
 =?us-ascii?q?mcPBoERGUkCAgIFAkA6gWYiBhwSAgMBAgI6VQyBdwICBIIWfYIKD4gCgQsFL?=
 =?us-ascii?q?oERAgELbT03CQsbBj2VDE+DCQgtLKV/ons0B4I4gWeBZAyKLpU+BhMvl1IOB?=
 =?us-ascii?q?pMFmQYijWabOYF+JIFcMxokgzZPAxkPjiEZhBqBC8J7QjUCCTECBwEKAQEDC?=
 =?us-ascii?q?YVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gGzPAqO6tH59b8BcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3AtMYphWlTcPx4XoRHHFfmtcniMD7XOUHE61b/M1S?=
 =?us-ascii?q?6MEpWEoalFFSpxqJ4uvM7zg=3D=3D?=
X-Talos-MUID: 9a23:oDOu4wTy2N62PdpARXTXmjUzKc1DpJiFDXwryI8/4s2vCn1JbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,242,1758578400"; 
   d="scan'208";a="132520911"
X-MGA-submission: =?us-ascii?q?MDG2vSOxo7sk2clU7W/KHGpwsY+H3EkRmG71xZ?=
 =?us-ascii?q?eu0JcdzpVtjbkgFKM9NkI2VRhzsU/d7fq3QHM4DFdgqjfkJP277SS9T+?=
 =?us-ascii?q?pW+bNrs0/OLY3BPnTI9bF0Y0NISatPhMrCnm7PeQzGxqvyGBnfYprS7m?=
 =?us-ascii?q?fhvwf7UFK7EkrXlU94o5zYjg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 10:45:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764668754; x=1765273554; i=markus.elfring@web.de;
	bh=uuKL8Cr2r4d0v2S6WC+IYY271H+016R8ncswcBko/sE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AsW5pAoC0jCcn+bJNzm/y71wYOyGWHnzhmFD+j4ZmlsHSwQBVXhh89RQCvdynpDB
	 GLbJybaqisR/P9OUWEqwTdOpXmW5vOMpKj12o2SIw4z2PSyhmoXQdB2FvVEQL+0yN
	 CGZt8sPUQ10dZ8W37mcjLtuQ18v2fzDAgMt+2hFLBlfwPCC5td8lMiZjLtrSFknyZ
	 fQTa74hw83Jo3aSvRMHC2ogP9kOUdsClDzYe6gCKhrNSFsLNQONSvkyE4hOrzQQxE
	 pslYIcaAgqcazoMHmNL7utLW1CBnkPAsGCdVwD4mv6PHUedl226VBBXZwDGWz9cMk
	 j36G+HBpVAK2BehvyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.218]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MW9rM-1vaqXD3VL0-00U2Zo; Tue, 02
 Dec 2025 10:45:53 +0100
Message-ID: <65b25a42-b50e-4a02-a781-74cb8ae9dd56@web.de>
Date: Tue, 2 Dec 2025 10:45:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tobias Deiminger <tobias.deiminger@posteo.de>, cocci@inria.fr
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dGBVjfl/9E06r0QhYHqZrKvZnoiI/33CqcmoYUnR4MAK2fsDYGG
 SyreTewcXJ0YnrknwwoFhRXlvKKs3tivC6OdHsbwbplowArmOPd1cTuojHI3AxBVgwuPq7q
 YMrvv1hiRGfZ3CG4OVskVwp7HdGKhe7XrJtERqXE7eWg3rA95Wsr95+0raAglMa9mx/gl8g
 YbPbU0vK8C2Dmw/qSkBJA==
UI-OutboundReport: notjunk:1;M01:P0:nV9uMr/7csc=;I80olyrAwliZPX0o+CGgWeYet7i
 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
 HmYgQAF7afnl9LP50RsnbmKNTz74y
Subject: Re: [cocci] Searching for system call implementations with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3235
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/65b25a42-b50e-4a02-a781-74cb8ae9dd56%40web.de>

> But I really want to search all syscalls by the conventional macro names=
,=C2=A0i.e.=C2=A0search=C2=A0for=C2=A0SYSCALL_DEFINE[0-6]+.=C2=A0How=C2=A0=
to=C2=A0do=C2=A0that?

My pattern recognition needed a while to take another software design appr=
oach into account.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/4c9d00ae071800cb447ef=
affd753f3bb2be28800/docs/manual/cocci_syntax.tex#L480-482

Corresponding SmPL script example:
@display disable braces0@
iterator name SYSCALL_DEFINE0;
@@
*SYSCALL_DEFINE0(...)
 {
 ...
 }


Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.1=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> /usr/bin/spat=
ch --macro-file-builtins =E2=80=A6/Projekte/Coccinelle/Probe/my_empty_head=
er_file.h arch/alpha/kernel/osf_sys.c =E2=80=A6/Projekte/Coccinelle/Probe/=
suggestion_for_Tobias_Deiminger-20251202.cocci
=E2=80=A6
[no diff output]


How will the clarification be continued for more desirable software behavi=
our?

Regards,
Markus
