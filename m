Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1D0CCF9E9
	for <cocci@archiver.kernel.org>; Wed, 29 Oct 2025 13:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=cVxJt+nhxHU4dy0n9v33tLsNGpPkGvwh9xNa8r3Ec/M=;
  b=vSv9xtvkIT2AneZkNU4IWuJPaF2OUd2xiCHHRvfLvbSAwHy3yWyT+H2r
   2vGLjldd9rz7zfXVLlVqYK+lsPS+t00RAM7Fxll4Z38ziUxrD2HQUeqxw
   ef+/I3cLkj9x8rgy+EQcs0mzGkc4IM53D+VFYLv/V130u5yoyteE2HX2e
   c=;
X-CSE-ConnectionGUID: SqnjTX42SyGdesoZhthw/A==
X-CSE-MsgGUID: 7ax19EkUSnO9QMV/FWAUeQ==
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
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="246688052"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2025 14:42:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8DF02E0CEC; Wed, 29 Oct 2025 14:42:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 79FDBE0172
	for <cocci@sympa.inria.fr>; Wed, 29 Oct 2025 14:30:10 +0100 (CET)
X-CSE-ConnectionGUID: drdAxLP0RguUTweyTJ3sxw==
X-CSE-MsgGUID: sX9x4mKgSLyRt9J5GQnHHw==
IronPort-SDR: 690216e2_28g6giC/vEXDr9ti+Dt87X7kE2hDDfrnhHdEPRkJtHbj0tj
 2n5tZ4RlTHpHWh+ewOuB0cfjjiDsG03IPw05aLA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EWAACmFQJphf4EaaxaHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?j+BAl4zBAtJBIxtX4h4nh0UgWkCDwEDAQ09FAQBAQMDAYUAjFQCHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAUBJhk8Ng?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAg2BADYBDQEBNwGBPAESgwIBgiIHSgMRsyWBAYIMAQEG3CWBZAMGgUoBh?=
 =?us-ascii?q?WyHYYQFaYEhG4INgRWDaIQGUoYvgzSGJ4JWhV2JdUiBHgNZLAFVEw0KCwcFW?=
 =?us-ascii?q?4EIAyoLDAsSGBVuMh2BJEEQCHGEXQ8SaA8GgRKDUwaJKw+IcAMLGA1IESw3F?=
 =?us-ascii?q?BsGPm4HkzETBIJlexMsUIEVTRyTHQuDGYxwLqFDgT6EJoFkijqVORozgUuWB?=
 =?us-ascii?q?5MYAS6YWCKLbIF6lhk3hGmBaDqBXDMaCCgIgyJPAxkPjiEZhSWDVcZnQjUCO?=
 =?us-ascii?q?gIHCwEBAwmSHmtgAQE?=
