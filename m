Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AEDC46CD4
	for <cocci@archiver.kernel.org>; Tue, 26 Dec 2023 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=fdcXnpzpVCarVNotSaPtKCaabFq1lENmeCMZqPdDnJQ=;
  b=u6b8R5+AI3q41wZeIgNlknUTmHYDP5+Qnh85ZUscwhwfnipvdUVrmsgo
   T8COYIq3LcjvqdAJq06jABgsU1fAra3fmRYU6GzJDsoOC+q7dyrQZwNWW
   cFyradvrafLQDkHY1TG3ipjnOhSSmFE8ZZZBnlp9Risj3l7x4mwt03EH5
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144033177"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Dec 2023 10:36:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1EDCBE0CCE; Tue, 26 Dec 2023 10:36:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CC39BE004E
	for <cocci@sympa.inria.fr>; Tue, 26 Dec 2023 10:36:37 +0100 (CET)
IronPort-SDR: 658a9ea6_DFxZ66mtoHMDOQTsaBKOdwqLlYw3DqXNSS0EwsjUHRPWq/T
 /RPBqlBP1mY+gMJ4osBebk0H8IC77DTwAp4EYRA==
X-IPAS-Result: =?us-ascii?q?A0FdAACrnYpl/w4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYI4B3hTMgQLSIRTkTaEa4c1h0yIb4FWFIEsPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ3AYRHhzgCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QKBBhOFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR2sdAQERJgEuA?=
 =?us-ascii?q?QUCERUCXgESAgEBgnyCKwEDMQeuY4EygQGCCgEBBq9YHywiVoFgCYEaLgGIG?=
 =?us-ascii?q?gGFZ4RiD4FVRIE8g0GDfIEGgxyCaIkcBzKCHINPiiSHNX0EAUFwGwMHA38PK?=
 =?us-ascii?q?wcEMCIGCRQtIwZQBCghCRMSQIMwCn4/Dw4Rgj4iAgc2NhlIglsVDDQERnUQK?=
 =?us-ascii?q?gQUF4EObhsSHjcREBcNAwh0HQIRIzwDBQMEMwodCyEFVgNCBkkLAwIaBQMDB?=
 =?us-ascii?q?IEwBQ0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMUANsHzIJPAsEDBoCGx4NJ?=
 =?us-ascii?q?yMCLEIDCQoFEAIWAyQWBDYRCQsoAywGOAISDAYGCV0mBw8JBCUDCAQDKykDI?=
 =?us-ascii?q?3QRAwQKAxQHCwdSAxkrHUACAQttPTUGAwsbBj4Cpkt7E4J2xQE0B4I0gWCBY?=
 =?us-ascii?q?QyfKwYTL4NuE5MlDgaSVJhNIIIxphWBZQI5gVkzGiSDNk8DGQ+OIIQrjwkBP?=
 =?us-ascii?q?UA1OwIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 XE=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:4oknoqoZPJFMc6hZSvrfSFIaV5rzeYIsimQD101hICG9vPbo8/
 xG785rtiMc7wxhPk3I+OrwX5VoJEm2yXcb2+Ys1NuZLWvbUQiTQr2Kj7GP/9SIIUSXm9K1vp
 0QFpSWZueRMXFHrYLd/BSyFcomzeKK6aaymI7lvgxQpE1RCp2J9G1Ce3+m+6BNNXF77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:SQTDs2+JlDx/FNeLC/2Vv20FQcF4b1Dk92+KDxKkVkVDdbmpEFDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A6DPr4g/sPuA4vP4trykw2VOQf5tsuJmPIUQArZ4?=
 =?us-ascii?q?HupWCcnJ7Pz6Xvg3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,306,1695679200"; 
   d="scan'208";a="144033173"
