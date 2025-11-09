Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0272CCCFA1A
	for <cocci@archiver.kernel.org>; Sun,  9 Nov 2025 14:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BFPcmFAnGJ7I5Ohd8M7Ny/csnq/lfFxA90BvBvwWFVk=;
  b=d/YeIR5NOHYuK5fBa1AMXWX0wr5wrV+DZhzSBxHapPCecAb4aixXbRu1
   CwxFjqddgDao94FdLTFmF1QZyp5QgoMZLx+THqDJKhJXRuIv2jC1nm1cV
   mMAruxxgDHdCthwYghifmlsqRVn7a6XRnJp/y8jMvFH9RQRVbpPvMGeLo
   E=;
X-CSE-ConnectionGUID: /jd9C1ZLQfyoF38kjTxVVQ==
X-CSE-MsgGUID: lPfUjcYaTOa3iwh6KbQcvg==
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
X-IronPort-AV: E=Sophos;i="6.19,291,1754949600"; 
   d="scan'208";a="248364247"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2025 15:32:39 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3D389E0172; Sun,  9 Nov 2025 15:32:39 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1415EE0171
	for <cocci@sympa.inria.fr>; Sun,  9 Nov 2025 15:32:35 +0100 (CET)
X-CSE-ConnectionGUID: HimfN5pRROe1xKXhNIM4qQ==
X-CSE-MsgGUID: ncuQz78VRqiIRsbo2IR5Rw==
IronPort-SDR: 6910a602_LT5SMqv/11rFemoPZPGth7o8R1WUDIoA9s428zvcNEUmtOZ
 Eqiv7wvKmc2HWP1xjJ4KshqdIdkrXTjpNUIFbAQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FbAAAfpRBpg07ASNlaHQEBAQEJARIBBQUBQIE9BwELA?=
 =?us-ascii?q?YI/ZSNYMwQLSYRVj1OCJIQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIUAAoxaA?=
 =?us-ascii?q?h4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?SEZBw47hk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEEC?=
 =?us-ascii?q?wsaAiYCAlYGFQEBgn6CIwEGEAEDDycHrlKBMoEBggwBAQbaXx8sIlmBZAmBH?=
 =?us-ascii?q?C4BhW2CZQGJbHonD4FVRIE8C4JHMT6EQ4NbgkcigiaBDoF0l1RSeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSBDA4ELI0sFLR2BJCIfGBFgPRdAg0kcBmgPBoESGUkCAgIFAkA6g?=
 =?us-ascii?q?WgGHAYcEgIDAQICOlcNgXcCAgSCGX6BSkAPiXBAAgELbT03CQsbBj2Ue4IJg?=
 =?us-ascii?q?gEBgkrGWzQHgjiBZ4FkDJ9sBhMvg3GTYQ4GkwWZBqlBgWoBN4FcMxokT4JnT?=
 =?us-ascii?q?wMZD44hGYQavEJCNTwCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Qwhp1fOxckwsfqovPk8DBnest+jO9Ez
IronPort-HdrOrdr: A9a23:ROCBhasSGaDzv3p7c3G8u4jC7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:a21lZmHNkruL8S6bqmJH9UsaPJ09SEf6wS7AAH+4L0dMFKSsHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AHq/Ovg40gIB2rRqs7m4Us6jGxoxu6LmXGh9dr68?=
 =?us-ascii?q?fuui+LiZ3YRan0Q6oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,291,1754949600"; 
   d="scan'208";a="130376445"
X-MGA-submission: =?us-ascii?q?MDH5T9jkNKiXqcLgF45NhdLAgDXdEBLFUm9cki?=
 =?us-ascii?q?ahKqHta1Xn+F8Q7hY2Od+jAOQaWn0PanW+aXXt8V9tWGV/Ksvl1YJ7Wb?=
 =?us-ascii?q?37Vac/VjitVAHnsuMfezb0E4ObZWLWDODnUbDiqxzpkyc4FrHLnBSUd4?=
 =?us-ascii?q?NMnKqwpUFBTeB8OnZLor7avQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 15:32:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762698752; x=1763303552; i=markus.elfring@web.de;
	bh=BFPcmFAnGJ7I5Ohd8M7Ny/csnq/lfFxA90BvBvwWFVk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BHcezGtuoiHtMRGyiwf1VkI0/H+xNAU4U3y2UMIMMSRVGlG3WUEsyOO2j9/PHMHP
	 wzFN8ktj2P9xtBRrnUPUK0lbM8PGVbi/DDjAKNiMC7Y6xtU05/PznUvGggcTPqbuy
	 5k4xsGeNKHQZUe/qFiFeDhSvTWR3KqQSuPtgqr4euR7viC54KCFB0rJFxZGTaC0rW
	 Px4D74Ps2jsdFZqjkmVM20ajQJ4M72c2OFat/rOWKlxqGfOPHHuj/w2XjkhWTvXxh
	 zC9tXVIib+ddm7U2wHrXT1nxtV/voxmyXMiXaGP/g6bik/pdbdxL97aFe6f7VOuME
	 xMDfX3cpB29B5XWEzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.232]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgpA-1vX23i3UGM-00PiZV; Sun, 09
 Nov 2025 15:32:32 +0100
Message-ID: <4a879286-3488-461b-b41f-c80d82941241@web.de>
Date: Sun, 9 Nov 2025 15:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
References: <e27551b2-34e9-40ad-9a14-f7b5cdf9a02c@web.de>
 <5C6B7613-D38D-463D-A586-4AD8070BD390@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5C6B7613-D38D-463D-A586-4AD8070BD390@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nDt8zrn9+MgBXWVXZ75eOJzHLzwrd+p9aBdp3veH9hoRONyYkV4
 KqIjhV/P05ZZccUE/Fq9ibwJXdYKhLji9HPjSbbj6icUnwu6zWtpIjX/5mgXDS3d6kY4Hb5
 x6gPY8T9vlfVZv9V07O2aanyyW5K0ev+fzh+xCFjaKySgGhILIfJo0THpW1zfF9VALzp5ui
 H4z5QA2plEBc0a6oXHj6A==
UI-OutboundReport: notjunk:1;M01:P0:ohoclVZyWmM=;MHt8JDmJKgoMXTa4vTZJ7t5TXfL
 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
 g3LT1qeV0qoB8DBZL0qWYA1BrE=
Subject: Re: [cocci] Restricting information search for header files
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3154
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/4a879286-3488-461b-b41f-c80d82941241%40web.de>

> If you don=E2=80=99t use include headers they will not be included in th=
e file list, only included from other files.

Thanks for another bit of information.

A file filter is already applied then.
Would it be more efficient to exclude undesirable (or unsupported) input f=
iles
also by corresponding system configuration parameters?

How many additional data processing resources would be needed for the eval=
uation
of a final function call like =E2=80=9Ccocci.exit()=E2=80=9D by an SmPL ru=
le script?

Regards,
Markus
