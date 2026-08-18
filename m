Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0101C5DF6D
	for <cocci@archiver.kernel.org>; Wed, 19 Aug 2026 08:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=A5SA3qexvx0UXWIAtCFlkPfhyZbzB9r1OKgCFasYg5A=;
  b=rIc9AFYE43GxB3Z8QjsxpGlthJ+cc3rJQ+nwMAA1pcj0wfWYYQbObbqc
   pTjlpzCuMWEGTN1ozDG3J4oWXnyCWx0GEvIWyXMZfOMrvRBiTwA92GQc7
   g09dxTDxrnPGv9PLNzghAlwKJHfivldFBXVoSmeyGtdQmmIDvFcobwEnI
   0=;
X-CSE-ConnectionGUID: LoGWaUxiRvWAKP8B6NqOXg==
X-CSE-MsgGUID: UEMA9FztT/ioQFRmGmbVDg==
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
X-IronPort-AV: E=Sophos;i="6.25,231,1779141600"; 
   d="scan'208";a="290634350"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Aug 2026 10:02:01 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0F78A81BE2; Wed, 19 Aug 2026 10:02:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 12C27812D5
	for <cocci@sympa.inria.fr>; Tue, 18 Aug 2026 14:04:32 +0200 (CEST)
X-CSE-ConnectionGUID: JnumPCZ8R3qlsek16w6nmg==
X-CSE-MsgGUID: EDAu9gogTmCLMcJoWN02rg==
IronPort-SDR: 6a844a4f_imqqmAezzM1sAODWxv1jVHNYGzreP1yzNJbF5turrar1UM3
 96EqTYB3kDPARXiRmDaUfkakLmnTkkqBv5tMXYw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FrAQCaSYRqgarQVdFaglmCQRZ0XzMEVI1SiHmeHoF8A?=
 =?us-ascii?q?g8BAwELAQFEDQQBAQECBIR+Ao1sAh4HAQQwCQ4BAgQDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOO4ZPDYJbgSyBJgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAR0CDX4CAQMyAQ0BATcBDwtGMwEFARyDGwGCIgEGSwMDDrkFjSOBAYIMA?=
 =?us-ascii?q?QEG3DOBZgECAwYJAQoBAYE3jWGEeHonG4INhA8xPoJhAYIuhVYigiaBDIJhk?=
 =?us-ascii?q?ElICoEUA1ksAVUTDQoLBwVeRUMDNRIqFSMPPAUtHYEjIR0PCBd2GwYFEiAqQ?=
 =?us-ascii?q?UMBIwM+OIEIQQKBdT8jGTZ6gQlegSsqYQECEBdGLhWCCgKCc4EoXgIBST8LG?=
 =?us-ascii?q?A1IESw3FBkEPm4HjiwggX5EAoENLCCCKpMQk32fWoQohHOHLpU6TZdTkxmFP?=
 =?us-ascii?q?ZNLjgqWUIQ+AgoHBxEkgUQ6gVwzGggoCIMiEz0DGQ+OLRaIc8cGRDU9AgcCB?=
 =?us-ascii?q?w4DC5IcgUwBAQ?=
