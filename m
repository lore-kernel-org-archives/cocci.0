Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B50E7717F
	for <cocci@archiver.kernel.org>; Thu, 12 Dec 2024 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=p6hOEiVct+iyq05uyY4a1MPNFN1RaB168d3A4gkTP0w=;
  b=nmIMjg9rgvSP4GeqiFZxnBFc+FusK2LxqMmRfupC/lRvDELgajiTstBS
   A9qu5LZnc5QyVPoUsTZ08glvedVwaIMKgclIwbXmVWwOQt8C0La9WNf5y
   ihsgMRaSovjaiM++EbtMd3zfjkeRRMVcbyYhcB7om6YbHQeS2ZTCPcTfO
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
X-IronPort-AV: E=Sophos;i="6.12,228,1728943200"; 
   d="scan'208";a="198813517"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Dec 2024 13:31:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F2C9E0D1D; Thu, 12 Dec 2024 13:31:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C3E27E0077
	for <cocci@sympa.inria.fr>; Thu, 12 Dec 2024 13:31:02 +0100 (CET)
IronPort-SDR: 675ad786_rm8L/7H4WaqTv+YSaeKiF/1XmuAdUeP2kGW7bO4NGtppUJg
 v9qLHjo0C++LpzIY4Y1g+pfclpt5KH5xupng+TQ==
X-IPAS-Result: =?us-ascii?q?A0GYCAAk1lpngAMP49RagQmEF2IhVDMEC0iEVo9NgXQwh?=
 =?us-ascii?q?DuHO4dWiHaDVA8BAwENQQECBAEBAwSCDIJ0AopsAh4HAQQ0EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGARQBAYJ9gjABAw4jB?=
 =?us-ascii?q?69EgTITboIMAQEG2lsfLCJXgWQJgRouhWuCYwGGJoQ8Jw+BVUSBPAuCRzE+h?=
 =?us-ascii?q?EODW4JpgkCFVCVng36JUIRGinFSexwDWTIBVRMXCwcFgSkgLAMuNjGCBRyBP?=
 =?us-ascii?q?wU3R4JJaUs3Ag0CNoIkJFiCTYElBAWDaYELg16EWoYjghmBRB1AAgELbT03C?=
 =?us-ascii?q?QsbBj2dBYJuLYQxsUKUXDQHgjiBZYFjDJ9aBhMvl0MOBpJ6mHsiqQiBfiOBX?=
 =?us-ascii?q?DMaJIM2TwMZD45Zg3XADkI1PAIHAQoBAQMJhUYBAYpsgUsBAQ?=
IronPort-PHdr: A9a23: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
 dXF0q7+em8qGz384sYWQcTZepvvDQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:iB+Q/Kh2PyirxyEOGiGA/V1a2nBQXs0ji2hC6mlwRA09TyX4ra
 CTdZsgvyMc5Ax9ZJhCo7G90cu7Lk80nKQdieIs1NyZMjUOzVHYSb2KmrGSpwEIdReTygck79
 YDT0EoMqySMWRH
X-Talos-CUID: =?us-ascii?q?9a23=3AmtdMH2j6UTzI5jtJ74fyXPVyLDJuUFHekFP8CGm?=
 =?us-ascii?q?DK0VjT6LNVmerwp92up87?=
X-Talos-MUID: 9a23:jg67Ewmoun7Dh+M6dOVOdno/F5dy2Ya+OnwqjIgKlcrYMnVuIgek2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,228,1728943200"; 
   d="scan'208";a="198813510"
X-MGA-submission: =?us-ascii?q?MDHBSQ0eLBoa/bJdmadoswR8qOCkwJRDr687vB?=
 =?us-ascii?q?iFbhGTU2rC7Yf/OUeaG780uQUcOySCF66TET3qcZtC1c5dOQ4iztPJSE?=
 =?us-ascii?q?3ndr25f1XFcLqQnjr2q41oXZG1tTQU+43mhpIBFIMs1k+3wVk05g8ksl?=
 =?us-ascii?q?f/r7kpIv6p4cnZ+mCwAhFIeg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 13:31:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734006661; x=1734611461; i=markus.elfring@web.de;
	bh=p6hOEiVct+iyq05uyY4a1MPNFN1RaB168d3A4gkTP0w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NQUrWI10cN2LMVCYPJ77oXl3nolq76KcPCDaHSxaDvpfsk6EZhgWrFtyQUkV0E9Q
	 msujV421m+a7+RJgv/PUai9KteTbAzfMUxBGBg3AltmwBgFhWTkFatFD6AWO88jBb
	 D+CavfbVwTj+iHddJAs9NwIWwSKQ5FEWN89gPBtlfT6OW3dqHNwbb/Qz/GYxmjTB3
	 nG3dUdq6Mo982Otxgy4vCMl5TEFoLN3diLePFFmgWcnMbPWr66TmXcpzcecPuEyXN
	 qoJ1xY6Z3bfBplKs+Y9s5QpzT2haVVY4tAciLt93Ue+3lSvrMUuUxepDixXHAZXw/
	 hsTRpEPUNGu4oaVftA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.70.15]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JB0-1tIyFz1zCs-000E2X; Thu, 12
 Dec 2024 13:31:01 +0100
