Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD53C433EF
	for <cocci@archiver.kernel.org>; Wed, 18 May 2022 19:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=y5gKxZ4EoUCGtww7AN61EjOG1EYAU2iCVgb79FPCHEI=;
  b=Sy/GHdhxMjLbiVwxVLOp2ppNwlvzRwFWfIHxOCye4bzIMl9kcqt4UAN+
   Jr162T3RCXTYblq82sDoSh477Bz/z93PtijTm59974xQwlYGUp3cMyW5H
   h2oJMs6Joa7RtgeD/0I8ApwA1tEsUxmIjZL0De5J938QCxlK7+Z0+wvvf
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.91,235,1647298800"; 
   d="scan'208";a="36987729"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 May 2022 21:31:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E93A5E0094; Wed, 18 May 2022 21:31:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BDC70E00A8
	for <cocci@sympa.inria.fr>; Tue, 17 May 2022 15:36:11 +0200 (CEST)
IronPort-SDR: VHH2p0anE+QUZEDO8aq03NmzNR6DDSc0qwKin1Ql2IvJqpoiyLDpNr+QxOla6WRyGM0KQeC1kZ
 QajIJtcvLALJU8DlUqJAkVAECvykxuW4LEHoW1hh6Ktut05LDIejv+b0dh7KTT1BCrJifyoSEB
 pa6+cfhIppW770naM0l3ZCFuK/QakTLETQMrpwmMTg+OOsNKjqVvEBD9J6w04ZRxnJBHtGW/v2
 IscTl2Fo6aFE+shb2qqPxOOg/Ss+84V8vu06C02C8GtSi+rnHNroqtsrm4jebSHUmvv6WbEr2Z
 kUNCUqoaQmrQWaJsG6N787ep
X-IPAS-Result: =?us-ascii?q?A0AwAQA7pINimKv8oNJaHgEBCxIMggQLgiR+VCsDBAtDi?=
 =?us-ascii?q?yeCJ4gLlxeFUBSBaAsBAwFADwQBAYUChUEeBwEEMAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAQBEwEBAQEBAQEBCQsJBwYMBQ4QBUFkYoFFggQGA?=
 =?us-ascii?q?wEwDYI1KQGEHAFGgT4BEoJ9AYMWrhIaAmWIGYFlgTyBZodeUjiCL4FjN4FVR?=
 =?us-ascii?q?IEVgTyBPm6BD4J4hngEjVOGLYIsAwkGBwWBPhKBIXEBCAYGBwoFMgYCDBgUB?=
 =?us-ascii?q?AITElMMEgITDAocDg5GGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMjCwIDGAkHC?=
 =?us-ascii?q?gMdCAocEhAUAgQTHwsIAxofLQkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJLw0oC?=
 =?us-ascii?q?wMFDw8BBgMGAgUFAQMgAxQDBScHAyEHCyYNDQQjHQMDBSYDAgIbBwICAwIGF?=
 =?us-ascii?q?wYCAkAxCigNCAQIBBweJQ4FBQIHMQUELwIeBAUGEQkCFgIGBAUCBAQWAgISC?=
 =?us-ascii?q?AIIJxsHFjYZAQVdBgsJIxwsEQUGFgMmZAYiHZVoggkBehMrgk/AXjQHg0+BP?=
 =?us-ascii?q?QYMiC2BHpRWS4VEkRgdA5FcAS2RC4UuII0IlTOGL4IVTSODOAlFAQIBAgEMA?=
 =?us-ascii?q?QICAQIBAgECAQgBAQEBjjYehHmJIUMxOwIGCwEBAwmPDwEB?=
