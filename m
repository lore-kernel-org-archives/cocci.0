Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36306C38142
	for <cocci@archiver.kernel.org>; Fri, 27 Jan 2023 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=T1hCdhOMzAohLix9hBTtHixdcekvh2AXdObdQPW2Zcs=;
  b=nhBoiHZVn9yaBe7oxz4ICg5UKvg8MX6+z5ZxYOFSYhSEzrCpyFdYpwrZ
   jVZwkJL+IdFvj3BE3UZC9Xf9C6WCWcNkH6nTutGxY1SJB6hWxdV8pG7Te
   6KM/h7op7hdzFt/6ycfhuSkha0+nI4WjyHkczCAjq1oGJibncYG1rBz3a
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.97,251,1669071600"; 
   d="scan'208";a="89811871"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2023 18:10:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 29940E0280; Fri, 27 Jan 2023 18:10:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2F78BE027E
	for <cocci@sympa.inria.fr>; Fri, 27 Jan 2023 18:07:56 +0100 (CET)
IronPort-SDR: 63d404eb_BsqrbHAveQ1MLrNr+fiqQQ4cCExWDULgKS7YwEshDRZAgLg
 jvPaSBgahleUYCbY2vaHCwWKzzEDi/WeHHBNi4Q==
X-IPAS-Result: =?us-ascii?q?A0FpBADXA9Rj/0YpCbBagQmBT4ItgV4rAwQLhRSIfog1n?=
 =?us-ascii?q?yoPAQMBDUQEAQGFB4UmHgYGMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAQBAQKBBhOFdYI3IoQwVjUCJgJDhlAHAaoqgTKBAYRzmmaBZ4EULYkQi?=
 =?us-ascii?q?FmCDYQQAYV9gwuCZwSbawqBOXeBJQ6BRoEPAgkCEUgsPzcDGSsdQAMLOzIKP?=
 =?us-ascii?q?zUWSisaGweBBiooFQMEBAMCBhMDIAINKDEUBCkTDScmaQkCAyJkAwMEKC0JI?=
 =?us-ascii?q?B8HJiQ8B1Y9Ag8fNwYDCQMCH1ByLhETBQMLFSpHBAg2BQZSEgIIDxIPLEMOQ?=
 =?us-ascii?q?jc0EwZcASkLDhEDUIFNBIIMCi8mnz+DAForLa5ulAaDfQWBTZ8YMoFEp2iGE?=
 =?us-ascii?q?IUFjDmoEIF4JyuBLjMaCDCDI04DGQ+iBT9vAgcLAQEDCYwjAQE?=
IronPort-PHdr: A9a23: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
 gRzgixDCmwNWkvCCVGxZtGT
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:H+wv16/oCKAgOPlEQtFuk+DbI+orL9Y04lQ7vn2ZhyY7TiX+ra
 CTdZUgtCMc5wx+ZJhNo7290cq7MBHhHPxOi7X5VI3KNGLbUQCTXedfBOXZrwEIVxeOldK1zZ
 0QFpSWEueAaWSSk/yKhzWFLw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,251,1669071600"; 
   d="scan'208";a="89811625"
X-MGA-submission: =?us-ascii?q?MDHSxoa22LPS98XuJC4Y8W6EPijPePi/V3A3+V?=
 =?us-ascii?q?/xOwyJ4ftRQDxtET6/UmLes5B+c3d7UVNgYYJFz6Lnb6ZgoHMH2n9NuH?=
 =?us-ascii?q?Bf4rWQePUk9PLh4yRqj7C5i15RSbGSoWzI/IhX1WGCKb21/UOaew3mPX?=
 =?us-ascii?q?AP3i5FPpE7iODSryediOacRg=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 18:07:55 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pLSCe-005yDw-07;
	Fri, 27 Jan 2023 19:07:53 +0200
Message-ID: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: cocci@inria.fr
Cc: julia.lawall@inria.fr
Date: Fri, 27 Jan 2023 19:07:51 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Nested macros
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 820
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/df710cc39e1da39521f09827f5528703887e9bce.camel%40coelho.fi>

Hi,

I've been struggling with a change I want to make, so I hope someone
can help.

Basically I have something like this in the code:

/* regs below are bits 15:0 */
#define _MIPIA_HSYNC_PADDING_COUNT     (_MIPI_MMIO_BASE(dev_priv) + 0xb028)
#define _MIPIC_HSYNC_PADDING_COUNT     (_MIPI_MMIO_BASE(dev_priv) + 0xb828)
#define MIPI_HSYNC_PADDING_COUNT(port) _MMIO_MIPI(port, _MIPIA_HSYNC_PADDIN=
G_COUNT, _MIPIC_HSYNC_PADDING_COUNT)

As you can see, these macros assume that the calling functions have a
local called dev_priv, and I want to fix that.=20

So, I'm trying to find all users of macros that have this construct.=20
My problem is matching the nesting in the macros.

I have tried this:

@macros_noargs@
identifier m;
expression e =3D~ "dev_priv";
@@
#define m <+...e...+>

@nested_macros@
identifier macros_noargs.m;
identifier nm;
@@
#define nm(...) <+...m...+>

@@
identifier nested_macros.nm;
@@
-nm
+foo

(this last rule is just for testing if anything is matching, obviously)

But the "nested_macros" rule doesn't seem to work.  Does anyone know
how I can solve this?

Thanks!

--
Cheers,
Luca.

