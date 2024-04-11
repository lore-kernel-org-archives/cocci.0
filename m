Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F26C4345F
	for <cocci@archiver.kernel.org>; Thu, 11 Apr 2024 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MXtg0g9sBVz3d9qMRPkmGWgI4RPJHijlxYzbBZYzNGU=;
  b=aqpsbBnIIEHLklvLuu8AS9iRHvg62ZaSUMPYuTTZvdKv8CKSFqX8ZA8x
   GxfkcMZkmQRTUvIt3m0dKX6pjymN3KjW4nm+ndOxERCYiNiyUT9AUgRRu
   zVb3sA20wp88xThNXvHQmSwNZPsO5vGOHL+XYO6kGLVqAqE79My2SgXcF
   Q=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.07,193,1708383600"; 
   d="scan'208";a="161133887"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2024 19:46:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6D84CE02E4; Thu, 11 Apr 2024 19:46:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0B3C1E0131
	for <cocci@sympa.inria.fr>; Thu, 11 Apr 2024 19:34:00 +0200 (CEST)
IronPort-SDR: 66181f07_N0zx47jt/kSe0L3HheBIWejxyzdOdzaae1tLvFfsy+D3fGe
 DMtFZMBl/AV0OKxcGhhmDpoZi5UNOVe4zLBQA6A==
X-IPAS-Result: =?us-ascii?q?A0FdAwDNHRhmfyunVdFaHgENLwwOCwmBT4JEgVEzBAtIh?=
 =?us-ascii?q?FaPRoIinguBfg8BAwENRAQBAQMEhVAFh0MCHgcBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEIAQEFAQEBAgEBAgQGAQIQAQEiGQcODimFbQ2CYIEmgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAg2BFBEdAQE4JQ8CJgIjEgEFARZBhT4DpQCBBUKLO4EygQGCCgEBB?=
 =?us-ascii?q?twdgWEJFIEGLogsAYFZh2SBIQ+BVUSBSoEGhz2DDoJGIo8qSogXSINyhD8mC?=
 =?us-ascii?q?R0DBwcQK0kRBRwDWTIBVRMhCToLBAwaAhsUDSQjAiw+AwkKEAIWAx0UBDIRC?=
 =?us-ascii?q?QsmAyoGNgISDAYGBlsgFgkEIwMIBANQAyBwEQMEGgQLB3WBRoF1BBNEAgEQg?=
 =?us-ascii?q?TKKF4M/giKENE2FEVcBAgFDHUADC2ILPTUUGygnoWQBgSYlLVJYA8UDNAeEF?=
 =?us-ascii?q?oFbBgyfWjOqNJhiozWFPxEjgUE6gVwzGjB0BoIwTwMZD44sFohsmSxFMjsCB?=
 =?us-ascii?q?wsBAQMJiSKBSAEB?=
IronPort-PHdr: A9a23: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
 sNmdw==
IronPort-Data: A9a23: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
 U7Keg==
IronPort-HdrOrdr: A9a23:il4aCKqXfkxxp2E6JV2+HUcaV5omeYIsimQD101hICG9E/bo8P
 xG+c5w6faaskdzZJhNo7C90cq7IE80l6QFg7X5VI3KNGLbUQCTXeRfBOXZslnd8u7FmtK1F5
 0MT0GzMrLN5JFB4/rH3A==
X-Talos-CUID: =?us-ascii?q?9a23=3Aq4TmqmjujyCkR4+/QH7u0nacIDJuamPD537UHm2?=
 =?us-ascii?q?CUGNIYayvc1LPxY5hjJ87?=
X-Talos-MUID: 9a23:kBwn4QUYATwSUG3q/AG1uS1eNuNV2IS3ClJRuKQb+OnDKyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,193,1708383600"; 
   d="scan'208";a="161132671"
X-MGA-submission: =?us-ascii?q?MDE3pxjQVeHHOVgz2LP5k/p+iEGtNElJILVl3g?=
 =?us-ascii?q?PArCp3gfS6U3KKl2X4+9r0MMKZzylQ12blG+anhV/mhDjdiNuLWULX8R?=
 =?us-ascii?q?uLIrspDPDumZW67/lJJn/Ay5QpwoLyf8ZcvwWZoNG72b6k1qgk/JiDQJ?=
 =?us-ascii?q?NlmZRItY9nQQrbbk1qA8RY8Q=3D=3D?=
