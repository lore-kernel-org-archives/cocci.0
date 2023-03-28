Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7422C6FD18
	for <cocci@archiver.kernel.org>; Tue, 28 Mar 2023 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/MMZPZ9/9i9N87G+MvML3EfsABuxYV02Z5MC9TT5Akc=;
  b=ofN7fbmD6eZ+n0Yg0JXUArYTTjfSIq8DoJ63K1V74FnoRulsacwlmGkP
   4oC5lChcw85gETw66+2sQxd9j2nbRwfg3GX0W8jZftO7RI+QWySG3WAFO
   H/QbN/zsC7Tzqup+w/5cvGWJJdS6dKgMAvT/tzNVy9z8QoiEQfnKI5z/4
   w=;
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
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99582514"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2023 20:51:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DB544E0D45; Tue, 28 Mar 2023 20:51:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 86F1AE0D40
	for <cocci@sympa.inria.fr>; Tue, 28 Mar 2023 20:51:22 +0200 (CEST)
IronPort-SDR: 64233729_s4XKDuuOfWP1C2NKWEeWtKhn912BrwRCXPbuPQDb72DX7Z7
 1wMPlv8XPO96dxfBCEmtcy6sQu5czIX4mSaYMyw==
X-IPAS-Result: =?us-ascii?q?A0E/AgAlNiNkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLoFLLwQLRoRTkQExhC+HLIc6iGmDFj4PAQMBDUEBAgQBAQMEOIRGAoU5A?=
 =?us-ascii?q?h0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARoJF?=
 =?us-ascii?q?wcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR1M9A?=
 =?us-ascii?q?wMjHQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQevGIEygQGCCAEBBpwKH?=
 =?us-ascii?q?ywiU4FeCYEULY0FgzZ6Jw+BVUSBPIEVgT5uiByCZ5lECoE0c4EgDoE9gQQCC?=
 =?us-ascii?q?QIRa4ESCGuBfEACDWQLDnGBSgJkTB+BASUEDgMZKx1AAgELOzo/NQYDCyAGW?=
 =?us-ascii?q?GsCCSMREwUDCxUqRwQIOQYbNBECCA8SDyxEDkI3NBMGXAEpCw4RA1CBRwSBD?=
 =?us-ascii?q?XwKBgEmJJ1TgQ6CdsMmNAeCKIFVgVkMnwwGEy6XCA4GkiMuhy0tj2Igp3qBe?=
 =?us-ascii?q?iOBXDMaJIM2TwMZD44gDA0JFYNujwkBPj80OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 vDIqwVsjPfRBL8L
IronPort-Data: A9a23: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
 D3GxkDNAw==
IronPort-HdrOrdr: A9a23:192DIajZH4UA2bQxJFWQgqyAo3BQXiwji2hC6mlwRA09TyX5ra
 uTdZMgpHzJYVcqOE3I9ursBEDtexzhHNtOkO0s1NSZPTUO2lHDEGg41/qE/9SIIUSXygce79
 YET0EUMrHN5DZB4/oSmDPIceoI8Z296rmhgeqb531xTQdsApsQljtRO0KhCFR/QAQDPYY0CJ
 bZxscvnUvaRV0nKv+gH3EAUqz4q8bVmImOW29/OzcXrDOWhTekrIX3CQScw34lIlVy/Ys=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="51520835"
X-MGA-submission: =?us-ascii?q?MDFzpZJMPT2CQRZ05YL6qBC9UTtdrAkDV0zBuk?=
 =?us-ascii?q?iVGOBA0OEV8XqJRge/dAbMlUTjhWeWZ/Sn33/gDjBUcBKT7gI0ZdjfMN?=
 =?us-ascii?q?P8lUmizgeJJKKKu4jjx4WxguhPHYpQbrdyJPlPUjTm3g/PsPIr1hWD6y?=
 =?us-ascii?q?vXTifjs0YWJXsH16r7WBo3yw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 20:51:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680029442; i=markus.elfring@web.de;
	bh=Clyq8wX31d7V0zzENqBlIVQIcpm3HQTJ81gipu5dnzg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=VPwtuVN9fxAw+lg3aZ54jtuqXF4m+2ATJR+MkmHt6LDJwmqDzfWTG00nXjSzYyTfa
	 h01Oz29Jywc9WNLx4QH35pEfMyd0jRhsSP5LGVsawfMm2Amx5ukKe7YbRn8e+boVGg
	 zKYYGNwLjIyDQkNVIgUlfTr0FdacaQitPJv1RAjqiosd+Pi6VCQ90vUBJUF5PVW3pp
	 SpACKok6u3bnmB9hMrCHb+bKZN6kbEkGld5ETbfUpbYsQocN83IRI4gt/VfASBAuzt
	 ryKu3OYCfsiWoTETTFl0X6MNeIwBZzBhUV0n0mj146I9T9hxPl3HJtDjgUOkWVLeQ7
	 Ml8j0hUK3g5gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UgI-1qVRMG0n98-016tng; Tue, 28
 Mar 2023 20:50:42 +0200
