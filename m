Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5583D5E38C
	for <cocci@archiver.kernel.org>; Sun, 10 Nov 2024 01:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jWZyijPCFFxJ/X5A+ZuqEhb5ZV1Kkcz5OZR+SNubC8E=;
  b=afcwCg7LfCiyE8f7XQgH4zWEut0b5l17cNLmBymT1PBQG8Fi2zK3i8rY
   Ck6K3rZ69KLzt3wqbVWVsp2AtWs7v6hlZ0rnTPUGml1Y0B024zeQdP4nG
   YwfAqnWKV0Bk+3b3QtV8ZSTRW3sei7M65CvG/JHsINGb3G3BJER3IgK/u
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="193077154"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2024 02:37:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E2446E0D22; Sun, 10 Nov 2024 02:37:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1C233E00B7
	for <cocci@sympa.inria.fr>; Sun, 10 Nov 2024 02:37:17 +0100 (CET)
IronPort-SDR: 67300e4c_6N4ZOrjsUsfbHwbGgDpyOXSCPx6PU9rBqUmFJswvBtxuBvQ
 Xe1WLqE4ODwBgbMe3UncqgTdIZf6/vLJIQsxvlQ==
X-IPAS-Result: =?us-ascii?q?A0FaAQCQDTBnhdlUsotaHgEBCxIMgggLgkSBVzMEC0iNU?=
 =?us-ascii?q?qcKgX4PAQMBDUQEAQEDBIUAAoo7Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBAQFASYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdA?=
 =?us-ascii?q?g1+AgEDMgENAQE3AQ9RVhmDAYJlA7IYgQGCDAEBBtwfgWQJgUiFaodccIN9e?=
 =?us-ascii?q?icbgUlEhA5vhApOOIVVIoJHhRwlhyqBa4FvjBodM4oASIEhA1khEQFVEw0KC?=
 =?us-ascii?q?wcFYIEXA4JWeiuBDoEXOoF+gSJKg1iBQkY/gkppTTcCDQI2giR9gk+FHYRvZ?=
 =?us-ascii?q?y8DAwMDg0WCQEADCxgNSBEsNRQbBj5uB544RoJ6NIEOMIFISKVeoQOEJIFjn?=
 =?us-ascii?q?1waM5c/kw6Yd6Q9hGaBZzqBXDMaMIMqTwMZD44hGR+IVsEQNDU7AgcLAQEDC?=
 =?us-ascii?q?Y5DNIFLAQE?=
IronPort-PHdr: A9a23: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
 UJg/A==