IronPort-PHdr: A9a23:3W5SRBYsyO+5kFbMz3iEXjL/LTFl2IqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1gSPANqQtasMotGVmpioYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2+5ZPebx9IiTe/br9/L
 Qi6phjNu8cLhodvNrw/wQbTrHtSfORWy2JoJVaNkBv5+8y94p1t/TlOtvw478JPXrn0cKo+T
 bxDETQpKHs169HxtRnCVgSA+H0RWXgLnxVSAgjF6Bb6Xortsib/q+Fw1jWWMdHwQLspQjmp8
 btlRwH0hycGLz458X/YispsjKJAvRmtowVzz5PIbI2JMfZzeL7Wc9EHSmpbRstfVzJPD52hY
 YUBDOQPOulXoYbmqlcSrhazHxWgCfnzxjNUgHL9wK000/4mEQHDxAEuBdIOsHXQrN7oO6kdT
 O60zK7SzTXfb/NX2Sr25Y/QchAhoPGMWah8ftTMxkghEAPFlEmQqYzlPj6OzOQCrW6b4PR7V
 e21kG4rsR1+oj+qxso1jITCm40axEze+ypj3IY1OcO3SFR9YdO8EpZduC+UO5ZrT84mX2xlu
 Sg3xqAYtJO0YiUEyIoryhHBZ/GJboWF7RzuWeSPLTl3mX5reK6yigu8/0WvxeDyVs+520tEo
 CpCl9nDrHEN1xrL58iDS/t95kas1SyB1wDJ7OxPPEM6lbLDJpI/37I8ioAfvVnCEyPqgkn6k
 q+bels+9uS16enrf7PrrYKGOYBukAHxKKEul9S/AesmNggOWHCW+f6i273n+E35RLRKgeM2n
 6XDsZDVONgUqrSjAwBL1IYs9Q2/AC290NgCgXYHK1dFdAqGj4jvJV7OPOj1Aemij1iwijtn2
 vHLMqH7DpnTLnXPjq3tcat/5kJB0AYzyMpQ55NQCrEPOvLzXUrxucTADh85Mgy0x/zrB8tg2
 YIQXmKPGLOZMKPSsFKT/OIgPe+Ma5EOuDnnMPgp/eLhjXg8mVMFe6mmxoMYaGqkEfR+P0WZf
 X3sj88fHWsSpAoxUPTqiEGeUT5Uf3u9Q6U86S0nB4KnForDXYCsgLmZ3CihBJFWZ2ZGCkqNE
 XjybYmEVe0MZDqIIsB9ijwESaShS4g52BGqrgD7xaBoLu7Q+iADtJPj1d116PbJlR4o7zB0D
 sKd03uMT25uhG8ISSU2j+hDphlf11OC2OBciuNREdgbs9FUVgYzc7rV0OV+D/jzXBjAd5GHU
 gDiCvOnCjY1R8l5+9YKYlY1T9OjhRfH1jHsG7YRlqyjBZk9/eTSxS6iCdx6ziP+1Kglx3QqX
 cxVKW23zvpn9wnXQYPFjEKDi6a7Xb4R2iPW/XzFxm2L6hILGDVsWLnICChMLnDdqs70swabF
 +fG4dUPNwJAzZXHMa5Wcpjyik0AQv7/OdPYamb3mmGqBB/OyKnfJJHydTA72yPQQFMBjxhV5
 WyPYBA+ByPnrm7BCyZyFUPHeU7q/PJ3szWwSUpnhxqSYRhZ3qGusgUQmeTaTvoS2rwevyJ0s
 zV1GBCw083REcaAtiJ7caNRetomplxA0DGRrBRza7qnKa0qnVsCa0J3skfpgg1wEZlFmNM2o
 WkC1gd2LKaZ3Q4Hdj+Tm4r9PLDMI3K09xeqA0LP8nfZ1tveuqIG6fBj7k7moBnsDU06tXNuz
 9hS1XKYoJTMFgsbF5zrAA4x8FBhqrfWbzNYhcuc3GBwMaSyrj7J2s44TOojxBG6et5DMaSCX
 AbsGsweDsKqJaQkgV+sJh4DOelT8uYzMabEP7Oe2K+veutsgzW8kWRWyJpw1E+X/jE6QenNn
 t4Ez/yewgqbRmLkll7y16K/0YtAZDwUAi++0X2+XdYXP/MqO9xWUyH3fJTko7c2z4TgUHNZ6
 lO5UlYP2cvyPAGXc0S4xgpIk0IevX2gnyK8iT1yiTAg6KSFj0msi6zvcgQKPmlTSSxsl1Dpd
 MKsj9EeGkWkcA8ziBu0zVz3waVArb85JG7WCxQtHWC+PyR5X628u6DXKdZP6ZduvClIV/6gY
 UGyULP7rgATyGXoGG4Ul1VZP3m6/57+mRJ9kmeUKn1++WHYdc9HzhDa/NXARPRV01LqXQFAg
 CLMThi5NtitppCPkovb9/u5TySnX4FSdi/iycWBsjG67CtkG0/3k/e2k9zhWQ80tE2zn8FqV
 CGOoRrjZZP317WSK+9hc1JhHxn37M8yFoxlk4Q2jY0dwjBA383TpCRf1z2ua5MChvu2ZWFoJ
 3ZD29PP5Qn5xEBvZmmEwY70TDTVw8dsYcW7fnJD3ys8685QD6LHid4M1SBxo1e+sUfQea0nx
 29bkKV2riRH2adQ51N+q0fVSqofFkRZIyH2whGB7tTl6b5SeH7qar+okkx3gdGmCriG5ABaQ
 nfwPJk4TkoSpo1yNkzB1Hrr58TqYt7VOJgLthyQ1RrMkO9PNJIgvuAHgyd8MHm7tnoggb1e7
 1QmzdShsY6LJn84trq5AxoeOzHqYNkP+iDFl6tYk92fxMakGZArSVBpFNP4CPmvFjwVr/HuM
 Q2DRSY9pnmsEr3aBQaD6U1ioiGHA9WxOnqQPnVc0cR6SUzXOhlEmA5NFmZf/NZxBkWwycfma
 ks8+j0B+guytE5X0uwxfxjnDjWF/V/uM2lsDsLCdlwPsVgK5l+JY5bHtqQqQXkepMD76lXSc
 An5L0xJFT1bAx3eQQm+Yf/3uoiGqbDBTuumc6mXMO/I8LEBEa7XlNT1itEu/i7QZJzeZD8zV
 rtigRcFBCgmfqaR0zQJQCgKmy+fdNaV4heh/yRxp8+ytv/sHgD3rYqJAL9PPdg9zAuuj//Zc
 fSdgitiIC0e3ZQJoB2AgLkHgAxL1nwoKmfrS+5Z83eWBKPIxv0OUkNdNn01bpERqftglghVZ
 ZyCzIqzj+ckyKZyUQogNxSpm9n1N5VQfyfkbAKBXRbScuvOJCWXkZuuMOXlEeMW1rgM8Ufs5
 1P5WwfiOD+HijXkBQu3P6dUliaHMRdCuYa7NBFwFWzkS9GgYRq+eN5v0W9rm/tu3TWWZChDV
 Fo0O0JV8u/LsWUB0685SzIHtSQtLO+PnzuV4rvvMY4Y9+NwB2J3keVF6nlmjbBS6UQmDLR0n
 iDWs9Jj8Wa9iufJwzF+TRtH7D1MgcqKpRkwYPuJsMMcBDCep1RXty2RE0hY/oc0TIK1/fkPl
 p6WyvOWSn8K8sqIr5JAVo6LcoTdaSpnYUGhDjfQCEFtoSeDE2bZigQdlfiT8ibQtZ0mst33n
 4JITLZHVVszH/dcC0J/HdVELo0lFjUj2aWWisIF/x/c5FHYWdlas5bbV/mTHeSnKTCXiqNBb
 gcJxrWwJJoaN4ny0UhvIldgm4GCF03VVNFL6ipvC2186F1K62R7R3Yv1ljNcA6p5XsSGKPyn
 xI9zBFzZ+k2/Syq6FAyZxLLqCY2jEgtiIDljDSWI1uTZO+7WYBbDTaxtlBkaMqjBV8rNUvow
 BYibWidFNczx/N6eGtmiRHRo85KEP9YFuhfZQMIgOqQf7Mu2EhdrSOuwQlG4/HEAN1sjlhPE
 9bkonRe1gZkdNNwK7bXIf8D1lhRguSDsjCvzPwx0ScEKkAA62qJPiUPvQZbU9tubzrt5eFq5
 QGYznFbf3MQUvMxvv9w3lkwP+GEzi+9lb9PIQarOuqSNKqC/WPHkITbJzF4nlNNnE5D879s1
 M4leEfBTEEjwoyaEBERPNbDIwVYByK33GLeeyuVuP6LypVwbd3V/gHAV+KKsaIVjx/iHQoiW
 Z4B6MkaF4Lq20bdf5+PxFEt0xgr6R/iPxOOC/EbIXq2
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:z2xADaMQQnv94MBcTtKjsMiBIKoaSvp037Dk7S5MoHtuA6ilfq
 +V/MjzuSWZtN9zYgBEpTn/AtjifZq0z/cci+Qs1NyZPTUO1lHGEGhl1+DfKkXbak/DytI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="14333266"
