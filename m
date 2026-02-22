Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDA1E9B251
	for <cocci@archiver.kernel.org>; Tue, 24 Feb 2026 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=SCWTk+IBh+cv0sTp+5FoJ30T//K04N5n6pJL4hNPgAY=;
  b=JrtppiRUteyWc3xZCFygO1//IsPkuwTU79ZUusSv0d+ymg9/4b0/efTG
   mbgFCYaVxRm12eMaA0G8R4Nj/NqogAK7jVHGnACJZ9XNsBMhAqSnMAzmo
   q2swIUfbj7p2o4P+eMfg2Xp6hSD4ciboKs/CffDUkgX7ajorNKU0nZpY9
   o=;
X-CSE-ConnectionGUID: WxTaRQtcTCe31uRQL9nh/Q==
X-CSE-MsgGUID: 8MVMMG1MSJ6BnziJVns2/w==
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
X-IronPort-AV: E=Sophos;i="6.21,308,1763420400"; 
   d="scan'208";a="264908160"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Feb 2026 12:04:52 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EDB6C8367F; Tue, 24 Feb 2026 12:04:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7741C812EA
	for <cocci@sympa.inria.fr>; Sun, 22 Feb 2026 23:44:08 +0100 (CET)
X-CSE-ConnectionGUID: QQe6dS72S522lhZthgSQIw==
X-CSE-MsgGUID: 7InSkq9MQ9a7eJj4+g7lbA==
IronPort-SDR: 699b86b7_kvrrm/y6p/k2qTe9Tq2zu7XcjZLxYvGPs6RUnRakSSbjXtk
 E+3+L9Xkk5UOwX0nV9DOA9LhAND40rXf8PGAeaw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HOAgDThZtpga6AVdFaglkCgj8WgVAzBFSiRpIjgUA9A?=
 =?us-ascii?q?g8BAwELAQFPAgQBAQMENwGESI0iAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBDQEBBQEBAQIBAQIEBgECEAEBIhkHDjuGTw1JFgGBe2BMYQIFAzsBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBCgIsYRYgAQ0BGwQZAQMSEAJZA?=
 =?us-ascii?q?hEBBQEjCggigmCCIwEGEAEDNgOdBoEFQoxTBQIWgQGCDQbaZQoZKA1xgWEBA?=
 =?us-ascii?q?gIHCQEKAQGBNwGEdildAYI3hSCEdIEhG4INhA5vgh+COTiFVSIEgiJ6FJNIC?=
 =?us-ascii?q?AcfEggBHAYKAkgVEgMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTCgMKCwcFH?=
 =?us-ascii?q?woCDBQKKCISAikKAyAKCxIPAxgVAQEHBgICAwEEAgQMAgMBBQICBQQDAgoEA?=
 =?us-ascii?q?wMEAQEIAgItAwEDGQgJCAILBREYDAsFAgonAw8BCQMfFxkIAUUIBhYBGgcFB?=
 =?us-ascii?q?gs4FQcKBAICAQUFAgEBAQwJAgICBwMOAwICAgMEAQIDBAMFAgMEAQEBAQQFA?=
 =?us-ascii?q?gMDAgIBAwUCAgEBAgIEBAIDAwYCBAIOAgEFHREBAgYFAwIBAwUDAwMDAwIEA?=
 =?us-ascii?q?gICAgYHCwwEBAQDBQMDBQYDAQMEAwgDCgIEGAYFAgICAQIMDwMDCgQEAwIFA?=
 =?us-ascii?q?gYJAwIDAwQBAzkcEwQFAgUDAwE6Aw4EAwgGGAIBAQIGAgEDAwgCAwEDAgcDF?=
 =?us-ascii?q?AYBBggCBAQKAgMDBwYFBwIRKAQCAgICBAMDAwoHBwQDAQcDAwwCAhACBAQCF?=
 =?us-ascii?q?AMDBAMQAwECEhgGAQMHCAMCBwQWAwIJGQQCBAMCAgICAS4DBQcCBAECBgEDA?=
 =?us-ascii?q?wcDAgwCAgISBQQGAgEDDAMEAwUFCy0RBxMKBgQHBQICAhQGAgQMEgMDBAQCA?=
 =?us-ascii?q?QICAjoECAwaDgQIBwMHARgFAgMCAwUBAwEHBxICCggDDh4BAwIGAgkBAQoPA?=
 =?us-ascii?q?gICBAICAQMIGAMEHwQDAwcCAgwJAwQRAgUFCAcKEhsDDgMNFwcEAwwKMAsOE?=
 =?us-ascii?q?w8DCwkIBwwBPAwHCigENgEGDhQHBCUZZwcHjh0/gjSBDoFHl3OPD6AgcWiDP?=
 =?us-ascii?q?ptchXwaM5dSkxgBmQYikXCSR4Q9AgoHBxEkEoEyOoFcTSNQMYI2TwMZD45fg?=
 =?us-ascii?q?0K7ODs1PAIHCwEBAwmFQyYTC4ojgXSBSwEB?=