IronPort-PHdr: A9a23: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
 GRhPTbAArZT1v5uLD8zzgDbvpRLFLhXSqgWOHct
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:PXCf96qtCHY5roHnfoKYCK0aV5s9LNV00zEX/kB9WHVpm5Oj5q
 Pe5sjzhCWV+U0ssS8b+KH5BEDhex7hHP9OkP4s1dXLZmPbUQ6TXfxfBOTZskHd8kHFh5tgPM
 RbAtxD4b/LfCZHZK/BiWHSf7hQoqjjzEmGv5av854Hd3AUV0gP1XYJNi+rVmVSeSV8IbocOK
 XG0MpBzgDQI0g/X4CQHXkJNtKz1OEj2aiWLyIuNloC0k2jnDmo4Ln1H1yx2QofaSpGxfMH/X
 LemwL0y62/u7XjoyWsl1P73tBzop/M29FDDMuDhow8LSjtsB+hYMBEV6eZtD44jemz4BIBkc
 XKoT0nI8NvgkmhP12dkF/I4U3NwTwu43jtxRuxhmbim9XwQHYAB89IletiA1bkwntlmOs5/L
 NA3mqfuZYSJwjHhj7B69/BUAwvvlaooFI5+NRjzUB3YM87Uvt8vIYf9ERaHNMrByTh8r0qF+
 FoEYX1+OtWS1WHdHrU11MfheBEY05DWituA3Jy/PB96gIm20yQzCMjtYYidzk7hcsAoql/lp
 L525tT5fpzp+8tHO5A7bQ6MISK4zv2MEnx2SSpUBfaPZBCAH7Lo4P6+/Ee7P2xdPUzvfwPsa
 WEa19evXM/YAbVA8uU0PRwg3TwaVT4ZjjrwtxT/NxCtqbiSKHNOSmOIWpey/eIkrElDsrSRv
 qpfKhOC/uLFxqJJa95mzfzUYVXIXkaFM0Z0+xLIm6mk4b3LY3m39arAso7+4CDLR8vX2PyBW
 ZGRzTqOMlb8wSqVxbD8VHscmjgYlDy5481EKWyxZla9LQw
X-Talos-CUID: 9a23:0/LAyG7PFnrUpiDwbtss1kgJH/gOQC3nl27UOEK7UDh2FruQRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AJdMAmg6RTDnQxcy4i6wSCi00xoxFz42zWU8Knqk?=
 =?us-ascii?q?DkO2hPg53BBHF1i64F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,230,1779141600"; 
   d="scan'208";a="290533850"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFzLyqxQOkBj7OZUZqYdtmNMk1NLn3mVjJ3aE?=
 =?us-ascii?q?n6IEkcU8C43oX9hr6eJPE71vVZgesQNHQfaNvPm+Lu/fm3OR6isoj6YJ?=
 =?us-ascii?q?PybXwmyzgtXQKVNiH/p23poxyNogY1MWuqmBzKgyHhPS0ZAxKVLBs/J3?=
 =?us-ascii?q?1sQ8k7rYrxpuw07XAw7e9vWw=3D=3D?=
Received: from mail-lj1-f170.google.com ([209.85.208.170])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 14:04:30 +0200
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c7ce122c7so38004101fa.2
        for <cocci@inria.fr>; Tue, 18 Aug 2026 05:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787054671; x=1787659471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A5SA3qexvx0UXWIAtCFlkPfhyZbzB9r1OKgCFasYg5A=;
        b=TvGtyaJrZgu2yDHScn10iEUAJjwZzrAn5H6xotUAgK0gYNc7yJZlWds43Tw4r/VHX/
         VgF2+OOubzL7CjrZzPkzzK+ZaNvQjC71qqbg7dYCzIVb0MbMOJGdALh0MK5OvV3kCMT6
         u48iL6zLLDiDM9+8O6SP+4dTUtJcznUjZes1CjzZouuehc0NK34SyW55N/d05eil8Oxw
         N0EZVSti83PqX0eXch3SxBUk+PXcHug57QzLzzFwEKX9rwmmZhRM6JjSbDZVP0HfcfRj
         KSrcgl9iRwdHD3AKA372s+yUkW6A6lS2oxl5eneUAtl8Btm0iPkeAkr68NjwfwO79PE/
         4pQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqxdfv31El+17aiTXUUeY4PAfD3dJIHa6iJxYevploqGKfv9qbbicbsRXQ+wWZcSeN6qEx8zw==@inria.fr
X-Gm-Message-State: AOJu0Yy+1VnlMcL+0HcTDDrD2EFoj0slU5bYqzFeG7ng8JgKVZkaDAcU
	JKNv2Aj+aoBJVa+jKjLlX6MaJj1oBJn16uk0kSIku2H2Nj14e/KZlDeh4irQ2zrSdw==
