Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E2AD5E38A
	for <cocci@archiver.kernel.org>; Sun, 10 Nov 2024 01:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=zvbbkp3r18OQpYvZ182Vuqt9WETsri+mcaKBFV8ZxWw=;
  b=ApkAMMSYZNHiCUXXSzLp0xcgnqFno8EFjSdVnqCzp6Hxo3fuTcx+kr/i
   OdP56uzNIklvAoPD2pze9t4Clax2c3TAYciirBLrKGcm4MUzqEFyDbEs2
   mwjGbzFy5peTWbLv8m9j2VsozgC6iwY/39RY8/Zb0ZlwWfdjpxd69zxrQ
   8=;
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
   d="scan'208";a="193076902"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Nov 2024 02:37:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 47599E013D; Sun, 10 Nov 2024 02:37:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 97921E00B7
	for <cocci@sympa.inria.fr>; Sun, 10 Nov 2024 02:37:00 +0100 (CET)
IronPort-SDR: 67300e3b_+vyIumOHOLoKB7H4GHHLqo8PIoxk6U4uZo6iTR6khovxvGK
 KLkXPR0fnR3sIL1alIIxsSbcZ7er4HoFUUPbFHg==
X-IPAS-Result: =?us-ascii?q?A0G5AQCQDTBnhVvBS5NagRWBR4JEfVozBAtIWodLhS2nC?=
 =?us-ascii?q?oF+DwEDAQ0xEwQBAQMBA4UAURWJVwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAhABAQEBQEmFew2CWztxgSUBAQEBAQEBAQEBAQEBH?=
 =?us-ascii?q?QINgQA2AQ0BATcBhFABgmQDshiBAYIMAQEGgQjbF4FkCYFIhWqHXHCDfXonG?=
 =?us-ascii?q?4FJRIM9gUCBUAGDBziFd4MxU4JpdiWICIENg3+JbYptSIEhA1khEQFVEw0KC?=
 =?us-ascii?q?wcFYIEXA4JWeiuBDoEXOoF+gSJKg1iBQkY/gkppTTcCDQI2giR9gk+FHYRvZ?=
 =?us-ascii?q?y8DAwMDg0WCQEADCxgNSBEsNRQbBj5uB543R4MtAYEPgUZiQKMYgh2hA4Qkg?=
 =?us-ascii?q?WOKM5UpGjOFWpFlkw6Yd5NOkCBPhGaBZzqBXDMaMIMqCUYDGQ+OOh+CZIMUg?=
 =?us-ascii?q?l6BPb9TNDU7AgcLAQEDCY53gUsBAQ?=
IronPort-PHdr: A9a23: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
 Kc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9B7Eo65C3BDDNS5fOgPXwNvXdLJyesId70hD6qm+c3Jom6uj5q
 STdZEguCMc5wxwZJhNo7y90cq7MBbhHPxOkOos1N6ZNWGM0ldAR7sC0WKN+VLd8lXFh4xg6Z
 s=
X-Talos-CUID: 9a23:AEyZKG2zk6ahkxPqMI7d4LxfCN0UYF6N5kvpMXC9Fl0wZeavQmGAwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3A1cD56wz6qfJZ2v1v2unFNdlImWCaqLa+Unkdo44?=
 =?us-ascii?q?NgcaVanZZIgyciQq7bLZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,142,1728943200"; 
   d="scan'208";a="101200579"