IronPort-PHdr: A9a23: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
 A==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:RcBvyq8ukGe8XFmE7Kduk+ALI+orL9Y04lQ7vn2ZhyYlFvBw8P
 re5sjzsCWftN9/YgBHpTntAtjjfZq+z+8P3WByB8baYOCOggLBR/AA0WKL+V3d8kbFh4lgPM
 lbAs1DIey1Il5gk87g7QW0V/omysKW6b2liI7lo0tFfEVFb+VP4W5CZDpz0XcYeOCFP/cE/e
 Knl7J6TvObGEgqUg==
X-Talos-CUID: 9a23:NQVQWWCxcrhmETX6ExBe+RAYIZ9/SSCHlnPQEVO4Bl1QaaLAHA==
X-Talos-MUID: 9a23:Xb50aAh6nX/dYs6HwYycz8Mpa+Zu2Ke3WWU0wJxZtuuGaW9/ZDOXpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,305,1763420400"; 
   d="scan'208";a="139498175"
X-MGA-submission: =?us-ascii?q?MDG6GeJ+o2m3Ry8vF3wjAX9LfUnOejyKLcQbS8?=
 =?us-ascii?q?u17TSysFJ/xbseDZYHQxxtgEi270YeByCCTkr1KsXGq0xMJeQ2SozUqa?=
 =?us-ascii?q?6J/sh9FXs5cTw5B8Tf2Hcjfa4kE7j2YDpg/LorJNXN2oXTg5g2wzz5cN?=
 =?us-ascii?q?umAyPvAcHsjm/nXPyL+cclpg=3D=3D?=
Received: from mail-yw1-f174.google.com ([209.85.128.174])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2026 23:44:08 +0100
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-793fdbb8d3aso30198547b3.3
        for <cocci@inria.fr>; Sun, 22 Feb 2026 14:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771800246; x=1772405046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCWTk+IBh+cv0sTp+5FoJ30T//K04N5n6pJL4hNPgAY=;
        b=J9eYkMNhnBh2DgfBbCpMyLISmObiW8d9MxpTxhVKbx7TYMnJqS4iACyIldHcS5+az5
         BiLNyWrdsULR/SQBNK3Gl1sVFxDlofrxhN80epPIbm1GN1PffZa5Xozj9KpMuSI8MsQH
         5t56LfephT2TgOYMfzVAaCzlpOcCSfen/GdHamKwDXeXURoF/iSAo3bRKFcQQ9ArKT8e
         BBBnNzj8TLP+L8E6XQupW8mb9B5GnH1eeMIuJ8KTBN0wT9zyH3/Z6DOEs++2EBVXo2ZU
         2405U1GJfvRoWP3Q5sO2UsDcIAF8Q1BtmXhIUnFEDeP48hdZt0bKJLJESyv3w/taNIYJ
         6Lag==
X-Forwarded-Encrypted: i=1; AJvYcCXm/RNn5vRVQVr8paeCt9LIkg1JqAcGsYjFgXM8Tt+Es9pRHwwbCM7nz1B8Blec5q5/aTy1aQ==@inria.fr
X-Gm-Message-State: AOJu0Yx57sSw8oHzO7PCK2oNVBh8dQhpXoj/YmoxeCWe4qTgGCJUpoOg
	ChKW+1pMGMzGCmBckq4gVHfLWgRndmCj236oElk/0jeY7A9RTtUylhRK
X-Gm-Gg: ATEYQzwq3MqM7K+0DlggfgvxqCOhUIcmKM5lTYTial8dZV1aknuiJvRD/A35gZTqF9l
	S1NCHNv6ec/MDgQLpq1I1+0o9kQn7xqJ4j8rGUp94TipjxSuHgq3W+aJJAhUyEEOWl7MrKkbqWU
	LVUAmQs3xZpaFNpmLvedLEnPAmpw+eqM3cTzhULcpal1hPT67lslOK86cJSfFOUtwGv1MYseSV+
	UDZpsui+CtgJO8m3zlrvmBWoJ4DNsVO3BZyRMNsIyiIso0MBoXaA2Axu51CFJSQACbY9RSkRh+d
	Bb5V1K/Aa4RaGO9GrpiEIA0EQkEbVl4E6mnjDnIBcyO00sJfvEndWfELW1oq7Gz0PShtqyHJ4c2
	ZNLq0k2gl4qDjOSVOVAGlXdtqn8F4NDcxLNjd1I9IIzmxdCtZy4VezXjKjMDw0xTXve6d3yPPnZ
	16PvfWXm21cBhqPrvfzQM=
