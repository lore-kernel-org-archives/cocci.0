Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36D2C369CB
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bJBRZaSgchliWw4wWLkLEWuwp3nk6zi0pApkA4ydaQA=;
  b=dp4fYZkPUJnglvAb5kM1HNjlwqacH85dyJ4ygDlb/eXZP0ljGi+pGahK
   JxHGXYEP1jqVBokNkso9ZRjp/kS33ztzDfbiHPJkK+zRiSX5wMmGeeDCU
   rIj4GEmC8HIO+cLhZf+6sIXFSPP37imzSqhLPT+ZC85j24f8J+3lQ5/dp
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
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219087653"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 13:02:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1810DE0264; Wed, 23 Apr 2025 13:02:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B2623E007A
	for <cocci@sympa.inria.fr>; Wed, 23 Apr 2025 13:01:59 +0200 (CEST)
IronPort-SDR: 6808c8a7_YDpnPrUNaL0Q04oGmxbytsgSnja0hlVWLDwIYtP7VJWH1Fq
 Mzf6RJt54SD3pKNNWpbf/90j6ROJ3zyCPiMHsCA==
X-IPAS-Result: =?us-ascii?q?A0HQAADVxwhogAMP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBUwKCQn0GVDMEC0gDhFKPUIF0MIQ7jw6IdYFpgWoPAQMBDTQNAQIEA?=
 =?us-ascii?q?QEDAwGEOkYCiy0CHgcBBDQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgoxhXsNSQEQAYIHAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkQBAQECASMdAQERJgEECwsODAImA?=
 =?us-ascii?q?gJWBgEUAQGCfgGCLwEDDiMHDbF3gTKBAYIMAQEG2lwfLCJXgWUDBoEbLoVtg?=
 =?us-ascii?q?mMBhWw7hDwnD4FVRIEVJ4EUgW8+gkoXBBiBCT2DW4JpgjGBF1aEBoQ4hFVLg?=
 =?us-ascii?q?m6NGFJ7HANZLAFVExcLBwWBJhAzAyAKNBQdAhQNEBIPBBYFMB2CV4IwT4Img?=
 =?us-ascii?q?hFwbAMDIgGDE3Qcg0OBJYQORC1Pgy+BBH9OGgYdQAIBC209NwYDCxsGPZZKg?=
 =?us-ascii?q?TmBQYItgU1wkzaDGK9YNAeCOIFmgWQMiimVNQYTL5dGDgaSfS6YUCKNZJsvg?=
 =?us-ascii?q?X4jgVwzGiSDNk8DGQ+OIYQzgQuDVYoqAbIGQTUCAQEBCywCBwEKAQEDCYVGA?=
 =?us-ascii?q?QGIYYFzgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:JgIbhKy3NnG0x4k2g1V6t+fhwirEfRIJ4+MujC+fZmUNrF6WrkUOn
 GVLXWjQaPrcZ2GgLYhzPI209xkFucTRxtNhSwQ9+VhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmMc3l48sfrZ9Usz5q+q4Vv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPMk6R1JVwfJbEaoN4vOmIe7
 KceFBE0O0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyXo4QwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXKWQJ8ALK+/Zri4TV5BZX/Kj2NfrlQNWte9tMunqC/
 Dr39k2sV3n2M/TElWrdqSLz7gPVpgv/UZ0bELmQ5P9vikeagG0VEhwfE1WhydGyjUW1WvpEO
 kkM82wvq7Iz/QqlVLHAswaQpXmZolgDVtAWH+BSBByxJrT8w1bIHUEZZyZ9aoYe7PQ1FSVx0
 GOopoa8bdBwi4G9RXWY/7aSiDq9PykJMGMPDRPoqyNbsrEPR6ls1nryosZfLUKjsjHiMR3dq
 w1mQQA7gKgPy9EG3eO38DgrYg5ARLCZHmbZBS2OAApJCz+Vgqb7PuREDnCFtJ59wH6xFAXpg
 ZT9s5H2ABoyJZ+MjjeRZ+4GAauk4f2IWBWF3gIyRMV/qGT2oiP6FWy13N2YDBg3WirjUWC2C
 HI/RSsMvsADVJdXRfQmOtPqVazGM4C6SIi4Bpg4keaikrAqKF/fp3ExDaJh92Hqlk832boyU
 ap3gu78ZUv2/Z9PlWLsL89EieFD7nlnmQv7G8qnpzz5i+T2TCDOE98tbgDRBt3VGYve8G05B
 f4FZ5PSk32ykYTWPkHqzGLkBQtTdSRmXcmn+5w/myzqClMOJVzNwsT5mdsJE7GJVYwM/gsR1
 iDtAB1r2xDkiGfZKA6HTHlmZfm9Fdx8tH83d2hkd1qhx3FpM87l4bY9ZqkHW+At1NVi6vpoE
 NgDWcGLWcpURhr9pj8yUJjara5ZTiqNuz6gBSSeTQYaQ49BXC3Mo9/tQRvu/nIBDw2xrsoPn
 Iej3QL6H7sGHhpuPP/LZKiRzne0h3w8mf1zbWTMMNJ8aEXhy6k0Ci3T39scAdAAFgXH/RSej
 z2pOBY/ofLfhqME6//LjrCgg6K2NdBhD2xmH2X/xpSnBxnwp2aM79dJb7eVQGr7SmjxxpSHW
 cxU6PPNaNs8g1dAtttHIYZBlK4RyYPmmO5H815CAn7OUlWMD4FgKFmg2e1klPVE5p1diDuMd
 nO/wPtoEpTXB5q9C38UHhQvUcqb3/JNmjXy0+U8EH+n2ABJpoi4QWdgFDjSrhdCLYlFEpIvm
 sYgn8801zaRqDQXNvS+syQF0FjUc1IhVf08u4A4Eb3brFMh6mt/bKz2Dg7055CyaOtwDHQ6H
 w/MhIf/g+Vz+0mTVVsyCnnH4sRFj7ssph1h7QEPNnaJqPX/l9412xxdqwo2agFvyjRGzONBF
 Wx5PGJlJai13mlJheoSe0uOCg1+FBmi1Uip8GQwlUrdVBOOREHWCX8UYMKh3Rk+3TpHXz55+
 Lq49j7UYQzydpus4hpoCF9XlfPzaPdQqCvAoZmDNOaYFcAYZTHFvPefVVAQoUG6PfJr1Vz1n
 sg0zuNecqahCDUxpZc8AIyk1bg9bhCICWhBYPN59pMyAmDuV2Cu6AeKNnyOVJtBF97S/W+8L
 v5eFMZFehC99SSJ9xQwJ6oHJZ1ql/8IuvsGXJ7WJlA9jrjOlQox7ars9RX/ilQ7HPRos8I2c
 b3Kexy4T2e/uHpzmk32lvdiBFaWW9c+WVDD7LiHy9lRT5Mnm8NwQH42yYqx7im0MhM43he6v
 zHjRq7xzs45+7tNgrnDL6RnLCe3IOPVS+6n3l2SsdNPTNWXKubIlVofhWfGNjRsH4k6eopIh
 4XWleXozmbpga0TUV2Fq6KeFqJM29q+bNBXPu3zMnNeuymIA+3o3Dcu5EG6LsZvvO5Gx8z6W
 Ta9VtS8ReQVV/hZ2ndRTSpUSDQZKqbva5bftTGPlOuNBjcdwD74Aouer1GxVl5idwgMJ5HaI
 S33saz35tln8aJ9NCVdDPRiW5JFMFvvXJU9TOLItB6aM3KJh22Tsb6zhDsi7jD2UkO/KvjY2
 q6cZBbCd0WVgprqneFp69k4+lVdCXtmmuA/c34M49M82XjwEGcCKv9bKpkcTI1dlivpzpzje
 TXRdy0YBD7gWShfOwDJiDg5stxz2sRVUjs4GtAow69QQyKxGZ/GH7ZrsCtti5uzlv0P08n/Q
 ezyOFWpVvRy/n2tbfke7Lq3jI+LA9vEk2kQ9xmVf9PaWn4j7HZj6JClNBVAX2rLHqkhUakNy
 XcdHQh5fa1wdaI9/QuMtZKY9NH1cQ4DFwkVUBo=
