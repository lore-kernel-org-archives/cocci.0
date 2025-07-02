Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37713C7EE30
	for <cocci@archiver.kernel.org>; Wed,  2 Jul 2025 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=q+HVxrzpmxwSY9nZuZ8uUn68/HggVi20VlQ6xuUcwPg=;
  b=n4Bg/+Pm3hEOPw25xIKWtFaVMF1foY7GKabPOob1AawQtIeY9/YHoHT0
   v3TSTCJMnoTO7AHcs5NTa81SnnAcNQexw1FupLbyDwCanp/3W8S2ZDWX3
   hG/g7n+xb9rPizncJXvgjfvLYs86P1hs5PObGTcGmTtfYa9+LWnYM+DFX
   I=;
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
X-IronPort-AV: E=Sophos;i="6.16,281,1744063200"; 
   d="scan'208";a="229954228"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Jul 2025 11:11:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CB00CE0AF1; Wed,  2 Jul 2025 11:11:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3A7BBE0131
	for <cocci@sympa.inria.fr>; Wed,  2 Jul 2025 11:11:50 +0200 (CEST)
IronPort-SDR: 6864f7d5_TQn5Z569ndb1GMn4AsM1mdSghygPPzRbYL0PFptXv3/gBOt
 Fpn0hF2PXcmhj7lpCRGLv3Aq93CtyomuTleagLQ==
X-IPAS-Result: =?us-ascii?q?A0FhDgBM92RogAQP49RaHgEBCxIMQIQXgQAGVDMEC0kIh?=
 =?us-ascii?q?E2PUIF0MIQ7jw+Id4NSAg8BAwENSgQBAgQBAQMDAYIMgnQCi3UCHgcBBEcBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR?=
 =?us-ascii?q?0QBAQECASMdAQERJwQLCxoCJgICSwsGARQBAYJ+AYIhAQYQAQMOJAcNBq4mg?=
 =?us-ascii?q?TITboIMAQEGgVhB2EUfLCJYgWUDBoEbhhuCZAGFXEuEPCcPgVVEgTyDAz6CY?=
 =?us-ascii?q?QEDhTmCaYImgRaEepNAUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEngkwcg?=
 =?us-ascii?q?wmBDoQsK0+CJHWBeUEZP4NUHgZtDwaBHxtTQAIBC209NwkLGwY9kmSEDFmCe?=
 =?us-ascii?q?qQzoUI0B4I4gWaBZAyKLZU8BhMvg3GTWw4GkwKGIoIhkEIijWWbNTaBSiKBX?=
 =?us-ascii?q?DMaJE+CZ08DGQ+OIYQzgQu+EkE1AgkxAgcBCgEBAwkBgVWDcAEBiAyBSwEB?=
IronPort-PHdr: A9a23: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
 IUDQPlXWQ5tfs4=
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:EiXKTaxp9i1CFUJiqd8pKrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: =?us-ascii?q?9a23=3AxlhaB2osQse0bet0zQ5kmFXmUcUYciCN3SiBGE6?=
 =?us-ascii?q?XVXtZaqOXdV+U6qwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ae/fm9Q9L4428iCHn5jF6ptCQf81ZzIr/JkERqI8?=
 =?us-ascii?q?lpo6qO3EuBW6Now3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,281,1744063200"; 
   d="scan'208";a="120488212"
X-MGA-submission: =?us-ascii?q?MDHN5S++1el6sNHrChjPSTjEma5M+PcdAHYb0a?=
 =?us-ascii?q?RU+PuQp177rJF3LQfUN9nXbKTF/HcesCEcFkkDw56YfK1X26uyFgD6/q?=
 =?us-ascii?q?6EeIjE1yyAF8D8pO9tGxXUXfbMIogDyXCTEZGEtVFMNeN8morqukiGON?=
 =?us-ascii?q?d4IAx7AJd0EDEbcKgLwx9DZA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 11:11:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751447508; x=1752052308; i=markus.elfring@web.de;
	bh=q+HVxrzpmxwSY9nZuZ8uUn68/HggVi20VlQ6xuUcwPg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f3BDTEbcEeH5bIy/DLnJ6GutgSObJgYZzXjdnzrLkfuMpvNxHlvwRKtaJwH7LxOh
	 2Tj12l3lqunOX2PZtxD915wYSGo15I1rJoj2Vx/KSU86BTyeYodyIK0S6sX7c8bMv
	 jIzE8jp0VBXcPiSpLaBsNpymrBrj3jFWtsi5f1IhVzL/+StCTiCOMW8+3C22ptZfj
	 xhyNQyGizSeGiYFHIh+XaOFStiJbPc9jTm1Ff4K9cpELVRJ/X9qUJXS2kYNlILNOd
	 NgwCrynAFF+TBzm8wrKxiaasHv84WyhFSC0T2shddCAsoAUO1Glp52ICohhi1TcTL
	 NrsmhtLszuDH8gVi/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq1CA-1v23CI0pBy-00ZaUE; Wed, 02
 Jul 2025 11:11:48 +0200
Message-ID: <166b2e55-fe21-4e0f-856f-1628d7d06c9e@web.de>
Date: Wed, 2 Jul 2025 11:11:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
 <38ed2bf4-4bb2-4ace-87c8-191e19f8445b@web.de>
 <5ce5048-db22-67f-aceb-a358c54a62ee@inria.fr>
 <65638cec-fc36-44c0-88ce-f9678a0a1d53@web.de>
 <d0fb31c8-2888-47e6-c527-57f0e828f32d@inria.fr>
 <20d8778f-27fa-43ff-97e1-44375755d952@web.de>
 <8a69338-c049-cce1-2d66-a9607c175270@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8a69338-c049-cce1-2d66-a9607c175270@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6Xqr5esGxpmhXSlRjymevz+IGpEn0Dkmnjzx1YxXb/i47QIkgiT
 I0hr7Y4PPVeSE3WIIW2Aet9U+7v7CgWLToKmidcDF9oD/3GXNO2Ib7gWCPViHJusJluqQZA
 emkmm0w+YlJ5Ye4e1wNynDOEW1IBHSXcDPAvsAoLPwcaACyKz1wKmrNiYhJkg571MaymEsB
 uJuwZrhUo/KnXF00dv+JQ==
UI-OutboundReport: notjunk:1;M01:P0:n9o9fVNKLrw=;e37c6XwOUpAAEp2+z/jdN05DiaQ
 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
Subject: Re: [cocci] Search challenges for =?UTF-8?Q?=E2=80=9Cstatement_li?=
 =?UTF-8?Q?sts=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2847
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/166b2e55-fe21-4e0f-856f-1628d7d06c9e%40web.de>

>                         You can write { sl }.

Such a source code search pattern can occasionally be helpful.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/b00c5adb1a485321c88450bdaa9e0d9ff93123dc/docs/manual/cocci_syntax.tex#L348-350


>                                                You can't write S1 sl S2.

Which software constraints would hinder the application of such a metavariable combination
so far?


> There exists no representation of a list of statements that sl can bind to.
Is there a need to clarify further possible software extensions?

Regards,
Markus
