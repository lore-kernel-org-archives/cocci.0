Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B97C54EFC
	for <cocci@archiver.kernel.org>; Sat, 25 Jul 2026 11:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=KQrRKf9D++Lr0hz35OIvB/crklMFi/5cNI6yOp5jHOw=;
  b=g+qyJ0oBfVD9ngaWvTP9/R82eLj0lJA0Fp1bZF16v1iS3Ivf6PvyI7aM
   qWiqm+WU6XDPGkJle67rZQlg9a/7q3oGPbvDx7CvPDe2o05kmqBZnvfK8
   tY/etprYte7SC0ZCoRVk/Q141cXNn6WVXLr3Kd4knKUrhI5A2JIGQHKDR
   M=;
X-CSE-ConnectionGUID: ibY/MAlvSzqHtT0HrzMk0A==
X-CSE-MsgGUID: 7oqxAojlRDOUvcBXYq2i3Q==
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
X-IronPort-AV: E=Sophos;i="6.25,184,1779141600"; 
   d="scan'208,217";a="287871730"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2026 13:44:43 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 84EAD805A7; Sat, 25 Jul 2026 13:44:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AEFBC802B7
	for <cocci@sympa.inria.fr>; Sat, 25 Jul 2026 13:35:31 +0200 (CEST)
X-CSE-ConnectionGUID: PBmsrDoWTcKfwjYe43VHJg==
X-CSE-MsgGUID: 9GEUuwkPSkCbv1T2uYJvCw==
IronPort-SDR: 6a649f83_iRonwDgUURbiQlMF7Mgdi+G6fl+xpnV479+R79mIsPJYMfu
 onQE6UepOqWuOqvd/7dmjBQJeC1ei5w3tRdlhhg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HkCgCKnmRqfCzYVdFaglkCgj+BaTMEVJUHBoE+iTGCG?=
 =?us-ascii?q?TACh1OKT4E/PQIPAQMBCwEBTwIEAQEBAgSEfo1jAh4HAQQxCA4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOEimGTw1JARABB?=
 =?us-ascii?q?AEBggGBJWECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBQIsYRYVCwENARsdAQMSEF0RAQUBIgE0gmCCIwEGEAEDNwIBtkWBAkKMP?=
 =?us-ascii?q?BYFAhaBAYINBoJq134KGSgNdYFmAgcJAQsBgTcBhHcqXQODUoMsX3WEAoEhg?=
 =?us-ascii?q?RiBEIR+hBBIhjAEgiJ6EpJAAQcHHxIIARwGCAICSBUSAwQDBAQBAgsTCQMDA?=
 =?us-ascii?q?g4CCAMCCAYZAT8SBBMCCAMGBAsHBR8KAgwUCigiEisKAyoLEg8DDQYFFQEIB?=
 =?us-ascii?q?gICBAQCBAwCCQICBQMEAgQNAwQBAQgCAi0DAQMZCAkIAgsFERgMCwcxAxAJA?=
 =?us-ascii?q?x8DFBsIRQgGFgEaBwUGCzcVBQwRAQIbAiEEHREIAwEYBAQCAQsDAQMBFQQIC?=
 =?us-ascii?q?QQMAhAKEhUDDgMHDwINBy4LAwIOAgkIDBcCAgIGAgMDAwoBAgEBAQEBAQECB?=
 =?us-ascii?q?wMDAwIDGQcGAwQEAQQEAwMCAwUBAwMDBQICCgYJAQEBAQMCAggDBwMKCQIFA?=
 =?us-ascii?q?xsDHAYBAgIDAgECAwYDBwgDDQMEAgMDAwQBAgIBAQECAwEDAwQDAQMDAgEDB?=
 =?us-ascii?q?wICAwMDCwECAwMDBQMFAQUDBQICAwUFAwUCAgoCAwMDAgEDAhwDCAMGAxIBE?=
 =?us-ascii?q?AMDBgEDBwMHAgQDCAQDBgIDCAMDAgkIAxYGAwMDAwUBAgICAwUDAwMICAQDA?=
 =?us-ascii?q?wQCAgMMAgYDAwMCAwMFAwMHAgQCAwYDAwMBAwMFAQIHAgMHAgELCwgDAgQCC?=
 =?us-ascii?q?QcJBwECAwsEAgQGBA0JBAIEAgIPBAQFAwMHAQECAQIIBQYDAgIRBQgKBQYCA?=
 =?us-ascii?q?gIdAyEBAw8GAQkFAgEFDgcFAgIKEgMGAgMEBQUBAwEKAQsBAQIDAwUFAwMFB?=
 =?us-ascii?q?wECBAIHAwMDBAMDAwMBAQICBAYEAwIDBwMDAwMDBAUFBQMCBQIEAwUDBwIDA?=
 =?us-ascii?q?wIBBQoBBAUECgEDAwMDBQUDAgIDAwQBAgQGAwQCAwECCAQGBQMDAwUCAwMCA?=
 =?us-ascii?q?gIDAwUBBQIDAwMEAwMDCAcFAwMFAgkDAwkDAwsCAgMhAgUDAwMDBgMHAwMEA?=
 =?us-ascii?q?wMDBwcCAwIDBwMCBQIHBQMDBQMGAQMCAQMDCAsSCRYDCwkIBwwBPAwHCiQEB?=
 =?us-ascii?q?AwqARQUBQQlGWcHBwKNdSOCPwGBDgF/ggtvAQEBpE6Le5NZgRYeCQEGAmCBZ?=
 =?us-ascii?q?4EKFQovoVsaM5dTkxkumFojpDeEPgIKBwcRJBKBNAE3gVwzGiOBAW2BSVADG?=
 =?us-ascii?q?Q+SI85JNTU9AgcCBw4DC4VeiSqBIIErFjOBTAEB?=
