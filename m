Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEE4C5DF82
	for <cocci@archiver.kernel.org>; Thu, 20 Aug 2026 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=oMYv3XyV5C8iUykaJASvJBTljPlzVPDg/EJP/k7pA9g=;
  b=psCdbVUwFlz4Non7AlFC5vOTNCY0XQ3DyW7U50S70JzUOgpknRTLxCjQ
   MbrNDjIuJ9ALJ3s+qhyIlqGF2tqwjdvicGtAzK+zoEfX2XFaGhjsVRJHh
   6+nmxH8z7KgqQVeb4Lq1BfH0rkxu4+NLNV58SWBQvxFKCCD97qJEof4Rx
   M=;
X-CSE-ConnectionGUID: lPvPeZpkT4CMW8rHYWcy+A==
X-CSE-MsgGUID: zk6cw4PfSSOoEUMViBkyiQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.25,232,1779141600"; 
   d="scan'208";a="290784058"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Aug 2026 10:36:48 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E2F47813E5; Thu, 20 Aug 2026 10:36:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 6419681747
	for <cocci@sympa.inria.fr>; Tue,  4 Aug 2026 21:15:39 +0200 (CEST)
X-CSE-ConnectionGUID: q29/bpziSpSnXppx6uq8Sg==
X-CSE-MsgGUID: WsrL4NG3S+atj9+ViFN9xA==
IronPort-SDR: 6a723a5b_cvBqZB8wYK7MCaXcNxEKnR8uGDOF62uONuXVrxz5RyuX25n
 rbo9wb6jVQe+pHV5xI/3Koz13rw47HaorSbZ9wA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EWAACLOXJqj/4EaaxaHQEBAQEJARIBBQUBgXwIAQsBA?=
 =?us-ascii?q?YI/gQpfMwQLSYRYiBtfhliBdDCEO4cpkGKBVYF8Ag8BAwENRA0EAQEBAgSEf?=
 =?us-ascii?q?gKNZwIeBwEEMAkOAQIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBA?=
 =?us-ascii?q?QECEAEBAQEBATkFDjuGTw1JARABggcBgSSBJgEBAQEBAQEBAQEBAR0CDX4BA?=
 =?us-ascii?q?QEDIxUIAQE3AQ8LGAICJgICIDYGARICAQGCfgGCIgcRAzcDEb9ogTKBAYIMA?=
 =?us-ascii?q?QEG2zINcoFpAwYVgQouAYVwgkwgAYV4GyCDR3onDg2BSEWBPAuCeT6CHyQeB?=
 =?us-ascii?q?BiBW4NGgmqCJoEMkldSeBwDWSwBVRMXCwcFXkUQMwMgCi8tAhQNEBIPBBYFL?=
 =?us-ascii?q?R1wDCcSDx0XFx5YGwcFEiAqQUQjAxQtIQtDBYFVAoF1PyMZNnyBKnVKci1pA?=
 =?us-ascii?q?QIQF0o3GIMSAoJ6VAELbT03BgMLGQQ9jwcggkaBOYF9pTproB41PIQngXKCE?=
 =?us-ascii?q?Igfjz6GAQYPBC+DcYM0kC6TGZkII41nhAmXMIFoOoFcTTAIgyJQAxkPjiEZi?=
 =?us-ascii?q?HyKKgG8eiU1AgE7AQcCBw8CgXOFZIpQgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:MaZFqKOuI//2y8BcTvqjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7290ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWUnNK1l5
 0QFpSWY+eRMbEVt7eY3OD1Kbcd/OU=
X-Talos-CUID: 9a23:JM7Wtm7WWAU+nuw4mdss7RRFXco9YHzm1EzWE1egGTh0Ue2uRgrF
X-Talos-MUID: 9a23:gK1+iga7fDcFGeBTiCT2oG1EG5xToK2yChFOr5QonZiUHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,205,1779141600"; 
   d="scan'208";a="289107865"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDH0ldSMVnMvCsm/i8EAH+F4fG5jEwN4K4uLYD?=
 =?us-ascii?q?vYlEeSP4e1+wRbvs95VEg4wIOTVAZKYK3EoISDcRoIXll89Gh9yblWYq?=
 =?us-ascii?q?l7SjUzqTe87YLuGwWG11UT8NejiC1Mq54pQ5KT72O1n6VxNlyk7hGcp5?=
 =?us-ascii?q?IR+ZRyMZxJkS3BQayjndWmEg=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 21:15:38 +0200
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8D02E60A78;
	Tue,  4 Aug 2026 19:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B2E1F000E9;
	Tue,  4 Aug 2026 19:15:35 +0000 (UTC)
Message-ID: <f8a89cd1-eb4f-40f7-8556-2f4d689a293a@kernel.org>
Date: Tue, 4 Aug 2026 13:15:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sang-Heon Jeon <ekffu200098@gmail.com>, Julia.Lawall@inria.fr,
 Thomas Renninger <trenn@suse.com>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-36-ekffu200098@gmail.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20260723184538.3888637-36-ekffu200098@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 35/36] cpupower: remove conditional return with
 no effect
Reply-To: Shuah <shuah@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3684
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/qdbiuYB9Er7fCgj_92DtVg>

On 7/23/26 12:45, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Applied to
https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

Will include it in my next pr to PM maintainer.

thanks,
-- Shuah
