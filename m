Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4119FCAC5B0
	for <cocci@archiver.kernel.org>; Sat, 27 Sep 2025 09:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/1u+8sTR3V72H77qUnr2FeN0KokPITGVnFfledBDv7Y=;
  b=C2/LBSaily/Ye162YDojG40dQEaPBv0ir/h3EnjfIXhUsLuy7ui66NVw
   lWi0Ocecg/GG+cIb/RDl9VbsiX4R8vE40Fw4/S9uKg6uZY6NGQGG9GJ6c
   Lup98Fk4qKal6CI4PUcL6mA31v/qbx2v/jPVzUVxpjA8oY/cmdS/zq9/I
   I=;
X-CSE-ConnectionGUID: T7j9gB9IQNm/ILwEaeEgcw==
X-CSE-MsgGUID: QVwxr5z7SbeWkx+DBBnr1A==
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
X-IronPort-AV: E=Sophos;i="6.18,297,1751234400"; 
   d="scan'208";a="241310468"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2025 11:34:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9CB38E0B0D; Sat, 27 Sep 2025 11:34:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7D17DE0171
	for <cocci@sympa.inria.fr>; Sat, 27 Sep 2025 11:34:14 +0200 (CEST)
X-CSE-ConnectionGUID: YsRrZv3STOiwOJfbcEFDJA==
X-CSE-MsgGUID: pxrJjnf1SwKT2WiVBO0GYw==
IronPort-SDR: 68d7af95_tuE4jIXn3SnNoljv005CXpJnax1FleEKEY4++nbSFdcQXEH
 ryBXdylLeWsz8bxgRni0ZzXrZ47cvVVmgwOPe5Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E4AAC5rtdogwsR49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgVOCQGUdWjMEC0mEVY9QgiGEPo8RiHmDUgIPAQMBD?=
 =?us-ascii?q?T0RAQIEAQEDBIIMgi5GAoxGAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBAQENA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBOgcOCjGGTw2CYgGBJIEmAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBFwINOkQCAQMjHQEBESYBDwsODAImAgJWBgEUAQGCfgGCIgEGEAEDN?=
 =?us-ascii?q?QcNtAB6gTKBAYIMAQEG2l8fLCJZgWQDBoEbLgGFa4JkAYYnCYQzJw+BVUSBP?=
 =?us-ascii?q?AuCeD5pgXgCgWCDW4JpgiaBFoNYjFmONlJ4HANZLAFVExcLBwWBIBAzAyAKN?=
 =?us-ascii?q?BQdAhQNEBIPBBYFLR1zDCgSZYMHgQ2EHitPghxygQB0PhlBg1MeBmsPBoEVG?=
 =?us-ascii?q?UkCAgIFAiwXPoFrBQEcBh8SAgMBAgI6Vw2BegICBIIvgRKCDwxAAgELbT03B?=
 =?us-ascii?q?gMLGwY9mDWEdyKBfRIMllEBr2s0B4I4gWeBZAyKLpU+BhMvl1IOBpMFmQYij?=
 =?us-ascii?q?WabOYF/I4FcMxokgzZPAxkPjiEZg2czx2lBNTwCBwEKAQEDCYVGAQGMVoFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nKh54aPbtUyjnsBcThWjsMiBIKoaSvp037Dk7TEXdfUnSL38qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhbX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3A7EOr62vrG+UV11FuwkhxChWH6IsUaUfH/mmLGHO?=
 =?us-ascii?q?fCHlOarOfQnK+1IFNxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ATWefzQ+wI07fV9fuxjOhsjCQf994+YasDk5Uqoo?=
 =?us-ascii?q?lh5O7NBJaHG+yvSviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,297,1751234400"; 
   d="scan'208";a="126710660"
