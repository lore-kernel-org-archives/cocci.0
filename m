Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0BFC6FD18
	for <cocci@archiver.kernel.org>; Tue, 28 Mar 2023 17:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MLcjaa4lpVvr4uNkuSAdhId1B2Ebiov3TuHexpwXZ3Q=;
  b=r8/FZ8xqlLvivvEhdppRqRsdlYoTF+pVRyd4AzROnMaMF8mT/x1aA1+N
   8WGCB+o4udU4JRwQJrYFQSSuiKIcb3PgXyxpq/spm0aSBjPlbfeAWBDCp
   0bMwykq6JAi94/4CUClERt349CqapccSpTkgNAS0u9nCZfXEiD9yRio+m
   o=;
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
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99575950"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2023 19:13:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E7EAE0D4A; Tue, 28 Mar 2023 19:13:16 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 46B4BE0D40
	for <cocci@sympa.inria.fr>; Tue, 28 Mar 2023 19:13:09 +0200 (CEST)
IronPort-SDR: 64232024_i9Ee1yi2edJ8ABikr/glrnMvSsh5Yq9J+QZUAusfC1Vj/rP
 M9yf3FX0DMD/eC06O2JAL5iPMZX/CKJyFmCmvfw==
X-IPAS-Result: =?us-ascii?q?A0E5AABFHyNkhwQP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPgMBAQELAYItgUsvBAtGhFORATGEL4cshzqEZ4QCgWqBLD4PAQMBD?=
 =?us-ascii?q?UEBAgQBAQMEOIRGAoU5Ah0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBAEBAhABAQEaCRcHDhAFIoVoDYI3IhlkgQgBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARICR1M9AwMjHQEBESYBDx8GAhEVAgJXBgEMCAEBgnqCKAEDM?=
 =?us-ascii?q?QevPIEygQGCCAEBBoJjmScfLCJTgV4JgRQtAY0EhDAnD4FVRIE8g0GDfYEGg?=
 =?us-ascii?q?xmCZ4IplxsKgTRzgSAOgT2BBAIJAhFrgRIIa4F8QAINZAsOcYFKAmRMgSAlB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGGzQRAggPEg8sR?=
 =?us-ascii?q?A5CNzQTBlwBKQsOEQNQgUcEgQ18CgYBJiSdU3sTlU6SQJ4ONAeCKIFVgVkMn?=
 =?us-ascii?q?wwGEy6DagESkwsOBpIjLoctkA8ggi6lTIF5JIFcMxokgzZPAxkPjiAZhAyPS?=
 =?us-ascii?q?D80OwIHCwEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 D3GxkDNAw==
IronPort-HdrOrdr: A9a23:bwbvxqsYHmeGDP1wGU9t4BJZ7skDotV00zEX/kB9WHVpmwKj5q
 eTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99575946"
X-MGA-submission: =?us-ascii?q?MDHpxNEN8jq/2YdwB5KjmH/vSLtVd698f8Zm70?=
 =?us-ascii?q?QQSfI+Cur3a7JqlGsIn2AbUM4TZJak7b/YBg8Jo/SrmMWD2IMibQBpye?=
 =?us-ascii?q?ZMoKGic8YyU8S7ucaBRCp9OvLSuWA5MLlfp0nVgNKm/5F/jsPJ7IewGV?=
 =?us-ascii?q?YSILHXD6nOKdDDxTV8/twssg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 19:13:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680023586; i=markus.elfring@web.de;
	bh=nYhzGGjMdJCGlzpUo0wwCbY727bW/FztOWOymTl0qCA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=uv7akqShr0oyKioALiUu6AcnpB1E4oYnHTQy02ACDWLxiKhzoADWFGef1NF2QZtpl
	 mf8q5P4jma7w4hBkBiWSquzxuRiB6tI6dqcFcS3MHq5Bey5f6v9IOQQKHRLcCCkGbW
	 xXbVDGveVVL1Y4bitj6UFey4OpPNUBgGidInTjwllIPqGQ70RNBRw9AQHh6BTjQQj9
	 5ez2uekroVZw/lpPYdovzEbQzfvjeTXkIgW/IwuUnMbIDxViLg3vYSdxi5+WUhGx5Y
	 kDM58BoJaa1GwIlabMjSJY2NamSj/twhoiPzpR0AJnwg0hz9BpD6aPgOdFmWFt0dHL
	 K1WSbBYLRYi3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNwfU-1q5V4E0tQm-00OFFu; Tue, 28
 Mar 2023 19:13:06 +0200
