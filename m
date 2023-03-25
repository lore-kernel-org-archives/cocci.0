Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8A9C6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 08:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=q323WZBZ/WNLnKWVO75xWtv1I94nFOeg6IUjREpN55E=;
  b=W+aZnCQ/5DwtgtpQSezPQU4qJd/WTN7o3POl4GtljAOlAAfxIKqEc9Rx
   uaHgPZH4jOUNLbt+WCrF1rQaBrMslK5XC2u+BKbgi4rduY/nCO8qSSKFa
   uMQozLFhzaND+V0BjC4djcoU/IQqxGeO4UyLFkCY9jFoeYQ9D3k2UcQoG
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99043371"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 09:50:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 77FE9E0D42; Sat, 25 Mar 2023 09:50:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6E2F3E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 09:50:44 +0100 (CET)
IronPort-SDR: 641eb5e4_bjR0RWDiDknQR7LzPGjW6+ATeoJP0rZnVU+DXFzoa9ylHy/
 EJC5yWFEw5sPpybyyLPvS9yMlgGjN7LBozpuZzg==
X-IPAS-Result: =?us-ascii?q?A0EuAAAztR5khwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItgUsvBAtGhFORAS4DhC+HLIc6hGeEAoFWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4JzAoU6Ah0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAEBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQESAkdTPQMDIx0BAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHs?=
 =?us-ascii?q?SGBMoEBgggBAQaCY5knHywiU4FeCYEULQGNBIM2eicPgVVEgRUnDIEJgiyIH?=
 =?us-ascii?q?IJngiiHVocliC8KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMg?=
 =?us-ascii?q?R4lBA4DGSsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPE?=
 =?us-ascii?q?g8sRA5CNzQTBlwBKQsOEQNQgUcEgQqBAQYBJiSacQIBgmcBUjsUOCaCBJJYk?=
 =?us-ascii?q?kCeDjQHgiiBVYFZDJ8MBhMulwgOBpIjLoctkA8gp3qBZAE4gVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIBmEDI8JAT1ANDsCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 Fg6h1knCdk=
