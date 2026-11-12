Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB55606A321
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=YVJK1w4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:cc:reply-to:in-reply-to:
   references:message-id:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NiUHwB5N3w+iIcTL8IgmMfoS0MOo8z7R79VyF9SpJDc=;
  b=YVJK1w4E9blPj1sTgkEtFDmsjdX/ICEgbDrjL4YlsCGsQPr9zQyoDmHk
   CUvIM64812JNnXzgP2htdf+I9OCtM2spgsc6W3OfCPWIRo8b70zNNH7XA
   2eutXfSk6B8Mdxkx/GuLsd0A1EM0clMHkBEFz/rEfQA8xopDh0CHt8f+2
   Q=;
X-CSE-ConnectionGUID: gDeZHRmURN+KmfTInejZlg==
X-CSE-MsgGUID: w8FEl6njRayfProbtRfsCQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305099587"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 15:10:40 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0755681BE8; Thu, 12 Nov 2026 15:10:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3D8A281BE8
	for <cocci@sympa.inria.fr>; Thu, 12 Nov 2026 15:10:36 +0100 (CET)
X-CSE-ConnectionGUID: jZW/RDf+SsuhjK2kkTtcyQ==
X-CSE-MsgGUID: w57oArMhR46m4ZFX+Avk4A==
IronPort-SDR: 6af5c8dc_Mvx+XyPasNe0GoRMODwDMLHjrTTES5G0i2ThxwB5JmlNNGc
 lSoOFzlmbtqqELECj0sW59ZRRKGuDABZARpPOtw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GSAgBQx/VqgQQqG9RaglmBblOBBVQUMgcIhSGIepsWj?=
 =?us-ascii?q?AmBfg8BAwENTwIEAQEBhQQCjh8CHwcEBSwIDgECBAMCAwEBAQEBAQEBAQEBC?=
 =?us-ascii?q?wEBAQQBAQECAQECBAMBAQEBAhABATsHDjuGXIwaAYQAAgEDIwQLAQVBEAQHC?=
 =?us-ascii?q?RECJgICKysGG4VvBAMBu1R/M4EBhGbZY4EfVYEfLoV0gm4BinYnDg2BSEWEE?=
 =?us-ascii?q?DE+iB+CagSCIoEMl2YHBx4mHVscA1ksAQ8RNRMXCwcFYEVDA4EGI0sFLR03b?=
 =?us-ascii?q?CEdFxEeWBsGBRIgKkBDW4ESgQVdgSsoXQEBAR9GLQoLgXUCglGBI10CAUlBD?=
 =?us-ascii?q?gdFUwklQxJHJCIIEgkBExosCoEaNTwJJj8VDFsMCAMaBRomAh8IAgsCDHQoE?=
 =?us-ascii?q?RATHR4kLwUaJj4bCn4HZj03CQwZBAIBOghCHRIClncTTIISxkU8hCqBdIIQn?=
 =?us-ascii?q?WISHBeDcQGnAJkIqUWBaQE4gVx9CIIUgQ9PAxkP4F9EcQIHAgcBDAEDC4VGj?=
 =?us-ascii?q?CIHLYFMAQE?=
IronPort-PHdr: A9a23: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
 Z7bqwUrifzFW805MCxyYw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:2Rhh86MVSI6U/8BcTvCjsMiBIKoaSvp037BZ7TETdfU1SKalfq
 +V8MjzuSWE7Qr5HUtQ/exoW5PufZq/z/NICOAqVN/IYOClgguVxelZnO3fKlbbehEWmNQtt5
 uIP5IRNDWmZmIK9foTvWSDYrEdKY68gdmVuds=
X-Talos-CUID: 9a23:qSfAZWBQNCeJzNH6EytVywkuNs5mSWbAzHXzeUy7NXpiWYTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AgwfMCQ+uXZR/V6+1mnRAAJSQf9g1vKOHEmUNq8l?=
 =?us-ascii?q?YvpW2GxwzEime0B3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305099575"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDE3hZEqVYQ2IE0VuzwQY9eWtiPuuzYRvP8FLE?=
 =?us-ascii?q?gjlJtJUwa1pRCeF7bdEIfnsQszBqqkA4CQ51KfQAstb/2n6ohHb9z3Qw?=
 =?us-ascii?q?7xUvmokGtWOFaEW9YMcHO7WGZ9FmR7AQLANOvgBk+8nh+fULj44K//mb?=
 =?us-ascii?q?tuI4ERswfRp7ucErY7RtFeNQ=3D=3D?=
Received: from smtp4-g21.free.fr ([212.27.42.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 15:10:36 +0100
Received: from lettres.chocolatnoir.net (unknown [83.159.1.88])
	by smtp4-g21.free.fr (Postfix) with ESMTPS id 675D619F59C;
	Thu, 12 Nov 2026 15:10:33 +0100 (CET)
Received: by lettres.chocolatnoir.net (Postfix, from userid 126)
	id 1A94DCE8E20; Thu, 12 Nov 2026 15:10:32 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
Received: from lettres.chocolatnoir.net (localhost [IPv6:::1])
	by lettres.chocolatnoir.net (Postfix) with ESMTPA id 88A8ECE8E1D;
	Thu, 12 Nov 2026 15:10:32 +0100 (CET)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 15:10:32 +0100
From: picca <picca@debian.org>
To: Victor Gambier <victor.gambier@inria.fr>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Reply-To: picca@debian.org
Mail-Reply-To: picca@debian.org
In-Reply-To: <e94be607-8aeb-493b-8dec-8415e05551b1@inria.fr>
References: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org>
 <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr>
 <45e0468b84f19a5d75ea99fb434113c0@debian.org>
 <0faa3236-0ab2-45d3-953e-6168ce6c8d76@inria.fr>
 <0e99b58f1f63d6ff89889c6f132d4e2e@debian.org>
 <e94be607-8aeb-493b-8dec-8415e05551b1@inria.fr>
Message-ID: <28c028e839449a1bc8236acc9707cb32@debian.org>
X-Sender: picca@debian.org
Organization: Miaouh
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
X-Loop: cocci@inria.fr
X-Sequence: 3799
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/ljU9T49bhQlgb2J3p15OYg>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1

Le 2026-11-12 13:29, Victor Gambier a écrit :
> Thank you. I cannot reproduce the error. Could you send me the file 
> "hkl/ccan/array_size/array_size.h", as well as the output of `spatch 
> --version`?
> 
> Victor
> 

If I rename the INLINE global variable into -> inlines, the error goes 
away.

capital letters issue ?

Fred
