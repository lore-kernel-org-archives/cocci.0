Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9532C6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 14:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ugkUvPd8DaXjULdBZl/o7iPFSFyb0iibyr3LHFKXgC4=;
  b=KKXBEBs8Ov/afNobrlAYdkhBETpqfmYujcRSCEjM2e7k2wK5g2qhkDvq
   NjwoGyeObPZZQPymx6EdAsDVb1hyU7lOsL26LqrXHmOrj7o6DhcQ6Bvua
   wS/w4Sv1nVd/mOmT5j8B3xFjX5l0zK5mYoijOxtfr33aft4IYB98V7J9h
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99065616"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 15:02:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A0FEEE0D41; Sat, 25 Mar 2023 15:02:37 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 77B70E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 15:02:34 +0100 (CET)
IronPort-SDR: 641efefb_8USo1+x2RECIJ9ytnPcC74HdeYthyPVzA4HocwZWiOBzbH4
 VnuZgmxBWvH6l9wCeK0PgjVbT2/2Q/y6LrIQA8A==
X-IPAS-Result: =?us-ascii?q?A0EqAADj/R5khwMP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIH4hiLgOEL4cskCOBVoFAPg8BAwENQQECBAEBAwQ4gVOCc?=
 =?us-ascii?q?wKFOgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQA?=
 =?us-ascii?q?QEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?gJHUz0DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQexMX8zgQGCC?=
 =?us-ascii?q?AEBBoJjmScfLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBFSeBFYIsHod+gmeBDIEcj?=
 =?us-ascii?q?nuILwqBNHWBIA6BPYEEAgkCEWuBEghrgX1AAg1kCw5vgUoCZEyBHiUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo/NQYDCyAGWGsCCSMREwUDCxUqRwQIOQYcNBECCA8SDyxEDkI3N?=
 =?us-ascii?q?BMGXAEpCw4RA1CBRwSBCoEBBgEmJJpxAgGBdHMBUjxLJoIEHJI8kkCeDjQHg?=
 =?us-ascii?q?iiBVYFZDJ8MBhMulwgOBpIjl2ogp3qBYzqBXDMaJIM2TwMZD44gDA0JhAOPR?=
 =?us-ascii?q?0A0OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 z3TFr0c8yVdGq1UeNs=
IronPort-HdrOrdr: A9a23:qx8kj6+fYX4OAMK0Gkhuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99065607"
X-MGA-submission: =?us-ascii?q?MDGSJ0LzQorOhCI84fbUn8BIQTEZ2Olp3Rqlr8?=
 =?us-ascii?q?ExAeO/WS0+0YOjbSe60jkZGHQOusiZEgwOfi9e0r8X97EO3V64uEl8HZ?=
 =?us-ascii?q?8+VKfebCvXp/FCqfxnQbRPpG9O6RZyFC2A25Q+rtUKCYWFA4wt4D6oF1?=
 =?us-ascii?q?pHXbASqZEseTIdroRQtp1AdA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 15:02:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679752953; i=markus.elfring@web.de;
	bh=RwEdXKP7nwzY6DzdWj8w7ZBlLl74vfqXWwVBaEPscVE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=mc+RjW8tdUPfDxE9rLGgMdiNgHoeuoYooYPbV741RwmBHoRPeonURJaweb2i5kpG5
	 inzqoe0Cn9BcjTZEjVNL02Zw4yhJHPitGGQjlMtEMO/qLOzKbKxVvb01N9AxY2IR36
	 6SCD9aihor7tY8qpJ1Qg2KUlAHkOKp9rYEIqCLiTgThx7I5FMmERnhl5d5B0GZhQkP
	 NZUHaC3pDYWEjp/IUXocrseuMdrwKQ9TCBImh0buSvQha1D7b5QzSKutYxpd7XS65C
	 rxXd5iblnrozKPAKfgzOo1TBZxstpE0J11CukrAsaYMpfFMY25sB1R7PVaAVcnvmup
	 WNzHyX8uERFBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq182-1qIvWN0JQQ-00n2bF; Sat, 25
 Mar 2023 15:02:33 +0100
Message-ID: <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
Date: Sat, 25 Mar 2023 15:02:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
In-Reply-To: <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6gwHSaQE5TNex2NDqPjArqbFtcBkYJkuwLF6WZj167hyFhwbIyO
 Cf6kXJRREaw6sNDxo2dMOMJSm7khOLZDkfHXV/8ioxxT4TUfebbv2VGuUnxTevQVeQcpuPc
 5FJD4/AwKSc7+Vs+MFmLYJ4lvgUMZmBPn9kJE421Tx/I6zFjFSYREYjdXAY9x6flG3Q9gxp
 vO0DOBksubqrX0rw3FR1A==