Message-ID: <0192f245-a0f0-290a-41ff-b75efa157a50@web.de>
Date: Tue, 28 Mar 2023 20:50:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <d9c673f9-2c32-282f-f261-b4d5762409bb@web.de>
In-Reply-To: <d9c673f9-2c32-282f-f261-b4d5762409bb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jTOQP/Hg1aFNnkk6qxZ2C3RacpY4pZIEpKpWV6rUcEO7LiZNUeB
 tmSJVOGVneO3ZiVvMiUmeWUt+MyKFn6HOBjMkGB0r/RVnT/e5hpal5Br5qSA30eqcckaUCl
 p50ndnnVSv0Lmell9ie421hJU6f60Hwbj1uAl9cXarw4v4T7yM7CQpWEvc8aS0FOit/FdGc
 cWPlfhcPvaLjFLciAbx7A==
UI-OutboundReport: notjunk:1;M01:P0:Xg8CkPzfIDg=;kgRv9TIF7O+wTew/c1SPpV9m2/A
 3mk03wUpIB3Q+5VfvaSFuOJ35V3zW2kEoDhu721Fgrp3S9kCHc92dTHrhj7rpnk5D1AijFFRw
 YgLlwNbT6EL7BKxmxaG5OrfcePX18gd4jpbION7/Glh0H6Tdv4iAi5EqKj1+yf7ftPd1kL0Wz
 Em4uXBPiRpTIeN/oEKjFSNS72ZkV4n7aFlYvyk1K1DpbpuBAF+19xDCXjj9ZvW/KnxLSFM/xe
 wQmRcPwtULzggZ2z5+HdbxoI+lU7oAz4ZwAzODd3G8k15KL2sUABclN7J2nUIOFCYuGnWlBPs
 o8D1D4zw3E3pv0sr6drdVspGiopR9nTxEnagwSqg6/0Xcm8o5n/7h53G2BReKji83Uxy3ksC6
 HSnW3wt+/fkv26z7L6M4m5ba1cGeGxXCItpOrFtOvUc8W6LSU8sOfzSBee1aRIdfhJuWzW8NC
 pYBxOh8RgblnU1+UHJYMpYtPRPzEczTTvPOjELKa+zhx8Ynjtkq053d6r06A4i7Fblo3k5wMA
 guqANrdMHvq8HxeHnBrlMZ8V0ifEupYXQK5J+z4h8acvwJe6BiQTPd7qlNhzwUbxSJqtX2vPO
 JM7YJz2TDBLARpewyr9FuKaOdpQFj1kyOnDgJh4W7wu13sBnkCIbzNl6MWgTw4wRi94fVet/b
 h713AoUBzDDioXrVjvsUPPh/9gV16QqBoxgh+Zrvvffo8aLuKmgt6sFSQ773Igm3Hk6C7PJel
 z1b41G9bh+mdekp6V7ojwfOSt29v3XDhml6Cl3jRKlC+h4hgxw467QF1/8rkA2W2/LOpFYA36
 kvZ9whT5lqJApkQCdiwA8MHC54+PNOU4lFdHEju7TwTDPm1hIREKhzxaEfdCHYV4IXBcONTEy
 rCoErLbVaft9BHUaQlCNU2DnO7IHBvQPQBzd8dnIy/sG7+UEtWPFmqo6o
Subject: [cocci] [PATCH 1/2] perf/x86/intel/pt: Use -ENOMEM directly for a
 return statement in pt_pmu_hw_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 975
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/0192f245-a0f0-290a-41ff-b75efa157a50%40web.de>

Date: Tue, 28 Mar 2023 20:22:05 +0200

* Return the value =E2=80=9C-ENOMEM=E2=80=9D directly without an extra
  assignment statement.

* Omit the variable =E2=80=9Cret=E2=80=9D.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/x86/events/intel/pt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 42a55794004a..93af27edded3 100644
=2D-- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -190,7 +190,6 @@ static int __init pt_pmu_hw_init(void)
 	struct attribute **attrs;
 	size_t size;
 	u64 reg;
-	int ret;
 	long i;

 	rdmsrl(MSR_PLATFORM_INFO, reg);
@@ -242,7 +241,6 @@ static int __init pt_pmu_hw_init(void)
 			    &pt_pmu.caps[CPUID_EDX + i*PT_CPUID_REGS_NUM]);
 	}

-	ret =3D -ENOMEM;
 	size =3D sizeof(struct attribute *) * (ARRAY_SIZE(pt_caps)+1);
 	attrs =3D kzalloc(size, GFP_KERNEL);
 	if (!attrs)
@@ -273,8 +271,7 @@ static int __init pt_pmu_hw_init(void)

 fail:
 	kfree(attrs);
-
-	return ret;
+	return -ENOMEM;
 }

 #define RTIT_CTL_CYC_PSB (RTIT_CTL_CYCLEACC	| \
=2D-
2.40.0

