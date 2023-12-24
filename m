Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E15C46CD3
	for <cocci@archiver.kernel.org>; Sun, 24 Dec 2023 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Log9pZX7J4Rom3Jrg4lsrDgSJa0McO7FZQ7lFPUnnVM=;
  b=hBic1LIMt6zIC3y+AIbMocisGKkQYrFCJhrnO1DGCPAppygEfIA+PHTL
   ik8rF9Pe9dBvlaa10hNbP1zdlA5sbREz2WsffLnblK7YLpt00RqiqYzRm
   8LIqujw0PL6zxtIBEHl84rDOc+YqtSVoJYZmF7b6d5tAwxmbQuDDuU5RQ
   Q=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,300,1695679200"; 
   d="scan'208";a="143915242"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Dec 2023 09:52:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CEBADE0AF1; Sun, 24 Dec 2023 09:52:42 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 098A9E004E
	for <cocci@sympa.inria.fr>; Sun, 24 Dec 2023 09:52:39 +0100 (CET)
IronPort-SDR: 6587f156_+XC3oOiOHd8DgA6uyvqUU62iknqYDWT+wr7ulgwFnVlgXHu
 wx9zuQUOCXR5/Weh7T4Q3O0yNQ7R54/IEAcbMDg==
X-IPAS-Result: =?us-ascii?q?A0FsBQDW74dlewQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COX9TMgQLSIRTkTYtYYNdhzWHTIRrhASDFj4PAQMBDUEBAgQBAQMENwGBU?=
 =?us-ascii?q?4J0hzgCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?SQYBg4QJ4VsDYJcEYEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdrBBkBAREmA?=
 =?us-ascii?q?S4BBQImAl4BEgIBAYJ8gisBAzEHrwF/M4EBggoBAQavWB8sIlaBYAmBGi6IG?=
 =?us-ascii?q?wGFZ4NBgSEPgVVEgTwLgQmCLYQKhBSCaIkbBzKCHINQkVl9BUFwGwMHA38PK?=
 =?us-ascii?q?wcEMCIGCRQtIwZQBCghCRMSQIMvCoEBPw8OEYI+IgI9NhlIglgVDDQERnUQK?=
 =?us-ascii?q?gQUF4EObhsSHjcREAUSDQMIdB0CMjwDBQMEMwoSDQshBVYDQgZJCwMCGgUDA?=
 =?us-ascii?q?wSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDE8DaR8yCTwPDBoCGx4NJ?=
 =?us-ascii?q?yMCLEIDEQUQAhYDJBYENBEJCygDLAY4AhIMBgYJXSYHDwkEJQMIBAMrKQMjd?=
 =?us-ascii?q?BEDBAoDFAcLB1APAxkrHUACAQttPTUGAwsbBj4CpkgHUygTTCaCBLBAlEE0B?=
 =?us-ascii?q?4I0gWCBYQyfKwYQAy+XJg4GklMBLpgfIKhGgXojgVwzGiSDNk8DGQ+OIAwWF?=
 =?us-ascii?q?oNzj0dANTsCBwsBAQMJhUYBAYMmNIFGAQE?=
IronPort-PHdr: A9a23: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
 X+EqnVdx0R8YdRzKaGCfMKhK3BPi6jIsiL6jogM
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:9wEPKaFDw0J+7S3cpLqEMMeALOsnbusQ8zAXPo5KOH5om7+j5q
 OTdZMgpHnJYVcqKRYdcLW7U5VoLkmyyXcY2/h1AV7AZmfbUQmTQL2KhLGKq1Dd8kbFh4pgPM
 lbE5RWNP21K0RmhsDn5wSCH88n28TvytHSuQ6T9RZQpRoBUdAY0+6VMHfiLqX8KTMtOaYE
X-Talos-CUID: 9a23:Ctpck26TOyi9psI6qdss6l4QANolU3Tn/lzMDEWZVkdvUYe4YArF
X-Talos-MUID: 9a23:x524vAaexiNlqeBTijnug2k4EspT4Iu0Mn08m7MLi+OcHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,300,1695679200"; 
   d="scan'208";a="75281703"
X-MGA-submission: =?us-ascii?q?MDHV3irD/x6Z+t5gAVjKV6V+VZb8ro0aRWc8t+?=
 =?us-ascii?q?ENFS+UYer9r+wgxDMshmde/TYDVJDnL2HtthfN2bLf+GfVPX5n+5A6zH?=
 =?us-ascii?q?0zWx0rbVO1oWtlCcU96d/tV5ke5ZYTO+/+Cb1wNTspKtxrs8m5UvDIdt?=
 =?us-ascii?q?jX/ly4dr/pygk/UDtdqjtI4w=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 09:52:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703407953; x=1704012753; i=markus.elfring@web.de;
	bh=J9AFeaTjFODuXC5t8p5hISXXnz0jr5F1tAmJ6A9HIGs=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=Fa1v4kYUxSqv14A0oAQxXZCYXk6urYxYo20TODS9WM4UOtT7nT27ZLodhs8sikXh
	 eS0Qn4v3zusco8tMXEM2Tg200p+MmErQ3ogtjQJbZVhruPJRSllytA/Lx6r0GJTUt
	 guS9jXQTz9r0ZahW+M0vz6Vr4qj/DYaEq2HGdMoN+CibrX3FKcLVDaOEJAc7tUV0j
	 YnJVSHT7aWtpxt3ouQ88Mp9obbSxr22yXQDfYLxw0O0dWfn3sVY11oo8AUsh/V5T2
	 DOCMqW1oaub1IxsZOyubj4lhWqqNZ1Ho/Xt0BZ4qdm9vyqkISp2AqW6XuLBjQYu4u
	 2FuzL3WGVSJeZ0YbEQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ma0PY-1rkuIf2nqe-00WMuB; Sun, 24
 Dec 2023 09:52:33 +0100
