Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21F6EE3683
	for <cocci@archiver.kernel.org>; Thu, 12 Feb 2026 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=CQA2lajdIKgY9RudtWGlgIHcpyaRakg0btd9TJJY0Vw=;
  b=W7I2elfmP7UTGn+ERk7hofC7aFbdr9usGqvAiC3Z6Re3CE/s1L1Vg+sK
   vtv1J2oM2udIn8b7iQVLU2SygJeBqWcm46sfSgRHurak2y5OqfHdlVPQ2
   jqWDO1VhPobOQNUAKBtFxB5bYpMCbQlnGZgYG25WYHb2Lw2Yum54IHbrX
   k=;
X-CSE-ConnectionGUID: C+hFlU4pQv6s2nddroE/gA==
X-CSE-MsgGUID: 3hx3xXIvR42zlk7H7VVT+Q==
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
X-IronPort-AV: E=Sophos;i="6.21,286,1763420400"; 
   d="scan'208";a="263192353"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Feb 2026 15:07:42 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id F05AE82626; Thu, 12 Feb 2026 15:07:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DB2B882554
	for <cocci@sympa.inria.fr>; Thu, 12 Feb 2026 14:42:56 +0100 (CET)
X-CSE-ConnectionGUID: uT19BSCHTC+OrmXQXtN06w==
X-CSE-MsgGUID: 0Yt8/4CAR2GNd2E8NDcamw==
IronPort-SDR: 698dd8e0_XPUim7KRWokfvDI8B+hUDyIWbdyGr4w1ZoFpxxtUsUvtBNu
 zUGer2XvthEgG7vWBnCGMUh0xc7Qw4UCg5Eehrw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EFAQCs141pjtiSqVFagQmBUIJBFnFeNAcISYgnrEKBf?=
 =?us-ascii?q?QIPAQMBDTEgBAEBAwEDhQCNIAIfBgEEMgcOAQIEAQEBAQMCAwEBAQEBAQEBA?=
 =?us-ascii?q?Q0BAQUBAQECAQECBAYBAhABAQEBAQE5BQ47hk8Ngls7ghYsDYE2AQcGAQE4U?=
 =?us-ascii?q?H+DAgGCIgdKB6s7gTSBAYIMAQEGgQiBYNlCgWQBAgkUAYE4hW+CZQGFAHSEe?=
 =?us-ascii?q?icbgg2JVTiFVSKDNJNoSIECHANZLAFVEw0KCwcFgWYDNRIqFW4yHYEjPhczW?=
 =?us-ascii?q?BsHBYgMD4pzgSBwAwsYDUgRLDcUGwQ+bgeOQ0GCM2EtAYEwyCmCP4FngWSKO?=
 =?us-ascii?q?pU6GjOBS4QQkXcOkwuZBqRZhGiBbwQvgVwzGggcFIMiCUYDGQ+OOoQagiO9f?=
 =?us-ascii?q?UUyPAIHCwEBAwmSHoFLAQE?=
IronPort-PHdr: A9a23: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
 ApoOWWdL1q0p7JtbW5vhUnQtMkXccM=
IronPort-Data: A9a23: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
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:YlgBx6wHQgUWlJLcVJChKrPw9b1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYVEqKQkdcLG7SdK9qBbnmvBICOYqTNOftWXdyQiVxeJZnPLfKl/bakrDH4dmvM
 8BT0EUMqyUMbEVt7eZ3ODBKadH/PC3tJuaq6P380pNJDsKV4hQqzxLJEKwN2VNfk1nKPMCeK
 ah2g==
X-Talos-CUID: 9a23:IH5fcWCKDkN+y3/6EzRbrR8+IesFTlae623VE3aIFUAxFqLAHA==
X-Talos-MUID: 9a23:mp4CTQgXkReoVwCGwulS7cMpbPZ0s+PyI2k3y7ogt5OpZQpcMD6Yk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,286,1763420400"; 
   d="scan'208";a="138653374"
