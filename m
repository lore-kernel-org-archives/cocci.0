Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162FCC7EE30
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 12:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=99zUmSYKa7vE4vzj+Sar4JbCw7pz1+tPHiXLJnThYYs=;
  b=nfZpj29JwwZ+pC1FNgNM2V+NAddSqyv39kgSwuX/Dkrhw2xeChmFScTq
   j+Y64gnUmDDfRSAm0KFWsmBn9jX7MJBvBhGyGVTMhBppXd/ZMLiEKvs1p
   9IqhlJPe/vN8Uwm1EqmxHIfkVjq76Dgk90UfdiEgtE2lUmE+bfuvgtZFJ
   c=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229802996"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 14:42:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 76DE9E0BE9; Tue,  1 Jul 2025 14:42:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3DAEBE0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 14:42:33 +0200 (CEST)
IronPort-SDR: 6863d7b8_nftohD4r9XvauY3AATrsYgLtQSMKPEAOp1QNUsizWCGXu+O
 Bz18vzBSjmRo/+405tJQfyQqsIRW6Kps8M5DWiw==
X-IPAS-Result: =?us-ascii?q?A0H5DQDg1mNogAQP49RagQmBU4JEgQZUMwQLSYRVj1CBd?=
 =?us-ascii?q?DCEO4c8h1OMSQIPAQMBDU4BAgQBAQMEOIRIAot0Ah4HAQQzBg4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CW4EsgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYbAQGCfoIiAQYQAQMOJ?=
 =?us-ascii?q?AewGoEygQGCDAEBBoJp13UfLCJYgWUJgRsuhW2CZAGKYycPgVVEgTyDAz6EQ?=
 =?us-ascii?q?02DDoJpgiaBFoR6kzNSeBwDWSwBVRMXCwcFgSBDA4EPIw88BS0dgSd/gU0cg?=
 =?us-ascii?q?wmBDoQsK0+CJHWBeUEZP4NUHgZtDwaBHxtBQAIBC209NwkLGwY9kluHLcYnN?=
 =?us-ascii?q?AeCOIFmgWQMn2kGEy+XTA4GkwKZBak8gX4kgVwzGiSDNk8DGQ+OX4N1u09BN?=
 =?us-ascii?q?TwCBwEKAQEDCYVGAQGIDIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:yB2rWKOUGax4XcBcTh+jsMiBIKoaSvp037BZ7TEUdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwIk80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVyaygc378
 ddmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3Azw3tD2vxx5EtDRZFkf5YoAnO6IsucEXz00jeOXO?=
 =?us-ascii?q?HMkN2UbeVU16t97tdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AQzZxmg4a1C03ktKeJv6BMO59xox0ypz2DRE9z64?=
 =?us-ascii?q?nqsWaZCloHgeXoTO4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="120400252"
X-MGA-submission: =?us-ascii?q?MDE85ZBloBXEorzioIwlN0bwCJbH+cUv08yZQV?=
 =?us-ascii?q?vdh62zZhkCNn3o9Pnyh3kJAb0tu5TRXaFoBDlEUZoaamfOqQEew7NAHX?=
 =?us-ascii?q?ky6F0AcT8EikHWcBy2CvyYxVWIAEj9mYChkelZoARbkWJ3853mXwv1H9?=
 =?us-ascii?q?beFdf8y+DbnPxB5Zm0ZnBS1A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 14:42:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751373751; x=1751978551; i=markus.elfring@web.de;
	bh=99zUmSYKa7vE4vzj+Sar4JbCw7pz1+tPHiXLJnThYYs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H89eukplN2uWD9Vv3LMfTlTWJAQJlFBxRMEJ78hJ1in6wTW8Uc6B39nnUwi3Lxqy
	 4ftN8GoSmGdLS42gEw7eIfrpmIFRervYr5yHwaATDZIb4HaP8117CEBJE4zECWXP2
	 ILQuICLVjkwEDpw6Nhw+FJGF22LOh0q0KI4ka1ewmw9YyxBY+fWfgZ6T2JK12y00s
	 62sQxJQq3KeVH5xpqMXhfOxbaVlBUIV2rI+Gta2Boq4DeNmURvhX5gPRxAERy8zIM
	 IQTszNPpxFrKipL/HE6DMJ7ZvyZJHckzNTQe4ZZ9xFoqBQovFSjmscICtwRa3No4X
	 +L9oKnjrO2tQZkkAnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mv3US-1unydz2qfI-018EnN for
 <cocci@inria.fr>; Tue, 01 Jul 2025 14:42:31 +0200
Message-ID: <5da0fab5-ebbd-491b-84b1-69db7cec524e@web.de>
Date: Tue, 1 Jul 2025 14:42:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
 <bd958cff-a9bb-4f6e-8305-e5a09375ccc6@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <bd958cff-a9bb-4f6e-8305-e5a09375ccc6@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LsaNDvNgqOOc2A8BVqaDMTzshtAZql4FwGQ/1g0LJX1xUGh/UKn
 bqpByd9gYpbkcQ4+aCdwTlRHNVWAJ5SRntzSYePuSs9HRs/k+hKb57XZldNd33o5qWQRCZM
 3iEC1DKyUqggFb2ikHWUdkafizoY82BDLhJ6xOo0cDEBkFkd0yKey0mgwTNf+sP88cfkra1
 wjEG10Jt4c+t910Z+9HOg==
UI-OutboundReport: notjunk:1;M01:P0:fzeG22O9qlU=;uIhWLRl9m78/A2c3TMQtVwyHNcv
 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
Subject: Re: [cocci] Searching function implementations with variable
 declarations and statements?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2836
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/5da0fab5-ebbd-491b-84b1-69db7cec524e%40web.de>

> Should any diff output be produced accordingly?

Would you occasionally really find a source code search approach like the =
following
more appropriate?

Another SmPL script example:
@display3@
statement s;
identifier i;
type t;
@@
 t i;
 <+...
*s
 ...+>


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_statements_a=
fter_variable_declaration2.cocci include/
=E2=80=A6
@@ -668,7 +668,6 @@ usb_endpoint_maxp_mult(const struct usb_
=E2=80=A6
@@ -723,17 +722,10 @@ usb_ss_max_streams(const struct usb_ss_e
=E2=80=A6
real    0m0,243s
user    0m0,199s
sys     0m0,042s


Is there a need to reconsider the handling of curly brackets (for compound=
 statements)?

Regards,
Markus
