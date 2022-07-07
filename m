Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8EECCA479
	for <cocci@archiver.kernel.org>; Thu,  7 Jul 2022 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ubih761XnwxtPXbFuQJ8YQAwsyvkemQJbsj1CXQ0KXw=;
  b=eNYVXG0x0wI0dvjqemlJO5OZ7kIcYJukCR4zhApas3U07U8YC2+qiJDf
   YaXOsZ6jV/1ggFfGLfkUsaEs93QPMZKR9e4LKTr1uTCvZ9+EuMxOgfu4p
   bkvxarGJeITAWkyVfPPvQGE7698sXBlcIJgOphpjmhZkTTviKZHhd25uq
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.92,252,1650924000"; 
   d="scan'208";a="44643684"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jul 2022 11:24:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 920FDE034D; Thu,  7 Jul 2022 11:24:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D1A35E0092
	for <cocci@sympa.inria.fr>; Thu,  7 Jul 2022 11:20:47 +0200 (CEST)
IronPort-SDR: 0LszkZiRBCalvykhXZGHIxIwlNVPdCOg0bqGFuXjUIuqAFoycRX9uh3A+iQJt8HMhY1m6oYpbS
 7PKfdweKMlw0ejUW/Jtr1hG3WE3M7zpcWohhzRywqPdzfQVa3hbDSmW6tQb36MV43Xl+Pbcw2N
 0M1pFnDLXocLraSpRzcvTNdbGDmTcp1PIttjQW89EE/AbVstWi7qqZ7+p7t4EeyD1GJtPVN6RV
 oZCdB+NL5yF6RYpUQQXPyLJzaRflh9OxB6knDW22kxL1uf6QIsx+nRLl26sNdJsR7Gr0XU6Nin
 rBFPoUtFSryJK5Za/4SZ1MuA
X-IPAS-Result: =?us-ascii?q?A0CUAAD4pMZimEel3FVaHgEBCxIMggQLgVJSgVcuBAtEl?=
 =?us-ascii?q?VudDIFoCwEDAQ0/AQIEAQGFBIVPAh0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBAETAQEBAQEBAQEUCQcGDAUQDgU8ZGcBgU4BgXkGBD2CN?=
 =?us-ascii?q?SkBhBwBRoE+ARKCfYMZBAOtZYEBhG6DLIFlgT0BiVuBC4IyggqBZUSBFYE8g?=
 =?us-ascii?q?ixrGgGDASSGVASMYYtDgnwDCQQHBV0SgR9uAQgEBgcKBTAGAgwYFAQCExJTC?=
 =?us-ascii?q?hICEgwKGw4ORhcMDwMSAxEBBwIJEggVExgIAwIDCAMCAyALAgMWCQcKAx0IC?=
 =?us-ascii?q?hwSEBQCBBEeCwgDGR4sCQIEDgNACAsKAxEEAxMYCRYIEAQGAwgvDScLAwUPD?=
 =?us-ascii?q?QEGAwYCBQUBAyADFAMFJAcDIQ8mDQ0EEREdAwMFJQMCAhsHAgIDAgYVBgICP?=
 =?us-ascii?q?y8uDQgECAQ3JA8FAgcvBQQvAh4EBQYRCAIWAgYEBQIEBBYCEAgCCCcXBw0GM?=
 =?us-ascii?q?xkBBQkpJxAJIRwpEAUGFQMhbQUHPg0CKDQ2PCwfGwpNTSwrFgMEBAMCBgwOA?=
 =?us-ascii?q?wMiAhAoAQYyAxUGKxUVFgYTDColKB2dC3QHE4JLd8ByB4IUgT2ffUuWZJIAA?=
 =?us-ascii?q?ZZ2IKIJAkuET4F3JIFbMxokgzdOAQIBAg0BAgIDAQIBAgEIAQECAY4zAo45P?=
 =?us-ascii?q?zQ7AgYLAQEDCYVHAQGJPAEB?=
