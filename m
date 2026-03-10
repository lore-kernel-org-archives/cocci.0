Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624B6FD2D7C
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
  b=CDiRTvxSn0VzvwCG2/QWseqiAk2wxpxBtr/eD27PCYfqU7IIIwUE+VsO
   fbcIt1oTK0SYBXtYfABjsYT3d4oYJwkmFB/+laaNIj108huldTwjy4w46
   H7rjc+Ah39USgdaHK/+hi3icWP2+X+nraoncv7l+1kVqU9K85SQNJHxR5
   s=;
X-CSE-ConnectionGUID: m5X8MG6nSpmmtFT7Zol+wQ==
X-CSE-MsgGUID: +qITV0MST3yGe1BQ8oFnaw==
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
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267099480"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 14:23:53 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8B962833EC; Tue, 10 Mar 2026 14:23:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1E5BB83398
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 14:22:12 +0100 (CET)
X-CSE-ConnectionGUID: W0sZ/2HlQnGZF8RpRMabLw==
X-CSE-MsgGUID: cMvSbZJoT5etkwM4lPC7AA==
IronPort-SDR: 69b01b03_m/VV2wFjiufjxkE3dzRV/o2JoKUzqORQ3DsdnJ5XSVofi6T
 EZEV9Occ0jkp1ebPrNoO5Nct+ikd9A8XENoiVrw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FeAQAPGrBpg3yFCqpagQmBUIJBghkHUY1TiHyeGoF9A?=
 =?us-ascii?q?g8BAwELAQFPAgQBAQMEhQACjSECHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QENAQEFAQEBAgEBAgQGAQIQAQEBATkHDjuGTw2CYgGBJIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBFwINfQEBAQECARIoBgEBNwEECwsOChwSEAQfAQUBIhMigmCCI?=
 =?us-ascii?q?wcjJwOfWgFugQJCikIBAQF2gTSBAYIMAQEG3CqBZwkJAQsBgTeIVAGFWhqEA?=
 =?us-ascii?q?HonG4FJRIEVgyo+gVKJNYImgQ6JCooWUngcA1ksAVUTFwsHBYEjQwOBBiNLB?=
 =?us-ascii?q?S0dgSMhHRcUH1gbBwUSISqBSXiCAQ+GaQF5Ay5eGg4iAigSXEo+C1oFgj8DC?=
 =?us-ascii?q?209NxQbBI8nPoIzAnqCU8cahCahcjOXUpMZLodlkHOkIoR0AgoHBxEkgUQ6g?=
 =?us-ascii?q?VwzGggbFYMiTwMZD446g2fJQCg0PAIHCwEBAwmFRRGMSIFLAQE?=
IronPort-PHdr: A9a23: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
 5HsLYIraI6sYks=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:mNBTlasFwD3dHv9YF6zknFXl7skCpoAji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJh5o6H6BEGBKUmslqKdkrNhR4tKPTOW8ldASbsP0WKM+UyGJ8STzI9gPO
 JbAtBD4b7LfBVHZKTBkW+F+r8bqbHpnpxAx92utkuFJjsaCZ2Imj0JbjpzZXcGITWua6BYKL
 OsouZXrTupfnoaKv+8GmQEWOb7odjKnoLNYBINBRIrgTP+wQ+A2frfKVy1zx0eWzRAzfML9n
 XEqRXw4uGOouy20RjV0k7U9tBzlMH6wtVOKcSQgoxNQw+cxDqAVcBEYfmvrTo1qOag5BIDl8
 TNmQ4pO4Be+m7cZWa8pDrqwk3F3Cw143Hv5FeEiT/IoND/Rhg9F81d7LgpPSfx2g4FhpVRwa
 hL12WWu958FhXbhhnw4NDOSlVDile0iWBKq59Ss1VvFa8lLJNBp40W+01YVL0aGjjh1YwhGO
 5ySOnB+fdtd0+AZXyxhBgt/DXsZAVwIv61eDlHhiWn6UkQoJm/9Tpf+CUrpAZEyHv6cegc2w
 2LCNUxqFgEdL5qUUs0PpZ8fSLwMB2NffuEChPtHbysfpt3RE7lutr55q446/qtf4FNxJwumI
 7ZWFcdrmIqfVnyYPf+laGj3yq9N1lVZw6dvP129tx8oPnxVbDrOSqMRBQnlNahuewWBoneV+
 yoMJxbDvf/JS+2cLw5lDHWSt1XMz0TQccVstE0VxaHpd/KMJTjsqjefOzILLTgHD44Uif0A2
 cFXjL0OMJch3rbEkPQkVzUQTfga0b/9ZV/HOzT+PUS0pEEMslWvg0cmT2Cl7W2wP15w9kLlW
 dFUcDae/mA1BiLFE7znhVUEwsYCFpJ67P9VH4PrRMWMirPAMQ+h+k=