IronPort-HdrOrdr: A9a23:TW9Udq0KfI6vmXabrdn0kwqjBGYkLtp133Aq2lEZdPWaSL3+qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SODUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AVSuqPGheMJng3n/UJFP+U8xGLTJuUi2M117NCle?=
 =?us-ascii?q?ECzxREIaWGUbL/p9Fqp87?=
X-Talos-MUID: 9a23:JczKlgTQlhtaLKNjRXT2oh1yL8JI056nL34TiLE6oZPcBCVZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219087644"
X-MGA-submission: =?us-ascii?q?MDGDK8PnmJV6qql2E7/SE0BvzWy5WNZbEGN4A0?=
 =?us-ascii?q?sxTI/NNZyGnEsJ7EQUFuBNEI9B4gCqf5OLMMHh8kJlO6Kiy9gkipjEty?=
 =?us-ascii?q?4DkVYYZUTI08QV6Bwsm9CSjzxJ5tMw637rQk+uqRi3sVbHRney5rriNx?=
 =?us-ascii?q?GEekjQ5He5RjL6tFIDc/SJMw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 13:01:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745406071; x=1746010871; i=markus.elfring@web.de;
	bh=bJBRZaSgchliWw4wWLkLEWuwp3nk6zi0pApkA4ydaQA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ox8SHhMDynRZ4UWq5g+NDy3WLxAgbWwiPuGIaqRjAdTgEARXgKvENusKre6qfQlx
	 qIYRkjFbHC8jeWQ8gTOnyCaj65GQLj2KZ/2KI9qO3hNf/s6tG1PzygUsqN7OFX70g
	 dAReE3UrzgvWkWQukjV12AjX088iZ1rhv4qMLNqw7MUEcbj/JKmcpFD6lGhQ9ViTR
	 UrYYv9nTjx8hQU+X+oTBAzp8eYna21c4icmgUiPW4z/RJh9PqwPc7iiB8s+cbOKw3
	 CZEps0aLh8Bgx2KU1hea2cAPXrAae5vtI82IJGoPLyKhwJOZbd5x9OhyNqgq5TjjJ
	 ZO5rWeNK9WKkse9V2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.6]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V6E-1u86571ArC-00AzGR; Wed, 23
 Apr 2025 13:01:11 +0200