X-MGA-submission: =?us-ascii?q?MDG2AK+dGCaKEuyzc9yANHRcrRxdEv/2lrVFyk?=
 =?us-ascii?q?F+achx1p8s06mPFkZMDvIgh6Mjfik54EkMGUlLNbcFwyq1/BbcW2ZhbJ?=
 =?us-ascii?q?MUuG7ze+wsOv2wI4U26DB6bSaDUxJ9GYvBdfg9466efxq6vlRo9G71JB?=
 =?us-ascii?q?8oHWxabB5jixWCsh13yJBPZA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 11:34:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758965631; x=1759570431; i=markus.elfring@web.de;
	bh=/1u+8sTR3V72H77qUnr2FeN0KokPITGVnFfledBDv7Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pPFXo2O7x70whVCIhPyMRpzKQ4vWcydAyCBtuZL08YIfGVlGgTDhXWzBa04/RK4N
	 F91dvQVHPLjOJeAulSpgQ+chdoL35csCGOZ7XRtfq1IKGH4OhPT4uCYW1eZbHqUGe
	 7puWQTvYCGBXCSra9D2+mtnUQtQkbuQGVhOvbtQ1LmqCqEylgO+y9tT/xZ6T0D7ls
	 lLpRExGnIrtNVlrF3YYQA6k4hCBPPmDe17wD96vzsZmXN33lKsHJBcsqJX8qLkQPw
	 pZa6CduSqSzAWPqhz1nRfXd8xVBEHXybPZZh2HeE4xRkk4kdOtqqsEs0pDeLz3CXs
	 Y/pGIqF+YWrpR81yYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHVal-1v6Xtv42DZ-001l4o; Sat, 27
 Sep 2025 11:33:51 +0200
Message-ID: <b994f006-552b-41a8-9714-5efef68f2f12@web.de>
Date: Sat, 27 Sep 2025 11:33:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Oleg Petrov <o.petrov@ispras.ru>, cocci@inria.fr,
 dri-devel@lists.freedesktop.org, lvc-project@linuxtesting.org,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20250924140126.23027-1-o.petrov@ispras.ru>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Vadim Mutilin <mutilin@ispras.ru>
In-Reply-To: <20250924140126.23027-1-o.petrov@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:71UA9sLb3/4N2kgrxV5wtqmcFepCKuA18AEhzGF0nUvfaZdmNGU
 16e3IOhQJjiY7J9OXdOH6RvcOTWHGdggqnGssIJK51l1WqMisQZOH70im6sO9qTCGhH0Ra0
 CGTejKhaqhPE86JtBFqHSfZMo3LpiZjjKJk01mtDXN2zTOkbnu3wU07j8vqACKyjeS1rBw+
 jifTNX3OfmMLbuHUNX0jA==
UI-OutboundReport: notjunk:1;M01:P0:9AjejW254dk=;3rK4r3f2e9XASgGM8HIuN/IKzc6
 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
Subject: Re: [cocci] [PATCH] cocci: drm: report devm-allocated arguments and
 fields
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3043
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/b994f006-552b-41a8-9714-5efef68f2f12%40web.de>

=E2=80=A6> +// find devm-allocated (devres-managed) second arg for drm*ini=
t functions
> +@badarg exists@
> +position p;
> +expression devm,e;
> +@@
> +// only devm_kzalloc is really used
> +devm =3D \(devm_kzalloc\|devm_kcalloc\|devm_kmalloc\|devm_kmalloc_array=
\)(...);
> +...
=E2=80=A6> +// same as above, but with an intermediate local variable
> +@badarg2 exists@
> +position p;
> +expression devm,e;
> +identifier vitm;
> +@@
> +// only devm_kzalloc is really used
> +devm =3D \(devm_kzalloc\|devm_kcalloc\|devm_kmalloc\|devm_kmalloc_array=
\)(...);
> +...
> +vitm =3D <+...devm...+>;
=E2=80=A6

Your source code search approach affects recurring development concerns.

The shown rules start with the same SmPL code.
Thus I would find it nicer if such duplicate code can be avoided.
I imagine that software run time characteristics would be more desirable
if selected data processing does not need to be repeated.

The search should obviously be continued after a relevant source code plac=
e was found.


=E2=80=A6> +@script:python depends on report@
> +p << badarg.p;
=E2=80=A6> +@script:python depends on report@
> +p << badarg2.p;
=E2=80=A6> +@script:python depends on report@
> +p << badfield.p;
=E2=80=A6

Will development interests grow for another clarification approach?

Support for SmPL rule groups
2019-04-07
https://github.com/coccinelle/coccinelle/issues/164

Regards,
Markus