IronPort-PHdr: A9a23:o64mXBLwccFk7j26ydmcuJFvWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEvrM10BSQA96LsLoE07OQ7/u7HzRboN6oizMrTt9lb1c9k8IYnggtUoauKHbQC7rHSRJ/N
 +l5EGFfwnegLEJOE9z/bVCB6le77DoVBwmtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJ
 xmqsAndrMYbjIVsJ6or1hfErXREd/lXyG5mJl+ekQv36sOs8JJ+6ShdtPws+sBaXanmcak0S
 KFTASg7PWwy+MDkuh7PQBeV6HABSGsWiB1IAwbE7BH+QJj8tzbxu/R+1ieHI8D4VKg4Vzu64
 ahkURPlligJOSMh/G7YlsJ/gqRboAm8pxNk2I7bfJuVNPtlcazDe94RWHdMUdxQVyxFBYO8c
 pcPAu8cNutWs4Xxu10DpgalCAKyGO3g1CNHhn7u3a07zeshFx3G3Bc9FN4KqXjYscn5OLsXX
 e2z0aLGzyjMb+lO1Dn99obFbA0vr/+PU7x3fsXfxlIiGx/Gg1iKtYDoJS+Z2vgLvmOG7+RgT
 +Wvi2s/pg91pTivxt0jio/UjYwXzVDE6yJ5wIIoKtalT0N7Y9mkEJtKuCGcLIZ2Qd0tQ3tuu
 Ckkzr0Ko5m7fDIFyJk+wRPUdvOIfZSS7B35SOaRPSl3hGhjeL+nmxu+7VWsxvP4W8S70ltEo
 C5InNfOu30T2RHe99SKRudh8kquxDuDygHe5+9GLE47iabXNpAsz74wmJcQvkrOAyn7k1j4g
 q+Rc0Ur4Omo6+L/b7XluJCcLYl0hR/6Mqg0ncy/G+s4PhAPX2id4+S81afs8Vf3QLVQiPA9j
 6rXsIjCKMgGpKO1HRVZ3ps/5xu/FTur384UkWcHIV9KYB6LkpTlN03ULP36DfqzmVChnClxy
 /3GPbDsBIjGIGLZn7f7Z7l97lZRyAotwtBb4JJZEq0BIPXpWkPrr9zYCQI5MxaozOn5Etl91
 Z0RWXiJAqCHNKPeq1iI5vggI+WUZY8VvijyK+Q96vLzj3I1h0URcbS10ZYXcny1Ee5qL1uZb
 HfjmtsBFH0Fvgs6TOzkkl2CVjtTam6wX6I75jE0EoSmAJzARo+zmryB2jm0HplMamBBEFCMH
 m/kd5+YVPcUdCKSPshhnyQAVbe7RY4uzxWutAvhxrtmL+rU/zYXtYj529Rv5u3Tkwsy9T1uA
 MiH3WGNVXl4nnkUSD8uwKB/vUt9x0+f3qh/n/NXCd1T6uhSUgY6MJ7c1/Z1B8rzWgLHZNeJS
 UypTs+oATErVt4xxcQBbF5nG9q+lhDDwzaqA7gNmrCVHJA0/bzT33/yKchn03vLyrUsg0E8Q
 sRRK22ohbRx+hDPB47OiUWVjb2qdaMB3C7X6GiM03CCvEJGXw5qV6XKQ3QfalHRrdTj6UPOV
 6KhCbcmMgtE0cOMMqREZdP3g1taWPrtPszSbH+0m2iqHxaH2quBYpLzdWsF0yvREFMEkxgd/
 XueLwYzGjqvrX/GADx1DVLvbVvj8elgp3O/SU851xmEYVR52bS6qVYpgqm+VvcS1/ogsTgor
 zE8SHSg29PfTf6JuANleI1dZ8k86RFJzzSd/yp8NZukJrsqvlcachQ/60Xv3BJzA54GicEur
 WMCzQ97JuSWygUSWSmf2MXSPb3eLCHS+w6ob6KejlPZ0N+Q0qQC8vI1rxPkpg7/RRlqyGluz
 9QAiyjU3Z7NFgdHFMupCi7fljB/rrDeOGwm4p/MkGdrOu+yuyPD3NQgAK0kzAyhdpFRKvDMD
 xf8RusdAcXmM+k2gx6xdBtRPudS/agcPM68cfaCnqmxM7Uohyqo2FxO+5s1yUeQ72x5Q+/M0
 YwCxqSa2QuOUR//gU2nv8SxnppLNnkJBmTq7y/iCcZKY7FqO4YGDWD7O8qs2tB3nILgQVZE8
 0TlHFQbwsSkPxmfdVrw2UtXz0t/TWWPvyy+wnQ0ljgoqvDaxynS26H4cxFBPGdXRW5khFOqI
 I6ujtlcUlL6Jw4u3ACo40r33c057Ox2MnXTTEFUfiP3M3AqU62+saCHatJO75VguDteUeC1a
 1SXArDnpB5S3yTmFmpYjDc1ElPi8pf+nxV8oGGQNnB+qDzeY84xjRbT6drAROJAiyIcTXowg
 j3WC16getixqIzLzdGa6r34CyT7C8EAFEujhZmNvya6+2BwVBi2nvTp38biDRB/yyjwkd9jS
 STPqh/4JIjtzaWzd+x9LSwKTBfx7dR3HoZmn84+npYVjDIYgZWc+1IEnH31PNEd3rjxJiloJ
 3ZD05vO7Q7p1Vc2ZHCOx4v/fnaQ2M1sY5+9eGxciWotqstNDqmT9rlNmyB490G5oQzmav94h
 j4ByPEq5Rb2mskxsRE2hmWYC7EWRwxDODD00g6P5Ja4pblWY2Cmdf6x0lB/lJavFuPKrgZZU
 Xf/MpAseE04psd4MFvK+H7+8IfpfJ/Xd91buhCPkhjGhvRYM9poyaBM3HI6fz675yB5g+cgx
 QRjx5S7oJSKJwAPtOqiDxhUOye0L8If9zfxjLpPy8Of3oShBJJkSX0AWJrlS+7tESpH7Ku9c
 V/WTXtg7C3GRem6f0fX8kptonPRHor+MniWICNc1tB+XFyHI0cZhgkIXTI8l5p/FwawxcWnf
 l0qg1JZrlP+tBZIzfplchflVWKK7gWvaj4yYJuSNhxb6kdF/UifYqn8pqpjWjpV+JGstlnHK
 GubbgJgDmwTXEGAQVf5MfP9rcmF+O+eCO2kKvLIarjbsu1SWcCDwpe325dn9TKBZaDtdjFyS
 uc20U1ZUTVlCtzUzn8RHjcPmXuHPIaL4Q2x8SptooWj/eT3DUjxsJCXBeI3U50n+gjq0/rZc
 bTNwn8ieHABistExGeUmuFEjRhL1HEoJ2XrS+1f/S/VEPCJxvIRU0ZdNXM1a5Ytjep03xERa
 5eH15Wpjvgn1bhoVh9ETQCzw532I5NXZTjsbxWWXQ6KLOjUfGKRhZivPOXgD+cN0IA2/1Wxo
 WrJShC5eG7Yy3+zCkrpargEjTnHbkUB4sfnKUorUDK7Com2IhyjbI0u0mdwmOVpwC2WczdMb
 V0eOwtbp7mUp0u0m91ZHGpMpjpgJOiAwWOC6vXAb4wRur1tCzh1kORT5DI7zaFU5WdKXq49n
 iyatdNor1y894vHgjN6TBpDrCpKj4OXrA1jP6ve7JxJRXfD+loE82yRDx0Ao9YtBMfovuhcz
 d3GlaS7LzknkZqc5cwHG83dM96KKlI9NgCvAznJFgAICz2mL2fSgwpaiv7TvnyZo54mq4T9z
 ZoDTrgIMT59XvgeC0ljAJkDOMIuAWliyObGypJOvyfi/3yzDI1As5vKV+yfG6DqITed1/xfY
 gcQhKn/JsIVP5H63Eprbh97mp7LEgzeR4MowGUpYwkqrUFK6HU7QHc03hevaASt6Xk7FvOum
 BMyzAxkbq5+kVWkq0dyPVfMqCYqxQMpns75hDmKbDPrBLu3R8dNDDfuvEV3MZ7hRQtxKwqok
 gY3UVWMD6IUhLxme2dxjQbaspYaAv9QQ5pPZxoIzO2WbfElubyzgiaq30lK4a3CE5QwzWPCk
 LawqGgGwAV+dtU4Y6/dPqxEyh5XnK3c5kdAM8gyzRUYKkJL93mdKnZghQ==
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:FH5kJK5+ZZmsxb9alQPXwTKBI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc6QxhJU3I/OrtBEDuewK+yXcY2/hrAV7AZnidhILXFvAG0WKK+VSJdEOfygc079
 YZT0FQMqyWMbEQt7eZ3ODXKadF/PC3tIqyheq29QYKcegmUdAU0y5JTiKgVmFmTghPApQ0UL
 Ka+8p8vjKlPVAadN6yCHUpV/XK44SjruOQXTc2QzocrCWehzKh77D3VzCewxclSjtKhZMv63
 LMnQDV7riq99u71hjf/WnO6Ik+oqqU9vJzQOi3zuQFIDTljQilIKxnRr25pTgw5Nqi7V47+e
 O80yvJa65Iik/5TyWQm1/AygPg2DEh5zvJ0lmDm0bupsT/WXYTF9dBrZgxSGqV12MQ+PVHlI
 5b1WOQsJRaSTnamj7m2tTOXxZ20mKpvHsZl/IJhXA3a/pTVFZol/1RwKppKuZKIMu60vFuLA
 BWNrCU2B+CSyLRU5jb1lMfseBEEE5DUCtueXJyxPB94wIm40yR8HFouPD3vk1wh67VGKM0ld
 gsdJ4Y4o1mf4sqaqJxbd1xOPeKNg==
