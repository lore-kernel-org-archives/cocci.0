Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99381C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nfJKFlOAQT3b26bfEBxov9Z4SDbveEEBY9nEfGpb7Us=;
  b=IbiRaCdl//j2jgZb9pAEWHu0DnKBvbP/1MNsmgcew98Y0IqMRqX5iqjm
   vZataM7sseU6ZIcgrBXidUHJx7RXpJp7mYY71vi/sp/dOULaF+dMnamSO
   wHaqoQI6Y4DvY89WWuy/md7p0QhZ289M8yFX/B3GY241EubfEHqd6v7AA
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=permerror (signature expired) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208,217";a="213419968"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 10:12:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1F4F6E0D1F; Tue, 18 Mar 2025 10:12:59 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 76696E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Mar 2025 15:39:25 +0100 (CET)
IronPort-SDR: 67cef99c_s3f/bf4mbwD/xOSLMwogQ1kWL+pQl9ceVMXDlCtwYqaM3OX
 uDoY96jNOFwk/u73yvra104vbdOhyEFTX606HqQ==
X-IPAS-Result: =?us-ascii?q?A0FTAwCf+M5nfDHYVdFahSCBVjQEC0iEVoEjjiyCIZdCh?=
 =?us-ascii?q?mmBEQNWDwEDAQ1EBAEBAwSQHAIeBwEENBMBAgQBAQEBAwIDAQEBAQEBEAEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBIhkHDhIphXsNgluBLIEmAQEBAQEBAQEBAQEBHQImf?=
 =?us-ascii?q?REdAQE4Hgc3AiMSAQUBV4JggmUDonWBBUKLPoEygQGCDAEBBt4FCRSBNIhPA?=
 =?us-ascii?q?YFcAg6HfIEhgiiBSoJEhHiEFYJpgRSBH4QbgQyBbIozHRwtgWo7gSmETYRdV?=
 =?us-ascii?q?4JygnOIOyYmAwcHDitJDgENFAMmMywBVRMXCwcFgWwBAgGBDoFGejeCDGlJO?=
 =?us-ascii?q?gINAjWCG3yCK4RNgheCJUSDfYVQghGCBYFvQoZ8hGQuMh1AAwtiCz03FBtMo?=
 =?us-ascii?q?jyDWmuBDQETOoEjBx+Ta0mPTIIagTufUQeEHoRvnHMEL4EfK4I5jQmYZGcIl?=
 =?us-ascii?q?315o1YYhTQRI4FbI4FcgXEGgjBPAxkPkhvGZkEyAjoCBwsBAQMJhkiJVIFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 zYzgwp6JPwvrXLivwZxKV3Nqy891kI2nIe96Q0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HKg24Kp3M+zdZwW6pSdys2UaV5oGeYIsimQD101hICG9E/bo7v
 xG+c5w6faaskdyZJhNo6HiBEDiexPhHPxOkO0s1N6ZNWGMhILCFvAE0WKN+UyHJwTOssBYkY
 hte7VjE9HrZGIK6PrS0U2XF5IPzrC8n5xARt2z856ud2xXgm1bgTuRwzz7LnFL
X-Talos-CUID: =?us-ascii?q?9a23=3AkueLrGvfy9iWTy716mCIfGwf6IshbVT0/SbpJHS?=
 =?us-ascii?q?nDGp1TL6xYH2hxYF7xp8=3D?=
X-Talos-MUID: 9a23:N2JtngSJJBagxLKnRXSrmhdMNZ9I6J2UBW0xlppX4MW+JylvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,236,1736809200"; 
   d="scan'208,217";a="111158290"
X-MGA-submission: =?us-ascii?q?MDEm5Ck0yg7an6OjJGsJMp0CgWEjUhcH6bwxuh?=
 =?us-ascii?q?cBW//DKtBpaP/06FG8Nj1arvKGgTe5v2swmwYl1igBSUqJshS1/bAV5w?=
 =?us-ascii?q?P4QQjCPdWhHKZOp8BwvMPNNJdHsRUgGbWxA820oYpb78wG6h4Q384ikw?=
 =?us-ascii?q?BS43CqRgOJRRpqWoXm6RoidQ=3D=3D?=