Message-ID: <89708781-f34a-47af-8aab-025136507da0@web.de>
Date: Sun, 24 Dec 2023 09:52:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-clk@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B9yYikbLk2Rc1omAIk7V1I4TYkgY3SUAvNpijGraxc4PWGwWolc
 TDonYPQmNJkx+EONlIBJ5/9iuPRSHNUupsbJ31paWQp3ZdY25VE38Or3BDMAJSfyqmeKZvC
 jaxSusEoTz7PAmx62x5SHyQ2eHCnhFhqNmbuCf5ROQJRglUKPwcUbyopWjXGk685cbSS+9E
 V0xvNAC3t01QCbVdjiDjg==
UI-OutboundReport: notjunk:1;M01:P0:cPzjS5EdR30=;8kzncu32jgClyJqfnSC/jFyGbPI
 chw/MI99G76gULkuV2Sgp0TBFmIG6ucPK7HZw62RNlHS8p0GDERWe3GXDl01mncMkykxjkfDR
 xuoMWgd+x1uIbA47j84raF36RnLtSLZ6lBT/LOUOSZVzIBOCOhck5N73mVJkA7jJFYJ15b0eA
 IcipaI0dPXU4NJOYDTM/NCmfWfc27yK7NEewAmCPMdViZc/ts7byidJI7Bgl8l9i2TCstjpWC
 Ew064FDTEku5YNzMvCLwvk8kREzvDt69+95Gegacaiv+aQbR68wNlSEDBwe9HhOPbnpJbvrwm
 EZDpk95XROIP7TZ9i3gTRtIByw9VbJg7EbGwAv6+Ns3GZkEzYjyJOvc2DYKNVuBxnXuvEa4o1
 SCGC8HYRrR+N2MHh4Joc47kAr4YzGajea56ls84e3yN2jvTSqrWUB4Ss58wdmGy50bik0p+0E
 1BWnjNKG85DGHET2Mq+ZS/Y3a+O1tyV+xHpsSYFZc+leMtj3w7GPJ1JFiW/Qi/stv5V6zmN7g
 O/U30JpBaq3CGNAPBPStlsGX9tJMKn2FgNmF9EGLnYThSKFJG5G5v8gkG7f/sdUDgf/Y8yiIl
 FjHff+Otg8P2jkKDyDcRyvPLgb134darF2BJ/O7LFOL3w15kDOwMAfNZ5DWyGLXJod7INyV+0
 gNW/Mqvkk8xTe3YrSx8RVlmkstg2Cn7J9Ik8DfUw177MsbiQMSsjwHaGr7GNyMspGZ/0Y/dKz
 E55S2gyJ5+KFCR6ti+3+TQ3SDJj88/0edzbk4UI7oWIE7aT/HGD/inPr6JVOhpN2fYRXjNdJJ
 n6KzJlHj5HuySKuC4iKk3EsxCkm09Jo8rrplq+NcOkRMPSgB5LonlT/hQxKc9lYJOLsRzB5tj
 dPDqEhcozv1b+sacdz10EzKRWo6XnK4JqC2uCeIh2QtAvQGkGf79A4LHrnZctriXqa3hjMI9K
 GovnztI+5W68AwMDxI+eqz3hqFk=
Subject: [cocci] [PATCH] clk: stm32f4: One function call less in
 stm32f4_rcc_init() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1367
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/89708781-f34a-47af-8aab-025136507da0%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 09:40:10 +0100

The kfree() function was called in one case by the
stm32f4_rcc_init() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/clk-stm32f4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 07c13ebe327d..c7690a1594eb 100644
=2D-- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -1714,7 +1714,7 @@ static void __init stm32f4_rcc_init(struct device_no=
de *np)
 	clks =3D kmalloc_array(data->gates_num + stm32fx_end_primary_clk,
 			sizeof(*clks), GFP_KERNEL);
 	if (!clks)
-		goto fail;
+		goto unmap_io;

 	stm32f4_gate_map =3D data->gates_map;

@@ -1897,6 +1897,7 @@ static void __init stm32f4_rcc_init(struct device_no=
de *np)
 	return;
 fail:
 	kfree(clks);
+unmap_io:
 	iounmap(base);
 }
 CLK_OF_DECLARE_DRIVER(stm32f42xx_rcc, "st,stm32f42xx-rcc", stm32f4_rcc_in=
it);
=2D-
2.43.0

