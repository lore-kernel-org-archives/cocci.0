Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678A7EB64DD
	for <cocci@archiver.kernel.org>; Fri, 23 Jun 2023 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3JZMNSEq1OL4SeWzjhHzYJL17EjsXMKUz1nMTamSjrg=;
  b=O1PVZ41PMpUcm/uFI//00sb5iyEcPYf7d9ty2godcVPASlTLkwg00wyO
   Jsx0hpKC24rU/DbSccacSYBhEDc07BbmqE4l2SqnLzT/hkgoEg8sUDHEB
   zXwdhcwmOnKhSZmA9haxlX/3Wg6QIr0VUMfLHk2PMextRnLl+BPHd6GaR
   s=;
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
   d="scan'208";a="114381153"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jun 2023 14:24:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 32528E0A8D; Fri, 23 Jun 2023 14:24:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7ADA1E03AE
	for <cocci@sympa.inria.fr>; Fri, 23 Jun 2023 14:24:03 +0200 (CEST)
IronPort-SDR: 64958ee2_/c6g0kf6UwGx8gDgoajKExsG63P5+9RKGkN53ZLesORJqT2
 cyEwqTnjE5xGNNzsm/Kxw/LIo9iA40S5KtIuJ/Q==
X-IPAS-Result: =?us-ascii?q?A0F6AACbjZVkhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIydQNTMAQLRwOET4gdiQeEZ453iGyBVhSBLD4PAQMBDT0EAQIEA?=
 =?us-ascii?q?QEDBIFLAYJtRgKGBgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAUBAhABAQEjFwcOECeFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgINOj8DAyMdAQERJgEPCxoCJgICVwYBDAgBAYJ6AYInAQMxBw2uB?=
 =?us-ascii?q?oEygQGCCAEBBq9SHywiVYFfAwaBFS0BjTCEMycPgVVEgTwMgng+gksXBBiBL?=
 =?us-ascii?q?BqDW4JniyUODIJogzSCMQeLdIEob4EegSB6AgkCEWeBCAhfgXJAAg1UCwtjg?=
 =?us-ascii?q?RxSOoFGAgIRJxMUBU54GwMHA4EHEC8HBC8JFgkGCRgYFyUGUQctJAkTFUEEg?=
 =?us-ascii?q?1gKgQw/FQ4RglkiAgc2PxtRgj8lBA4DGSsdQAIBC3A9NQYDCx8GQgIpgVcwV?=
 =?us-ascii?q?nAKJCSgLwODIYE7gU0NI5ZQAZkdlGc1B4IwgVuBXQyKE5UJBhMvg24BEoxsh?=
 =?us-ascii?q?igOBoN5jjaYGiCNO5pegWM6gVwzGiSDNk8DGQ+OIBmEDoRhimc/NAIBAQssA?=
 =?us-ascii?q?gcBCgEBAwmFRgEBhgABAQ?=
IronPort-PHdr: A9a23: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
 chWIoI=
IronPort-Data: A9a23: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
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:sVEKC6o9tJ90s02c44zwm6gaV5r/eYIsimQD101hICG9vPbo8P
 xG785rsCMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW3bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAbmSS5vyKgjVQfexB/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:ZVqtoGxn8WiU9l5qmVNWBgUtNe99V3zXlUvPHF+mTnhpV6GqVVWprfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AGHntSg25ncgiXKNMJ1LLkD3J/jUj+4r+J3Irtsg?=
 =?us-ascii?q?6o+qoMCN8BgzMnQSWe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,152,1684792800"; 
   d="scan'208";a="114381113"
X-MGA-submission: =?us-ascii?q?MDH4Xb/ZZGP/ObStm2U3NRWFCr1fFkcM+D9rLx?=
 =?us-ascii?q?nGWwshK175aRsIfSCRbEJYGcf1c427kBnlckv5T2oopzUWa7PjuG+AhQ?=
 =?us-ascii?q?f9qcyESNRBFCwXq8p1rJ0O0x5usj4sSSNMaNWSHnzQXyf5LLEVexfIxh?=
 =?us-ascii?q?Tr7bL4Qejtv+wIU07DezbXfw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 14:24:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687523033; x=1688127833; i=markus.elfring@web.de;
 bh=Wlv+XOhNkQT3fz051q7kVZTnAzFjg8f6i61p7Es+b/o=;
 h=X-UI-Sender-Class:Date:To:References:Subject:From:Cc:In-Reply-To;
 b=rxI1jJkS7O8wbQtAYraaxDP2gTD2agpuM2XnEhdumeO7EQBh6oK6hOtzq6LMUKnEcjSD0pN
 5HjISyyJzt9U93evRKSg9j4FSBYedwXCEVncD9aTNHrUCrIkMe0tG45HSjXQW3FulLh61yak8
 SEg4Y3jahn6EJvatYdEVN2RF6xXD79zNI7iKBdKrRm6pYByzZ2awsH7f3bIrPdIo4bnlU/+k+
 PqRhCmpedsFCR2O2lLmNUyB4CL6AWYeWsXQiNPo0PIMxz3RDF41EQIytxWx8T0uyF43zKgzS+
 1uL1GTHOzrKV+vpSVLgfnVmqmaE9a+tDUoVtpC+sS+dI7atA55aQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JF8-1qFPeN1QmA-002wg0; Fri, 23
 Jun 2023 14:23:53 +0200
