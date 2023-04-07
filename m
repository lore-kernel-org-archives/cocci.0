Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B08DC6FD1D
	for <cocci@archiver.kernel.org>; Fri,  7 Apr 2023 17:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mkJDkPO8xloMEl/JCJA22DO8osIagfQQnLHqJTWvQ2g=;
  b=vDvcr8dm2VDhAKIjqpzj2U5KdN7067FUL4dhM7jPZI52BlmWc8W2tRZW
   KC8viDZwMM5zQStGokxvTBsE2YkrOoe8/BQQp73jNn8weYs92pxdbmRxG
   toDSanKdW2u6ra89FijPvN1f5PG8XrPz4Yy6cCDCYw8aXkdHacSHdyZ8u
   U=;
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
X-IronPort-AV: E=Sophos;i="5.98,327,1673910000"; 
   d="scan'208";a="101662617"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Apr 2023 19:49:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6DE8EE7315; Fri,  7 Apr 2023 19:49:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D4D1CE72F8
	for <cocci@sympa.inria.fr>; Fri,  7 Apr 2023 19:49:11 +0200 (CEST)
IronPort-SDR: 64305785_ZYo8ALhHmBYiBiB9wxOiVxj2YFwsH0fdy90vf7p7NixN0X2
 4V2/YqgEQC9MnyvBQbndSlZrH4o4+iDtDJtChhg==
X-IPAS-Result: =?us-ascii?q?A0EvAgDuVjBkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLoFLLwQLRoRTkS0DhDCHLpApgxY+DwEDAQ1BAQIEAQEDBDiBU4J0AoU9A?=
 =?us-ascii?q?h0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBGgkXB?=
 =?us-ascii?q?w4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHPgMDI?=
 =?us-ascii?q?wQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB6wIfzOBAYIIAQEGnAsfL?=
 =?us-ascii?q?CJUgV4JgRQtjQqDNnonD4FVRIEVJ4EVgT5uHogBgmeBDIEgh1CHaYhOCoE0d?=
 =?us-ascii?q?oEgDoE9gQQCCQIRa4EQCGqBeUACDWQLDm+BSmNMgXsEAhQuJQQOAxkrHUACA?=
 =?us-ascii?q?Qs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg4Bhw0EQIIDxIPLEQOQjc0EwZcA?=
 =?us-ascii?q?SkLDhEDT4FGBIEKgQEGASYknXFzAVI8SyaCBBySPBGOaoNKnhk0B4IqgVaBW?=
 =?us-ascii?q?QyfDQYTL5cJDgaSJZdzIKJehSGBeiOBXDMaJIM2TwMZD44gDA0JhAOPSD80P?=
 =?us-ascii?q?QIHAQoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 bIRR7UdWFFnTpsn
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:N+fIfK+GfwhxlFRMd+Vuk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,327,1673910000"; 
   d="scan'208";a="52537595"
X-MGA-submission: =?us-ascii?q?MDEuA8EkD1iERzkuwfM03hNz9TaF7jB92Ohl0i?=
 =?us-ascii?q?+1/VLIGaWQJKaZSM9JPxH5cOWgx7lPPud4j7CIXbszCSIjY5ciQGKf1L?=
 =?us-ascii?q?nRTBiPn7jW38zjzA4LVQ01UHCC39oy22g7cKzoNAUOsI2sGbFUYvyN4A?=
 =?us-ascii?q?fKna4Na8Kaaia5n5BScKs3hw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 19:48:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680889731; i=markus.elfring@web.de;
	bh=v2KDZoQQiOJXaaTrGdTQFc5FGjfTTREGWL8G+gI5Sks=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VNwCESrKh0y5YZn2nLWbPCEHjCMKKEw9XevOp7IYkgI32U0Rirft9oeojEWUHYHXf
	 ll9qjrQAttRW8sOldn4knyWnNzYZHHUJnQJI1tHSiVfEKPwLQ0BjSRRl3DBHrjGu/M
	 H0tuSw6VjZBooIIi2jfXEc7fitMqW/nKB7VHlqCp6xkyFmxgsyChvkYd4yI4nrfCJe
	 UbPVNaQKvWrGMwZ7WCDXpt2qgO2ILOzG3k1dc3Sub0TXpKrgFzYsIjgN1qrtAHkZHJ
	 CaL13aVlQAXHSQcJtEKAbcHvsUFWfzb1RSwdmPhFO7n0ku2Co/MdFpZ01kB+wIduQd
	 HikBMHR5eJFzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKB5-1q1X5C2kiD-00PKRG; Fri, 07
 Apr 2023 19:48:51 +0200