IronPort-Data: A9a23:nJMmEK/vKuGJAlsZmHyqDrUD+XqTJUtcMsCJ2f8bNWPcYEJGY0x3m
 2cWXGHUafuMYGb9etEjYYi+pkoBv8DXm95jQQM5pShEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f4nW8kWo4ow/jb8kg3566v4GpwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE56tPEl9sM90ky+dlCj9y+
 NUHM3cqV0XW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV698B8qZHOOTupkBhl/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUJ+QrJ/vFpsgA/yiRX4IbRc9vea+WRQJ9us2a/j
 WOf7XbQV0Ry2Nu3kGfZrCv12IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku5Rs4ZN
 EEevCYjxUQvyKC1Zv2jfgOm+nDUgi8dSdEOL+AT9xrK7ZOBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvV6dpH7+X9pZW1qe/8kN+iBcQGBTNSNHFbEmPp9/Gz+9Bt0HojW/45SPbdszHjJd3n6
 xynxMTUr5Yal8oQzbi78DgraBrz+MGYH2bZCi39V26o6EZGeZS5e4Gt41XB4p59wGuxS16co
 D4blsLY4O1m4XCxeM6lH7hl8FKBvqft3NjgbbhHQshJG9OFpi/LQGyoyGsiTHqFy+5dEdMTX
 GfduBlK+LhYN2awYKl8buqZUpp1nPawT4u+DqGJP7Kih6SdkifYrEmCgmbPgAjQfLQEyv5X1
 WqzLJvzVi9DYUiZ5GPmH7ZEuVPU+szO7TqOGc6ilkrPPUu2PTDMAbYDLFaUaO0lpKqLyDg5A
 P4PX/ZmPy53CbWkCgGOqdB7BQlTcRATWM6qw+QKKL/rClQ8RAkJVaSLqZt/INMNokigvryVl
 p1LchQEkwWXaLyuAVniV02Pn5u+Dcsu8S9rYXBE0JTB8yFLXLtDJZw3L/MfFYTLPsQ6pRKtZ
 6lZIZezEb5URy7Z+j8QS5D4ocYwPF6onA+CdW7tKjQ2Y5cqFUSD987Gbznf0nAELhO2ks8i/
 Jym9AfQGqQYSypYUc35VfOIznGKh0Y7pt5cZUXzD+d2RFTN66lvciz4se82KZoDKDLF3Tqr6
 DyVChY5+8jI+pE5wODUifq6rqOsKe9fH1VbLUbf/72ZJSnXxUv94I5iAcKjXyHRa3Pww4qmP
 d5q9vDbNOYVuXp4v65XMadZ/Yhn6/TB/7ZlnxlZRlPVZFGVO5ZcC3ih3/gXkJZSx7Vc6DCEa
 mjW9vZ0Yby2ad7YSngPLw8Yb8OG5/Eeuh/Wyd8XeEzaxitGzICrYHVoHSunqXJideNuEYYf3
 +0eltYc6FW/hjoUI9+2tH1o2FrWHEMQcZcMl888MNfwhxsJ22NyR8XWKhXL7aGlb/RONUgXI
 QGoupfSuoQExmf/dyscKHuc+8tcmpUEhz5SxnAgOVmiu4TIl9037jJr4BU1SQVZlCtG9+dJP
 klqKExHCqGc9Bh4hMV4fj6NGiMQIDa760DO218yu2mBdHaRV0vJMGEZEsScznAzqm5zUGBSw
 +CF9TzDTz3vQvDU4gIzfkxU89rYUt1781z5qvCNRsiqMcEzXmv4v/WIe2ENlhrABPExjm3ho
 c1B3r55SY//BB4qj5wLMauo/pVOd0ncP01He+9rw40RF2KFeD2S5ymHG3rsRuxzfc714W2KI
 O0wAPIXTBmv9je8nhZCD442HrJEtvoI5t0DR7DVGVA7o4av9gROjpaB2RX91UkKQspvm/kTM
 on+VSyPOU3OiGp2m13ilthlOG25bYM6ZSn55uSU8foIJb0HoupDYUE/6ZrqnnS3YS9M3QOYg
 xPHXIDSl9dd8IVLm5fgNo5hFjeEA4r/e8rQ+T/irukUS83ENPn/kj88q37lDlxwBqQQUdEmr
 oa9mof7822dtYlnTl2DvYeKEpRIwsCAXOB3FMbTB1sClAugXP7c2Tcyy1qaG7dozuwEvtKGQ
 jGmYvSebdQWAtdR5ENEYhhkTioyNf7FUbfClwic8dK8UxQT6FmSZpfvv3rkdnpSeSI0KoXzQ
 F288eqn4tdD6p9AHlkYDvVhGIV1O0LnRbBgTdDqqD2EFSO9tztuYFc5ecYIslkny0VoEfoWJ
 brAQQXiMgu/sufEwbm1dmC0UgI/VB5AbSsYJyrxOOKaTxilAWRAIel13VAuFMRPiiKrvH3nT
 GilUYbhYBkRmRxbfB+67NmLssJzwAAREo+RGwHFNH94p8t76E1szVehGupdD69KRwbe
