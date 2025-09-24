Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1569DCAC5A5
	for <cocci@archiver.kernel.org>; Wed, 24 Sep 2025 15:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Fxtcx4A1lIkBA+fnaYrI+5nN3wIMjoN2Kn6vJd6kzOg=;
  b=n5ffqWAy5FCeeUSvV6mrUQKOWaeKtUuCdd/RwZrD3TfLY1QNbrLybKsy
   RYTiqR3kYMi9Fq7hRdZPIwS0MPbEtrsTsJf3w4eY0XgYwNvTaSJG3rxX3
   yq394Eq7XhnxdAzpEVIuw0iH+Mq8DxI7ppqzPQR4/oAMuXpuBOoE8P80C
   o=;
X-CSE-ConnectionGUID: mIXsrPdcReu4lrGZG4yWhg==
X-CSE-MsgGUID: WGwtNt+IT5697JJjTNUcgg==
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
X-IronPort-AV: E=Sophos;i="6.18,290,1751234400"; 
   d="scan'208";a="240851196"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Sep 2025 17:09:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C0D48E0171; Wed, 24 Sep 2025 17:09:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7136CE0171
	for <cocci@sympa.inria.fr>; Wed, 24 Sep 2025 17:09:09 +0200 (CEST)
X-CSE-ConnectionGUID: g0kr4t2qTa6aOE6ilyma8Q==
X-CSE-MsgGUID: XCyRJIclSUynm+A6zf7AMA==
IronPort-SDR: 68d40994_0GvdeD/W5jGPoRXsPqfaLKAX+MpzGXuIz6cVXCI/GMPV2Nt
 4l2TsfYFE2aTKe4zl7DW5gIt7op15vCqMxFyr2g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FIAAAOCdRogwsR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFTgkBldzMEC0mEVY9QgiEDhDuHPJBOgWmBaQIPAQMBDU4BA?=
 =?us-ascii?q?gQBAQMEhQACjEICHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQE6Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBA?=
 =?us-ascii?q?gEjHQEBESYBBAsLDgwCJgICVgYBFAEBgn6CIwEGEAEDDyYHtkV6gTKBAYIMA?=
 =?us-ascii?q?QEG2l8fLCJZgWQJgRsuAYVrgmQBhieCWYFjJw+BVUSBPIMDPmmDHT2DW4Jpg?=
 =?us-ascii?q?iaBFoNYjFiNHFJ4HANZLAFVExcLBwWBIBAzAyAKNBQdAhQNEBIPBBYFLR1zD?=
 =?us-ascii?q?CgSZYMHgQ2EHStPghxygQB0PhlBg1MeBmsPBoEVGUkCAgIFAiwXPoFrBQEcB?=
 =?us-ascii?q?h8SAgMBAgI6Vw2BegICBIJHgRJSQAIBC209NwYDCxsGPZdJhWk1Xi89lhQBj?=
 =?us-ascii?q?HCiezQHgjiBZ4FkDJ9sBhMvl1IOBpMFmQYio0A/hSCBfyOBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hGYQayRdBNTwCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:XJs+ta5tgVGsQM5zyQPXwBzXdLJyesId70hD6qm+c20zTiXqrb
 HKoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWYtKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:cKGtvmEsk0uwmGERqmJorE0ORtx/a0HUkn73DhG5DXdsQe2sHAo=
X-Talos-MUID: 9a23:HP8ozwRXWW66L33XRXTcryBYFuZj55+TGUYI0rxYqcfbHAlZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,290,1751234400"; 
   d="scan'208";a="126470831"