X-MGA-submission: =?us-ascii?q?MDFy71ZEfCPZfSXTV9WYh7lMjTjy5m0a7EyJxa?=
 =?us-ascii?q?QZpuVFlN5l7r+KXMR8B1u9yCJaowtLHn9PiqoRibf1sEuUTfH1G/T5yG?=
 =?us-ascii?q?s3FBxf2S+f4oCgMCdl7fooxkay9B5MwjfM1z9kmxVBo52QT2Kvkwsfhe?=
 =?us-ascii?q?5oHdiFMP1y5JKEHssA0CAhMg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 10:36:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703583379; x=1704188179; i=markus.elfring@web.de;
	bh=7s7Czem3g9WjULia5nQz77gt2Cg/2yiGOV1liYLC2qQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=RKGJQpAKm5ThzCXd5Czxs97SHfHgJy6K1Fykn06cIGR/3Pg+EU1Wko9eBf8kX3Ac
	 hHHAvx7MUOmqxeXvI8PiLIQEGgpmHqXUdFH8iSYw1OkCvbJzTtsHe2EiTJcuW85Zt
	 Rkjt78lwpJPItp3tPq89lfUZBqc1crSuVKsxtuIHrHv4ppkd9EIg+npdyFUE4Bbj7
	 q7JtpSEgqWxw293DsBBjY+MDVfkfT3KSscm3nN60ZdyLX0M7NwMJrl1zFiWExf1CX
	 Ny1zjOTckSOmTXPsoJQ8YakpWQKR2MhIgcbHwYYdInPdkMi6DzHgXj50wfZmllFT0
	 F4WXAmaDTrMRKBNNxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhnu-1qs6RZ3Cy6-00jyS5; Tue, 26
 Dec 2023 10:36:19 +0100
Message-ID: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
Date: Tue, 26 Dec 2023 10:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DcL70u3CW7ium0TLeQa8v3pqMAuHd3U3ffavREKGtKtoIotqohU
 vVm/sRhXjJKwXOYQ9pFWJucZSe+994yhW2o0ijsxi6iHZ/Q0zgliCRzPJonYzGsCVBbzBz/
 0zNekbaZqRGP3FS8eocU6giczTt17vn0lz2CUyuIihbAwCRdssrlhFRRrdRUfkOPsL5/oRF
 eZxsilcj30qz1vpdWDsDg==
UI-OutboundReport: notjunk:1;M01:P0:O70ZNeseb0w=;E0IpgcOt3k0QKhIiPQyi/vzDRWf
 mJZZOh16XhhSfBHeGgCmmmSiX18pqy5Y6qilWjUOu6W+eeB9zc0h1HrD/pj+eLl+ZJtzGZo8u
 X2N60+S+57ZGtHEAj8m7jwQ4fJhydvSb4UOkfcy+1phgWNSCvg8QD1zdOas7hKjEcn+/ak49D
 EFtFNq/8G/V5y/hLLfc6qlCOHcj+iin08EsToosg8uhKfbYZh4UqOy0pN+1ewI7cPHzN+Rq3i
 XU1ZYQnUJjR0Ht7/enF2mFPy0b3pZmlED3I0oqwPbX6Y3xjPH0qgP1MfcjipvcRMhrLIFQaAs
 9ry03jYhcLfmHUpWJ9Am6ihqpODTvlwL93ssMk8UNPj0SAOhE31mCi0MTHhbY1hfyilozzkKr
 tM7K0+oBzCKRoIRU/oajPIKE85DLpOOP1lpYnjYb+waX+WliBfIBDYe830X3Aico/KAZOWqHc
 KZt36PIdoXSLYqBH7QSabTDUTJPT4a/mzNNZ8kyssSEIJh14S3MSXuSRTa+SNQW1Lpqd8q+qv
 LtGEwnyhJXdDA5tLZytgBuiitLXw8CB7MDxP8xFkK+BeBniJy0XtV6ryxwpLtsgaoT6EY+DCw
 24OtmHsVgtC0U/iQGZW2hUVoLgHMi8lozuzrRQe9sOfp02PS3Y4TR+rs2ZTdS7bzvVdiurtAz
 P+WV4tjbtPXAtwS/iaSJjdxXy8ghymm25A8RlXDOjqN8PPOOx208Jexa+5cgrOXvU/y8JgCmb
 hvsoY8HvqmgIIFOaOwaSNVpYBWGrXguJUcCWy6H7NbAPqG2/GDkN0YywnnMeaVD0QLrG8RMaA
 GUWsH/0wFqaxoe0ml3fqEcLm4g1OQb+8kmrjTu+2eEWuUWe03rdNEHjCWxQABxmJb1NkZITbg
 AlWnI89SchtGPGkdwUnbbWeOXWlxUF+5DSGdz35lxgCvVmnZxQkFnkJL4Rn6x+n/PtGrovMtw
 n5Ur+A==
Subject: [cocci] [PATCH 0/3] drm: property: Adjustments for three function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1393
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 10:26:36 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  One function call less in drm_property_create() after error detection
  Delete an unnecessary initialisation in drm_property_create()
  Improve four size determinations

 drivers/gpu/drm/drm_property.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

=2D-
2.43.0