IronPort-HdrOrdr: A9a23:SUqJyq0RAv6dzQwrsqH8VwqjBSZyeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ4exoS5PwOk80lKQFqLX5Uo3SOjUPJgOTXeZfBOfZrQEIOheOk9K1tp
 0QO5SWaueAdGSS5PySiGXWLz9K+rm6GdWT9IXjJgBWPGJXgs9bjjtRO0K+KAlbVQNGDZ02GN
 63/cxcvQetfnwRc4CSGmQFd/KrnayAqLvWJTo9QzI34giHij2lrJTgFQKD4xsYWzRThZ8/7G
 n+lRDj7KnLiYD39vac7R6e031loqqu9jJxPr3MtiHTEESttu+cXvUvZ1RFhkF3nAjg0idprD
 CGmWZbAy060QKtQojym2qn5+Ca6kdL15aq8y7lvVLz5cP+Xz40EMxHmMZQdQbY8VMpuJVm3L
 tMxH/xjesiMfrsplWO2zHzbWAeqmOk5X451eIDhX1WVoUTLLdXsIwE5UtQVJMNBjjz5owrGP
 RnSJi03ochTXqKK3TC+mV/yt2lWXo+Wh+AX0gZo8SQlzxbhmpwwUcUzNEW2n0A6JU+QZ9Z4P
 msCNUeqJheCssNKa5tDuYIRsW6TmTLXBLXKWqXZU/qEakWUki92KIfII9FlN1CVKZ4vafawq
 6xL2+wnVRCBX7TNQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99043369"
X-MGA-submission: =?us-ascii?q?MDE88QkHHqDW+dz4RbodCTitzq7AETsDlvMDfI?=
 =?us-ascii?q?6M3f6yoAAMQMl5FdNHBuxFDdUavUevKiIXhZCeyunNlLgfMPu3q9oMWp?=
 =?us-ascii?q?jk8gNmgFYSp9Jbjied7Mk4odVAwLp3ocobQSzR6DkF75WDcUFJ96GiEJ?=
 =?us-ascii?q?2PaxlrUhUr4xOH650cJ0yP+g=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 09:50:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679734238; i=markus.elfring@web.de;
	bh=NDyI4YPYzZL7QFWQU8dqLV6LGmfFNUZXk/7+sPzcbsY=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=YTlaVbXDQn5y3/H/UCBSCVsxAA/Zmu4baV4fMvtdLMIBhnfuNTQcrIwN7skv5cKIK
	 5h6TpXuK0WedKtE46BaSqBEj3/yhlV5QvLPZw/hjP56HianxtMLXiBBZ95XYIiF7p5
	 IJM6njAkp7GTWBRmWznUw1202B9jrG+Gt7raJRB74LMnNy8mOxpCL8qLaQ3iBGXMpt
	 cpf3Bq8R8kYly5c6FdJUlcNxY4wxpiIgAESBoVAASRBOWJJhjfRd634+l6EHxQQPCf
	 8/aSBqRnkxDnywfJNT7l4O3jsfshRiVPH8GSThvA+1ZSPbENn+jdOpDWTmhBLdXL3U
	 4OsraebaZC6xA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m9J-1pfico3ay3-000uo4; Sat, 25
 Mar 2023 09:50:37 +0100
Message-ID: <6a6ce62b-3345-5951-d885-68d1834ae17e@web.de>
Date: Sat, 25 Mar 2023 09:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
 James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Leo Yan <leo.yan@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
 Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <b1c70348-6459-474e-6a0f-d956423368d5@web.de>
In-Reply-To: <b1c70348-6459-474e-6a0f-d956423368d5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AdCPsXVnuB60GCeLUcFlQyglieg60O8vOtEpSAUQFvCO2b0EhlS
 cmswB36I9zQ9vz2O1fLC3CmVEmFMxvdHFPjCeewIQcEn2ZNvSQTXH9BaslmTWLg4sa5DyTX
 8mqI6jZbI6ExftulzqiTA3xJvOmZllRer3L8qAWrv3Km0Lvv65NtCfcSpFeTXtmGOc6jtKA
 x0va+6uRI0GfzEZvh8hsQ==
