Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98072CE8D6B
	for <cocci@archiver.kernel.org>; Mon, 17 Nov 2025 10:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=1hbLQ81GgZJBFj286xvD+izM7MRSTNj+o0OAt9CxpYo=;
  b=huLD5oL8IrENj09l2dtufd9r5qvRV6goxm4t9QLVk+aRrt9LjnTG6R0+
   TpwHiEVe9U9E7zglirEQ3ycDp8W6Th18OBpMY+tv18V1swN2H9n2E2vs/
   6rGu8KipSA+E4sZxr9ps9Hj5cjLn0vJiX2PvTXJTZU/Ma+Gnvku5ogpo7
   c=;
X-CSE-ConnectionGUID: OO4ceRJ1S9mx7cGSU6AiYA==
X-CSE-MsgGUID: 5dPbudTARLmwscXhiFBpuA==
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
X-IronPort-AV: E=Sophos;i="6.19,311,1754949600"; 
   d="scan'208";a="249509639"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Nov 2025 11:05:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 98167E0C55; Mon, 17 Nov 2025 11:05:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 85104E0172
	for <cocci@sympa.inria.fr>; Mon, 17 Nov 2025 11:05:07 +0100 (CET)
X-CSE-ConnectionGUID: /1RmRYTZSHezokkHric8Pg==
X-CSE-MsgGUID: +yciM0D1QWe6epXVit4xJQ==
IronPort-SDR: 691af350_Aqqe5930YDqRlBS0jTTIiLW+KAiDgf3DKt8ezI8yH7dUl8W
 Qnp0wkgu3F2my4gbPq5mTkgw91bVrz0tcif/QYg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GGBQBM8hppgA4P49RagQmEEGUdBlgzBAtJCIRNj1OGX?=
 =?us-ascii?q?48RiHmBaYFpAg8BAwENSgQBAgQBAQMDAYIMj1ECHgcBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR20dAQERJ?=
 =?us-ascii?q?zQCJgJzAQGCfgGCIgEGEAEDNgcNBq1pgTKBAYIMAQEGgUYFDUFQ13YfLCJZg?=
 =?us-ascii?q?WQDBoEcLoVugkobAQVuhGuFLw+BVUSBPAuCSYNOAQOBRGeDDoJpgiaBDplJg?=
 =?us-ascii?q?UocA1ksAVUTFwsHBYFjA4ELbjIdgSRBGHE9V4NJImgPBoESg1GIXEAPijACA?=
 =?us-ascii?q?QttPTcJCxsGPZUCUYMOWYFRlCizATQHgjiBZwWBXwyJCIEmlT4GEy+DcZNhD?=
 =?us-ascii?q?gaTBZkGjgiVYIVZNoFJI4FcMxokgzZPAxkPklSBC8FuQjUCCTECBwEKAQEDC?=
 =?us-ascii?q?QGBVYNwAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 QwhtFcfNBg=
IronPort-HdrOrdr: A9a23:DWNfr6kTn5y+kOT4tzkXKJz98/jpDfIO3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE7wr5OUtQ/exoXZPqfZqyz/FICOUqTNWftWrd1ldATrsP0WKK+VSJdhEWndQtsJ
 uIHZIfNPTNLRxdkdvw5hW+Hu0t2d+d7cmT9J/jJjtWLD2DcMtbnmFE4+ugYzRLrIIqP/AEKK
 Y=
X-Talos-CUID: =?us-ascii?q?9a23=3A6dciZmsMQMah+HuxPA5NdNRI6ItiK0fY9kbsEXS?=
 =?us-ascii?q?YBHRuS761U16bqJtrxp8=3D?=
X-Talos-MUID: 9a23:eWw3/ApN9UfDAS+i8doez3JzP8ZNu4j3MX8Az5gei/eFKXBgGQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,311,1754949600"; 
   d="scan'208";a="131031632"
X-MGA-submission: =?us-ascii?q?MDGsn9zaErgBWE5K2nt4U7GWvb/hwm+g0iVOLy?=
 =?us-ascii?q?OT/GNKM6C8IqEhLr3mUruVL4/Xfj4oDk9t4U0E19bPE6C96Ct/QVr/Ei?=
 =?us-ascii?q?UW28uIEVzu5Ttm5IL/jHDCZqbvV8gTdiuytVVoTQqEVSXai68Cvg4MrU?=
 =?us-ascii?q?GNdeCs1/M+IKZ+kKja9gpyXg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 11:05:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763373902; x=1763978702; i=markus.elfring@web.de;
	bh=1hbLQ81GgZJBFj286xvD+izM7MRSTNj+o0OAt9CxpYo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SEuFLgqeMNV38qpDN/JJ0Cob+fCXhVe40EIeuMFRzCRc1Ok7jECWCJ0eapavPpQZ
	 PSri0Wx9i7y0HNDthZ2MPabeZdejWhRY1ryZ7OugMX8wGrkYcPohGM0gNQeuASA5H
	 Q4wvog7awpatq7fcAxflDmYedJBb46lIjZVd8eeuMIqy3mSsGITvr39faU6bAeVp6
	 WatPRME5a8/csWTkjAoRmhB0YydR6Ya4s6kC3fEY+bOEkwWcpqUhDVgq95uG4d2LX
	 lGlrpi+84ZxsLiM2eesZcPr2VKs9KRqVrTb+Gzkqr5+vKei+fgEcZq8yx/elauWK+
	 7frUtBnkD0a0Ry0j/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECGX-1vV4zT0FG9-00CLsn for
 <cocci@inria.fr>; Mon, 17 Nov 2025 11:05:02 +0100
Message-ID: <9a707386-3338-42f5-b7c1-5891b83b02fd@web.de>
Date: Mon, 17 Nov 2025 11:04:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bY8dvp/WIdDskx8mA7ibSvBRkDz3klWY3jkQkPp+Pagrx/OnAec
 4DFviKDDyK20+2Il1sj5SFpyMqVPh/mGYW3XJi0RIKDUz5kVTyXZeN7bkhyACjriuCdiEZ2
 kfL+mLXsf3R62S4rkVR5uu/x+jURfTOZAlmT5upEE0FfOeQFPWD6bQBvgR6BleNhgDuR7yN
 ivJOtruoNyfNQWSFcOybw==
UI-OutboundReport: notjunk:1;M01:P0:FEFUgnGchQs=;K3kkitMfBy9vsrZGfMJLRW/EZ+r
 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
 LkHoKnD/C6sxHZBjCmT6os2Zcv6tAyCaa08wfS
Subject: [cocci] Improving software around information =?UTF-8?Q?=E2=80=9C?=
 =?UTF-8?Q?should?= be =?UTF-8?Q?removed=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3186
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/9a707386-3338-42f5-b7c1-5891b83b02fd%40web.de>

Hello,

I tried some expressions out with the program interface =E2=80=9Ccommand-l=
ine semantic match=E2=80=9D.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731=
a9d546dc4f0b181526e/docs/manual/cocci_syntax.tex#L1920-1957

I observed that the message =E2=80=9Cshould be removed=E2=80=9D was presen=
ted according to my tests.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/master/parsing_cocci/=
pretty_print_cocci.ml#L1210-1211

Will any improvements become helpful here?

Regards,
Markus