X-Gm-Gg: AR+sD10JRPOuaZwSARcfzlBtkOdwi09GTSIDR72BL+4WlK2HRBmluYUIMB8y19AHAe5
	fqGUJTShUx163/LkOtnH+wpL6y8r0ltRpJOffjsIIuVjK3twVOcFC3AcQ+5Ei5pNoCsAWIXTz7e
	S74YmwB/v2k7jVjZPnuexeA4axgOXsyL0R3EdicrjSMU8LbaXXmv1q8pVDliHzvJdJsXDNbZQ9c
	9ifuRAYdP5irADXtR+iSyfI4I9Lwa8zqJjsQa8iDjkolgt6VxCKUrFKPkLOGiKFw60G0Wj9uunb
	D2KS6c2QqiT+8XNrGjCaU+oYJIIki+d+BSmGJsq2USUJBxXFT3AtHAnjS5JJN3sPSZOzPRHnLRd
	wsSmlCLrwYilvYVoS7SB4M2rBMfT6/aLUzEYiBlnVPrTxtDWPDfvCXic6oS4GKOYi22CMiC1e0D
	DWaKxBvxoKeYgoSqdNMsRXgfgUoBHGAi3wD8lKS+MWAYWpW9pnhnjB2LvTDkxV+iJAQJg9JKSLy
	kWcHT1RRfh5kL0kHgBk6ajw5c7xfPQepyNmDs3MAe2O
X-Received: by 2002:a2e:bc84:0:b0:3a1:39d7:c6ea with SMTP id 38308e7fff4ca-3a1751ee9b7mr13195061fa.11.1787054670724;
        Tue, 18 Aug 2026 05:04:30 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b204389sm12047321fa.42.2026.08.18.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:04:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: dmitry.torokhov@gmail.com
Cc: Julia.Lawall@inria.fr,
	bentiss@kernel.org,
	cocci@inria.fr,
	corbet@lwn.net,
	hadess@hadess.net,
	jikos@kernel.org,
	lains@riseup.net,
	linux-doc@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nicolas.palix@imag.fr,
	skhan@linuxfoundation.org
Date: Tue, 18 Aug 2026 12:04:28 +0000
Message-ID: <20260818120428.2546810-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
In-Reply-To: <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com>
References: <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: re: [cocci] HID: add documentation and Coccinelle script for FF
 registration race
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 3682
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/Sn2KhQZAxYiwX__k5aMP8Q>

Hi Dimitry

Looks like media-ci is not particularly happy about this patch:

https://gitlab.freedesktop.org/linux-media/users/ribalda/-/jobs/108127901

/usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file /builds/linux-media/users/ribalda/scripts/coccinelle/hid/ff_race.cocci --patch /builds/linux-media/users/ribalda --dir . -I /builds/linux-media/users/ribalda/arch/x86/include -I /builds/linux-media/users/ribalda/arch/x86/include/generated -I /builds/linux-media/users/ribalda/include -I /builds/linux-media/users/ribalda/include -I /builds/linux-media/users/ribalda/arch/x86/include/uapi -I /builds/linux-media/users/ribalda/arch/x86/include/generated/uapi -I /builds/linux-media/users/ribalda/include/uapi -I /builds/linux-media/users/ribalda/include/generated/uapi --include /builds/linux-media/users/ribalda/include/linux/compiler-version.h --include /builds/linux-media/users/ribalda/include/linux/kconfig.h --jobs 16 --chunksize 1
Position variable r.p2 on line 20 must be attached to some other token using @.
coccicheck failed


The following change fixes the issue for me... but you probably want to double
check it, I am not proficient at cocci.

diff --git a/scripts/coccinelle/hid/ff_race.cocci b/scripts/coccinelle/hid/ff_race.cocci
index 479f5d1e3184..7cf84936db13 100644
--- a/scripts/coccinelle/hid/ff_race.cocci
+++ b/scripts/coccinelle/hid/ff_race.cocci
@@ -9,7 +9,8 @@ virtual report

 @r@
 identifier probe_fn;
-expression hdev, flags;
+identifier hdev;
+expression flags;
 position p1, p2;
 @@

@@ -17,7 +18,7 @@ probe_fn(struct hid_device *hdev, ...) {
   <...
   hid_hw_start@p1(hdev, flags)
   ...
-  \(input_ff_create\|input_ff_create_memless\)@p2(...)
+  \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)
   ...>
 }


Regards!