Message-ID: <68b1988b-987f-fa2b-111e-b1b42f9767ab@web.de>
Date: Fri, 7 Apr 2023 19:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <b3cce5b3-2e68-180c-c293-74d4d9d4032c@web.de>
 <2d125f3e-4de6-cfb4-2d21-6e1ec04bc412@web.de>
 <20230403033529.x6n3ihhkypwizq3b@vireshk-i7>
 <39342542-9353-6a7b-0aa9-f9c294b158cb@web.de>
 <20230403230432.xeubpa3cc2gt4mw3@vireshk-i7>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230403230432.xeubpa3cc2gt4mw3@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nq8g24DvclfH0l9A3+Z9C4AlvfsU18sb8U2BYEA+B38bwZJtdrP
 t0hnsMwyCmrBB9tin3L0vH2FK31dVgxZWjHYOZV+5KbMZapvtniJqQogr3Wil9tbnicJYnF
 Dfa4g3FExTdohDouYbDYyxIiGxXkr45lNXiV+lZia62PZx36KwJMbiN4g8sRLIHb9+TV7Do
 ua4q9n2awOZxsTFBb1u5w==
UI-OutboundReport: notjunk:1;M01:P0:GtBMjFbFD8k=;AU2fKtNiYNLvjI9+d97+uZ9UX3P
 pB8ZlGf2H+JJKtm9zfeTHnLrLuSKG19PlKyNnv6bS4/Pw+PqvIYX78PJztpUtaRDfCe3hVdT3
 fZuebfYvMHcIK4Eyw2cNo0Fk0LvuSCDqnjHMYfs1kgb9Q0JpNjbzWI3DU0xMrz02NRfBEcePb
 R8czNXooQelw2v9eNJfzadserlzT0ZtMGO4mSO33mk78oI7CCPw1mlzaqnJY1MyhGb6PDS4yc
 6ACB5vkF2vOyChnAn5hsqAXw+SxObV8+oYEXWM5KaZhJkAKa7Fckb8Bi1hsvKWIwoTQURewHh
 MWNbLPLM4UZO9WCAMpd24YRxCNOgoGe5Bq3AKH0b7wJN72IwzZGGuzkCvQ8b4GrsuiDfl7Vm3
 AIpsQeIMzSAEbUUzqkhRzPEErVcaaXVF5fHva3bXEN0T8DLS1O6hKb718k2yxV6mgMQ2pcD9f
 yWolcHL+rWv3djP8TmrYUXgBgAwNPKwVVUWGhHzrzSiXJQwVCmJivhGVrSXBoPqZVzca4W+RP
 w6c9C9P6XqqhN+Bj7Zxnlt41Thc4s6SYlF+5TGusZChKcfpN49WOhBvCp+c2iCX954VRre4jo
 M8cobliJQ5Xv1HdkSlmzJaHz1WtdE6xkMw2RgNqzyleZzxIZkACg9vAjw8FdXUX50zMZ93GGX
 oKy++DkqkCl5Y2Ty+r/In2f2FTYd+7M+G233QA642ExRMngPGKIcS3dILxCFOX+9r3caMzVFC
 JHl/T2zZBbgFRHfvhliZYWIjauWmXXon0WBcDeQQIcxkxZ4tv2ft1fjHjSeW8jbnavwjpQuWa
 iFhXS3rfMgWtW5wloPNw5fadj3osJst3TJoy8xEpjrlLHNSg17zXyDXWm5NOrejpY6OwGdly1
 CANSgJOMF/4pupHiv+MFzmjJ3F2r7cC/qTE0FNWSdhKZ8/erCxwX7NO81
Subject: [cocci] [PATCH v2] cpufreq: sparc: Fix exception handling in two
 functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1013
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/68b1988b-987f-fa2b-111e-b1b42f9767ab%40web.de>

Date: Fri, 7 Apr 2023 19:30:12 +0200

The label =E2=80=9Cerr_out=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the functions =E2=80=9Cus2e_freq_init=
=E2=80=9D
and =E2=80=9Cus3_freq_init=E2=80=9D that it was determined already that th=
e corresponding
variable contained a null pointer because of a failed memory allocation.

Thus perform the following adjustments:

1. Return directly after the first call of the function =E2=80=9Ckzalloc=
=E2=80=9D failed.

2. Use an additional label.

3. Reorder jump targets at the end.

4. Move the assignment of =E2=80=9C-ENOMEM=E2=80=9D into two if branches.

5. Omit the assignment of NULL for four variables.

6. Delete two extra pointer checks which became unnecessary.


