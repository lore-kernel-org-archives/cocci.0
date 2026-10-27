Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59723606A332
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=r2TIphDr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=R5y3TC+OxgWb2k2zCyoTeuDSWBjSf0l8Xg0k9asjKQ8=;
  b=r2TIphDrEOGCPFe5ggX1rAXlxbounaErnZlWqwUIXPXdR5hmTwxlSOfD
   m6ip9E675iI57Dh1HMG8/0rh6BdPWoqa85QBQmIZzGlDcDIq5YDw2RzaL
   sQ6VwZ/mlPKmaXryS72P9D5nq58kpxlMRVZ+si613/S6Djc4PcQpFy7d/
   s=;
X-CSE-ConnectionGUID: +AwsLPEnSz6Fe2kqW//p7w==
X-CSE-MsgGUID: W5WTMHkiSUmFM3dPVFVwrw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323108"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:14 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 84EC581693; Sat,  7 Nov 2026 11:59:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id CB08B816E2
	for <cocci@sympa.inria.fr>; Tue, 27 Oct 2026 22:48:30 +0100 (CET)
X-CSE-ConnectionGUID: A0PGgKmkTi6acD7GUKZMTQ==
X-CSE-MsgGUID: +fDnKCZYSP2wmO7Yoy3mzw==
IronPort-SDR: 6ae11c2e_nn5yFqaj4+kxs7l1zYc4tFMztSS/nc27sLkklf/BbSySZqd
 o1BO5DvAb+2xxRSKkz3LXuedlLAS75hLGUf94kg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HvAABOG+Fqj3u8fblaHgE8DAILgWWBblOBbTIEC0mNU?=
 =?us-ascii?q?oZZgiQwnWyBfAIPAQMBCwEBUQQBAQECBIR+Ao4YAh4HAQQwCQ4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBAQEBOQVJhk8NjBoBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDMgENAQE3AQ8LGC4zAQUBHAYTgwKCI?=
 =?us-ascii?q?wdLAwEDqyWNJIEBggwBAQbeIAkVAYE3jWN2hAN6J4IogRWDKz6LCIImgQyBe?=
 =?us-ascii?q?JROSAqBFANZLAFVEw0KCwcFgSVDAzUSKhUjDzwFLR2BIyEdFxF2GwYFEiAqQ?=
 =?us-ascii?q?UIBW4E+gQddgSspYAECH0YtFYF2AoJRgSNdAgFJQQ4HRVMJJUMSRyQiCBIJA?=
 =?us-ascii?q?RMaLguBGjU8CSZBFQxkCxoFGkgIAgsCDHcoERATHiAmLBgNSBEsNxUZBD5uB?=
 =?us-ascii?q?5FRhlqTTYMujxChEgeEIaFcTYNxk2KTHIgLkH2pGAIKBwcRJIFEOoFccIM3U?=
 =?us-ascii?q?AMZD447g2nORzg0PQEBBwIHDgMLgWiQNIFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:pl6mxapbuNgHM1N0/QeIBOcaV5tqL9V00zEX/kB9WHVpmwKj9v
 xG+85rsyMc6QxhP03I/OrqBEDuex7hHPJOjbX5eI3SPzUPVgOTXf1fBMjZskDd8xSXzJ8j6U
 4YSdkBNDSoNykKsS+Z2mmF+qcbsb26GfuT9J7jJh5WJGkBV0gj1XYaNu/8KCJLrWJ9dP8E/f
 SniPavjgDQCkg/X4CUBmQlQ+OGgNvXlJ33JScCDwMp7hKL5AnYmILSIly33go+TzgK+rsr62
 7D+jaJnJmLgrWUygL8y2SW1JhdmMLgxtxfbfb88fQ9G3HDihuIeI8kYLGJvCk0rOazrH4mnc
 LBuQ1IBbUH11rhOk+0vDrw0E3b3DEi52SK8y7hvVLvrdblRDUzFspGgpgxSGqq13Yd
X-Talos-CUID: 9a23:mD9VfGOGRQiWHu5DcXFf20E3H8MZcyPUx1uPDHKbO0NVcejA
X-Talos-MUID: =?us-ascii?q?9a23=3AUrTG4A72EU86mMsNLV5DNGNKxowr7YioK2s/oK4?=
 =?us-ascii?q?+4daBEnNBPCbGiSaoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,181,1787004000"; 
   d="scan'208";a="302598116"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEDJD3tCF45ZnaGfzdRzgsJxI56dvv16Pwisw?=
 =?us-ascii?q?/pkr59OnWIMedIQthWwN91cHVowAuPh3rb6SY11wEvvh/MDFNQP+fYKT?=
 =?us-ascii?q?vX1YFgQML7vVE4SblxGzaXZBUjVa7phYj972LOWhxdtA0boghfEZWQLz?=
 =?us-ascii?q?El82vseRjZj+SLnkUUsFOM9A=3D=3D?=
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 22:48:30 +0100
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1D0DF3F98E
	for <cocci@inria.fr>; Tue, 27 Oct 2026 21:48:30 +0000 (UTC)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab46165261so71205a91.3
        for <cocci@inria.fr>; Tue, 27 Oct 2026 14:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793137708; x=1793742508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R5y3TC+OxgWb2k2zCyoTeuDSWBjSf0l8Xg0k9asjKQ8=;
        b=SixZpWIWzYYoY58qE5TAI/sYrGmdfKh/4NOc0eeiNlyl/bi15F6Mt2w1MidRmFR89Z
         RFTTkaH7KqVkSsjHrsSVH1CxHt8cqY5eA53R5qstZ6+1WBacZKpRpJarKFYr0spm0r3d
         KEwfsOUepMPwzZvnPZyVaBySn8ysRO2s5FxKPIT0edz5fIJ9enAM29hp5MQ9teBMH0LC
         I+nvukFvktHrUU3YbsDktHQrMe87KVe6PKl5fqeufmSdc94KF9E0Luy5U3T3gRrJEVTT
         3MFCxAdEFrb+lfsAh0VjdFMDtLMbWMJcgYy4O9oVb0JWOfUHwLBcKYYCC4j3a69iqk90
         wJGw==