X-Talos-CUID: =?us-ascii?q?9a23=3Aa7dkB2k7h9IEDd/3Uy+tlEYIJ/zXOUKF10WXeW+?=
 =?us-ascii?q?8MGBGepPFc0eq3aput9U7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ARweoWw62VLLSEDkIqw/tgr5bxoxjxrqVAnIvlql?=
 =?us-ascii?q?bttWHKgksPw+20x2eF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="140927369"
X-MGA-submission: =?us-ascii?q?MDEyhPGGyJKsylq+T+gloywIPBu9PJJRshCMFO?=
 =?us-ascii?q?lRP0Js3N+qLLYqV+wQKc9o/bWaj8ra/LV45atmzZRF0kBZHhFpoW0dOZ?=
 =?us-ascii?q?Gr0fUPFQ190db+aPvR1rv1vE9mN/Y9pnqboRF91zclU3506elZADyO9B?=
 =?us-ascii?q?Fu/Qp8tm3hmsu6qiRrO4AoyQ=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:22:10 +0100
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-llbYh8wHNcOqqYpu87PNfQ-1; Tue, 10 Mar 2026 09:22:05 -0400
X-MC-Unique: llbYh8wHNcOqqYpu87PNfQ-1
X-Mimecast-MFC-AGG-ID: llbYh8wHNcOqqYpu87PNfQ_1773148925
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd81506677so1375226285a.1
        for <cocci@inria.fr>; Tue, 10 Mar 2026 06:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148925; x=1773753725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
        b=H8//zPZY5cxxOx3cckthWTyJn0/6Rac2actEoXIDeXL+14lZb8d7alpG+TpO+8jgw2
         qeBHJXfUU3n/7+wYSXefgT6qF7xqYBsBVnc4DqO3rz4fnu52Id6nY1d/2GTAbvXuSa+Z
         1a+2fNpImpqDPgAnvLyJ3iDX/ApZvQjR2uoObemO+HqMH63rt5Y7FFDMnYIfhduDxHNH
         pbRaH88N1jOEwbSm8TZBUVfcnnyHNc/SwY15fW0fwZAI6QPUvTypMzPqawnnJahsyGX2
         p3cFiE1C3TnbW7LeYtbTQ6ilJ5YiRgPF7z/LyiGZyvhKllcX4rb2jjc2btPeLlYvMw5X
         wwjg==
X-Forwarded-Encrypted: i=1; AJvYcCWvPy5JN2+m41xwroA+skBZGAtfjBivvim7YEDo7ya/j6wsvK3/+Vr5xzDdXHCgvfDyp4YZVQ==@inria.fr
X-Gm-Message-State: AOJu0Yz3UWtcw0Nrk3GMbFMNqk3S9Acdorg42nsZlbhRFG7C8HCOLALL
	HyuNouBcy4D4mUHZcAcbdgSgbJ1i4S5edW8QBToNeXdSyGKk2RoDAxrAa9YKUHEFwdqNtRHm7+y
	2uFCLCHCuBsQC/mA67RzLnTx8roBSXOKGFmL1FYRO7sDHlF4=
X-Gm-Gg: ATEYQzyc/hzAUWpncBpySKr0BcjLnCNsVBjjbFEbN65uz/GwlC6nbmZFJKj9PRTs/o4
	KR9SXzN+xZP83wUzYuQ45BSrMgVzPW5z/bzveSw1gMvliaZiLUcuRlXg+rKE/KI2aus9KMLh/QV
	m54PEB1V9vlZ9N5kRYxL7VaqY+b/nNyaAgqwJ7U/iVSK6kxDRhxjW4l4skFdp2BzMazlA4IS/dl
	vevEcD/DVuvD48gTy7U6qS5GVQ6Df3Wm9DPsUP8CR8e9l67yubqCTlBxO+K1CpLXcEBSo+gBtWh
	IRjDsnbnpcFQ6N5fSHdRtzqd735v7Bv+2L+dqHsbqqb0k8ASxIqlF7I40l9Ot9vdKbJiQeRwTgk
	6DY8dPk2jwzBpNj+9ovhkmN5rZThxmIK102vrGEAyRgaR0SH23rWlTqFo
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830784285a.45.1773148924663;
        Tue, 10 Mar 2026 06:22:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id af79cd13be357-8cd6d4f9469mr1830766185a.45.1773148922638;
        Tue, 10 Mar 2026 06:22:02 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd8576db0esm474754485a.47.2026.03.10.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:22:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:21:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Message-ID: <abAa9vQg4BSxl1BJ@redhat.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
MIME-Version: 1.0
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i2ZySG2a-eG_FrOqjN_CA9agazZWau71Ec3FRNFr1C0_1773148925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Brian Masney <bmasney@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 3375
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/R-I2ty6ZYnPDBwfrsIOv4g>

On Tue, Mar 10, 2026 at 12:49:22PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,

Semantic ...

> but not when the pointer was NULL. Now the warning is printed in both
> cases!
> 
> Change found with coccinelle.
> 
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

With the minor typo addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

