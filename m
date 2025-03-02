Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728F3C282D3
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Lra0vUwN1K4kba2+U3+GskifVMgR2zgvSIvCEe7aAto=;
  b=gsmMEN3So8apnDIiHLV+ZGAaAbGPSTlENCnMCBACM2eKNGhLlkQ/6b1r
   uaHGA/C++ZN2bqisjVs8exerUZ2YyZmFhuA19LP0+MaN3P8hLTgZ1nKqy
   HjfPy6zwnGlDahPuFFKNhYam9HwpB5+/PQIBBsOy1jAqCQLx6MSABVl1c
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@yahoo.com
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211069179"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 437C8E0DF0; Tue,  4 Mar 2025 10:58:42 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 58103E0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 17:53:48 +0100 (CET)
IronPort-SDR: 67c48d1c_ZPfxGJn8/Lk8NGlJlLSIWaNx6opvo5Zf1P8s8lLGahL1zg6
 e4VhOPtkvefCP9yloDbVXQkENtd1dbsGr843sqQ==
X-IPAS-Result: =?us-ascii?q?A0ELAACti8Rnj5m8o0JaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgVY0BAtIhFaIHYkmLQOBE4FrjkmMTRSBLD4PAQMBD?=
 =?us-ascii?q?UQEAQEDBIUAAkCKVQIeBgYwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBAQEBATkFSYV7DYJigSVRDQcJOAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARECRyQBAR0BAQEBAgEjDwENAQE3AQ8LFQMCAiYCAkQSGQIBAYJ+g?=
 =?us-ascii?q?jEDDiMDo3yKRHqBMoEBggwBAQbbJwMKbIFlCSB6LgGFa4JjAYR7cIMUaXpCP?=
 =?us-ascii?q?4FOgRUnC4EJgTc4PoIfgWcUhASCaYQcAYM9lmuDGo5TSAp7eCwBVRMNCgsHB?=
 =?us-ascii?q?YEpSAM1DAsuFSOBIwU0Cjc6ggtpSToCDQI1gh58gitqBAWBJII3hD1cLwMDA?=
 =?us-ascii?q?wODKYVSghGBXQMDEQUPAYMfdxyDfX+CMIFtTR1AAgELGA1IESw3CQsbQwFuB?=
 =?us-ascii?q?6B4OoQ6BwFzBxMBLx0uYBZPCw2TDS6SI6EGhCWBY59qBkKBS5Yukl2IMJBNo?=
 =?us-ascii?q?3oBGDeEZ4FnOoFcTSMVO4JnTwMXAg+OIRmDYckFJTI8AgcBCgEBAwmPaDSBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 i7br9oopVz/1PiGyj1gFhFJr2QT7L8=
IronPort-Data: A9a23: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
 Pv+oapfT5B6dNcpmNWmiskmmw==
IronPort-HdrOrdr: A9a23:3xl/sqrHs6K9MH7YMsYYZI4aV5rIeYIsimQD101hICG9vPbo8f
 xG785rrSPcojAXRX0mhJSkNK6PXHK0z+8K3WB3B8bfYOCGghrUEGgG1+DfKlLbak7DH4JmpN
 xdmu1FeafN5DtB/KTHCWuDc+rIqePvmM7IuQ6d9QYVcegAUdAF0+4WMHf9LqQ7fngiOXNALu
 vi2uN34wCHXlQ8KumYJl1AZcjsgLTw/q7OUFo9ARkm4k2voFqTh4LSIlyj2BAfWXdq7t4ZnV
 Qsx2TCi5mejw==
