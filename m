Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51A9EB64D7
	for <cocci@archiver.kernel.org>; Fri, 23 Jun 2023 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RivzCzq+1xqrOllNDd5eWdrVBtj7Lmy0XMs3oB2UXnc=;
  b=OYKHNUwaaLQatFHU+OEcfTM+bvMYz3ng+duzFiGVumID3/GI6VN+sYGi
   BIgddQm7UISVNTVukDiFGWvLt+3l2KMvq1X28N2xfibZeukOeXDCoeO3z
   aiNAk3UJD70N5f2VbwJ18vRMoZMoJAViua0k4669IJASW6b47tCGoxwyb
   g=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.01,152,1684792800"; 
   d="scan'208";a="114426572"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jun 2023 18:19:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C2152E03AE; Fri, 23 Jun 2023 18:19:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1DEA0E0157
	for <cocci@sympa.inria.fr>; Fri, 23 Jun 2023 18:19:06 +0200 (CEST)
IronPort-SDR: 6495c5f9_ufQziyAQM9GHIUq6Ig5eq0OdvoOBPDXR9KBm3FfG2KF4vZV
 wld8QQwKYCQLBpC2wgsRzYN8t1V6Chym+ufKNLw==
X-IPAS-Result: =?us-ascii?q?A0F6AAD0xJVkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIydQNTMAQLRwOET4gdiQcxhDaOd4hsgVaBQD4PAQMBDT0EAQIEA?=
 =?us-ascii?q?QEDBIFLAYJtRgKGBgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAUBAhABAQEjFwcOECeFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgINOj8BAgIBIx0BAREmAQQLCw4MAiYCAlcGAQwIAQGCegGCJwEDD?=
 =?us-ascii?q?iMHDa9pgTKBAYIIAQEGr1IfLCJVgV8DBoEVLQGNMIM5eicPgVVEgTyDBD6CS?=
 =?us-ascii?q?xcEGIFGg1uCZ4slDgyCaIM0gjEHjAGBKG+BHoEgegIJAhFngQgIX4FyQAINV?=
 =?us-ascii?q?AsLY4EcUjqBRgICEScTFAVOeBsDBwOBBxAvBwQvCRYJBgkYGBclBlEHLSQJE?=
 =?us-ascii?q?xVBBINYCoEMPxUOEYJZIgIHNj8bUYJoJQQOAxkrHUACAQtwPTUGAwsfBkICK?=
 =?us-ascii?q?YFXMFZwCiQkoE4DgyOBO4FNxQU1B4IwgVuBXQyKE5UJBhMvg24BEoxshigOB?=
 =?us-ascii?q?pIviA2QDSCNO5UshTKBYzqBXDMaJIM2TwMZD44gGYQOhGGKKAE+PzQCAQELL?=
 =?us-ascii?q?AIHAQoBAQMJhUYBAYYAAQE?=
IronPort-PHdr: A9a23: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
 cIkblbSSE0lirecRUxh3SXqNgxfKcZfpiG7QA==
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:CJd/YKnoPMoWueNgiQVtXSkfxhHpDfL43DAbv31ZSRFFG/FwWf
 re/8jzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK7/oSizPIdurIruPmzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:l58qRWDNie1ZFcH6Exd+ykovFswAS0zAkVeOeVGyVTdlc7LAHA==
X-Talos-MUID: 9a23:ISB4aQjLS06MWAlqch+DisMpMJswvKOwOE43odYssNvaDz1POhnag2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,152,1684792800"; 
   d="scan'208";a="59673353"
X-MGA-submission: =?us-ascii?q?MDH3uSQ8dt0mPt/xp4r/LJocBJrMWmOhf8w+vA?=
 =?us-ascii?q?Gs9jG0n7QX3LjnhxZ2NazvXjojFKm3cxKqvEv6Kw4pyYyNhVE9fwldnZ?=
 =?us-ascii?q?ssgSzqgRp0C97Y8u2bw5uN6QjvhxfIMHZATzhGEB09N45RVDm1vf0FEE?=
 =?us-ascii?q?Gz0bLMSL2r9czEqrCtiDt8VQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 18:19:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687537127; x=1688141927; i=markus.elfring@web.de;
 bh=RivzCzq+1xqrOllNDd5eWdrVBtj7Lmy0XMs3oB2UXnc=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=C+7nC3aY15Ju+QIetjdUDJBCDPpSDskdsgrkncpofgbYf6ybRkRoOotANfnMMC1pDQYNegW
 NNxhfFpdVVd0TXMM/9IiKyEMDdhJIR2IB9RF7mWy2ycruMtmtHcdPJyP6UPItQGF/gGSYYvI/
 rygjh6i0qPFv4poexnT6ETyinwd3tXiFPNtepF5ZCYVYzwziG6P330WhnqgrTmOAum896WDB7
 d9WFPhAPkQHpNuLq+mXQoRBDUtdc9PSWIvpzXTZL2+I3rxwTUVcMqsvLTuwa76VHxD4jY8jBw
 x8JwYtS2Ts8ZfM7Ryz8DAZd7qqySNhEDcL7XZN7OcmKgLFfHJVwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MN6Bb-1qSsle1T7d-00Iqgm; Fri, 23
 Jun 2023 18:18:47 +0200