Message-ID: <ba597a76-3b4e-4360-bde0-6d004fa6ffed@web.de>
Date: Thu, 12 Dec 2024 13:30:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <11adee55-edad-4f0e-b80b-cfd9099ab4eb@web.de>
 <78704675-cc81-b635-6161-a2fb91d2b6d@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <78704675-cc81-b635-6161-a2fb91d2b6d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dly9cZERexZlxtgNIGNYuNvdbZgvj7D6YZFf63IWfshCYLgGIQc
 F2GpVYFsiTrJsYsLIALP9NRShw3g2iuNxq4eSD03EYgbrte1/qVeYBjjbQbhCZJKeS5ko78
 mAsC+Chj3HpJsReg4fKunrdIQAVU/Epvslq7sGiO69jEoQzvbdtPpXeZ3Op9Rl85+g5HiBL
 JUHztGVITpmnu2ig+mXHQ==
UI-OutboundReport: notjunk:1;M01:P0:Js312HTkkdc=;/ZVeh5xN0S2tSRmNZWGyUm+pJX8
 KRMHquSou3CatLN8XaaU5aLlwJxLK4E5LTXrcBVRucNV5O2KkPIyGC1TE4vhGuoWOpQJy9Kpt
 aD/pTptzM1nM1CSrzLXQb9mJpv9dJLiSCYjjEd0vqS1aZ4gy9luv7zItZECKwYcIk2RvuvjFM
 esjX0LQBVyu1ofoJaeKUKRikINEUgRjpz8Ogvfplni1+5KZe2q7zQOTNBZDe2u7sGGDcwmhyS
 8jCG4pUwUD55NNGJpC8AQQWzb8f1kHpZNtQU31RYeHLer17w9yO8Jum5uDBeuBMqNBRu7FQ0C
 prfvea2RWHsUGB0TGrZlsI5Z0IEF0WHUEx6dwgjxU9fRLJW0NsTMliFSQPd9TgS6oJeO2mY2K
 uzF2IhZqYLmYiFoZUIF+lWcdX7y137xu1g0oCVo1PPL/PzpukpY+SL6Vichl/WOumpDvvioNt
 sQwOZfJS5GawaVS/bLvmuSdoC3f41jStcu6TfPb5VQT4Xh6HDBgqz2n4HBNpecZvwNyGmZCMv
 LbFvu1d/l4RRphESNF3xTh01Zoorg4VJ32xgJ09IE93Z3PG6hJMdapRJ5jktkBiO5RdgIDgk4
 ZLNLa9C6silzQALkRHzAtngQomLwUgPPyy+t+NimOV/k4h7RpJi9k5s2wFilsHACsaVb6XmY7
 UGEi33Sfk8jer006TWCyBpEzb8jObrfDo50/L0K75cXNqJ/OezPDy+IFt2yw88qGr148Kioip
 qRE9Pn3AY2u2YsVG4tkLVhuhxK3P65+Pbar+61clMvhU0wJotbaFeR4yb3Cw9mH5JmVpWUlSZ
 B9jGhPQTMKYic1wXhL6ZXOs53BBI6kXkFvL+AqHsg1v7AjEoJoBBoqnFlsPFtXVmhkTS9xauI
 hvtRo47XaH4R+1hFzNlRxZ8gIX/GgM5XU/GVxp0YK4XS0DqQ1V2u1iZMnULfe7IcpjVOGnjzM
 VnVnQoYPw8giMIxMtCYlDkm+mCUJIAJM6XYf8LBqZ+fNWJAchlClNDNrMJaWcLmlAYgJYRKNB
 92Jq3ml+08AvXpkdilEqexdYiKu3ElmG6k7iIb2tuPJFoR3czY0RSNNY5Mbxlnulwoc8/E/As
 VASQowV5Q=
Subject: Re: [cocci] Development challenges for handling of selected code
 repetitions (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2180
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/ba597a76-3b4e-4360-bde0-6d004fa6ffed%40web.de>

> As noted, there is nothing to attach the } to.

Would you like to help more to enable such a connection
even if code filter repetitions get involved?


>                                                 The ... goes to the end =
of
> the function unless there is the when.

Will such information influence any imaginations for possible software doc=
umentations?


I see further design options.

1. Additional notations for indicating code repetitions

2. It is demonstrated already how something can be selected by the means o=
f when clauses.
   Further settings can become relevant. They should probably not be confu=
sed with when clauses.
   Thus I imagine that additional parameters can be specified behind a key=
 word like =E2=80=9Cconfig=E2=80=9D
   for SmPL ellipses.


Regards,
Markus
