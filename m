Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CCECAC5A7
	for <cocci@archiver.kernel.org>; Tue, 23 Sep 2025 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:in-reply-to:references:
   message-id:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0et8fGv8PLygZlhp3H+ZCujTJZUy8PsOo5wWDmCZ3qE=;
  b=l2QaU7yToTGMJpJzf25BiI7oTjejkt4IWz+wnIyhRa/Ye5A7ceG95Nsz
   Njm1VyjmpuKXe3SjTIUVZV+6s4ZTiTHXkk1jpiCCQMf6aiHuidckDCfTB
   7YEFUGTnCupHCpYNXexnylAkVc76Lz0e4v2tK2fgEEUq1X97+VwsvTxSh
   s=;
X-CSE-ConnectionGUID: 8UVnMQ/cRPe3UtjB+GgCQg==
X-CSE-MsgGUID: qXgbYzRmSxO391ZOJQ3yqg==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@ispras.ru
X-IronPort-AV: E=Sophos;i="6.18,287,1751234400"; 
   d="scan'208";a="240576506"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Sep 2025 11:23:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BD76BE0C55; Tue, 23 Sep 2025 11:23:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5ECCDE0172
	for <cocci@sympa.inria.fr>; Tue, 23 Sep 2025 11:23:12 +0200 (CEST)
X-CSE-ConnectionGUID: NB5PKoVFTx29S0HSnl/7iA==
X-CSE-MsgGUID: BIa/x5SRSxOt5IBjiF5khw==
IronPort-SDR: 68d266ff_PjzAvZYoGJmXucHQ9swNPtVCrHPkPm+zvFkr65A/E8XxGWt
 CssAjPFTuNqQ0myeT5AhtNk2vhevdg5B8tMPsPg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HDKABrZtJoclTHlVNagQmEE4FcMwQLSYRVj1CUO4oug?=
 =?us-ascii?q?WmBaw8BAwENUQQBAQMEglWCKwKMQQIeBwEENBMBAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBDQEBBQEBAQIBAQIEBgECEAGBDIZPDYJFgUKBJgEBAQEBAQEBAQEBAR0CF?=
 =?us-ascii?q?HcCAQMjDwEFCAEBOA8EBQIaAhgOAgJWIYUdAk4HmSicRoEygQGCDAEBBoJo2?=
 =?us-ascii?q?T2BZAmBGy6INhoBBW6FPYQzJ4FkRIQ/PoQOARIBNjiDDoJpgRKCKoNYhACIW?=
 =?us-ascii?q?YYUhnYsJngcA1ksAQ8HCjUTFwsHBYEgQwOBDyMPPAUtHYEnd4QUhB4rT4Icc?=
 =?us-ascii?q?oF0V0GDUx4Gaw8GgRUZSQICAgUCQzIMgWsiBh8SAgMBAgI6Vw2BegICBIJKg?=
 =?us-ascii?q?RIpQAMLB2Y9NxQbBgIBOnuWPYMqBoEPgksURKUjoRQHhB+hXxIcF5kTkViZB?=
 =?us-ascii?q?qNohVmBfyNscDMaMoMoTwMZD45fiVjCEkA1PAIHAQoBAQMJhkiLVoFLAQE?=
IronPort-PHdr: A9a23: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
 JsVUqVSTxovC6FDYnk=
IronPort-Data: A9a23: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
 Z86q6VhLoxWNrEuVXMVhu8U
IronPort-HdrOrdr: A9a23:5cresaj1rBgavAZwzYkZ9gNbknBQXuEji2hC6mlwRA09TyX+rb
 HWoB17726TtN5yMEtLpTnkAsS9qBznmqKdjbN+AV7mZniEhILKFu1fBOnZsljd8v3Fh4lgPM
 5bGsAUNDSzNykZsS+Q2mmF+rgboeVuoMiT9IPj80s=
X-Talos-CUID: 9a23:OcgC12HAgj9nMVjnqmJB3hMsOccbXEHNlibre2+DD2IuF7y8HAo=
X-Talos-MUID: 9a23:W4izEAopOK5Pc2nfg44ezxtDPYB4vp+UM1AqjcgnkcuFG3FzOyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,287,1751234400"; 
   d="scan'208";a="240576486"
