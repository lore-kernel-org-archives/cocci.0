Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866ADC05027
	for <cocci@archiver.kernel.org>; Sun, 29 Jan 2023 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=jNQDysg2kxJHaI1lidxFdYOjzN3/K2YHukxV9ZnA7dg=;
  b=nKdy7MWZ+G5ZltJmeAsGWuKEpl4BR2POflpC8vMapFXForvAAF02tO8u
   CWuPjmiq7zsfH6tARMk4FLCn1JHoQ8LtaxdgNmXs0WsVCDX/0igezu+5/
   B2pqmaGG3MDbT9LOXeD+mu8mNlawPqBwx48liU8HOqth5A4w4zN0CVN5D
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmx.net
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="89928042"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2023 16:22:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C74EEE743F; Sun, 29 Jan 2023 16:22:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 20A0CE743E
	for <cocci@sympa.inria.fr>; Sun, 29 Jan 2023 16:14:41 +0100 (CET)
IronPort-SDR: 63d68d61_i9qqyWYxvtklwNVQ59h1j15UhgYhtaOAtAZHiVmdbo8S746
 Kdhp9ZHwT1QBjSkrobcr6fKFK6SRsItUDowfhrw==
X-IPAS-Result: =?us-ascii?q?A0HlCgCfjNZjhxMP49RaHgEBCxIMQIFEC4ItgV4uBAtFh?=
 =?us-ascii?q?E+cdItYhhOBQD4PAQMBDUEBAgQBAQMEhQCFJwIdBwEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGAsXBw4QBSKFaA2CNykBEWSBC?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHU2YdAQE3ATQCJgJygn6CbgEDM?=
 =?us-ascii?q?QecZYsygTKBAYIIAQEGnAgBSwOBMoEeCSdtLItihEqBIYIphAgHboIggnGDC?=
 =?us-ascii?q?4JFIptoCoE5dYElDkx6gQ8CCQIRdEA3AwkDBwUsHUADCxgNFjIKEyw1FkoQG?=
 =?us-ascii?q?xobB4EGKigVAwQEAwIGEwMiAg0oMRQEKRMNJyZpCQIDImIDAwQoLQkgHwcmJ?=
 =?us-ascii?q?DwHVjYBBgIPHzcGAwkDAh9PcAEvEhIFAwsVKkcECDYFBlESAggPEg8sQw5CN?=
 =?us-ascii?q?zQTBlwBKQsODwIDUEYZbgSCES8mnzg9UVWBJ08pwXGBNgeDUCigUEypLgGFF?=
 =?us-ascii?q?5I4oz+EVIFiOoFcM0iDLE8DGQ+OIBmIMo12QDQ7AgcBCgEBAwmCOoMKAwEBA?=
 =?us-ascii?q?wEdEwsBhhoBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3Bz3GaCpLuZPIK3lHemO55DYdb4zR+YMi2TDGXoedfUzSL3+qy
 nOpoV+6faQsl0ssR4b+exoVJPtfZq+z+8R3WBuB8bAYOCOggLBQb2KhrGC/9SPIULD39J8kY
 F9bqN5FNr8NlRii93miTPIa+rIuOP3kpxBno3lvhFQpOxRGthdB4wVMGymLnE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="89927740"
X-MGA-submission: =?us-ascii?q?MDGUs5Ju0z1vrDUUg6u/NhjEW2u+DVUxHEjE4V?=
 =?us-ascii?q?8EKsv9PtF0FF54U91lSGyai7e10u1ga/PM8fWm2GZwOAa5oxSREfV1Ov?=
 =?us-ascii?q?ZAzmv/mDFKQ6JeZ3e3L1eFhb8U6uOXNuLnQC8ILQARxCeSV5naqlrgsB?=
 =?us-ascii?q?N0oupXeR6ZmhOzSkLO3O2J3g=3D=3D?=
Received: from mout.gmx.net ([212.227.15.19])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 16:14:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
	t=1675005279; bh=Xkk2wNMvCc6Xw7jVSI8Ne2p6gqEgoFqQ1RMVFA8w0Yw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=sh/NfCDI9eCn9BPMAgRPaidw6AV/PvMbIvmkJlt2FluBL6d08DyfkOYQkGt6jcEeQ
	 4n7/mHBo3/lQu4cyJwGr/oK9TgL0v4/QMChmsqKF4/48rBI9aaOzVNnMUy2FpGyPwW
	 MIMg5aAzrZn4xkUBLWKXwq8fluA/BDr7bvVuuan2ckdUU2iAR6N6zwiIper6oOgNgL
	 12YqfKWexdgvMZmuIQHYQcBbNkE/56ic52Wxm4tOMu91BwiF/ryYHFJgZEF1ux+7Ke
	 dDI71NNRZQaCY2hiu61sT3qHPc2wVLKKNe8+CJD4xAMELwPnubIQJdsfYPyFalht/K
	 lm2trhMJYhsTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1oUjmv2KAM-00rUtE; Sun, 29
 Jan 2023 16:14:39 +0100
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-doc@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jonathan Corbet <corbet@lwn.net>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Sun, 29 Jan 2023 16:14:08 +0100
Message-Id: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uFBiIphmXEeRlB5va60ud01KyrW18ZmJLRIIc6nBb6esVmlpr6p
 JZaPv0QxjZtJVFkj7PEPH/zF6GGDNhx3jucFh5vm7g6QGRo909p7YAj0d2sLBOCfs8ggd0u
 LQIC4lwvlGgRnA/otQNn9JZXQlJwila2brqU/T1Q/a2JP93Sq5AmhPacdgreGg7Fl5yGZ8y
 eVcL0sKMRsY+jWd6YNFAA==