X-Talos-CUID: 9a23:uiNh8W1J5qXK9MW1KGjuVrxfFtopW2359C/qLFKFNXlkWYG3EkSA5/Yx
X-Talos-MUID: 9a23:gaYb7QnQNDgavYmebcjSdnp5BJZ4v6GNB3spgK8a6uvZGhV2GxeC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="246685693"
X-MGA-submission: =?us-ascii?q?MDEAlwHi3hvuKbMjelMposTBqoq9wkSPn54TCq?=
 =?us-ascii?q?Iu7uf9Lwt+a7RpUQudN1uJpnNh9Gz1wAD0Sw1XY5Yh9XfQPnQSORZ7q/?=
 =?us-ascii?q?Zj2zXXhUy256A/Fi+uZj/Z8/ZjIcLWhG1Nm4x5eLi0/OHT25BUV9YyiQ?=
 =?us-ascii?q?OaFLunWKGEZIHjrBnKBO1VeA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:30:09 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E79F86118E;
	Wed, 29 Oct 2025 13:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88739C4CEFD;
	Wed, 29 Oct 2025 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761744607;
	bh=a/x3BocHR/s8615Io2F7/Bq1r8QllIsGnZYgJqApHWo=;
	h=From:To:Cc:Subject:Date:From;
	b=fpdHgLYoajX5OwtwyS5gPZcOoAo0Uf8IhS86qIqqyiE3ie0rLuqpm0aP8kQErJPDA
	 mtRTjbbbb1tEnXThQFW+wN3Purj7bVWKgo7So8xk/uNmskggBBIpi03k8n4L+VDXtR
	 HnJXeVcfjha4LRNdWe1sNI2NOEet6a4muaY1LB7lXdGIrADPRHFvktL+7UfDNSR4me
	 6kBht8+xozoLFr9uUTcH2aGfIcMWWuCoPWQIaMVevmKg59AygJ7QOr3mt/dVyiTSjv
	 1Qe04AQmGktZJqV7wkkk0vQL9dIGR6TB1ytxatg/vb0zUZjfbLjAA6T4RutCtQx/6o
	 TOat7o+voSmkw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vE6Fh-000000004WQ-2dI4;
	Wed, 29 Oct 2025 14:30:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Alexei Lazar <alazar@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Date: Wed, 29 Oct 2025 14:29:22 +0100