UI-OutboundReport: notjunk:1;M01:P0:qe6ri16rt9U=;U117j8MRPsuaPQl8NgTAuY4MTt/
 C3MwMIAgkqpLGilN6wieXth5kPLDRaHu5gwHH5+MB5eQ7RJNt6cqH/gIGRkHHnp6uEXFVY/AI
 84wTpa2ufh1mrUuWbDgVGeTZcHNvzKXRDbyQy8a7MIWNR6XSve7PR5r6E3Yj8UxYYwBFCEc8O
 1oRZGWIKGA+ABBwXuhrXc3cDwMTG6pqsqQ98ckXq+UDKtSwHK3EmX6Gl3MqNChpe1jeH8oWvB
 nAY6/5Abqu016RDNbWuO380t1h4/y/4EJ4E2w0vntRb9ARLhlRbh7UBpr+JRcf57XI5gVq67H
 RgDJPj8XQEmx9mdRcQUyM9RTlBpsM3uOU3IikBndLMod4IwZqXXla1gSsSv20wADfpwQkYAcS
 kGZ4Vl4UyCVKGlfQnaBaN/vVnPVSggX1g+U6s1udRtHA1QbynicIiBuTqkQaq4KSHyqAccSUC
 sFYONi9XsJDKFJhsjAPonvz1RFONRWSnD9Y69hEqQ5geNgBZn80hdWflrsou/es+v29YSR0Ok
 9Y+S8NaZ9HShtm3Y4eaiE99zt0YFuDAs65UqZyAO/55jWKgAETTInbRgG43jLfkwKFZsnVxIx
 ngklbdSLLcFq+TL9MCPpAuk/Bl2tUdI2aZ8vCQcZO+Mt2jtJe/AXBg4t3XQQlyMYaEZGU+4+L
 j+etAcdHFIRYnRxsrX3HwaidUgk3UHBNHjwdqhBlhcPDNU4JRxDJJSFkciTwpKlnFUrpiV9lQ
 2kzpMM8vDlEnrpZ/MW3Is4rzcIn4e3KMRL7ZwG+WMAX7DOw74/tGRwoOzbcxcd5YBZYr/vxfS
 ssmgrN3x8aOwrl4NMD86mKEMO1h/IxSj5JzPjFVqPMnJic9BAUIn88YNNI3MUd+cJtvbZfCgf
 GQjuOttOEjezinCrV6DQf5/ogIdU4yrAzxbhY7eud2LDvwkj6Lo1cFjGo
Subject: [cocci] [PATCH resent] perf cputopo: Improve exception handling in
 build_cpu_topology()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 924
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/6a6ce62b-3345-5951-d885-68d1834ae17e%40web.de>

Date: Thu, 23 Mar 2023 22:00:07 +0100

The label =E2=80=9Cdone=E2=80=9D was used to jump to another pointer check=
 despite of
the detail in the implementation of the function =E2=80=9Cbuild_cpu_topolo=
gy=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed call of the function =E2=80=9Cfopen=E2=
=80=9D.

1. Thus use more appropriate labels instead.

2. Reorder jump targets at the end.

3. Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 5135d5efcbb439c2acb20d6197dd57af3a456e76 ("perf tools: Add cpu_topo=
logy object")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 tools/perf/util/cputopo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index e08797c3cdbc..fd185951ee2c 100644
=2D-- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -112,10 +112,10 @@ static int build_cpu_topology(struct cpu_topology *t=
p, int cpu)
 	}
 	fp =3D fopen(filename, "r");
 	if (!fp)
-		goto done;
+		goto exit;

 	if (getline(&buf, &len, fp) <=3D 0)
-		goto done;
+		goto close_file;

 	p =3D strchr(buf, '\n');
 	if (p)
@@ -131,10 +131,10 @@ static int build_cpu_topology(struct cpu_topology *t=
p, int cpu)
 		buf =3D NULL;
 	}
 	ret =3D 0;
-done:
-	if (fp)
-		fclose(fp);
 	free(buf);
+close_file:
+	fclose(fp);
+exit:
 	return ret;
 }

=2D-
2.40.0