UI-OutboundReport: notjunk:1;M01:P0:4qcU5eWx50M=;cd0bYTXQvcHn9LsOtRWLkIdkvFK
 hod1enpmbepDkjVS0TLRfqrmhCXIfFBpvUZwL1qx6CxW0qlEdMHk9E6G31xaRTItz5S20+DKL
 rdeaTdnPY7kUpHf9LtGP8o+5S6DJJnu7Ff3uqNBLJb3xH75Zkis1vpo44gdZj2eU+gxKyeUsd
 g2pMNlQUh8U90zPSyj7KXUBu45hytwtJCqtoeLFqo9mUu92788hK2lQTmXpWlYab6Uj1Alk1/
 TghjaLtBmhcdBzYzhuRljdudMf46M87gvpLudHc/HLWMb2MojHAo4caNqEARe+XcaxSt72QXQ
 vXoeEEWCU/D53UHZGDmzjwQBi3iQzmLIkDB9dHu7v9CBUISOW/gR7QSx8S61U/i8Bbk9NKTFS
 HW1R6+Ffiwp+tlTj31OWqlGP0IP5vqf9H/8tqreK2HzX9hG2k7YetWr7i7i5BoJliv0WPHU+9
 Xdaf2hdbBQ/Sprls6wIRxeGjUnfkm5VWyVRcoBWMFRJ1dETHKbXzCl1s7M/e9teZWeMHNidWu
 +1WdbeCeVVoHi0rlZ46vukQVFAr3JIOvSZM7G1X0IQ37ldf/gTuIUcMPmkQb3r2FFH2ObxSq4
 FqL351EFNiAuM9uVQHO2LpKbwZstBIb1XlfNZ1tnEZXPCcZDs2K/mm+sDp1QJL9fgQ1ew0d3W
 Z+dL23HvVudg6B2W8bAZm0FHxZjnfRhFGRCpWVi26hUyo8pBqRd8RDN/fKO6+nEPiUtKbtAcr
 1EsfDGN+yp7KLkbnSduBKAJz6gKk24HSqTQFJGzRc+uaNUG3lc5lHUaGmF8YYHaP/o8nL6Ckm
 KfCytb9zZKTEzLi0el/5gYW+RRKSwHh/CrrO7LS4w7aH5hhXUX8TqyBALI9/kCEKNcdpkrD/c
 uUNdFJuH3hyvcyLprwVlA9R0o37N6mCOa8v0rnbjmK1nXm+LgYgeEHR0G
Subject: [cocci] [PATCH resent] cpufreq: sparc: Fix exception handling in
 two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 947
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/2d125f3e-4de6-cfb4-2d21-6e1ec04bc412%40web.de>

Date: Sat, 18 Mar 2023 11:40:11 +0100

The label =E2=80=9Cerr_out=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the functions =E2=80=9Cus2e_freq_init=
=E2=80=9D
and =E2=80=9Cus3_freq_init=E2=80=9D that it was determined already that th=
e corresponding
variable contained a null pointer (because of a failed memory allocation).

1. Use additional labels.

2. Reorder jump targets at the end.

3. Delete an extra pointer check which became unnecessary
   with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/cpufreq/sparc-us2e-cpufreq.c | 12 ++++++------
 drivers/cpufreq/sparc-us3-cpufreq.c  | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-=
us2e-cpufreq.c
index 92acbb25abb3..8534d8b1af56 100644
=2D-- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -324,12 +324,12 @@ static int __init us2e_freq_init(void)
 		ret =3D -ENOMEM;
 		driver =3D kzalloc(sizeof(*driver), GFP_KERNEL);
 		if (!driver)
-			goto err_out;
+			goto reset_freq_table;

 		us2e_freq_table =3D kzalloc((NR_CPUS * sizeof(*us2e_freq_table)),
 			GFP_KERNEL);
 		if (!us2e_freq_table)
-			goto err_out;
+			goto free_driver;

 		driver->init =3D us2e_freq_cpu_init;
 		driver->verify =3D cpufreq_generic_frequency_table_verify;
@@ -346,11 +346,11 @@ static int __init us2e_freq_init(void)
 		return 0;

 err_out:
-		if (driver) {
-			kfree(driver);
-			cpufreq_us2e_driver =3D NULL;
-		}
 		kfree(us2e_freq_table);
+free_driver:
+		kfree(driver);
+		cpufreq_us2e_driver =3D NULL;
+reset_freq_table:
 		us2e_freq_table =3D NULL;
 		return ret;
 	}
diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-u=
s3-cpufreq.c
index e41b35b16afd..325f61bb2e40 100644
=2D-- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -172,12 +172,12 @@ static int __init us3_freq_init(void)
 		ret =3D -ENOMEM;
 		driver =3D kzalloc(sizeof(*driver), GFP_KERNEL);
 		if (!driver)
-			goto err_out;
+			goto reset_freq_table;

 		us3_freq_table =3D kzalloc((NR_CPUS * sizeof(*us3_freq_table)),
 			GFP_KERNEL);
 		if (!us3_freq_table)
-			goto err_out;
+			goto free_driver;

 		driver->init =3D us3_freq_cpu_init;
 		driver->verify =3D cpufreq_generic_frequency_table_verify;
@@ -194,11 +194,11 @@ static int __init us3_freq_init(void)
 		return 0;

 err_out:
-		if (driver) {
-			kfree(driver);
-			cpufreq_us3_driver =3D NULL;
-		}
 		kfree(us3_freq_table);
+free_driver:
+		kfree(driver);
+		cpufreq_us3_driver =3D NULL;
+reset_freq_table:
 		us3_freq_table =3D NULL;
 		return ret;
 	}
=2D-
2.40.0