Received: from mail-lf1-f43.google.com ([209.85.167.43])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 19:33:59 +0200
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5171a529224so121014e87.0
        for <cocci@inria.fr>; Thu, 11 Apr 2024 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712856838; x=1713461638; darn=inria.fr;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MXtg0g9sBVz3d9qMRPkmGWgI4RPJHijlxYzbBZYzNGU=;
        b=Vc7B35itsIlsO/vfuFiuen5EpVHsVxBVs5Go1Nd2vNmWYl3y3qOsD33b6QoTzZTElr
         cb+LkQHKlqcApnTch2Cjb78D+tZ/yo6hzYS7BwrB5EBFe/OdMpWZ0EkU/xJlOMqyqTbY
         9kSA9S6fFjxByiU5H1Aoq2qMhK3n/3UIeVI52T9ORjyCUlPhoCbo7VwP23ANlz2evM77
         rmNlAThHk9ZZWtO79asoWliBvFT09RVLcjE1bU2y9SNpV5Xd6MJkH3pxrgxoGhrtBefn
         jwvdKOn8W9Sw1MxumvtLM4mdagk+4GDq7cxVQqxnJr5QL5HsZF2tVDPpOkVnfz3i2XxM
         r8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712856838; x=1713461638;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXtg0g9sBVz3d9qMRPkmGWgI4RPJHijlxYzbBZYzNGU=;
        b=p9SY6fP+0adLySPs9a3MOLY2FBTKcNekcW5ClIYEO8BC+Kh5wiVoYEP+1kcc1Qt8Mn
         elThLROg9ChCKN6HCsMnUjX2VAqOY2sWSMhuqz8KJB7Ykh2VXNckAMvIcu3/iq2pwhV5
         CYnMYfl/QgOljiwScMKW8gJWUoyZDH+/MEsf0t5VsUHQWq2m2TVkn4BoDquD6agTx8cu
         oYsm0F21j2YKurYNLSlPgvwvy9ADHy5bMHh6BDFEv6XqZFWaPSG2zPO2TXJDkHEpUIKG
         39B4RXPpERSabGcrMCyLEvU0wenw9L108F/rp4HFGsbEcs3QwEqlm6ZLLIUEc3t3Xagg
         gHMw==
X-Gm-Message-State: AOJu0YxRocWVQ8ZLXz7F4uAWt5nhaI1PgdNqCf+YxYENq/Du+Ch5Hkbm
	7iffil6xYlfapwBR3WwaLs5xlTQHtQXhNc6CwliPTRVwsIpepE+r2GnU+oQG25ogFx2kEfk9CAF
	dbCdRSNakrYmo1VhYHlLo66sPlUveJIsLYMgSMgu/19UKoHkS
X-Google-Smtp-Source: AGHT+IEkPfCSA+K42/aTKFK22819I5my+PiY75cPlnq5TC+/UvzzxNrUtrufMcpn8HokAgZPJKW1vFpwK9glBQZt7/g=
X-Received: by 2002:ac2:5615:0:b0:516:d55b:3124 with SMTP id
 v21-20020ac25615000000b00516d55b3124mr251800lfd.18.1712856838310; Thu, 11 Apr
 2024 10:33:58 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2024 18:33:47 +0100
Message-ID: <CAFEAcA8vr4tPAWy=cHKCfAafjZXfccb=ppquuKwZV5xhnwPQBg@mail.gmail.com>
To: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] making a coccinelle rule apply only for a specific file
Reply-To: Peter Maydell <peter.maydell@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 1636
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/CAFEAcA8vr4tPAWy%3DcHKCfAafjZXfccb%3DppquuKwZV5xhnwPQBg%40mail.gmail.com>

Hi; I'm trying to make a coccinelle rule that only applies when
a particular file is being processed. Looking at the documentation,
this seems like the 'depends on file in "..."' syntax ought to work
for this, but I'm getting weird results where the behaviour depends
on how I invoke spatch. Here's a test example:

$ cat foo/foo.c
#include <stdio.h>

int main(void) {
    printf("hello world\n");
    return 0;
}
$ cat test.cocci
@ test_rule depends on file in "foo/foo.c" @
@@
- printf("hello world\n");
+ printf("goodbye world\n");
$ spatch --dir foo --sp-file test.cocci
init_defs_builtins: /usr/lib/coccinelle/standard.h
HANDLING: foo/foo.c
$ spatch foo/foo.c --sp-file test.cocci
init_defs_builtins: /usr/lib/coccinelle/standard.h
HANDLING: foo/foo.c
diff =
--- foo/foo.c
+++ /tmp/cocci-output-756201-03be74-foo.c
@@ -1,6 +1,6 @@
 #include <stdio.h>

 int main(void) {
-    printf("hello world\n");
+    printf("goodbye world\n");
     return 0;
 }

As you can see, if I tell spatch which files to operate on by
passing '--dir foo', it says it's HANDLING foo/foo.c but doesn't
actually apply the rule. If I tell spatch to operate on foo/foo.c
specifically then it *does* apply the rule.

How do I write a "depends on file in" rule that works
regardless of how I specify the files for spatch to work on?

Side note: is there a way to get multiple "--dir" arguments
to do the right thing? I'd like to tell spatch "process
files in directories foo and bar", but the obvious
"--dir foo --dir bar" doesn't work: it tells me it is ignoring
all but the last specified directory. At the moment I work
around this with "for dir in foo bar; do spatch ... --dir $dir"
but that's a bit awkward, and it would be nice to be able to
pass multiple directories on one command line.

thanks
-- PMM