X-Received: by 2002:a05:690c:a75a:b0:796:3787:39b2 with SMTP id 00721157ae682-79829002a28mr49952017b3.30.1771800246204;
        Sun, 22 Feb 2026 14:44:06 -0800 (PST)
Received: from Gentoo ([158.173.25.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982db94565sm24807487b3.6.2026.02.22.14.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 14:44:05 -0800 (PST)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: Julia.Lawall@inria.fr,
	nicolas.palix@imag.fr,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	cocci@inria.fr,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Mon, 23 Feb 2026 03:58:19 +0530
Message-ID: <20260222224320.27797-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH] Doc:dev-tools Added Gentoo in Operating System list
 under Getting Coccinelle
Reply-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3310
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-02/Yn-riqgCTANA3PJc4h0ylQ>

Added Gentoo in the operating system list under "Getting Coccinelle".

It should be available the package like this : emerge -av dev-tools/coccinelle

Example:

bhaskar_04:11:00_Mon Feb 23: :~>sudo emerge -av dev-util/coccinelle

These are the packages that would be merged, in order:

Calculating dependencies... done!
Dependency resolution took 6.35 s (backtrack: 0/100).

[ebuild  N     ] dev-lang/ocaml-4.14.2:0/4.14.2::gentoo  USE="-emacs -flambda
-latex ocamlopt -xemacs" 5377 KiB
[ebuild  N     ] dev-ml/dune-3.20.2:0/3.20.2::gentoo  USE="-emacs" 2981 KiB
[ebuild  N     ] dev-ml/findlib-1.9.6-r1::gentoo  USE="-doc ocamlopt -tk" 265
KiB
[ebuild  N     ] dev-ml/result-1.5:0/1.5::gentoo  USE="ocamlopt" 3 KiB
[ebuild  N     ] dev-ml/sexplib0-0.16.0:0/0.16.0::gentoo  USE="ocamlopt" 22
KiB
[ebuild  N     ] dev-ml/ocamlbuild-0.15.0:0/0.15.0::gentoo  USE="ocamlopt" 198
KiB
[ebuild  N     ] dev-ml/menhir-20240715:0/20240715::gentoo  USE="ocamlopt"
1217 KiB
[ebuild  N     ] dev-ml/num-1.5::gentoo  USE="ocamlopt" 67 KiB
[ebuild  N     ] dev-ml/camlp4-4.14_p1-r2:0/4.14_p1::gentoo  USE="ocamlopt"
627 KiB
[ebuild  N     ] dev-ml/csexp-1.5.2-r1:0/1.5.2::gentoo  USE="ocamlopt -test"
12 KiB
[ebuild  N     ] dev-ml/uchar-0.0.2-r1:0/0.0.2::gentoo  USE="ocamlopt" 22 KiB
[ebuild  N     ] dev-ml/dune-configurator-3.20.2:0/3.20.2::gentoo
USE="ocamlopt" 0 KiB
[ebuild  N    ~] dev-ml/stdcompat-21.1-r1:0/21.1::gentoo  611 KiB
[ebuild  N     ] dev-ml/base-0.16.3-r1:0/0.16::gentoo  USE="ocamlopt" 433 KiB
[ebuild  N     ] dev-ml/parmap-1.2.5:0/1.2.5::gentoo  USE="ocamlopt" 48 KiB
[ebuild  N     ] dev-ml/stdio-0.16.0:0/0.16::gentoo  USE="ocamlopt" 8 KiB
[ebuild  N     ] dev-ml/parsexp-0.16.0:0/0.16::gentoo  USE="ocamlopt" 56 KiB
[ebuild  N     ] dev-ml/sexplib-0.16.0-r1:0/0.16::gentoo  USE="ocamlopt" 54
KiB
[ebuild  N     ] dev-ml/pcre-ocaml-7.5.0:0/7.5.0::gentoo  USE="-examples
ocamlopt" 41 KiB
[ebuild  N    ~] dev-util/coccinelle-1.3.0::gentoo  USE="-doc -emacs ocamlopt
pcre -python -test" PYTHON_SINGLE_TTotal: 20 packages (20 new), Size of
downloads: 14168 KiB

Would you like to merge these packages? [Yes/No]

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 6e70a1e9a3c0..990a049091e1 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -29,6 +29,7 @@ of many distributions, e.g. :
  - Ubuntu
  - OpenSUSE
  - Arch Linux
+ - Gentoo
  - NetBSD
  - FreeBSD

--
2.52.0