X-MGA-submission: =?us-ascii?q?MDFkUH0aqHARw/8ApMqmwEiIR3U3GPZkRbs493?=
 =?us-ascii?q?b+NzJiqlOrnhXYDklOIZH5dEv2EHzPROYqVX2bCDLh+P3AwborhJOivv?=
 =?us-ascii?q?j2xV7J+g5yKXXhR7071Jaya1uHqUBHURkJcju/HK1Gk1X3bmZsEi+c7p?=
 =?us-ascii?q?I7IGKtMJzBp4ANKyHmW9UF5Q=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:36:59 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3E7A6A40894
	for <cocci@inria.fr>; Sun, 10 Nov 2024 01:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211B0C4CECE;
	Sun, 10 Nov 2024 01:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731202617;
	bh=RRk8hkZbK0GXrkrDHcAPZkWCioaFcl49ugyQjY7nwjM=;
	h=From:To:Cc:Subject:Date:From;
	b=XwpL/xh0oLxBgoMv3XVu9sO4LH6EdkTzVVgRUaZSZwhIpCnYG+BUbbRMhxUG5QxAQ
	 wora8g+YJQiK/580Sn8rMH3Afj1r6LY2YmwNIFkusyo9tCQDxl6G9BmxmsjWp8gJl8
	 tQfWbusTh61BhCPPEOG+EHzsbOnKYMbPNwZOy95KzF9Pxjtk+5lhjoquwm7kKtuWv7
	 6CUze2QgF9Dl3jWuVtUwBNvU0HcNYKOurFIMtHk2NNB7Qid16Be4Ip53UkZZKoNCFh
	 9gXgxRi1VezOaVro4r/pgGMmPT9xBqJrKr0rLcIa02Sdz8/iOzxq4w48FrmwDBNeqc
	 gj+NVS7Np7wiQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	cocci@inria.fr,
	Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 10 Nov 2024 10:34:28 +0900
Message-ID: <20241110013649.34903-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [PATCH v2 00/11] kbuild: support building external modules
 in a separate build directory
Reply-To: Masahiro Yamada <masahiroy@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1975
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241110013649.34903-1-masahiroy%40kernel.org>


There has been a long-standing request to support building external
modules in a separate build directory.

In v2, 05/11 introduces a 'srcroot' variable.
(I am not sure if this is the best name, though)
$(srcroot) points to the top of the source directory.
  - When M= is not given, it is the top of the kernel source
  - When M= is given, it is the top of the external module source


Masahiro Yamada (11):
  kbuild: replace two $(abs_objtree) with $(CURDIR) in top Makefile
  kbuild: add $(objtree)/ prefix to some in-kernel build artifacts
  kbuild: rename abs_objtree to abs_output
  kbuild: use 'output' variable to create the output directory
  kbuild: change working directory to external module directory with M=
  kbuild: remove extmod_prefix, MODORDER, MODULES_NSDEPS variables
  kbuild: support building external modules in a separate build
    directory
  kbuild: support -fmacro-prefix-map for external modules
  kbuild: use absolute path in the generated wrapper Makefile
  kbuild: make wrapper Makefile more convenient for external modules
  kbuild: allow to start building external modules in any directory

 Documentation/dev-tools/coccinelle.rst |  20 +--
 Documentation/kbuild/kbuild.rst        |   8 +-
 Documentation/kbuild/makefiles.rst     |  14 ++
 Documentation/kbuild/modules.rst       |  29 ++++-
 Makefile                               | 173 ++++++++++++++++---------
 arch/arm/Makefile                      |   4 +-
 arch/arm64/Makefile                    |   2 +-
 arch/powerpc/Makefile                  |   4 +-
 arch/riscv/Makefile                    |   2 +-
 rust/Makefile                          |   4 +-
 scripts/Kbuild.include                 |   2 +-
 scripts/Makefile.build                 |   6 +-
 scripts/Makefile.clean                 |   2 +-
 scripts/Makefile.compiler              |   2 +-
 scripts/Makefile.host                  |   8 +-
 scripts/Makefile.lib                   |   2 -
 scripts/Makefile.modfinal              |  20 +--
 scripts/Makefile.modinst               |   8 +-
 scripts/Makefile.modpost               |  24 ++--
 scripts/coccicheck                     |   6 +-
 scripts/depmod.sh                      |   4 +-
 scripts/nsdeps                         |  10 +-
 scripts/package/install-extmod-build   |   7 +
 23 files changed, 220 insertions(+), 141 deletions(-)

-- 
2.43.0