X-Talos-CUID: 9a23:psJ+6Wya12/vdfb6GYWQBgUWG5t0X3PgwUyOJkj7B3tnRbCnWXmfrfY=
X-Talos-MUID: 9a23:6tHGpwTTqTi8LfCmRXTThjx/DOYw357pVkIgg8tcuuyEdiF/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210746368"
X-MGA-submission: =?us-ascii?q?MDFY56KuFyByGbhst4OFcYjFN8ZDlyDjTqYpC3?=
 =?us-ascii?q?7JB7JHbKqdKcNdZJPdAwMJ15mKWH8ZWbGN0tdnkWofIiqbUXfKbPcUzv?=
 =?us-ascii?q?PQCbxXsrI0kBehi5toOeWZ2BoFO3l+8swnew9RTMwp6sHDaoRN7CvGC8?=
 =?us-ascii?q?zqwQhyMASdV/LhBt6k/A3ACg=3D=3D?=
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 17:53:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740934425; bh=Lra0vUwN1K4kba2+U3+GskifVMgR2zgvSIvCEe7aAto=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Xb+UkmpI33ONIUkINncz96o5h/4fUQIec+/+gPrBkj5GOtKav93cQ4EBnfCMl8AEvCUjX5lvHFw4qhEcT/DypDp697I5UaXjmyZu3rJUoF3KPuLtW2njLgtb3v6UwFioxrwTaqEqj2WAS4wPg1W0ShQiw9YaqoWaRIorXethqX9sFebyyV8W6jonVRhHcndUqIi7Q3fipAeID1ORUtOHKhP/PZYRDMgpa6BGsAoooswniEXWHZh8zN6gxPO6BjE/HQsOf08r5/N9oYauknR3dJa5TDtv/8LMObAyHrSDryEx2g+W2MpA0Wo2swJ9MaXRBW4B+yGwaClzctN6+Ct5rg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740934425; bh=cL7m2wkLJYfuLb4ucGj8pZAXSiZNW45edEGCd3mDdQb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=l3V99oOntZ5yOKwL4mkipNbT9qevYKHX8R/3DiDEGfk1BCqVWOCDNl+rvgTH+8ZJ8X/8omNuxapThnd92MFBuTIspZcDwy2mY5WPb/9d3NALV6JIYzpSGjxgaRzFx6ukhp5w7uN7ljDadtE90tLhhX39XvS2Ez3Yk1hPV84q27UOakDY1HJN1W2bmaMoJvgkbbQJTFxDg7I/xhPLbSZJJBl2M7ZVt1lLNtvN20023q2m1vZhnHW7wt94pTQNp3XewrJup8yPr0GPI6hZPvh+ydEtEbEyLE4DFwPgOUXKaSEFhkUoB5vtRvPVe6xQQP86IIhBtQ+MJq+UDTybdT6R4g==
X-YMail-OSG: wv88pfkVM1njmcOBhx7tsi13s8FX9bSGHrTdzXuW9d5Ytl4LUgPOXIn3ptgiYD8
 pqeg7fI6FRp.KjL0VsEnb6U1Nq8viH2wkEORY_DTxvTBF8l_YZ2LYU3IZbDn_n5uYBtatAzXNf1U
 fwAQmVwrbX7THPBR3n6Rk7eIq7FMCpWiQDsyGnsG7j7yfw1iQgZGONsOG3SYDGLK6wjCSeC5mSbJ
 vwf2eNCeY5zvRhpsKjvAfxV7x.xaGw7s377mhDsHTnDWawKUx7JGXRyYQOIw6SkkexziT3qtlI9b
 AlWIR9xI5_IaQNxXjfh.rLWJrCFr28AN5dWktIxJAyHj1Lj2q97Y4177BA28Vh55ljWvzCS5Hnf2
 yIE275tgqoxssSeHfXTtmqnL_Aj4MWGOjVbGjrUqPPXOPYJ4jlnrJd2D3lO6cinJEx0k8ewF1IBv
 z3d8GE.KOs5iyeMjpQolTZObMrZMErJdusFPWUd7vQhvhgfRvXqzN9EVndlavLow3FQ.WdWQDlPX
 Dp6klnQJlDPMUTD7NxaqINsZoweyKX5a7mFfB7dpMbtxglhkPb1qH9_mMm8RKbf2bI5bbyUprP.u
 cNIAQQQyAdsWR9l6m38SOSbChB6MxyPPyW.XgGeB4L7jX2TushxpffsP8IcD9u_5gX6yK.UEUBG2
 uGap1iO3kDnkjynKxHMD.yxuvAf_eRHaVGT11gsl2fVLDAMUo925V44hNvSaOi9R6P2CenEC8mnl
 nqH4soY1p9G9PQxndqK8MYmWNY7Dk4mMYPTlLKufOI_88_yTeNiMMPmpmfRBGthYAltijl2uGw46
 clR7c3g0TKWWC5E4KVW62nJu2wQyJTZr0nQFPwQCShv_ZQ20LfXRIBcrrew6g_n2ljv1HBCTuXX.
 aWhhgh_tsGnN5QaCpRc56Q4lqZqKc60h__QZvQ5NNPP52SfDkRQDAEhQAt94tuCy3y9eBTrAlD2U
 DQjn.F1OkPvFjSh9UFUivliA9.ZF.lq4glNlvpOrsAvbHSioSJ3ZNB7lmhfaClrK0p.7UKMHjHqC
 1aBMKP4sJy7x4UDHyWRnXQ3e98rShGoulLKlFKU4TF2sGLcKEyMr3btXkOvdsVVddvrdsyTGkd2X
 R9Nq42EnCgZ.HhiKJrI7YOhxFktAHgXVB1e6mkLbiapFcwVC0tvUqcIJji5a5NteqlcgVFx_LF4E
 6kRe6kv0PCkSXwF6SZB66tUdu.TThECekzP6Pri2gKoCeqFqg8x9G8lPAjwVxdm4MripQ9atJphv
 qpkf1MIJiWpS4lTnU7Z.23uAr1HcwbRpaLwuVtnf7qV0X0RqtAURXF8T7sXGYiXW7GFvBJh4q1F0
 df8juOfxsIxAHjLr9GHwvJ0gnSWKVXomWcCdLp1d.I.8SbaowxHHTWmf9TEwCKkjwzAa7_dcLPZs
 CRdVYHfWT1chRC9J3JTPqThg0_R827i4uBY_FFjy0qf.dVTsn4IEKNTEGvW.GkW2mXrv_ahGFaKp
 cLYr2TAllGe.319oMToJIZTy_2Iks4zrPiLMm2atfwR3.xJUPZIv9fWGCh_K9I__a7fOvtYaXl7v
 OiQS0Z9tcgB0R6VGAORHminYObCI1WAOMhUx0XNKEWLpavxjLsRN6pHggA3c1EOsaAn1WoUXe04e
 Ii7bOJ.5Wze5jpNrYTNDDy0J3fbbFQzJhuAJR7RPFURmPmBd032J7HIuzAtpYqD71xp5EoCzoWTq
 cXreqOT7fUGlBf0SdHefABcLsqkYn1fhcO0Q0XCYAbo5wumQcKJs4.8FWEamHPUAPmCB5tul_d98
 ks0qI.lO6WZHjZ3HdbZrUtioQmiki5MP3LbO2fefHU1nt2QQAlRSIJeFDYD3zUoR8XqKcnC0PMAp
 bWLHWNrx2KmZSZ0sFGkpp2RLKmbjp.Iu6OAe1hOgVzvoDWkLQoNSkOdbMmYdUawRID6ZIzG_fcoT
 F.wJjVAcweiL0wrJBWdvxw5sXzppbIbxFARg0xRaKvnkOYX.s98XvzMmrAYXkvQCg3DI9O02xe5d
 pIEvPV7VAa5IapvVb_vkx0B.u1EMegSTbdCR6YBqNnQ6CIu2zKD6uJzxHAmUznphqp.hUHEBV.AA
 azu8pBmi6Xl97L54ozTRZpk30uvkRMnJ__al_wzyERfbUjBsYE2srryjNYRtEBZWK21dV_Y_hW8w
 xIEdI8NyaOfoJXLyrdlYbHTRYpkO8DcacD3giXNxKAzdwatjwe5CJqlKtTFvcCnOty5UMdrpgqsF
 eJutUMIPekgJzyzmgPCIzEr4PoMqgsrJPhfz9dmaJv7gDNvBTzn7GV9bpGdg8ZZZILLyl7mU3xAw
 7KcU1MrKmyg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2b07aca3-e99e-418f-8d19-36a7f689996d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Mar 2025 16:53:45 +0000