Received: from mail-pj1-f49.google.com ([209.85.216.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 15:39:24 +0100
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so6091959a91.2
        for <cocci@inria.fr>; Mon, 10 Mar 2025 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student-rau-am.20230601.gappssmtp.com; s=20230601; t=1741617562; x=1742222362; darn=inria.fr;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nfJKFlOAQT3b26bfEBxov9Z4SDbveEEBY9nEfGpb7Us=;
        b=UI6tjTTL2wBZuyRYahD1O7/j4DagYT8LQ1YThRptZybPkl1hkgl19/IC5mBR6RuvxF
         CJHpkTryKJtubOJjKHDGMjyGJF3tr7zjgdz9dIBoCR4aBmN2TqYIZ4CQQwAN01yJHjuQ
         HvE4JdtqikZIVN47sKVuPxLSCYrkWbj6zFW4bcGPSXu95ceMoBB6uPkcnVAGC08N4Gi0
         s/iXGaMczjgC8qmkoqMt64T8KrQaadgh2gs1zGlN6N70WPEPlLXmzCg3N1D5HCvrl2XJ
         YkxJ+j+3gVULb6mxlR/GgVddV3GjvDpNiuiGJj/aS+Jav5KQpuZWwZ6TW49rx2UPYW6I
         dONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617562; x=1742222362;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfJKFlOAQT3b26bfEBxov9Z4SDbveEEBY9nEfGpb7Us=;
        b=JcLfFWnk2hg5ZPZhDcFEexlj8QeAMP2BF6Kw1JpfQfXczB6eNr/xrW7nbXdCXxmhSj
         Y/vDWD2s0ff5cbVkvsm75zirrt8zcumwclTs5y9WbMSC/CT/8sCEXvYnbMDJiHq6GcCx
         s1XkKA6I7fU5UO8Orki07LNys8tTYdjMVCEANhHWVszvC+MW+OVZfJ5pgK09n49+/8mA
         MIQluQIQ73iyY1DSnEhsgm8eTBJ8djrfp/bE09k/S89sqH5yTPr7IJiiD5w3kJ3nshoQ
         JZMUZNrjWOkJ0YZs3sCAtR7DP1fFQstbEn3oWmyhnioh+awpZK61f5aAWPFIIlec54nG
         fdgA==
X-Gm-Message-State: AOJu0YwSo0IfgtKwc5z1pxD8B57WdNxC2iLFxrjtWUh36gtzA6gJWYTe
	e0jfEycdEgzo9vkUdweY7sFnf0kJqbt+/G+miNzMix1/RudfhhXpGR7S+wCJRBtCQBIDngM1DNO
	atexxwoUtX/3r+YE7U1Tnf9NwM/CzRLVjhushIyWeCvV6yLUD/ic=
X-Gm-Gg: ASbGncvyN3vTyMb0nJo0bY4vAtLuW4dFnnAclYFGAQBh3d9QpUYnkiBVc+W74Ne0MMJ
	NVUXyIuLu1K7M6/OuP0b7C9eDO7ZkutejoJFwdDe3sF4HRXQUYsJHFIVvEH1xPFuNBUqjtJMjro
	w+K8cI4KbE8GDYcJsEyBvl2vjqObE=
X-Google-Smtp-Source: AGHT+IEP38xWnejMVACulDji5mMkoWn+gCvUFdi8LNHYRPN5iul0+uh4BTVtkhsra0TDyJHxLLGpawcKutPiqv6WCpE=
X-Received: by 2002:a17:90b:180b:b0:2ff:5357:1c7f with SMTP id
 98e67ed59e1d1-2ff7cf3d0bfmr19628373a91.30.1741617561718; Mon, 10 Mar 2025
 07:39:21 -0700 (PDT)
MIME-Version: 1.0
From: Edgar Khachatryan <khachatryan.edgar@student.rau.am>
Date: Mon, 10 Mar 2025 18:39:10 +0400
X-Gm-Features: AQ5f1JovisZGUDsaoFya__J_ANJd2rZLmvfg58l4qaMmVR9UF5Fp0-ssHqWZg9I
Message-ID: <CAN1=rvJBSpCq35PY-tTFomZ17wNBRN=bNV4vwKTV-TgYe38FdQ@mail.gmail.com>
To: cocci@inria.fr
Content-Type: multipart/alternative; boundary="00000000000019f245062ffdf0c9"
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] Detecting Use-After-Free and Analyzing CMake Projects
Reply-To: Edgar Khachatryan <khachatryan.edgar@student.rau.am>
X-Loop: cocci@inria.fr
X-Sequence: 2605
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/CAN1%3DrvJBSpCq35PY-tTFomZ17wNBRN%3DbNV4vwKTV-TgYe38FdQ%40mail.gmail.com>

--00000000000019f245062ffdf0c9
Content-Type: text/plain; charset="UTF-8"

Dear Coccinelle Team,

My name is Edgar Khachatryan, and I am a student currently working on a
project that involves static analysis of C programs. I am particularly
interested in using Coccinelle to detect use-after-free bugs.

I have found and tried to use the kfree.cocci semantic patch provided for
the Linux kernel. However, when I run the command:
spatch --sp-file kfree.cocci file.c

Although I am certain that file.c contains a very simple use-after-free
example, Coccinelle reports the following message:
No rules apply. Perhaps your semantic patch doesn't contain any +/-/* code,
or you have a failed dependency. If the problem is not clear, try
--debug-parse-cocci or check whether any virtual rules (e.g., report)
should be defined.

I also tried running it with --debug-parse-cocci, but I am still unsure how
to proceed. Could you please advise me on how to properly apply Coccinelle
to detect use-after-free issues in simple test files? Am I missing specific
steps or dependencies when using kernel semantic patches on general C code?

Additionally, I would like to know if there are any recommended ways to run
Coccinelle on CMake-based projects. Is there an established method to
integrate Coccinelle with CMake builds, or any workarounds you would
suggest for analyzing such projects?

I would greatly appreciate any guidance, documentation, or best practices
you can share on these topics. Thank you very much for your time and
assistance!

Best regards,
Edgar Khachatryan,
Russian-Armenian University

--00000000000019f245062ffdf0c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Dear Coccinelle Team,<br><br>My name is Edgar Khachatry=
an, and I am a student currently working on a project that involves static =
analysis of C programs. I am particularly interested in using Coccinelle to=
 detect use-after-free bugs.<br><br>I have found and tried to use the kfree=
.cocci semantic patch provided for the Linux kernel. However, when I run th=
e command:<br>spatch --sp-file kfree.cocci file.c</p><p>Although I am certa=
in that file.c contains a very simple use-after-free example, Coccinelle re=
ports the following message:<br>No rules apply. Perhaps your semantic patch=
 doesn&#39;t contain any +/-/* code, or you have a failed dependency. If th=
e problem is not clear, try --debug-parse-cocci or check whether any virtua=
l rules (e.g., report) should be defined.</p><p>I also tried running it wit=
h --debug-parse-cocci, but I am still unsure how to proceed. Could you plea=
se advise me on how to properly apply Coccinelle to detect use-after-free i=
ssues in simple test files? Am I missing specific steps or dependencies whe=
n using kernel semantic patches on general C code?<br><br>Additionally, I w=
ould like to know if there are any recommended ways to run Coccinelle on CM=
ake-based projects. Is there an established method to integrate Coccinelle =
with CMake builds, or any workarounds you would suggest for analyzing such =
projects?<br><br>I would greatly appreciate any guidance, documentation, or=
 best practices you can share on these topics. Thank you very much for your=
 time and assistance!</p><p>Best regards,<br>Edgar Khachatryan,<br>Russian-=
Armenian University</p></div>

--00000000000019f245062ffdf0c9--