IronPort-Data: A9a23:OpGQVK1XiHh9YcnRcfbD5T91kn2cJEfYwER7XKvMYLTBsI5bpzFRy
 jZKD2COOf3ZZ2b2coh2PNzl9kxX65XXm943HAI/3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8gVaYDkpOs/jf8Uo37ayp0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJWybv/KQzFngWAdIVo80nAk9F9
 ewBAhlYO3hvh8ruqF66YuVimYI4K9TxN45ZuXx6yzzdS/E8TvgvQY2Tvo4ehWhgwJASW6yHO
 KL1ahI3BPjESxhGIV4XCYg5jc+ri2P5fjker0iazUYyyzGLlVYpiOW8b7I5fPStBuQNmRi6/
 17H4mfaIikdH/jE632spyfEaujnxn6jBtJNTdVU7MVCi1qYzW07EwwTTVL9oP+ji0f4Vcg3F
 qAP0iYgsu4p81GxRdS7XBCipnOA+BkGVLK8DtHW9inQyZWFvhygJlRbQ2dqON8Iv88mXBYDg
 wrhc8zSORRjt7icSHS4/7iSrC+vNSV9EYPkTXFfJefiy4e9yLzfni7yosBf/LlZZ+AZ9Bn8z
 S/Mty8jnb4ey80GzaO2+RbAmT3ESnn1ouwduVq/soGNt1IRiGuZi2qAsgezARFocNvxc7V5l
 CJY8/VyFchXZX13qASDQf8WAJai7OufPTvXjDZHRsZ6rm3ypCbzLdoMuVmSwXuF1O5aJFcFh
 2eN5mtsCGN7ZSryBUOKS9PrUppypUQePY25D6i8giVyjmhZL1LfonExPCZ8LkjgiVUtl6Avc
 YyWa9itBnsBQaVhx3zeegvu+eFD+8zK/kuKHcqT503+gdK2OiXPIZ9bawTmUwzMxPjfyOkj2
 40Eb5PSo/ieOcWiChTqHXk7cQpVdyZhXs6v+6S6tIere2JbJY3oMNeJqZtJRmCvt/09ej7gr
 yHjCHxLgkHyn2PGIgisY3VuIuGnF5VmoH5xeWRmMV+00jJxKcyi/YUORasRJLMHze1EyeIrb
 v8nf87bPO9DZA6a8BsgbL78jrdYSjKVuSy0MRCYPQcPJ6xbe1SR+/vPXBfeyy0VPy/m6eo8u
 +KB0y3Yc7oiRiNjLtzkWNCy/WyuoHJGuuRTXlTJEPZXak7D4IhnEA2vr/4VcuUnCwTP+Sue7
 CmSWSwnnOjqp5Rv1svknoWGktuZKPR/FU9kAGXr17a6Gi3E9G6Fw4UbcuK3UR3CdWHzooOOW
 P50yqziDfg5g1p6iYpwPLJ1x6YY5dG0hbt7zBxhLUrbfWaQFbJsDXmX7/Zh7pQX6OdihjK3f
 UaT9v1xG7aDYprlGWFMAjsVVL2I0PVMlwTC6fgwHl7B2xZ227i6SmRXAQiHjX1MDblyMb59+
 9wbhuwt11WdhCYpY/G8tQIF00SXL3cFbbcriYFCPq/vlTgQ6w9jZb7yN3bIxa+hOvR2HGskG
 Du2vJb5pq99wxPCekUjFHKW0ut6g48PiS9wz1QDBgqon8bBjfpq2Bd6rCo8Sw9U6j5l0OtDH
 HdhGGMoBKeJ/hZu3NNiWUL1ES5/JRSpwG7D4HpXq3/oFGyTSX3rEG0xHc2v7XIp2TtQURYD9
 Y7J1Vu/dyjhef/A+xcbWGlnmqTFdsNw/AiTo/KXNZ2JMLdiaAW0n5L0Q3QDribmJsYDhEfng
 +1O18QoYI3ZMR8gmYEKO7O4558xFi/dfHdjRMt/9pwnBWvfITG++QafInCLJ/9iGab4zl+aO
 edPeOR0SBWM5ASfpGs6BIkNAYNOstwH2d4gQo7vdEk66+axjzwxq5/B1DnMtElySfVUrMsNA
 IfwdTWDL2+uuUVpi1L99MlqBkfoYP0vRhHN4+SuweBYS7MBqL5NdG8x4JuVvlKUEghV+RmJt
 1mSPqTT6ehGzJholI6xFq9oWhu/LNjycM+q8wmDlctEQv2SEMXJtiIT8kLGOSYPN5Qvet1Hr
 5a/m/+p41H055MNTHH/p5mNM4Jr9PeCdrNbHeyvJUYLgBbYftHn5iUy3lyRKLtLoYt73damT
 Q7pU/mAX4cZdPkFzUIEdhUENQgWDpn2SaLSpSmdifCoITpF2CzlKOKXz1PYXVt5RAQpZaKnU
 hTVvsyw7O92tI5PXR8IJ893Cq9CfWPMZ/EUSM3ThxK5UE+TnVKwipnzn0EB6BbKKEW+PuTU3
 JbnfiX6JTOO4Pzm7dcAv4JL60hdSD43hOQrZUsS9uJnkz3wXiZMMe0ZNo5AEZ1O1DD70Jbjf
 jzWcW8+EmPHUC9ZdQnnqsHWNutF6jfi5v+iTtDow6+VV8tyLI+OH/168Tp66HoweTb5yuyjb
 9YE9RUc+/R3Lo5BHY4uCj6T2I+LBc82AloL9Fr7nsi0BAwRaVnP/GI0BxJDDEQrDOmU/Hgm5
 gEJqaRsQ0yhT0P1V8F6dBa53f3fUCzHl10VUMtE/DoTV0h3AgGNJD0T9twfCoE+Ufk=
IronPort-HdrOrdr: A9a23:IaHi5K3gHxOqJrk0e3CZ4wqjBL0kLtp133Aq2lEZdPWaSKKlfq
 eV7ZImPHrP5Qr5N0tBpTntAsW9qDbnhPtICOoqTNCftWvdyQiVxehZhOOIqQEIWReOktK1vp
 0AT0ERMrLN5CBB/KTH3DU=