X-Forwarded-Encrypted: i=1; AKwUvBx0UaYNL+5WrWVMflYEMnX6HPRTkyDuVxNbgzGVdAU38HrHeqrbkMwWAzqm03wZomVvdk6TfA==@inria.fr
X-Gm-Message-State: AFq9FYIw4me3hkE19kyqy9KlnxCCVtopTG5wYDY6o8ghoDduieYwE8w5
	SpTvlrhx1vzDPAMvhU2qG6mXd4Ra/96ggbtZpe3mubMsdo5ie+9Shr/B84qBNPRuT+z/j2k0zaR
	AjaUL0p54f1P/KjDvMrpL/n+Dbpns5kh0mUQKePpe6PfVkLnKT0d1rjnugik0OOw=
X-Gm-Gg: AYBFou1U+ZCya5Ljcjw4WVD5f2Efm3SdgOtjHO66RPcHZSk1AG3x9jclxz8C9CQp7IY
	XN4OqI+XmqsIyy4Hs9dIwMSgHYuawsn9m+PVM4MSnskFdQ+TKBT7lR5IbmRrE+kjNcdmA3o43o6
	NuADHLfVAp6QLZI+Q0uihzlKA8RcMtAYT3SuqlE01slHtSoAJDGXFyVW3mErFqFSuipEjB3YQyO
	aUbuhk9xUMDswccub6uJ4YPo7JEQ2Vo9WkimdQC2QiaJJN7qPDJi9rvBVU5aW7HiJKGuhXco3DY
	3eljw6drevnfcutZ+Iv9ITrdlEgcKnIaSyaRFJX/b2+mqGvqSgiiw8oGdRwNxCjEQXp7dGCUOEN
	fc9j8HJyoFfdDp2AVMRrOdLsEkHHzsSkJeRAJBy5QAJ6HB7QD6wRp5Xaol+2/s+E4V66rMatjez
	1BW3NUaHIVMVmxwk+rlPTe4wx/ZpopJkt9/MuHIw1v7qLwZLOu509aZuZVvmNSm1MfMxAduKYxt
	AQSq6HiTKAi7a2VvsdGXgnrwPng6GjzY9VpyBW7og==
X-Received: by 2002:a17:90b:6d0:b0:3a6:e1d1:e511 with SMTP id 98e67ed59e1d1-3ae581402edmr428973a91.4.1793137708590;
        Tue, 27 Oct 2026 14:48:28 -0700 (PDT)
X-Received: by 2002:a17:90b:6d0:b0:3a6:e1d1:e511 with SMTP id 98e67ed59e1d1-3ae581402edmr428960a91.4.1793137708192;
        Tue, 27 Oct 2026 14:48:28 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-fcc4-d427-0dad-9764.dynamic-ip6.hinet.net. [2001:b011:2008:445c:fcc4:d427:dad:9764])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9a5e73sm37741a91.10.2026.10.27.14.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:48:27 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	cocci@inria.fr,
	linux-kbuild@vger.kernel.org
Date: Wed, 28 Oct 2026 05:47:42 +0800
Message-Id: <20261027214742.3624605-1-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <75e6d86340073638d966acb85465c28e6a08ceda.camel@posteo.de>
References: <cover.1792856688.git.an.wu@canonical.com> <263a607c3602f31a3f6fdd245e3c2008cdf97abd.1792856688.git.an.wu@canonical.com> <75e6d86340073638d966acb85465c28e6a08ceda.camel@posteo.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v6 1/3] serdev: handle devices without an ACPI
 or device tree node
Reply-To: ChunAn Wu <an.wu@canonical.com>
X-Loop: cocci@inria.fr
X-Sequence: 3767
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/uPLFeVgFuNM7Ti9c7j52kA>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-10-26 at 13:59 +0000, Markus Probst wrote:
> Reviewed-by: Markus Probst <markus.probst@posteo.de>
>
> You should add the maintainers for the modpost scripts to To/Cc.
>
> $ ./scripts/get_maintainer.pl scripts/coccinelle/misc/of_table.cocci
> scripts/mod/file2alias.c scripts/mod/devicetable-offsets.c
> include/linux/mod_devicetable.h

Hi Markus,

Thank you for the reminder. Adding the Coccinelle and modpost
maintainers to Cc now.

BR
    An