IronPort-PHdr: A9a23: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
 giP3TBEfTpUP8c=
IronPort-Data: A9a23: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
 avLelaw
IronPort-HdrOrdr: A9a23:aavL/qmzP8F4P+m7kbMxnAzie5vpDfIE3DAbv31ZSRFFG/FwWf
 re+cjzsiWE8wr5PUtLpTnuAtjmfZqxz+8X3WBzB8bbYOCFghrPEGgK1+KLqF3d8kXFl9K1vp
 0QF5SWZueAb2RSvILV5E2XHb8br+VvM5rFuQ4d9RpQpHlRGthdBs5CZDqmLg==
X-Talos-CUID: 9a23:wbSidmMVk0Re1u5DYANi71Q4Hf8ZeV7T03XhLhPjN0ZLR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3ATB4PPQzbQAJDTL0f8hEkNvlm5a+aqPWBJX0QjpY?=
 =?us-ascii?q?+gMqvPzIpB22AvRapaZByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,184,1779141600"; 
   d="scan'208,217";a="152929175"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHhjZbNC1Icnt1fAkNs+Wa2eH1Fu/w/YRK+iN?=
 =?us-ascii?q?EZafuNqxsWwZTqnaiyMcqSQxmbYP22Lj/JiRs/z9AMp46pnrbiJW+bfQ?=
 =?us-ascii?q?ERnIZ2gKpbrdi43FVjZEihP1AgI5tB6qaozhGytFV3YwXx2RS95wAwa+?=
 =?us-ascii?q?+ZZkTfHNKlWsjo8BTZkj7XIw=3D=3D?=
Received: from mail-pj1-f44.google.com ([209.85.216.44])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2026 13:35:31 +0200
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1322295a91.1
        for <cocci@inria.fr>; Sat, 25 Jul 2026 04:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784979329; x=1785584129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KQrRKf9D++Lr0hz35OIvB/crklMFi/5cNI6yOp5jHOw=;
        b=blq64959oXJnNWZThm5GRqeqWUkhDgvIIqIfUSKhhAtu6PsdaWrUncfDVw2T6QpLl0
         NYxTnh7u1IDViHvQBrednqO9enKmYvdU+5t0qhbj2KSp0f0pfc5qi0cDYcc3ysnAJ8+F
         0se/tdxHvdEf/PGJb0qCfz6feOO9dHN3JBcFAu1bJVSxQysz9sGJNTs/8PAzGIqxrLtK
         FFbcJtRITN3vINXf4eFZXynt/tip6KZ9mcfmzxY2pxMC6eehXagsSEepRsJQoPuYSDUO
         T0JrZpLv68l2KfM2wUSoiwECHb8fUXrdP2c6AWCoNj+/YdudRJnnxM3sg1pRM6c+brj0
         LmVg==