UI-OutboundReport: notjunk:1;M01:P0:h+JDJ6+TucY=;Zm25VJ/b7OpIGuDIL1u9y3y+QEs
 uKB/BnXtj6JNNyOKpHrtyCHz5a1wPIvrQO2zjjkj+hvCkQss+xjM1ItwXJYB0pXAHQA9RNPzo
 8mKD8aMur5PWpIa15J2FKYnXd7jdTjZ2eit+YKXzwx1Z0gREhPZnk3+vsKzEe+IpG7LDUblAM
 GMEOPNuIDF5QaGkWa8YkVN4d7Ymq4oHaH7p+EJSa5sa8sA19SmGJ5fxDvA12lYb+sWmSJ92Ls
 7uQN/QRwi7x0iMm3N4Ryye4f/oa//bMg0J/oxl7wlAdzNk+ufPlK9Jge5rutf7LogEfGxKU0I
 zF4AVAwMG7um7GchGt2MFDSAb8Ej21otZ6FNNKHsTOpBBGFWACBOidh7TMew3okWmBKQA4IQ/
 xwMyUCTAMZPPIK4OC/jl3lO7ewqc7Dw+OHd76ml4A50t0QjOzcJtQs6E5AMrso/KuwJV5/qeG
 alpwYKCKkixH52/cXihYol4JGgZiKJPyD03rsJH3v4wH3tt5L+zMLO3SqsvGAQzE0UQqgjY/7
 jAhRUa/P8g1DZ/uvOGZTJ1yyJDbqMXO2us/YkFDa/QjDazHh286QmlS4/hmyKaNF2CamuJa+s
 Y2MDFcsjMdFdyPIg9C662sPv/0x5XSBPrmVBjchjpgpavOdDMuGQlP3CQ2OZHsYCE9aYk+j07
 pf5Fapzt+ke4gRYSjjwU5m2gM19XhhFornmxGVwh5wLpGewV6BqLlFLCilNJ+fPNsMsg/jF1o
 9g/579AHkZ//GtbmstXOXzDOly6pv6rlVTVXNJsif3GJinb1iBJgaZpVTCsV43yC2GiOCRtfD
 lH9Ykb0HsdrzbEbhXhi+C7Lk1zao3U1aBQyDBJHzxnIER2Gxl1NZnPmdMPpd19KN9Pdy3G1Wr
 ZEn/E4oHkpuA5VCTfxUD1jtt5ufgPLgssPU+G1T5dcvOtjPKB88QSVSY8M5X5if5P6iQIY3Q1
 wxZFz+gjwqUF12iprgPTnpN6GB4=
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] Documentation: coccinelle: Escape --options to fix
 Sphinx output
Reply-To: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Loop: cocci@inria.fr
X-Sequence: 832
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/20230129151408.1525324-1-j.neuschaefer%40gmx.net>

Without such escaping, -- is rendered as =E2=80=93 (en dash).

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/dev-tools/coccinelle.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-to=
ols/coccinelle.rst
index d9976069ed126..535ce126fb4fa 100644
=2D-- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -219,7 +219,7 @@ instance::
     cat cocci.err

 You can use SPFLAGS to add debugging flags; for instance you may want to
-add both --profile --show-trying to SPFLAGS when debugging. For example
+add both ``--profile --show-trying`` to SPFLAGS when debugging. For examp=
le
 you may want to use::

     rm -f err.log
@@ -248,7 +248,7 @@ variables for .cocciconfig is as follows:

 - Your current user's home directory is processed first
 - Your directory from which spatch is called is processed next
=2D- The directory provided with the --dir option is processed last, if us=
ed
+- The directory provided with the ``--dir`` option is processed last, if =
used

 Since coccicheck runs through make, it naturally runs from the kernel
 proper dir; as such the second rule above would be implied for picking up=
 a
@@ -265,8 +265,8 @@ The kernel coccicheck script has::
     fi

 KBUILD_EXTMOD is set when an explicit target with M=3D is used. For both =
cases
-the spatch --dir argument is used, as such third rule applies when whethe=
r M=3D
-is used or not, and when M=3D is used the target directory can have its o=
wn
+the spatch ``--dir`` argument is used, as such third rule applies when wh=
ether
+M=3D is used or not, and when M=3D is used the target directory can have =
its own
 .cocciconfig file. When M=3D is not passed as an argument to coccicheck t=
he
 target directory is the same as the directory from where spatch was calle=
d.

=2D-
2.39.0