Message-ID: <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
Date: Tue, 28 Mar 2023 19:13:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Russell King <linux@armlinux.org.uk>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1DDixNHUcmujZ/QeLIdvL+TUPNRyTtX9VXi1iCfkrHHbXknPVrD
 IbVimJQXhCKcr5NElhOjQZS5Qocd67JMN5B4xAzFbQ5rFDRPy2vd5q/I5Ml8xwYGQqmQpHW
 mM6f9YLAoM48X5QWbKji1h/xdnDp6UD1QE8XT2CaWXMdPk3eQDEFsaRuQbD0BjOWbxQtt63
 8R08pWU6DK2zxXqLtF9HQ==
UI-OutboundReport: notjunk:1;M01:P0:kzrYMyFeu+A=;5mA7fGfqxMfaRh7laA1ZdDFr9+d
 P8KP6I07QmASSbcZpBUEf7reLP95WzfY525nu0x1OVG1WfkPuQAb4GEY6JclZaafH6B+wPjAc
 ldpomQoHHVpkqgjbygdF+9A8jaP4G+63wXlz059lFmQcywLks+ECcX+y+Dyhb6eIubJSftkqm
 6zOcBJrseA/1PcsX9ILbnN1PIkA89Du/PJ0IEjnRKBYVoYR9HJaK37ZbD4mZzr0gIWZCfovCc
 Iwpcr8kbBY5N1kT/Pppfs3qW1/kUje9VVHmHWa95Elz5M+4Q9VwsdE1X0QkPv2BkBzHObT8Pu
 s+3LOijxMixqHIVeJhAEO2/7HddZo+0gIqgCFBmpaPOdMdnLmpF01R4yQJ/Z7rANxbYq7HvPZ
 HlPIC8Tn3c0lhYQ+BpT/IL7GMZA6yvFrA+oQL0g7DAI3i8n5d9PkK23cAZT4c59+VTdl7pC7e
 eRY/298fPTKRYrIlFRlWe/sUc5SeIzQN5LPdXgIo/mPJR1jGDqsK4zpHRpr8yrflFNLHYu6xK
 K0ECGl4vJo2vmlr5fmrrizhpWbiIounviI8spemi3ub/sK49PLtjIoJpfRm9HvN4bLnxSoALS
 Y9wtsg3CifwxFQDilnkah7CEsNwsC6wZdziWBzA9C3HcXJs0Pubmi6ln4byTwGA26nRAf/xKg
 ErB/SlX6Jh9PCjCcH1760x3CGefrYhxW6PN06f1zVn7S1wNjx0Cr9kv9UxTfC8ep0jVcxyK6N
 BMDFrcGhgbeqwcb47RR+jrjQKDvl2DBWXoZ5ohkOOpzbE7BGaUvgH5FfbTV8osamf773oA/LQ
 9e2+oAgepDmexL92OLgmasyzk9FultRLpMRyqyEtZyoV4UQX9HdYw9PyMEBFHBDaLDQm5tB4t
 L6fOY2oLsE/OnsiLKPbo0v6fm97kRKve2YM6LyXUGx5lPjixfIC16sPEL
Subject: [cocci] [PATCH 0/2] ARM: Adjustments for init_atags_procfs()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 971
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/562a6f99-3f8e-9a77-e519-b668e24dced2%40web.de>

Date: Tue, 28 Mar 2023 19:06:32 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Return directly after a failed kmalloc()

 arch/arm/kernel/atags_proc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

=2D-
2.40.0

