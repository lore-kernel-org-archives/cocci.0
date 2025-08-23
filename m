Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56B8CA0EFA
	for <cocci@archiver.kernel.org>; Sat, 23 Aug 2025 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mshYHpHI5HTHKx0pvJ9vtqv4RDLbQ19A20g0Vqms4aU=;
  b=j/q5IbFHcpOu9dEND8lvqogV7rYpW/MbfFVwmOlMkUzC23tK8ZErrpu6
   dUP1XAcZmRtjQjJmy4RcHtadeqXMkyljwT//eReH6PQTU7kSpfSQU+0jV
   wr9EdENQKe/vkRBjV/cdk0Sf0O+F4XUUDm2BpB+FSO8UgCOiP7dkCIZoz
   s=;
X-CSE-ConnectionGUID: vS/lUSerS/K2eSnkXJxFMw==
X-CSE-MsgGUID: 9fCdq4xDRdi0I0BgVYnvEg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="235844496"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Aug 2025 13:47:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D8450E0B0D; Sat, 23 Aug 2025 13:46:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2F674E0172
	for <cocci@sympa.inria.fr>; Sat, 23 Aug 2025 13:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=mshYHpHI5HTHKx0pvJ9vtqv4RDLbQ19A20g0Vqms4aU=;
  b=r1KRx/y/FTJ2AG3PWlNb0PCUV6KbE026900itmRC9PtXGOJ72Q3x2wX+
   myEAo5FLj7+aD5jxOC+cacMmVve2lfllZd/UFs1jBV0IUFpTUIia1xW1L
   aj/3nmUlA6LNORiXEKZAwxA/lHMne3Lmbf4c/X10nV7w6g7FTWJahax9h
   M=;
X-CSE-ConnectionGUID: xRM1n0VuT4eqcUMIPoahIQ==
X-CSE-MsgGUID: OI4Am62FQSubXFS27VlDLQ==
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="123747259"
Received: from unknown (HELO smtpclient.apple) ([172.59.113.151])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 13:46:54 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Sat, 23 Aug 2025 07:46:41 -0400
Message-Id: <5296528B-A549-4068-83D8-B47F403D64AC@inria.fr>
References: <4f230982-3108-4d6c-a165-ab85e7592b8e@web.de>
Cc: cocci@inria.fr
In-Reply-To: <4f230982-3108-4d6c-a165-ab85e7592b8e@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: iPhone Mail (22C152)
Subject: Re: [cocci] Reducing the scope for a selected variable with SmPL?
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2979
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/5296528B-A549-4068-83D8-B47F403D64AC%40inria.fr>



> On 23 Aug 2025, at 07:26, Markus Elfring <Markus.Elfring@web.de> wrote:
>=20
> =EF=BB=BF
>>=20
>> The when exists is what you were missing.
>=20
> I would appreciate if the application of such source code search pattern d=
etails
> would become clearer somehow.

Think about it. The code you are interested in at the end of the pattern is u=
nder an if in the C file. It is not the case that all paths from the top of t=
he function reach that point. But there does exist a pattern that reaches th=
ere.


>=20
>=20
>> How you arrange the rest is up to you.
>=20
> I see opportunities to improve related transformation approaches further.
>=20
>=20
> By the way:
> [PATCH] PCI: Reduce the scope for a variable in pci_bridge_release_resourc=
es()
> https://lore.kernel.org/linux-pci/599e9acf-886b-4394-86bb-099e062c5b2c@web=
.de/
> https://lkml.org/lkml/2025/8/23/136
>=20
> Regards,
> Markus