IronPort-PHdr: A9a23:kbusBhRAyvg5FKBVztiUFVzAUNpsop+VAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTBsOCta8P0rGempujcFRI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDffQtFiCCgbb5zL
 Bi6ohjdu8cLioZ+N6g9zQfErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q
 6BWAzQgKGA1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVTmk8
 qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXTndDUMlMTSxMGoOyY
 ZURAuQcM+hWrI7zqFQBoxalGQWhB/nixiNSi3PqwaE31fkqHwHc3AwnGtIDqG7arNX0NKcWU
 OC11LHIxijAYPxMwjjy9ozIeQ0mrPGUR75xcNDexlIxGAPBlViQsZLqPzWa1uQQr2ib9e1gV
 eSui28osQ1+vyagy94qh4LUiY0b1krK+j9lwIYpO9K4Ukh7bMa6HJVftiyWKo97T8IsTmxot
 ig0yrkLt5C0ciUL1Zgq2RDSZv6bfoWG4hzvSeacLzl2in9hZr6ymRK//FWkx+DgUMS/zVVEr
 jJdn9TPtn0BzQLf5tabRvdn40us2DaC2xrR5+1ZOUw4i7DUJ4I7zbM1iJUcrFjMEjPzlUnqi
 aKaa1go9vS15+nif7npu5qROopqhgz9NKklh9axDv4iMgcUWmiW4eS826Pn/U3+WLhKi+M5k
 rXYsJDBP8gUuKG4AxNP3oY79Rm/CTim0MkEnXkdK1JFfhOHjofzN17TPv/0Ffa/g1Kynzd33
 /3LPb3sDo/TInTdjLvtZ6tx5k9cxQYpz91T+opYCrQbL/LyXk/xusbYDhg8MwGs2+brEtR82
 ZkFVm2RBq+UK7vSvkGO5uIgPumMeJUVuDH7K/gk6P/il2I2lkEFcamvxpQYcGq4Eeh+I0WFf
 Xrshc8MHXoSsgokUOPqkEGCUSJUZ3uqQ6084S00B56nDYrYXYCsgLmB3D+hEZFMZ2BGDEqME
 XbyeImeVfcMcnHaHsg0sCEAVLHpb4Y+3BWq/FvY1r5mJ6zw8zIRsZbL1d5v5uSVmwtksXRSD
 s+a12iWB1l9mmIYD2sw3at4pUVmjE+K1aloq/1dHNMV6ekfASkgMpuJ9+x7D9HqQkrzd92ET
 B7yWpO0CDs8SvopztkBflpnHNOjnlbP0nz5UPcui7WXCclsoern1H/rKpM4ki6evEFAp1wvQ
 88VcHajmrY67Q/YQYjAj0Seka+uM6Uaxi/EsmmZniKVpE8Ndgl2XO3eWGwHIFPMpIHhoFHLR
 bKqIawqNARc1dSFLKpaLNHk3h1dXPm2AN3FeCqqnnuoQxOBx7eCdo3vLn1bzizXBUwsiw0V8
 muaLw84Bzfnr2+NRCd2GwfJZEXhufJ7tGv9TkIwyFSSaFZ90rOu5hMPrfmRV/IImL8UpGE5p
 jN7AUqn2NTXG5yMqmKNZY16ZtUwqBdC3GPd7UlmO4C4arpljRgYehh2uEXn01N2DJ9BmI4kt
 iFiyg06Mq+e3F5bElHQlZntJr3aLHXz9xGzeubX3F/ZytOf5qYI7rwxtVziuAijEkdq/W9g1
 pFZ1H6V55OCCwR3M9q5SgAl/hJ3o5nCby8y+p/O0nttIe+4v36K2t4kAvck1gf1Z81WY8bmX
 Ef5F8wXAdTrKfR/ywXvNEhcerkMqehrZpDDFbPOwqOgMed+kSjziG1G5No4yUeQ729mTeWO2
 Z8Zwvae1w/BVjHmjV7nvNqk/OIMLTwUAGe7zjDpQYBLYagnN55NG26kLsmf3th4iIPxQXle9
 U7lC15Mi6rLMVKCKkfw2wFdzxFduTq1kCG1yxRsnjcms7aF2yrP06LueVBUXwwDDHknhlDqL
 4+uitkcV0X9dAklmiyu4kPizrRarqByR4XKaX9BZDO+b2RrU6/q86GHf9YK8pQj9yNeTOW7Z
 1meDL/7uRoTlS35TSNSwzUydjfivZuc/VQykCSPJXx+qFLBdMd/2AvF49rdVbhd03IKSTJ5h
 j/eGlWnd4n0u4/Oz9Ga7L34CDvpX4YbaSTxyIKcqCa3gA8iSQaymfy+gJyvEAQ31zP6y8g/U
 CzJqBjmZYy4n6++MO9hYgxpHAqstowgQNk4y9Vtws5Jih14zt2P8HEKkHn+K4Be0KP6Nj8WQ
 CIThsTS607j0VFiKXSAw8T4UG+cy41vfYrfACte1yQj4sRNEKrR4qZDmH4/uhyqpAjcZdBlk
 zES1Oc073gbk6cFtUB+q0fVSqBXBkReMSH2wl6QqcK3pqhTTH6id7etyFB5m9GxSr2P6FI5O
 j6xatIpGil+6d96OVTH3Sjo643qT9LXaMoaqhyelxqTx/gQMp86keAGwDZ2IW+o92Nw0PY11
 FY9uPPy9JjCMWhm+7i1RwJVJiGgLd1G4Snj1O5bjo6Tz9K3E5NuBzQNUoHpQPSkFCNUufmCV
 U7GFS1usnqdFqfeG0qR8kZrqX7LAtanOjmBLX0dh72OXTG7I0pSyEARVTQ+xNsiExyygdbme
 wF/7ywQ4Vjxrl1NzPhpPl/xSDWXogDgcToyRJWFSXgepghf+0fYN9Cf5eNvDmlZ+JOmtgmEN
 m2cYUxBE2gIXkWOA12rMKOp4JHM9O2RB+z2KPWrA/3GsetFS/KB3o6iyKNj8iqNLYOCLmUkF
 /A91VdfR3d/GtSflzhOAy0bmiTRbtKK8Rex/ioky6L3uP/vWQ/p+c6OE+4CbJM1oUjw2Pnec
 bHJ10MbYX5C25gBxGHF0u0a1V8W0WR1ciW1VK4HvmjLRb7RnaleC1gabTlyPY1G9fFZvEEFN
 MjFh9fyzrM9gOQyDgIPTRrzk8ukYeQSLmeyKU/dA0CKJPKKKHeYpqO/KbP5UrBWgOhO4leov
 i2HFkb4IjmZvzzkSxG0d+xckGeDMRpRpZ2ndRBsGS7vQZi1D3/zeM8yhjowz7oug3rMPmNJK
 jlwfXRGqbiI5D9ZiPFyc4SkxmJoK+aZhzye6ejIbJob46MD6sVcku9G4W98xqtJqjlJQvNoh
 DHVqN9+5V2rwLHnItVPSBdIpStXnoWNvFUkNaiLr/F9
