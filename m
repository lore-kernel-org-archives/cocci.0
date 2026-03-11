Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE51A1049523
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JGYhPK256pxU9EiY8jbQSSjgozqR8V5kd9EUseD+GRo=;
  b=dHC24nzRTz6jBP7AltE1a3UH2UxYav/IRweTqTJ5LwneOcQFagWELjBt
   wZJANr9eh1qorvXsnBBejxXvGOflopg54MR+M6Vp2Jc972KGLFvnZ/Wb7
   hyJ5w4MpYNtUw3nZ2TAchuSr6FlZoAN1VWVCWj0WbPDHoAuStIgUEuGhs
   o=;
X-CSE-ConnectionGUID: j9Feun+sQlKD7gTyzqVJtw==
X-CSE-MsgGUID: RJRjC0oKRMiiwy1DGhqq/Q==
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
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267246606"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:49 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8440C818CB; Wed, 11 Mar 2026 10:46:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 788C180629
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 10:32:42 +0100 (CET)
X-CSE-ConnectionGUID: 9MTozfA9RzG3I7vC+F0Rdw==
X-CSE-MsgGUID: FhjyokonTcGrz8UVKoInmg==
IronPort-SDR: 69b136ac_5bYE46ucaZICdScG8mN1zf1INHVgQWVXHXDfhoFmgQkHFpB
 s0MBSXliP1qChFfxtaRnuYoDxi2z4grLgfCK6gQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G/AQACNrFphf4EaaxagQmBUIJBgWYzBAtJhFiIe4ZYg?=
 =?us-ascii?q?iSeGoF9Ag8BAwENUQQBAQMEhQACjSMCHgcBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAUBJhk8NgluBLIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHQINfgEBAQIBIx0BATcBBAsLCwMMAiYCAiETBR0GE4MCgiMHIycDrxKBM?=
 =?us-ascii?q?oEBggwBAQbcKoFnCRWBCi6Fb4JlAYFwg2oahAB6JxuBSUSBFTWCdT6EQxWDR?=
 =?us-ascii?q?oJpgiaBDokKiXMmCR0DBwcODR5GDwUcA1ksAVUTFwsHBV5FQwECAYEFI0sFL?=
 =?us-ascii?q?R2BIyEdFxQfWBsHBRIhKgdeY3iCAQ+GaHkDLl4aDiICOlyBBgtaBYIsAhwDC?=
 =?us-ascii?q?2ILPTcUG0qOYj2CMwLKZ4QmgWSgDjODcQGTYJMZLodlkHOpQYFoOoFcMxoIK?=
 =?us-ascii?q?AhsBoIwTwMZD446iHrEF0I1PAIHAQoBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 J7Uk7/pIzoE8N/O+8YYQc/OJ5DfWEc=
IronPort-Data: A9a23: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
 e0jx0A=
IronPort-HdrOrdr: A9a23:P9u1faAZPif8j3vlHelA55DYdb4zR+YMi2TDGXoBMyC9Ffbo6/
 xG/c5rqCMc7Qx9ZJhOo6HlBEDtewK4yXcx2/hyAV7AZmnbUQmTXfhfBOLZqlWKcUHDH6xmpM
 RdmsNFeaXN5DZB/L3HyTj9PNA63tGd/aykwcvYxWx8VBxnZshbgDtRO0K0FglYSAFaGYE0Dv
 Onl6x6TvmbF0g/X4CUAnEEWqzkvN3ElJXvZFojCwQ84AeDyROEgYSKdCRwFy1+bw9y
X-Talos-CUID: 9a23:/HIOjm5XMT2r3NpOddsspWsoHdIrWyzn3liLAhCmIiVHEIeZVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3A3tXEQg6xFMks29pCyTb0gJP+xoxG46a/D0MKl6k?=
 =?us-ascii?q?NlNOWZRFOGDC8ijG4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="141010757"
X-MGA-submission: =?us-ascii?q?MDGlYUMVg1jUdvwCNuoTbjmG5fGQUQH70PjE4u?=
 =?us-ascii?q?adu20fwOPwIushe9ZqmggycBP+nP+FTLtWUnFzmkevGZtOaxrJr+o9aE?=
 =?us-ascii?q?YjCz18/XUf3oW3zBgETlrA38pbuKGNxImzpOdOXJksHyodGDGRstzNKy?=
 =?us-ascii?q?M0el65UWSWgDDxT6yrc7oRUw=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:32:28 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C7996091C
	for <cocci@inria.fr>; Wed, 11 Mar 2026 09:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D20C2BCB5
	for <cocci@inria.fr>; Wed, 11 Mar 2026 09:32:26 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ae222d87dso12762980d50.2
        for <cocci@inria.fr>; Wed, 11 Mar 2026 02:32:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFuJPX10SImFeCPxjwlJfGiOa3ihP7gtC3UMb4nCcIavg9nXCpeFdH7i36Blv1A8FglOvpOQ==@inria.fr
X-Gm-Message-State: AOJu0YztUPWNbzaMFl052QyIIf8POupcX7VzZgoVWN7Lut5yzz/DrvHQ
	ayBTd0hS0jlMrT+HAWwAAjuoO5XHA3EG1SIZAZ/cLTIFDN3DY9znQpJ1MlUVPHpIozH6UGPrJk5
	4eBw8veP+f+XAgfQywZR3qSl/hwBYVWU=
X-Received: by 2002:a05:690e:144d:b0:64c:e890:fbb9 with SMTP id
 956f58d0204a3-64d656f696dmr1649157d50.20.1773221544775; Wed, 11 Mar 2026
 02:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-41-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-41-bd63b656022d@avm.de>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Mar 2026 10:32:12 +0100
X-Gmail-Original-Message-ID: <CAD++jLnDv00ErgVdQ4EBpKH9KMWrPD8ODrQ6m846zyQ=wNzCzQ@mail.gmail.com>
X-Gm-Features: AaiRm52aI8z_G2E4qYaKWPEA43RhLektjwMDQXSLwHd-Xy_BYcin-6heFFY4jM4
Message-ID: <CAD++jLnDv00ErgVdQ4EBpKH9KMWrPD8ODrQ6m846zyQ=wNzCzQ@mail.gmail.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 41/61] pinctrl: Prefer IS_ERR_OR_NULL over
 manual NULL check
Reply-To: Linus Walleij <linusw@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3413
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/MnE-HloDeXGGD5V0PxvK3g>

On Tue, Mar 10, 2026 at 12:55=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wr=
ote:

> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Linus Walleij <linusw@kernel.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Patch applied to the pinctrl tree as obviously correct.

Yours,
Linus Walleij