X-MGA-submission: =?us-ascii?q?MDG5uW+aBJoe75FYjzGzrFSWAGHdeMc+oDS61R?=
 =?us-ascii?q?42saSGPPzWmQtVwYNgNs5gZeTZbi/XcI7RZmlKQ0SIrcVDU0cYW9YnpQ?=
 =?us-ascii?q?39nJdY49S2sfZXi9Yi0AWLbGt6mb472wamfP7GoXYKGBOCbnjJEeVEcr?=
 =?us-ascii?q?KgoXuEIz2yY9UySMb8eMGx5Q=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 17:09:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758726522; x=1759331322; i=markus.elfring@web.de;
	bh=Fxtcx4A1lIkBA+fnaYrI+5nN3wIMjoN2Kn6vJd6kzOg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m8JX20G0Z5T/yaReHQNndEHofQqCM2lvX0rw2l9sy/Wt78/bOJDfI/hhg+ShEgHq
	 mfHj6mM8B6HPGOzqYrP0bbiqxkYCUgmDhKOku6acHyttAy2plKI3DeIJg2m9Xqign
	 lrpNwmgO21vthUFEaCKPpFumukR4VHKaWHD/cwsZVhtsrMxXzOmo7KTwcYm2+e2b8
	 t8xg+tFfMbFjVKoD/cD9gBfiWdpm3TXNiRIE4yku4djdE9aNF7dGqh3Lk1JA8lUKE
	 uKx88TwqHBt1ElKaXZW/jNQcleKJV9LgbVsGHxmCaR0YAVhKnEIs9OQ7eaaHfuDzI
	 Wn054SAqQ1yn1Ri8nQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.191]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWsc-1um6533Xei-00Yx6f; Wed, 24
 Sep 2025 17:08:41 +0200
Message-ID: <1071f2af-39be-425b-bdb0-7f004a6e8f65@web.de>
Date: Wed, 24 Sep 2025 17:08:39 +0200
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
X-Provags-ID: V03:K1:uZrWTvaoGpbDSZWsF91sFFye+hH7BZIZdED6uBooGDJEiUcJfaE
 7UACdoAp5MMPfoQMjAZ+r6Zj+UgH9dthLqgBDL/un/peke4LAq5DduG8chUXdJZCZIU+Qc+
 QBwUG8Iyc/2gn9DBG36YEGj+s3/pD3AcW8sYy9LeFnQ0WAHkffA1sr8LZXwMAU3e/bPudWy
 19whwCdVwJht8mnxv6O4w==
UI-OutboundReport: notjunk:1;M01:P0:8tbrgLiUt60=;1mJvOUB5Vk9P8qigUFuC9CamA7Z
 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
Subject: Re: [cocci] [PATCH] cocci: drm: report devm-allocated arguments and
 fields
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3034
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/1071f2af-39be-425b-bdb0-7f004a6e8f65%40web.de>

> Add two Coccinelle rules: (1) flag a devres-managed pointer
> passed to a drm-init function, and (2) flag a devres-managed
> pointer assigned to a field of drm-managed struct. =E2=80=A6

I suggest to start each enumeration item on a separate text line.


Would you like to refer to =E2=80=9CCoccinelle: api:=E2=80=9D in the patch=
 prefix?


=E2=80=A6> +// Copyright: (C) 2025 Oleg Petrov ISPRAS

Would another delimiter be helpful between the personal name and the organ=
isation identifier?


=E2=80=A6> +virtual report
> +virtual org

The restriction on the support for two operation modes will need further d=
evelopment considerations.


=E2=80=A6> +devm =3D \(devm_kzalloc\|devm_kcalloc\|devm_kmalloc\|devm_kmal=
loc_array\)(...);

Would it be nicer to write such SmPL disjunctions on multiple lines?


=E2=80=A6> +@script:python depends on report@
> +p << badarg.p;
> +@@
> +msg =3D "WARNING devm-allocated argument in a drm-init; use drmm-init f=
amily (or drmm-alloc)."
> +coccilib.report.print_report(p[0], msg)

I would like to point out once more that such data can be printed
also without an extra variable like =E2=80=9Cmsg=E2=80=9D.


> +@script:python depends on org@
> +p << badarg.p;
> +@@
> +msg =3D "WARNING devm-allocated argument in a drm-init; use drmm-init f=
amily (or drmm-alloc)."
> +coccilib.org.print_report(p[0], msg)

Would the following method call be more appropriate?

coccilib.org.print_todo(p[0],
                        "WARNING: devm-allocated argument in a drm-init; u=
se drmm-init family (or drmm-alloc).")


Regards,
Markus
