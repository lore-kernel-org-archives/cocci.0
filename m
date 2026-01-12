Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F546C9EC7C
	for <cocci@archiver.kernel.org>; Mon, 12 Jan 2026 12:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+TYJdP+0voSY4YMGGwNqz4sVZPOyXTpC3AYF9DYNOS4=;
  b=dgG3hlnmfNgdKJF0ExGJGn7GnttDBkYVLM/Q/6+owO71ZsPsVjSDqeCx
   FqeEg+eSu24TlNQbUDW1s3k+KT6TauacJ5Mph3DOo4YhhRp9lE6fGdBv4
   dbHDoHhtmPaVG8KihM2m61fQ0q39cKXmHIs5IE9jMRJiAkywZM9z9C0Hi
   w=;
X-CSE-ConnectionGUID: pAWcGCP1QP2lwqmT/pbkTA==
X-CSE-MsgGUID: kVQcFUzgRWCdOHkJq1FLRw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,219,1763420400"; 
   d="scan'208";a="258124871"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jan 2026 13:31:17 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C7C3B8298D; Mon, 12 Jan 2026 13:31:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A020282965
	for <cocci@sympa.inria.fr>; Mon, 12 Jan 2026 13:31:10 +0100 (CET)
X-CSE-ConnectionGUID: UaLTEbZ/SRuM/Simk7EW8Q==
X-CSE-MsgGUID: wQCnDMQpQIak39vA/CiQKQ==
IronPort-SDR: 6964e98e_7fZN8BnRkvgB7hv/r9/JOj/8KKkr1kpLb011dq8MPPe7Uh0
 pzmJnxGGE924x2u2JLy87DCd2WUFEhTdk88OeMg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FEAAAs6WRpg07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwHAQELAYJAaB8GWTMEC0kDhFWIHIc3giRpg1KPEYRwhAmBVYF9Ag8BAwENS?=
 =?us-ascii?q?gQBAgQBAQMEOIFUgWBORgKMbQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBA?=
 =?us-ascii?q?Q0BAQUBAQECAQECBAYBAhABAQEhGQcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAg06RAEBAQIBIx0BAREmAQQLCxoCHwcCAlYGARICAQGCfgGCIgEGEAEDD?=
 =?us-ascii?q?ycHDatYgTKBAYIMAQEG2mMfLCJZgWYDBhWBCi4BhW2CZQGFbzuDQ3onD4FVR?=
 =?us-ascii?q?IE8C4J4PoJKFwQYgUaDW4JpgiaBDpQZUngcA1ksAVUTFwsHBYEjEDMDIAovL?=
 =?us-ascii?q?QIUDQ8BEg8EFgUtHXAMJxIPHRcTH1gbBwUTJIFCBQEcBhwSAgMBAgI6UwyBd?=
 =?us-ascii?q?gICBIIQe4FmGw+HI4EABS5vGg4iAmACAQttPTcGAwsbBD2QIoQAASuBTcctN?=
 =?us-ascii?q?AeCOIFngWQMii6VPwYTL4QEk04OBpMFLodlkHMigjaJN4F6mziBaDqBXDMaJ?=
 =?us-ascii?q?E+CZxINMAMZD44hGSWDdYRgiioBr2tCNQIBAQwsAgcBCgEBAwmFRgEBjFaBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 XZJh21N0URvYYxtTZE=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:iJ2zL6/Vx6G12FUtGahuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:8LP/QGPE1xMt9O5DZSBDyGMeKIceSGD4i0zRJkznJFk5cejA
X-Talos-MUID: 9a23:WzNeugQb+O9Vy5P5RXTzvRpkGOJR+52PAUNWwIsv/OKFDA9JbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,219,1763420400"; 
   d="scan'208";a="258124781"
X-MGA-submission: =?us-ascii?q?MDGUrPACQhMn9iK1Dek4SLnWYmaIAPjSNG/ssA?=
 =?us-ascii?q?Go01QHsXwEdN+pyjA3hSOf9jHkuRXcXYCR/r0mx2DBfKkykC2183s4QX?=
 =?us-ascii?q?r/xgPLLDjJfKM6UmbQHzGVlmezFYfJrV9+nal4b0tm8uv98m+YEXCun8?=
 =?us-ascii?q?EoLFJkkfXwgdP4ICqX6Gu93Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 13:31:10 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.241]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5o3-1vWiLV2XNR-001j6Q; Mon, 12
 Jan 2026 13:30:44 +0100
Message-ID: <34ed442d-6ebd-4907-a77c-2c08db799411@web.de>
Date: Mon, 12 Jan 2026 13:30:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Can Peng <pengcan@kylinos.cn>, iommu@lists.linux.dev, cocci@inria.fr,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260112032116.49781-1-pengcan@kylinos.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260112032116.49781-1-pengcan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9vd73EM2EVYwZ/jTJJySINMtqqeXYRo+qHK9ycIzOmpWHbPZW7T
 IPtCAjppJYD/BX0XlbOXY33iMVvINz86Q3lowmFxdwJG792WCzqjEUSoqopR5zeurM8Sy02
 fmqKtjKRrg190ucVvgsCwR/2h0alULJ99K1P2pEDoyR3aQX0byCsAd6LqpqkW5u2yfV2pBs
 FWwodPm+Ht6I2lVjRECLg==
UI-OutboundReport: notjunk:1;M01:P0:y6DeUF/OvYU=;iEIzVPL9ty/VONNohzeO6htbGQE
 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
 1ta6Yg080bHWvQVpnaQFkHp7d1QRl6iaw==
Subject: Re: [cocci] [PATCH v2] iommu: simplify list initialization in
 iommu_create_device_direct_mappings() and iommu_group_show_resv_regions()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3269
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/F_m9H2qL2kPUEUo1YAfvjA>

> Changes since v1:
>  - Extend the cleanup to iommu_group_show_resv_regions() as suggested by
>    reviewer, applying the same LIST_HEAD() pattern consistently across
>    the file.

Thanks for your interest in further code adjustments.

* I wonder how they fit to the feedback =E2=80=9CApplied, thanks.=E2=80=9D=
 by J=C3=B6rg R=C3=B6del
  from 2026-01-10.
  https://lore.kernel.org/lkml/stpavkxy3sbevk7zmt4kxyecqy5gc6phubvcfutbtnu=
k7vphlh@a7aimtvk423i/
  https://lkml.org/lkml/2026/1/10/235

* A shorter summary phrase might become more desirable for this patch vari=
ant.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.19-rc4#n687

* Will development interests grow also for another transformation approach
  like the following by the means of the semantic patch language (Coccinel=
le software)?


@replacement@
expression e;
identifier i;
@@
-struct list_head i;
 ... when exists
     when !=3D i =3D e
-INIT_LIST_HEAD
+LIST_HEAD
               (
-               &
                i
               );


  I determined that 175 source files of the software =E2=80=9CLinux next-2=
0260109=E2=80=9D contain
  corresponding update candidates.

Regards,
Markus