X-MGA-submission: =?us-ascii?q?MDGkuQqP3BXGrOuCok0QBgUQBhstWmHqWzISU4?=
 =?us-ascii?q?9jel8Us+3UgRx9uZLY3RcXCoRikqRthvSNokW2OoQEdRUW9IMiBQ60/M?=
 =?us-ascii?q?MCVUBbKoeATPhCQsailIVBzAEiQ5HtTdaALrL11Q2edixkbeZVdBS5py?=
 =?us-ascii?q?vtIc/7Np/i4qEC5DGyyaWLvw=3D=3D?=
Received: from relmlor1.renesas.com (HELO relmlie5.idc.renesas.com) ([210.160.252.171])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 17 May 2022 15:36:08 +0200
X-IronPort-AV: E=Sophos;i="5.91,232,1647270000"; 
   d="scan'208";a="119949063"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 May 2022 22:36:05 +0900
Received: from localhost.localdomain (unknown [10.226.92.244])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C97A740061B0;
	Tue, 17 May 2022 22:36:02 +0900 (JST)
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org,
	cocci@inria.fr
Date: Tue, 17 May 2022 14:35:56 +0100
Message-Id: <20220517133556.6934-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [RFC] coccinelle: Add test for unnecessary check before
 calling clk_disable_unprepare()