Message-ID: <20251029132922.17329-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to %pe
 candidates"
Reply-To: Johan Hovold <johan@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3105
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/20251029132922.17329-1-johan%40kernel.org>

This reverts commit 57c49d2355729c12475554b4c51dbf830b02d08d.

Using "%pe" to print errnos is in no way mandated and a driver authors
may chose not to use it, for example, for consistency reasons.

Drop the recently added cocci script that has gotten the build bots to
send warning emails about perfectly valid code and which will likely
only result in churn and inconsistency.

Link: https://lore.kernel.org/all/aQHi4nUfIlcN1ac6@hovoldconsulting.com/
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 34 ---------------------
 1 file changed, 34 deletions(-)
 delete mode 100644 scripts/coccinelle/misc/ptr_err_to_pe.cocci

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
deleted file mode 100644
index 0494c7709245..000000000000
--- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/// Use %pe format specifier instead of PTR_ERR() for printing error pointers.
-///
-/// For printing error pointers (i.e., a pointer for which IS_ERR() is true)
-/// %pe will print a symbolic error name (e.g., -EINVAL), opposed to the raw
-/// errno (e.g., -22) produced by PTR_ERR().
-/// It also makes the code cleaner by saving a redundant call to PTR_ERR().
-///
-// Confidence: High
-// Copyright: (C) 2025 NVIDIA CORPORATION & AFFILIATES.
-// URL: https://coccinelle.gitlabpages.inria.fr/website
-// Options: --no-includes --include-headers
-
-virtual context
-virtual org
-virtual report
-
-@r@
-expression ptr;
-constant fmt;
-position p;
-identifier print_func;
-@@
-* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
-
-@script:python depends on r && report@
-p << r.p;
-@@
-coccilib.report.print_report(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
-
-@script:python depends on r && org@
-p << r.p;
-@@
-coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
-- 
2.51.0

