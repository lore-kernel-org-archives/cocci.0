Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E1BCA1002
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 09:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yA9OjM15yFQyIgxawprYDS/aXUkFdWeWGSKhnHHjIJg=;
  b=GUEf1ioA/q5f15FXCdfTOuVPTQuuAJXkSeBEltaUOkTFWetVvzij7j3Q
   13GligTDuQ3TUx8ANLz0H2P0U8XtPRRb8tEqPLadLlLJsimi+LoRCDmj/
   6572jMR4LuA6GnYgJKTTplPRMgc0QTI7RwlN7+ie6Yi1+j9mOvMcS4ooo
   o=;
X-CSE-ConnectionGUID: H5j5wFZyQ7qf3XJ0ykMKow==
X-CSE-MsgGUID: tf9iqrE8Q0aaEgNd+l38VQ==
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
   d="scan'208";a="237807666"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 11:28:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0ABF6E0BE9; Sat,  6 Sep 2025 11:28:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 31FB9E0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 11:28:05 +0200 (CEST)
X-CSE-ConnectionGUID: tDh/x2DVTYCIGGS2kk92cQ==
X-CSE-MsgGUID: K852bMziT4Kb1AQ4WEVW9Q==
IronPort-SDR: 68bbfea4_RtJdps8ZRMm37NL9oSOTiOeV3EwbvNmRVP58CY/Ind+CwoL
 fTg2ILOmr7DYuMc9NlLVkUbySxX6/qDGn/GfpJA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H+AAAd/btog07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYI/gQdUMwQLSYRVj1CCJIQ7hzyHVYh5g1ICDwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IUAAowpAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBASEZBw47hk8NgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBARcCR0QBA?=
 =?us-ascii?q?QECASMdAQERJwQLCxoCJgICVgYBFAEBgn6CIwEGEAEDDyYHsTiBMoEBggwBA?=
 =?us-ascii?q?QbaXx8sIlmBZAmBGy4BhWuCZAGGJ4Q8Jw+BVUSBPAuCeD6EQ4NbgmmCJoEWg?=
 =?us-ascii?q?1iYFFJ4HANZLAFVExcLBwWBIEMDKjQxI0sFLR2BJ3mDB4ENhB0rT4IccoF0P?=
 =?us-ascii?q?hlAg1MeBmsPBoEVGUkCAgIFAkM+gW0iBh8SAgMBAgI6VxCBfQICBEtAAgELb?=
 =?us-ascii?q?T03CQsbBj2Vc4MoNCuBXYE2sWaTWYEKNAeCOIFngWQMn2wGEy+DcZNhDgaTB?=
 =?us-ascii?q?ZkGIqkfgX4kgVwzGiSDNk8DGQ+OIRmEGrozQTU8AgcBCgEBAwmFRgEBjFaBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 nYL
IronPort-Data: A9a23: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
 VUIqat4rI1XhKI//QuMu5KYJf3BgA7S8g==
IronPort-HdrOrdr: A9a23:Ey7RSam0LJMvj04PVfugR7QxZSLpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:U+W4z2Gy4DnhXA18qmJ72E5TCpoJTEHs51b/DHTiCmU4ErasHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AI17GZg4bsnmDCn1i57uVkX98xoxLs/n0AmUfkKl?=
 =?us-ascii?q?amMPdHBUsBBqjs2WOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,243,1751234400"; 
   d="scan'208";a="124817705"
X-MGA-submission: =?us-ascii?q?MDEGa5paL1ng1v48t/qPf4Prs4Zwf4ANjZrzNO?=
 =?us-ascii?q?bhba2J19W4wGfBX2p9tODM+2qC7fuFxp2c/zTn5JyHnD7v8eMD7KodYV?=
 =?us-ascii?q?bzPowHmRoLfh+GLpeoWRwNK2+nsfFtFaV7JskYxreEO+tDVhAWbKT+24?=
 =?us-ascii?q?laj/Kg37PxPRyPRFZHxHtF0w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 11:28:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757150883; x=1757755683; i=markus.elfring@web.de;
	bh=yA9OjM15yFQyIgxawprYDS/aXUkFdWeWGSKhnHHjIJg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oIoMNl3aqqffYB8eDveJi9YIIBv1TmngyWjK67IQEMtF/W0YwdMm2h3uYM3juymy
	 hzDOIGblyrim5Rsh3m8wriMCzJ5jVA4e9kF1e3/qV1qrJEhUCQshfJXZ+nv2Z8l4p
	 yO1zoTMbdSoQqE9tLixdf+X/Byytwpcxc/v0m+2iqxdNqD9SiM3eG4KRKyid+Es9r
	 P3KhKZqBizlES1LxYJImTZbNacLQ5PMiAr7cSU4mENaECwHsczmGGpE6uS7cZRqiH
	 jkl/h3GSr7ZMTzpMrL/C+FipF+ISa+x26PwRYFo3N29WXu7QFeEzlq0LbajzMuCRj
	 bnvN7SQjftCYLofgBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkWK-1uJpAj2cne-00ZJhy; Sat, 06
 Sep 2025 11:28:03 +0200
Message-ID: <13ed7845-6fd9-4a8e-9670-3d2b7e7a0f4e@web.de>
Date: Sat, 6 Sep 2025 11:28:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de>
 <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr>
 <b0221946-43a5-43c0-8573-32c12e149681@web.de>
 <ba87aeca-594d-10b6-960-cd4aa1fcd1e6@inria.fr>
 <d28c6f76-6708-4dba-a446-910170e27572@web.de>
 <b2e58328-97f3-4f1-e588-4647c6ff30d3@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b2e58328-97f3-4f1-e588-4647c6ff30d3@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LDmzgFnzwKOUxSXVnbaI1SIuKqV7acz7GYzS4xr3JgN65wyTcXb
 vTwuTZc3EuLVDIQmb8mP928HK8NfInSO3WhlRV+/OIqFTT9E261IhfLm9IeNFHUgG16BDrs
 SiMsrujnvc5xvXumBImLRV0DjtlXDxxz+kOkwqFVhQnW2BQLUaXXgfpOYC0p8FPiLS7Xo4D
 FA7FaW5Cf5EX4WbyPFKBQ==
UI-OutboundReport: notjunk:1;M01:P0:Lam/npH0YDs=;odYJCoy9Qw3IwLxlm7kmBkDm0Je
 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
 RFJzw9W8Sl
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3002
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/13ed7845-6fd9-4a8e-9670-3d2b7e7a0f4e%40web.de>

>> Would you get further development ideas from an SmPL script variant
>> like the following?
=E2=80=A6> I don't get the point.

Multiple SmPL rules can be evaluated.
I am unsure if evaluation loops can be achieved for the shown use case.


>                         display2 should match a subset of the places
> matched by display 1.

I hope so.

We might not be able to continue a search directly after a known source co=
de position.
But I assume that it would be possible to direct a search repetition to th=
e place
which was determined before (according to a semicolon for example).

Regards,
Markus