This issue was detected by using the Coccinelle software.

Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
V2:
Further changes were requested by Viresh Kumar.

 drivers/cpufreq/sparc-us2e-cpufreq.c | 22 +++++++++-------------
 drivers/cpufreq/sparc-us3-cpufreq.c  | 22 +++++++++-------------
 2 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/sparc-us2e-cpufreq.c b/drivers/cpufreq/sparc-=
us2e-cpufreq.c
index 92acbb25abb3..f1ab085894a4 100644
=2D-- a/drivers/cpufreq/sparc-us2e-cpufreq.c
+++ b/drivers/cpufreq/sparc-us2e-cpufreq.c
@@ -319,17 +319,17 @@ static int __init us2e_freq_init(void)
 	impl  =3D ((ver >> 32) & 0xffff);

 	if (manuf =3D=3D 0x17 && impl =3D=3D 0x13) {
-		struct cpufreq_driver *driver;
+		struct cpufreq_driver *driver =3D kzalloc(sizeof(*driver), GFP_KERNEL);

-		ret =3D -ENOMEM;
-		driver =3D kzalloc(sizeof(*driver), GFP_KERNEL);
 		if (!driver)
-			goto err_out;
+			return -ENOMEM;

 		us2e_freq_table =3D kzalloc((NR_CPUS * sizeof(*us2e_freq_table)),
 			GFP_KERNEL);
-		if (!us2e_freq_table)
-			goto err_out;
+		if (!us2e_freq_table) {
+			ret =3D -ENOMEM;
+			goto free_driver;
+		}

 		driver->init =3D us2e_freq_cpu_init;
 		driver->verify =3D cpufreq_generic_frequency_table_verify;
@@ -337,21 +337,17 @@ static int __init us2e_freq_init(void)
 		driver->get =3D us2e_freq_get;
 		driver->exit =3D us2e_freq_cpu_exit;
 		strcpy(driver->name, "UltraSPARC-IIe");
-
-		cpufreq_us2e_driver =3D driver;
 		ret =3D cpufreq_register_driver(driver);
 		if (ret)
 			goto err_out;

+		cpufreq_us2e_driver =3D driver;
 		return 0;

 err_out:
-		if (driver) {
-			kfree(driver);
-			cpufreq_us2e_driver =3D NULL;
-		}
 		kfree(us2e_freq_table);
-		us2e_freq_table =3D NULL;
+free_driver:
+		kfree(driver);
 		return ret;
 	}

diff --git a/drivers/cpufreq/sparc-us3-cpufreq.c b/drivers/cpufreq/sparc-u=
s3-cpufreq.c
index e41b35b16afd..d603366deb7b 100644
=2D-- a/drivers/cpufreq/sparc-us3-cpufreq.c
+++ b/drivers/cpufreq/sparc-us3-cpufreq.c
@@ -167,17 +167,17 @@ static int __init us3_freq_init(void)
 	     impl =3D=3D CHEETAH_PLUS_IMPL ||
 	     impl =3D=3D JAGUAR_IMPL ||
 	     impl =3D=3D PANTHER_IMPL)) {
-		struct cpufreq_driver *driver;
+		struct cpufreq_driver *driver =3D kzalloc(sizeof(*driver), GFP_KERNEL);

-		ret =3D -ENOMEM;
-		driver =3D kzalloc(sizeof(*driver), GFP_KERNEL);
 		if (!driver)
-			goto err_out;
+			return -ENOMEM;

 		us3_freq_table =3D kzalloc((NR_CPUS * sizeof(*us3_freq_table)),
 			GFP_KERNEL);
-		if (!us3_freq_table)
-			goto err_out;
+		if (!us3_freq_table) {
+			ret =3D -ENOMEM;
+			goto free_driver;
+		}

 		driver->init =3D us3_freq_cpu_init;
 		driver->verify =3D cpufreq_generic_frequency_table_verify;
@@ -185,21 +185,17 @@ static int __init us3_freq_init(void)
 		driver->get =3D us3_freq_get;
 		driver->exit =3D us3_freq_cpu_exit;
 		strcpy(driver->name, "UltraSPARC-III");
-
-		cpufreq_us3_driver =3D driver;
 		ret =3D cpufreq_register_driver(driver);
 		if (ret)
 			goto err_out;

+		cpufreq_us3_driver =3D driver;
 		return 0;

 err_out:
-		if (driver) {
-			kfree(driver);
-			cpufreq_us3_driver =3D NULL;
-		}
 		kfree(us3_freq_table);
-		us3_freq_table =3D NULL;
+free_driver:
+		kfree(driver);
 		return ret;
 	}

=2D-
2.40.0