Message-ID: <a1be0efc-a4c9-461d-a01a-8fb830b2c68d@web.de>
Date: Wed, 23 Apr 2025 13:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Luo Jie <quic_luoj@quicinc.com>, cocci@inria.fr,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Marc Zyngier <maz@kernel.org>,
 Nicolas Palix <nicolas.palix@imag.fr>, Oliver Upton
 <oliver.upton@linux.dev>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Suzuki Poulouse <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Zenghui Yu <yuzenghui@huawei.com>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-2-6f7992aafcb7@quicinc.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 "Kiran Kumar C.S.K" <quic_kkumarcs@quicinc.com>,
 Lei Wei <quic_leiwei@quicinc.com>, Pavithra R <quic_pavir@quicinc.com>,
 Suruchi Agarwal <quic_suruchia@quicinc.com>, quic_linchen@quicinc.com
In-Reply-To: <20250417-field_modify-v3-2-6f7992aafcb7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xvSCXljCCknARbi0JItnFFXBwAmUxRh0fA0gwWeuOfRq7wj6wGN
 5xNQ4dFTKJ2Fik8upyc69y7miHX9kOfh+vGTMYy6HHyjPhT7DMe33NDvGjIXRDXV1+Lybhg
 xg/HO1UvOIMIsomFkLK5/x0PuSkg8yWK9747nUmSNjX+m2rb9sOTFxEfqbdXrdfKUBrSOP4
 EZopg77LmU3bOl4uwW6IQ==
UI-OutboundReport: notjunk:1;M01:P0:qNz1C3ar5JU=;rjaWDewSnTi3p/HCEWxAJ+B18ak
 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
Subject: Re: [cocci] [PATCH v3 2/6] coccinelle: misc: Add field_modify
 script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2707
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/a1be0efc-a4c9-461d-a01a-8fb830b2c68d%40web.de>

> This script finds and suggests conversions of opencoded field
> modify patterns with the wrapper FIELD_MODIFY() API defined in
> include/linux/bitfield.h for better readability.

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.15-rc3#n94


=E2=80=A6
> +++ b/scripts/coccinelle/misc/field_modify.cocci
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///

I suggest to omit a blank comment line here.


> +/// Replaced below code with the wrapper FIELD_MODIFY(MASK, &reg, val)

Replace?


=E2=80=A6
> +// Copyright (C) 2025 Qualcomm Innovation Center, Inc.

Copyright: ?


> +// URL: https://coccinelle.gitlabpages.inria.fr/website

I suggest to omit such information here.


=E2=80=A6
> +virtual patch

How do you think about to support additional operation modes?


=E2=80=A6
> +- reg &=3D ~mask;
> +- reg |=3D FIELD_PREP(mask, val);
> ++ FIELD_MODIFY(mask, &reg, val);

Would you like to integrate the following SmPL code variant?

-reg &=3D ~mask;
-reg |=3D FIELD_PREP
+       FIELD_MODIFY
                  (mask,
+                  &reg,
                   val
                  );


Regards,
Markus