X-MGA-submission: =?us-ascii?q?MDFGeP5luTfXlOnhZ+O9xI04b6B7kBIRjjtkwg?=
 =?us-ascii?q?nH7kZGnYJ2wB0SxVFTPDXLyiJZHG/DuZknUmviliQG2XeOISBlIaJPl2?=
 =?us-ascii?q?ScNziX4OIdruTZfl+xQ9nwE1wIpq8p7eJuKxEz1+uxx2kCa37eGFgshZ?=
 =?us-ascii?q?I0s17DOOgYGBN8MGic5zYaUw=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:42:56 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1770903774; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eRN73H5NXMVimG3ytm2F6bEyQ09LDinMIIHjlp5Pj0+x0/obm9pNmCKmoRuwuE7TqE
    B7KXRozOHc432sVQF5zKAbeKtGbl7yfiotXd74+2eUVG8zNxe+/CEhTqdGksIBNnnM+L
    O0CTVynY+NkqBWVywQdE5SCbCYmCN02k3K4trxnRbIS6qmIa9NV2yiZGeht3+LBPcV48
    PBiapGyzABRCL6TdcHPfxoVtvazGqVzKS7JpmZSwkE9sja3yWjwZXJS4dWsEh45aOZmo
    tacqKsMd2o/oHCGaWwbQxDmbgbwfQU9Ut6A3w3fU8mChj9WZcd8KNiHn+RgqXU6sre+T
    cnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1770903774;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=CQA2lajdIKgY9RudtWGlgIHcpyaRakg0btd9TJJY0Vw=;
    b=m+TxdXzOcm/bl0+wVTt7UahY3XyAskVKnXurzdpV8n5PzEgQz5T0oElyjsrxOccQYT
    DrQSYwaMTFCEt/5pLCfDSL/AwY4lT8EMmIkE/mHqs1XEO28nDS9E4inU10rNTnhbruN1
    A0uOt+WPPtcHajTx25Z1zOL0Yab4tyCOm30Ix7fhFWiAtEus3n87z8zQw4e57EdLgqny
    B9NfwPN2VWozV5BDGwz9DsCRUXMJ0xiif6JQ1poWJTEfGM+2JW93VGsLb4tgElfg98wi
    KqThVllrgwTG3K1i3RMLRkILGViGx3pXSWKLLGCt+g6HNkPaeEC4ZCMBNp8C8FEsztHq
    nWPw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSUNjamZSZmgT1gsj52m9Bn/g+fUPE21WRsQgIH"
Received: from sender
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id D8156921CDgsiek
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <cocci@inria.fr>;
    Thu, 12 Feb 2026 14:42:54 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: cocci@inria.fr
Date: Thu, 12 Feb 2026 14:42:25 +0100
Message-ID: <20260212134249.3790-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH v1] Substitute LIBDIR for file paths
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 3304
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-02/PomRhT2ZV1soCwtR4wNz5A>

LIBDIR is already used earlier in this file, but such usage was
apparently overlooked in commit 99d699e8eaf5ba49faf5ac55584e24357580df50.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 docs/spatch.1.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/spatch.1.in b/docs/spatch.1.in
index e54150402..37975f330 100644
--- a/docs/spatch.1.in
+++ b/docs/spatch.1.in
@@ -166,13 +166,13 @@ set number of diff context lines
 report partial matches of the SP on the C file
 .TP
 \fB\-\-iso\-file\fR
-<file> (default=/usr/local/lib/coccinelle/standard.iso)
+<file> (default=@LIBDIR@/standard.iso)
 .TP
 \fB\-\-macro\-file\fR
 <file>
 .TP
 \fB\-\-macro\-file\-builtins\fR
-<file> (default=/usr/local/lib/coccinelle/standard.h)
+<file> (default=@LIBDIR@/standard.h)
 .TP
 \fB\-\-recursive\-includes\fR
 causes all available include files, both those included in the C file(s) and those included in header files, to be used