X-MGA-submission: =?us-ascii?q?MDGX/9fVWsVqCNi8AjTjxqkvLeuz5K5D1+yTtW?=
 =?us-ascii?q?cVLhL7WsofPjoFHzqyl3L0Nq8QLZrDWu2OA6j4vhinMqDq6gO7XEsuZ7?=
 =?us-ascii?q?S3Ew9Yolvt43gO7h1vvFB+pbxfsX2DVOZs2n2r1Pqee00kTDegFH92NC?=
 =?us-ascii?q?OGFR/0KR/rZDYnjFEzcHQ7tQ=3D=3D?=
Received: from mail.ispras.ru ([83.149.199.84])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 11:23:11 +0200
Received: from mail.ispras.ru (unknown [83.149.199.84])
	by mail.ispras.ru (Postfix) with ESMTPSA id 0CEA8402837E
	for <cocci@inria.fr>; Tue, 23 Sep 2025 09:23:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0CEA8402837E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758619390;
	bh=0et8fGv8PLygZlhp3H+ZCujTJZUy8PsOo5wWDmCZ3qE=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=InJ6EiTutH2dLMbKQWh2Kae/tB6jdv/dby0/bw9+trit5ki1VRzTCv2QoPGfnjkDA
	 9adViqTfNMN91u3VdP4kUyrPVnmpa49ZbLY+yzw+Xq9kWH5eUGdETYY1aVMZoykXZs
	 KYzdGatoN7a8QzM4d3dDG9eoytauvXgP1tipCkXU=
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 12:23:10 +0300
From: Oleg Petrov <o.petrov@ispras.ru>
To: cocci@inria.fr
In-Reply-To: <3addf44d4f2524588d664102d5109aad@ispras.ru>
References: <3addf44d4f2524588d664102d5109aad@ispras.ru>
Message-ID: <c889f5f9194fa940b18a9a951b7b1de4@ispras.ru>
X-Sender: o.petrov@ispras.ru
Organization: ISP RAS
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] devm as drm-init arg: rule with expression finds less
 than rule with identifier
Reply-To: Oleg Petrov <o.petrov@ispras.ru>
X-Loop: cocci@inria.fr
X-Sequence: 3031
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/c889f5f9194fa940b18a9a951b7b1de4%40ispras.ru>

Oleg Petrov писал(а) 2025-09-05 17:06:
> Hello,
> 
> TLDR A rule finds a match with identifier, but not with expression.
> 
> I'm using Coccinelle to search for devres-allocated arguments for
> drm*init functions. I have a simple rule which seems to work fine:
> 
> @badarg exists@
> position p,q;
> expression devm,e;
> @@
> 
> devm =@p devm_kzalloc(...);
> ...
> drm_crtc_init_with_planes(@q e,<+...devm...+>,...)
> 
> @script:python@
> p << badarg.p;
> q << badarg.q;
> @@
> print(p[0].file + ":" + p[0].line + "," + q[0].line)
> 
> But then I'd like to find a similar thing, but when another
> intermediate variable is used somehow:
> 
> @badarg2 exists@
> position p,q,r;
> expression devm,e;
> identifier local;
> @@
> 
> devm =@p devm_kzalloc(...);
> ...
> local =@r <+...devm...+>;
> ...
> drm_crtc_init_with_planes (@q e,<+...local...+>,...)
> 
> @script:python@
> p << badarg2.p;
> q << badarg2.q;
> r << badarg2.r;
> @@
> print(p[0].file + ":" + p[0].line + "," + r[0].line + "," + q[0].line)
> 
> This last rule finds two matches:
> drivers/gpu/drm/tilcdc/tilcdc_crtc.c:1005,1018,1031
> drivers/gpu/drm/meson/meson_crtc.c:680,686,687
> 
> But if I change local to be expression, the rule finds only
> drivers/gpu/drm/meson/meson_crtc.c:680,686,687
> 
> I wonder, why is that the case? As I understand it, identifier itself
> should match expression.
> 
> Best regards,
> Oleg

I guess I messed up sending the email earlier. I'll add the versions 
then:
spatch is 1.1.1 and the results should be the same for Linux 5.10+.
My command line:
spatch --sp-file local_name.cocci --dir drivers/gpu/drm --very-quiet