X-Talos-CUID: 9a23:Zax9hGyfyTcNKLNYao+dBgVJGf90L2fk7EuPLhaTWWVHQ72FUHW5rfY=
X-Talos-MUID: 9a23:u0ge6QhQqM5FIMWhpxM7n8MpE4RJu6PwKhkxkIgFmOm8MgdUYBXapWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="101200597"
X-MGA-submission: =?us-ascii?q?MDFtpApn+fatqq/iuRhw1MbCQvmxKipoUvk7h0?=
 =?us-ascii?q?XPhXhf8nQfS0tgA1j+QnCa3TIXNh9OUEsrh+02bZ2h/YyqXXPS1i5aTE?=
 =?us-ascii?q?LD4JN9QG19FlNWykN8355afI/Mh3iGrzOKRfkQTdN7z5jvVuoANU/RGB?=
 =?us-ascii?q?ASXgTcYI0OTn+J3BXS2BlLCw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:37:16 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DE5425C0173;
	Sun, 10 Nov 2024 01:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D9BC4CED5;
	Sun, 10 Nov 2024 01:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731202635;
	bh=0zuP6CP79N07MZokL7X/3TUXckWFEXEyNFcF1B4viqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rh5R+UeYAqhDksHA37rS7cnbCjErm90Vq0kIK+C07uxDHBWJv+/AUidbid8iZ/yWJ
	 ISIiZzgjZKfQO88nG6mL69Ns+mUF9dbV4uutOVbmLF1rtK9oc5HQ0o/AgTHFj7PRqc
	 P1sDAazQJF+7K2Gi3TMaigW+JRyOKyKdOQp16aZpjCTfjJxSPMfuFNiNecd8mG70lb
	 bCe9/pENPgONCF2E9LFI1CmGs6Vr0xoFWHqT/zGf/gjw2n1Y2+Zbrr9BsCKHXzzjni
	 8PDbNRwEWosRBNlEoe3RLy65EgeX7o3E++Pfvp3SNvj/Z1TUKzJ5OiY3yL6nszXv2S
	 mp3dbi8zFefDA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	cocci@inria.fr,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Date: Sun, 10 Nov 2024 10:34:38 +0900
Message-ID: <20241110013649.34903-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241110013649.34903-1-masahiroy@kernel.org>
References: <20241110013649.34903-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2 10/11] kbuild: make wrapper Makefile more
 convenient for external modules
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1985
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241110013649.34903-11-masahiroy%40kernel.org>

When Kbuild starts building in a separate output directory, it generates
a wrapper Makefile, allowing you to invoke 'make' from the output
directory.

This commit makes it more convenient, so you can invoke 'make' without
M= or MO=.

First, you need to build external modules in a separate directory:

  $ make M=/path/to/module/source/dir MO=/path/to/module/build/dir

Once the wrapper Makefile is generated in /path/to/module/build/dir,
you can proceed as follows:

  $ cd /path/to/module/build/dir
  $ make

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

Changes in v2:
 - use $(srcroot) instead of $(_vpath)

 Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 35e34cce4942..df002595341a 100644
--- a/Makefile
+++ b/Makefile
@@ -642,10 +642,20 @@ ifdef building_out_of_srctree
 # At the same time when output Makefile generated, generate .gitignore to
 # ignore whole output directory
 
+ifdef KBUILD_EXTMOD
+print_env_for_makefile = \
+	echo "export KBUILD_OUTPUT = $(objtree)"; \
+	echo "export KBUILD_EXTMOD = $(realpath $(srcroot))" ; \
+	echo "export KBUILD_EXTMOD_OUTPUT = $(CURDIR)"
+else
+print_env_for_makefile = \
+	echo "export KBUILD_OUTPUT = $(CURDIR)"
+endif
+
 quiet_cmd_makefile = GEN     Makefile
       cmd_makefile = { \
 	echo "\# Automatically generated by $(abs_srctree)/Makefile: don't edit"; \
-	echo "export KBUILD_OUTPUT = $(CURDIR)"; \
+	$(print_env_for_makefile); \
 	echo "include $(abs_srctree)/Makefile"; \
 	} > Makefile
 
-- 
2.43.0