Reply-To: Phil Edworthy <phil.edworthy@renesas.com>
X-Loop: cocci@inria.fr
X-Sequence: 394
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/20220517133556.6934-1-phil.edworthy%40renesas.com>

The clk_disable_unprepare() function only calls clk_disable() and
clk_unprepare(). Both of these functions already check the clk ptr
passed in using the IS_ERR_OR_NULL macro. Many drivers already omit
any checks on the clk ptr, so it is safe to assume this is true for
all call sites.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
Note that this is the first time I've used coccinelle so there may
be some clangers in the script below.
---
 .../api/clk_disable_unprepare.cocci           | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 scripts/coccinelle/api/clk_disable_unprepare.cocci

diff --git a/scripts/coccinelle/api/clk_disable_unprepare.cocci b/scripts/coccinelle/api/clk_disable_unprepare.cocci
new file mode 100644
index 000000000000..17f00d3653c9
--- /dev/null
+++ b/scripts/coccinelle/api/clk_disable_unprepare.cocci
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Unnecessary check for valid ptr before calling clk_disable_unprepare
+///
+// Confidence: Moderate
+// Copyright: (C) 2022 Phil Edworthy
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@depends on patch@
+expression clk;
+@@
+
+- if ( \( !clk \| clk != NULL \| !IS_ERR(clk)  \| !IS_ERR_OR_NULL(clk) \) )
+{
+clk_disable_unprepare(clk);
+}
+
+@r depends on !patch exists@
+expression clk;
+position p1,p2;
+@@
+
+if@p1 ( \( !clk \| clk != NULL \| !IS_ERR(clk)  \| !IS_ERR_OR_NULL(clk) \) )
+{
+clk_disable_unprepare@p2(clk);
+}
+
+@script:python depends on org@
+p1 << r.p1;
+p2 << r.p2;
+@@
+
+cocci.print_main("clk_disable_unprepare call",p1)
+cocci.print_secs("Unnecessary check tests",p2)
+
+@script:python depends on report@
+p1 << r.p1;
+p2 << r.p2;
+@@
+
+msg = "ERROR: clk_disable_unprepare already checks for valid ptr so check on line %s is not needed" % (p1[0].line)
+coccilib.report.print_report(p2[0], msg)
-- 
2.34.1