Message-ID: <1bfe9150-d27b-9541-adcc-70d2095addc3@web.de>
Date: Fri, 23 Jun 2023 14:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20230623074123.152931-3-radu-nicolae.pirea@oss.nxp.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Sebastian Tobuschat <sebastian.tobuschat@nxp.com>
In-Reply-To: <20230623074123.152931-3-radu-nicolae.pirea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aOBHyxsKrS352E2mDrJvmpxbgfJGLgaMiyWGnR5B8JZhZznDEAM
 X2we3i8a/ycxQVXGlJp1ll5zJLRex2w9VjXVyDqIJmc5SM/4pqReCaA4xfXS9XBnefJ3/Ri
 LG/q+4NMllHAzAd3ruROEV/JTxeIgxZ7F1yRHeMnMMtStRpKcrvXrF/hpG3hxJJW5Y1SxcY
 MYM0w3j69fsDCjfNjh/Bw==
UI-OutboundReport: notjunk:1;M01:P0:RgxsYWCoLeo=;19zlArWw7IQcb4Bq5EqtzGlcgAc
 UIZKVCWnxMCDt1HEW3ECAZrvy2ac0Z9Euu8FschZcO3E26Pp5qMXpkXE7h31LE+rXkwNiDtAt
 XoJenxZMSSVHzwKrSlKh9FqV60fiVjKEpRAeFwB6UxXAwfHuhxrT73UMZrL1MVJOt0zl6eXgk
 PMQQTpofV9DaszgyKAcDdx1mV5hVv+rZGYrn6Ie/+bkoMfBLN0NLRbxhf2iND1mRpfO+pcRQZ
 RMUodVOcFmK0oV5omOdEJWandO1qG9L2vrk9hFKj4BUmrTtmYMUsQ3rdlhdnncDkvk/A0ue1j
 FpgL3IygXIubCdfdqhLQvamc/Bb1UPjsUvhTvs/P76ECnzyC5YKuRZTZu+D0Zbu5n0Pg469eV
 mfk312oqIaAGXfT7NH4xVI3ryjeI3dlBvNWRk+XhXqr4/adKZNdWSlaZiPhrwpJLUswd2H7Qb
 WCyVmTqDpJfBEaV4ozYsXXCJq57CNriGJLd7iHdnbgu3J7O8YsNIqnlYW5PbkPq5+S3P5ZgrN
 f/GGJwt9uMSols11dcyV1qH7Abc/vetdoeAbjg9Ih3W/Jh0KLSVCRkuYPddZa9ayPavcVEi0J
 cCL9RN4W79BotWvBkmYVu2+Y5NmaWrH//dSoMCMWFfimJS/ljC/ORWZgA5zm1YA6m+5Y/u0Cj
 infnYurRzgstatFaA4wZVpIVDhNzAzeXWLjOKRjyQyZkmkvKGfqu2jB4EOj715yjR8NY80b96
 VkppYDnupHKA0XldSQkLkgNxk0wZ3nXeqbn5YsFucHMJPal1GVruIkm7laT8KwHIPppk2O7Lo
 C5cxcReyOBzYrYGtjiptTHCG3Cm0AaI3X1sIcHDg2iwEEEZowuQuP1KvJLhF07Inq7sJT9a2T
 zThmeomzK6uA977OA1mChuQnwMSvKJoJ4YB6y083njKLiAWKeDaa9MoQAXtHLMS6OBiR46pGb
 R1qdIMnW6MpJ9tLu4qxpeF7gVVM=
Subject: Re: [cocci] [PATCH v2 02/13] net: phy: nxp-c45-tja11xx: remove RX
 BIST frame counters
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1208
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/1bfe9150-d27b-9541-adcc-70d2095addc3%40web.de>

>                                                       =E2=80=A6 So, they=
 don't
> provide any useful information and are removed from the statistics.

Please choose imperative change suggestions.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4-rc7#n94

Regards,
Markus