Received: by hermes--production-gq1-75cc957d6c-7gjr6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 69b926c9c32d591f2598364d1898b010;
          Sun, 02 Mar 2025 16:53:41 +0000 (UTC)
Message-ID: <6f74f18f-ba64-4372-8307-efba97c03bf2@schaufler-ca.com>
Date: Sun, 2 Mar 2025 08:53:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cgzones@googlemail.com
Cc: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 cocci@inria.fr, Casey Schaufler <casey@schaufler-ca.com>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-11-cgoettsche@seltendoof.de>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250302160657.127253-11-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23369 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 01/11] coccinelle: Add script to reorder
 capable() calls
Reply-To: Casey Schaufler <casey@schaufler-ca.com>
X-Loop: cocci@inria.fr
X-Sequence: 2498
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/6f74f18f-ba64-4372-8307-efba97c03bf2%40schaufler-ca.com>

On 3/2/2025 8:06 AM, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
>
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.

What steps are you taking to ensure that these changes do not
negatively impact LSMs other than SELinux? At a glance, I don't
see that there is likely to be a problem. I do see a possibility
that changes in error returns could break test suites and, more
importantly, applications that are careful about using privileged
operations.

>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>  MAINTAINERS                                |  1 +
>  scripts/coccinelle/api/capable_order.cocci | 98 ++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
>  create mode 100644 scripts/coccinelle/api/capable_order.cocci
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0736dc2ee0..b1d1c801765b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5196,6 +5196,7 @@ F:	include/linux/capability.h
>  F:	include/trace/events/capability.h
>  F:	include/uapi/linux/capability.h
>  F:	kernel/capability.c
> +F:	scripts/coccinelle/api/capable_order.cocci
>  F:	security/commoncap.c
>  
>  CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
> diff --git a/scripts/coccinelle/api/capable_order.cocci b/scripts/coccinelle/api/capable_order.cocci
> new file mode 100644
> index 000000000000..4150d91b0f33
> --- /dev/null
> +++ b/scripts/coccinelle/api/capable_order.cocci
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Checks for capable() calls of the left side of a binary expression.
> +/// Reordering might avoid needless checks, LSM log messages, and more
> +/// restrictive LSM security policies (e.g. SELinux).
> +/// Can report false positives if the righthand side contains a nested
> +/// capability check or has side effects.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2024 Christian Göttsche.
> +// Options: --no-includes --include-headers
> +// Keywords: capable, ns_capable, sockopt_ns_capable
> +//
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +//----------------------------------------------------------
> +//  Pattern to ignore
> +//----------------------------------------------------------
> +
> +@ignore@
> +identifier F1 = { capable, ns_capable, sockopt_ns_capable };
> +identifier F2 = { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
> +expression E;
> +position p;
> +@@
> +
> +(
> +F1@p(...) op F2(...)
> +|
> +E op1 F1@p(...) op2 F2(...)
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For patch mode
> +//----------------------------------------------------------
> +
> +@ depends on patch@
> +identifier F = { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
> +expression E,E1,E2;
> +expression list EL;
> +position p != ignore.p;
> +@@
> +
> +(
> +-  F@p(EL) op E
> ++  E op F(EL)
> +|
> +-  E1 op1 F@p(EL) op2 E2
> ++  E1 op1 E2 op2 F(EL)
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@r1 depends on !patch exists@
> +identifier F = { capable, ns_capable, sockopt_ns_capable };
> +binary operator op,op1,op2;
> +expression E, E1, E2;
> +position p != ignore.p;
> +@@
> +
> +(
> +*  F@p(...) op E
> +|
> +*  E1 op1 F@p(...) op2 E2
> +)
> +
> +
> +//----------------------------------------------------------
> +//  For org mode
> +//----------------------------------------------------------
> +
> +@script:python depends on org@
> +p << r1.p;
> +@@
> +
> +cocci.print_main("WARNING opportunity for capable reordering",p)
> +
> +
> +//----------------------------------------------------------
> +//  For report mode
> +//----------------------------------------------------------
> +
> +@script:python depends on report@
> +p << r1.p;
> +@@
> +
> +msg = "WARNING opportunity for capable reordering"
> +coccilib.report.print_report(p[0], msg)