IronPort-Data: A9a23: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
 w==
IronPort-HdrOrdr: A9a23:/9vPjakZw+ggu/blaT0CYmKCIvfpDfLf3DAbv31ZSRFFG/FwWf
 rDoB19726XtN9/Yh8dcLy7UpVoIkmslqKdn7NxAV7KZmCP01dAR7sM0WKN+VDd8lXFltJ15O
 NYTpk7LsbxA1h8hcO/2wWzE88hzN6bmZrY49v2/jNWZUVHeqFlqy1+DQGWGFAzZDAuP+tdKL
 OsovBu4xaweXBSSsy6Az0rRO7Gzue78K7OUFo9L1oK+QmLyQmj4Ln8HxXw5GZ4bw9y
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,252,1650924000"; 
   d="scan'208";a="44642916"
X-MGA-submission: =?us-ascii?q?MDHCEqX1k7qVxJLrCEVK2Mh3XDMlC2G0Go1iIa?=
 =?us-ascii?q?HxYjwOSbgS+EpUAicspVcg5hO01bdYqt0P9c0g4oZ6IZnaN0RjUJWE2c?=
 =?us-ascii?q?fBHD7M+GWoD9pslvjnMXr5g4WlF5e7iw3VdgYX1nm9PkSJ+Q3PVt/SsM?=
 =?us-ascii?q?hEaKHx16LeNO5LDD4ZByeNFg=3D=3D?=
Received: from metis.ext.pengutronix.de ([85.220.165.71])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 11:20:47 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.ext.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1o9Ngi-0006DF-SW; Thu, 07 Jul 2022 11:20:44 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	Philipp Zabel <p.zabel@pengutronix.de>
Date: Thu,  7 Jul 2022 11:20:30 +0200
Message-Id: <20220707092030.3319988-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: cocci@inria.fr
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] coccinelle: api: explicitly request exclusive reset
 controls
Reply-To: Philipp Zabel <p.zabel@pengutronix.de>
X-Loop: cocci@inria.fr
X-Sequence: 485
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/20220707092030.3319988-1-p.zabel%40pengutronix.de>

Match deprecated reset_control_get API calls and replace them with the
corresponding _exclusive variants with the reset-exclusive.cocci rule,
to hopefully advance the API transition started with commit a53e35db70d1
("reset: Ensure drivers are explicit when requesting reset lines").

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 scripts/coccinelle/api/reset-exclusive.cocci | 49 ++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 scripts/coccinelle/api/reset-exclusive.cocci

diff --git a/scripts/coccinelle/api/reset-exclusive.cocci b/scripts/coccinelle/api/reset-exclusive.cocci
new file mode 100644
index 000000000000..c5d6938ca542
--- /dev/null
+++ b/scripts/coccinelle/api/reset-exclusive.cocci
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Explicitly request exclusive reset controls. The implicitly exclusive reset
+/// control request functions are deprecated.
+///
+// Confidence: High
+// Copyright: (C) 2022 Philipp Zabel.
+// Comments:
+// Options: --no-includes --include-headers
+// Keywords: reset_control_get
+
+virtual patch
+virtual report
+
+@depends on patch@
+expression x;
+@@
+
+ x =
+(
+-devm_reset_control_get
++devm_reset_control_get_exclusive
+|
+-devm_reset_control_get_optional
++devm_reset_control_get_optional_exclusive
+|
+-of_reset_control_get
++of_reset_control_get_exclusive
+|
+-of_reset_control_get_by_index
++of_reset_control_get_exclusive_by_index
+|
+-devm_reset_control_get_by_index
++devm_reset_control_get_exclusive_by_index
+)
+ (...)
+
+@r depends on !patch exists@
+expression x;
+position p;
+@@
+
+*x = \(devm_reset_control_get@p\|devm_reset_control_get_optional@p\|of_reset_control_get@p\|of_rset_control_get_by_index@p\|devm_reset_control_get_by_index@p\)(...)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg = "ERROR: explicitly request exclusive reset controls with reset_control_get_exclusive() and variants"
+coccilib.report.print_report(p[0], msg)
-- 
2.30.2