Message-ID: <64741e8e-e81a-afb9-9ce3-9c2d6baab44a@web.de>
Date: Fri, 23 Jun 2023 18:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Ivan Babrou <ivan@cloudflare.com>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230623043107.4077510-1-irogers@google.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230623043107.4077510-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4/TntcMwu8AYIso6H+80LQyrYw5kuMylmQ2E+rXFbWAOJ+V3he8
 wPHVGSBPQvT9xGcghPI6xDN1O4jQ1bbR1DPB/6IOfVyW/QS4yGGz3jCNLNgCKTbdliJVhr7
 HxrlYNGZe5qdAREh66KKoYxZqgLWEa6b4ppwTOb6rem6C7WheCq7n7J15GYG2AByx209gew
 wwMiErkUzFHIWO36i1j8g==
UI-OutboundReport: notjunk:1;M01:P0:mcAhsYWdE20=;T2FihewSW14L5sWEPblZjZcsPjT
 YJ/adcsep6up7G/HHhBI5tiNCq+7BfiYYJEmFdL8YLTzQSKQw+tLjFbeGQdNcv0N1Ifc+eOTj
 XLqXGNl5UBYXgku2PsARYvG7hQrCYX0+Gcr8wg/oGr5Ebkb8fTI4woQT56RVqhTHEhHNyCW+U
 D1ZJtJ9oTe/iCWOyAmiZtdPirmeEY3FdNMEvOYy2OK1NMlO15bDDj3bfO0cW3qg7X55zMJyTB
 tq62mxPGFRti0FNbfjVQj+jAEUxNAY1I99EFw079rGl5ff/bKwFNucCuN5RxoBNczU8QjcjlT
 PHdGUyD6AGCgJP5x76lxcsxY/+PWSA94/FWuup74RYGPw4HfZoGoHr8OlGk41IUcPN2I5xXTt
 A8+7cu88+IAG4vKXGI63Yf2urQVmBQ6J32BDTA8G+oWWzRw4XX0SnzTS9fac6vhxKn7hrOLIC
 rnmdaR9XYGECDqm9Qbp74aqbJxyk6zip4vXatPa3v6R6Alko8EAtYRYzyhARrBpJMxu9hQ48h
 mn0pSMXkwripYt88aW9JXf9kO4aTD9IyFu7NvCJE8j6zPrtz9q6r+7rgu4DgMUSs7a230XxRM
 AeMbR2Nn6tgB3LEQFcMizjmWJTKBbqyncDiEwpMi6T24f8lnoAnEief51impiv5f4TkUubQVV
 Y4XkF3+F4rrQICSDmRSkcWevPzLq4h66BYuh79gfNZyZQ+RDuascGEc7eR1NrkEDCw3Wk7DTH
 QGarvJ5ugj9ni/Zoz8n+9OThob7BwP+14rBk9EzZv5cPkxajt10Y3AwWtYmQiyj1gyvHCjF5x
 61mnQ+wCckVmbrc91+PhdmX12ZTBhBN3VQul3xM45Bh2iw4f6ZuEsBlqbCqfMUTt8swnTkb9w
 FH4gIubKcItRKv9ndKdRvehYxLf96P8SegSMmFT6+LwuBllV16h2NkhRXyBWL5G3oZm2WDZWV
 wGUHrLJ3wqghijSMT82XYGO+Pv4=
Subject: Re: [cocci] [PATCH v2] perf unwind: Fix map reference counts
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1210
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/64741e8e-e81a-afb9-9ce3-9c2d6baab44a%40web.de>

> v2. Add missing map__put when dso is missing.
> ---

Please omit such version information from the change suggestion.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4-rc7#n698


How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus
