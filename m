Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87960D59F5A
	for <cocci@archiver.kernel.org>; Wed,  6 Nov 2024 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lzPWOfY+4hFYIiqswulZuoffQLHBgXKQOlamC+JAigs=;
  b=X6rwvOox64dyn2jxoOLMMjM41H56dMHyFlHzcqpyO7XBzhhztFAeltRr
   xQtnclYVbWWoQYL0yA6GYE9w9RU/Ge6FVN43ZUr61EWzuTpb56Ag0EvE3
   qyniskmKlJ9BrP23eBZf8hBc7OGlfQmcde7sQtkiAOX6izxoYa4Dt7RFs
   0=;
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
X-IronPort-AV: E=Sophos;i="6.11,263,1725314400"; 
   d="scan'208";a="192589581"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Nov 2024 18:45:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5E5EDE0133; Wed,  6 Nov 2024 18:45:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 531CAE00B7
	for <cocci@sympa.inria.fr>; Wed,  6 Nov 2024 18:45:08 +0100 (CET)
IronPort-SDR: 672bab23_VeMdI+phd7H1sfZEc2LHKCEwVyCE7S3d5wQvH8xbJ+VONZN
 9PHV4oowlr7DQgcsLFVny32AhtlAggi1W8beuzA==
X-IPAS-Result: =?us-ascii?q?A0GBAAAlqitngU7ASNlaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YJDYiFUMwQLSIRWj02BdC0DhDuHOpBKgVaBfg8BAwENQQECBAEBAwSFAAKKO?=
 =?us-ascii?q?AIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHD?=
 =?us-ascii?q?gkyhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn2CMAEDDiMHsB6BMoEBggwBAQbaWx8sIleBZAmBGi4BhWmCY?=
 =?us-ascii?q?gGGJIQ8Jw+BVUSBPIMDPoRDg1uCaYJMhSIlTUmHF2iMIYttUnscA1kyAVUTF?=
 =?us-ascii?q?wsHBYEqJCwDgXtYf4E5gVEBQoJdSoM9gV4FN0mCSmlLOgINAjaCJCRZgk6BJ?=
 =?us-ascii?q?QQFg2+BC4NlhGmBPR1AAgELbT01CQsbBj2fQIMjBoEPAYE8gSA3xEqBCjQHg?=
 =?us-ascii?q?jiBZYFjDJ9VBhMvlz8OBpJ6mHcio0yFNIFuCSqBXDMaJIM2TwMZD44hhC3AJ?=
 =?us-ascii?q?EI1OwIHAQoBAQMJhUYBAYwqgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 XcdHQh5fa1wdaI9/QuMtZKY9NH1cQ4DFwkVUBo=
IronPort-HdrOrdr: A9a23:9AWz7aAo9wb+NKvlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:cZY0jGzCoqKwaNpGiCmiBgVKWewjU2eGyUzueVGGIkFrdeCHamKprfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AwzjHTw2lron0ME8harYZDdhbyDUjyr7+AUAyyYU?=
 =?us-ascii?q?/g9iFbSktIm+sy2imTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,263,1725314400"; 
   d="scan'208";a="100934979"
X-MGA-submission: =?us-ascii?q?MDFjLMJw/PGMhrwBCK5brlS36knUjkufyM5a94?=
 =?us-ascii?q?Zj85KEWWI4bg8wmRaG4PydC5fI6m2FnzBUcG83C6MxQRCioWpdJa1qAS?=
 =?us-ascii?q?5LIIYAIGaH4yyTRj4vVaCsNnWBHwJZNBGmbdD44cxTrg4yu1b6sYdACb?=
 =?us-ascii?q?q+HpVs7n7cPN90WgVMohDC9w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 18:45:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730915106; x=1731519906; i=markus.elfring@web.de;
	bh=lzPWOfY+4hFYIiqswulZuoffQLHBgXKQOlamC+JAigs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GDYetIgwuE5bkdU/azFVZKJH0utogLNh5vXdV9kSenCCS2qSNwCsHtkn3GMrT3xW
	 czbZ00UZJ7cCLy9oN8HdLX3bWZQ8gdQj4FXc/mubQmmWF0t7UoSff1IA0Jz7EVmI2
	 f8e1fs/1+2owZ/d21ZSjqK0yOAPn9IvJl+5z8zx1hPemNgQLI9bpxdALA3rjkyXff
	 cnQXeCdWFPAAN67APXL68TfCjP71a2QM0GumL3errhKBBUHiLnIYB1mR11chKq6jW
	 ZY73ctPqRQCd/pUbpMS1kzbyw4df9z8zPHzEnhNMa+hecuT6E6QjCEqDbYk9llkfJ
	 N+6Oyp4K3mREHyd0PA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumJF-1tydv71nfP-018B1O; Wed, 06
 Nov 2024 18:45:06 +0100
Message-ID: <e2b41e0a-7e6b-4d2c-a6c3-adc68e6934b6@web.de>
Date: Wed, 6 Nov 2024 18:45:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <c07553fd-4c04-4f5c-a72e-a71fb1e66c38@web.de>
 <0a6cf23a-eec9-4e80-afba-e8f8409c1085@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0a6cf23a-eec9-4e80-afba-e8f8409c1085@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g3hz7JK5mlx6AaCzrFeiGE/iXZjKoJHrPH/vvnukwnwGXdU2Hek
 IZO8oWIPNOyWnE/HwmS964y12cfvsO1VmLMk5iVvLif9nnu7KosDK2tkwcPg6R+B4XH7SqK
 8ysHkOp+2x9Lg/moN9nfxqYq+RJgZcG1Up4/DlPbiDlonr8m7XTfYXtlYxfYhlyy4dBVsC+
 l5xIXeZ72cOWUOXwUOT3g==
UI-OutboundReport: notjunk:1;M01:P0:AxWzU3c5sBk=;LqNhsORCDeTViXelxPyixDiFGTo
 jX/iqEF2QlfoWzG33WPQHruDLDDiWHckSncFaVoDW5hrk2HCyBQivcbGQuN6Hcn7LFFvXISTE
 jRjeRZXhHGJGdMl+5hETYs5Lbb3qKjOh+Pz8BdFKqhLLLxW0bY4AxtqrWCCR9ccPHl6EWoDsa
 xe7P/iKd27vfGV18a8ynB6acNL3crE3jvK+BcgRgZwYht1gtLZA4ozS/BHw0zaukkoPPwOa0m
 PRl7fabftKcJICsFHP0KeG4MIFfREMMh5u1Rxv9iincXRB6X1MV9SN6gjmag6gLuhF9z3FuJV
 41mdlfC1RvLHMVRek67aKQvKBWtskzqVR9m5kHgm/OX7sct20OkvYCdQJd61knUXK2HAEJxGD
 1VzMigMhK3OIxKpCgYDerjRxPBY1ArDTkfi2aM8RMaMwxsUikK9UVAzysyUvK8FIn6AUGTo6T
 YaEl9OcdSo+IWxp697elbQHqFnXwBte6m2clbKPeP7prf0g+Og90HBUstXN/aI8MCvuknCzhF
 IBiPx3R5s4CGG2oMKeZuwzMsCcKOLv7gAio/d0fwAIk4HT3fUwNg5XfYBLg9+yyfeiDO7mxV2
 jm7YsQFVzsFJBLJCZ1WEnb4nu0WuVWCK5W6UQZyI+CmP9TPDNuJPO/b57XAjWauBKvF7crY9i
 /lKbNwSfPn4+EIHC7deqLROywT3XLncZEVSy5CSLy1cjdGyKjcq/rqcjT3mcab7YoOeLaxCXM
 BBXz8bM3FAy8nDK0D9VAptYXN+OWrIBaoVPy+DwT6Vi8eX9wQFoaipAY44AGDNDg/nCh4DGjR
 rzd5RTKcxV7+68SLSDZmzv8Q==
Subject: Re: [cocci] Generating parse trees?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1973
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/e2b41e0a-7e6b-4d2c-a6c3-adc68e6934b6%40web.de>

> Thanks for the suggestion. Unfortunately, many of the features you sugge=
st would take significant development time we simply don't have,

I hope that such a view can eventually be reconsidered better.

Presented ideas might become more attractive and helpful under other circu=
mstances.


> while simultaneously not having any obvious benefits or fitting any well=
-defined use case.

Would you acknowledge that parse trees can belong to a relevant part
of some data processing (also according to parsing approaches)?


> It's also unclear exactly what you mean - what would a collaboration
> with a parse tree generator look like in practice?

Several libraries and corresponding tools were published already.
Their development status might hinder desirable progress.

Some might be usable to improve data processing considerably.


> Are you suggesting we change the way we parse C files,

Perhaps. =E2=80=92 Partly, yes.


> that we add a new feature,

Probably, yes.


> or something else?

The situation depends on selected programming languages.


> Your passion for this topic is obvious, but if you are interested in see=
ing new features being added to Coccinelle, I suggest you either:
> a) clarify exactly what you want the feature to do.

You can probably know by measuring data processing steps (profiling)
how much efforts can be put into file parsing for example.


> b) implement the feature yourself and open a pull request, =E2=80=A6

* Were difficulties indicated with such a collaboration technique so far?

* Does an implementation language like OCaml trigger special challenges?


Regards,
Markus