X-Gm-Message-State: AOJu0YxmdQa3MHHHjL2tFXqfB1la8r+RhSPH2q//ZT4CSIvcUDrYseyB
	FvHqtxcnTNQ/vuVA4YCsK1ImT0iQf6Vl00ahfM/4yCANc4zKQvbw1zPGUWthhPvG
X-Gm-Gg: AR+sD12QDCZI8tC8O0KufHTaYpOn2qebSq9NmDPtb0Txj5/0o4Pq85l5AD7/kBIjUUo
	TI3kiCEWF8WCNnwoHhFt+RaUCaGyZjo/VJ22wzObvLhvk7E5CTYgk8BbSe7zgUy3eGMauXiOdaP
	y/jS9SPBECcgoqqVrkani2I+ezpGjHy+yxTtr/ehQ130O1hXCnfwdrlipYz5yK3T2vIA6OPJD7O
	l9DbU0TUP5XQaN07CT9p5bKmCA+oYEDfFasMJqPHESAHynJJw5IiHCQYsdaIzeSXoFuja2n9UFy
	Jm+iVXFoAWwK61a37qc3LDtSQC/ooSTbiODTEdwFuCnvpklkt4QS5HmdgniZ8ZZPUnt8XKbfNeP
	1+GH4KCr+qaeJsVg89G6AIALMvLpref46CEJJEnrvWzlalMsaeoTsiwsBqbGp7QP2q9C9gPI9
X-Received: by 2002:a17:90b:5102:b0:38e:9e9e:ec57 with SMTP id 98e67ed59e1d1-38f298b8e38mr2003716a91.43.1784979328693;
        Sat, 25 Jul 2026 04:35:28 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f08ae3079sm1539083a91.3.2026.07.25.04.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:35:28 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Sat, 25 Jul 2026 20:32:38 +0900
Message-ID: <20260725113303.691676-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 0/3] coccinelle: improve performance of mini_lock,
 double_lock and minmax
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3655
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/3R_C_YiSEj02DhbIvKgGTA>

mini_lock, double_lock and minmax spend most of their time
searching files that have nothing to report. This series collects
the candidates first and runs the expensive rules only when one
exists.

For mini_lock and double_lock this also restores lost coverage.
For example, kernel/bpf/verifier.c exceeded the 200 second timeout
set by .cocciconfig, and coccicheck silently skipped the file.

The benchmark environment and command are as follows.
- AMD Ryzen 7 8845HS, 16 threads, 32 GiB RAM
- Ubuntu 24.04, spatch 1.1.1
- spatch -D report --very-quiet --no-includes --include-headers --cocci-file <script> <file>
  - timeout 200 is added for the whole tree runs

              kernel/bpf/verifier.c    whole tree
  mini_lock   812s -> 2.6s             1.5h -> 1.4h
  double_lock 12.2s -> 0.9s            2.0h -> 1.6h
  minmax      9.0s -> 1.7s             10.2h -> 5.5h

A report-mode run over every .c file in the tree produces
identical output for each script.

No functional change.

Sang-Heon Jeon (3):
  coccinelle: mini_lock: improve performance when searching loops
  coccinelle: double_lock: improve performance when no double lock
    exists
  coccinelle: misc: minmax: improve performance when no candidate exists

 scripts/coccinelle/locks/double_lock.cocci | 15 +++++++++++++-
 scripts/coccinelle/locks/mini_lock.cocci   | 24 ++++++++++++++++++++--
 scripts/coccinelle/misc/minmax.cocci       | 24 +++++++++++++++++-----
 3 files changed, 55 insertions(+), 8 deletions(-)

-- 
2.43.0

