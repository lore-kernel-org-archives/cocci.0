Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2970EC3DA6E
	for <cocci@archiver.kernel.org>; Sat, 23 Dec 2023 20:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Jg5BYOmb7gR2JV7xP4JS3XGdY1In/RJoMZeUXF1gb+c=;
  b=Gdw/XCmBIOLUOnlNIGRJwY8tZM2y/8vXjrAKqu0bewa+Ycx4FGeSWCSn
   gKjg9+Zv5Dv4kN4YgMsbt1xq/inZkwU9cMsDnYQNrtq/x6JrTAj7Fc9JK
   qBODjtuZs3TDsBMAtixcB/KieZdIQY1wLCCo3fmrOH8dIHYY7QVLxKLBR
   I=;
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
X-IronPort-AV: E=Sophos;i="6.04,299,1695679200"; 
   d="scan'208";a="143890273"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Dec 2023 21:31:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 81849E0CCA; Sat, 23 Dec 2023 21:31:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 60B57E004E
	for <cocci@sympa.inria.fr>; Sat, 23 Dec 2023 21:31:04 +0100 (CET)
IronPort-SDR: 65874388_KsT/JVJK2H+DleDCPgCDi2LozCm5TGq8a/V1ahpB8spBZsA
 J7kwP8WMAv/SvoNTy//JncxqA+wCNBD5n/RqmLg==
X-IPAS-Result: =?us-ascii?q?A0E8AAAAQodl/w4P49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YI4B3hTMgQLSIRTiB2HJIF1gQ6DXYc1h0yIb4FWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DcBhEeHOAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBA?=
 =?us-ascii?q?oEGE4VsDYJcARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHax0BAREmAS4BB?=
 =?us-ascii?q?QImAl4BEgIBAYJ8gisBAzEHr1WBMoEBggoBAQavWB8sIlaBYAmBGi4BiBoBh?=
 =?us-ascii?q?WeEYg+BVUSBPIEUgT5viB6CaIkbBzKCHINQkVl9BUFwGwMHA38PKwcEMCIGC?=
 =?us-ascii?q?RQtIwZQBCghCRMSQIMvCoEBPw8OEYI+IgIHNjYZSIJYFQw0BEZ1ECoEFBeBD?=
 =?us-ascii?q?m4bEh43ERAXDQMIdB0CMjwDBQMEMwoSDQshBVYDQgZJCwMCGgUDAwSBMAUNG?=
 =?us-ascii?q?gIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDE8DaR8yCTwPDBoCGx4NJyMCLEIDE?=
 =?us-ascii?q?QUQAhYDJBYENBEJCygDLAY4AhIMBgYJXSYHDwkEJQMIBAMrKQMjdBEDBAoDF?=
 =?us-ascii?q?AcLB1APAxkrHUACAQttPTUGAwsbBj4Cpk97E4J2xQE0B4I0gWCBYQyfKwYTL?=
 =?us-ascii?q?5cmDgaSUwEuh1CQTyCoRoFjPYFZMxokgzZPAxkPjiAMFhaDc48JAT1ANTsCB?=
 =?us-ascii?q?wsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:eejC6a1umTaH1JTWqvorEAqjBIkkLtp133Aq2lEZdPUMSL37qy
 ncpoV/6faUskdpZJhOo7C90cW7LE80lqQFmbX5X43SPzUO0VHAROoJ0WKI+VLd8ljFl9K1op
 0PT0ERMrHN5BNB/KLHCUGDYrEdKfe8gcaVuds=
X-Talos-CUID: 9a23:fO0l6m+sTbcQuLcxpXSVv089EMQPWCzM9Vj3D169JFpFerKTQnbFrQ==
X-Talos-MUID: 9a23:2oYVwQWPNHvTOSLq/DD3lTo+EO002PyjJXwIko8ZhOXHBSMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,299,1695679200"; 
   d="scan'208";a="143890272"
X-MGA-submission: =?us-ascii?q?MDG8eakPNAZPdvZmTFOBD0FnMoQBp9oMToIg61?=
 =?us-ascii?q?OjgsPg4LRKvss7Zgkrack3kiSde4qmu7WsLDweODVTWkaWDgt9kXuTAP?=
 =?us-ascii?q?GPb7uYpCZUsXm8ZiiDcEGDJH89bli3VDWrC+SG34NdCoSYfaqtnMvuH1?=
 =?us-ascii?q?WNg06PMdxog4cMghnSsnhSNA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 21:31:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703363420; x=1703968220; i=markus.elfring@web.de;
	bh=CkiadlJnceiWb4wDxQjgDyAYKO3sigBrvSKQufUjwtQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=kJHR+ZFFUvcx4ZXEZHizmsrOcZkY5mcHXI8p0rI2tz7HBYkMqUwrIRIB9MXmQ6XV
	 QML7/ikykymwmL5EbkL00RHOffech4O1Qd2GI1pvQPya1fTxmERvBHZMpyJ2QsG0y
	 r0VtsG/7YnT5RwuUxByv/eWydQyHlXtlwgYSleVYoNRC0L/Ps/1cH90DROk6Freiy
	 biOx7SiOiA8lXquf6lIxSzRm+YRcEAm/zS5ScCMkiz1jYolRHy/CZxDfCOvePuxue
	 2CpFuWsfMr+p6psAlhtvsbS3g/b+mUN7cF4qnTAhcJC+EOVv6WauuNz/lnPNs7hQJ
	 a5hdZq+Ryy70YE31xQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX17-1qpXar1c0L-00j9SN; Sat, 23
 Dec 2023 21:30:20 +0100
Message-ID: <5b38ce71-3c76-4efc-a688-6f2651f93b6d@web.de>
Date: Sat, 23 Dec 2023 21:30:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xPGwYXpbcPGu2+M0VdwPQ7SUF0a7M37z16ssBjvgoCPi+x9tAoO
 NvQZ1g4SjMgDz4Ava3z+cL6tjUVRgCTDRTWYi5SO6+wiAmHZX6EnbAjVGCH7dW7IHiaSj3z
 ixLweZnePPhXebrte08ntjAtgJYFTck9lLBDVlGoQyqQeDOytPBAfzQr5wchziJY2dljghN
 iSuUCfIOO6P7BP0buSvRA==
UI-OutboundReport: notjunk:1;M01:P0:+SMfoYLuucE=;c/mPHW8OJcA3zTVCoyoYFJeALSM
 ZvfjHlnns9cYViZmfJpVMKTY31aF2ERQpa5xEcvlV45JG935oc58SmkfMKKfoEOgbC1ZY4IXh
 LQO16NkMeGI3PgGc5EG0LxvJYCOkTmXyYDpxVMGZlNFYdckX8gdwWjvFtGkWtyTqvskLO6aYA
 DAwQ8+fWP/4qBps6HdOXn8LoN+cDy6b1ipjdoXby3ElBvS+i2PRnqFlqLn4VSDOmyfohWgTS0
 8ZaUF+RhAVQbtiUfSnz6B7kvTO9WlJMOkEYIhUxRm09UeBPJ/Tq5c0HYBdTvkrU7g+S4SOO8H
 EnHiihcnVCSEpNjtVd+aI00BGqip06aI2lVLW+lamYW+tUkb00gKUrwF+GFhvBOPNJIMOHHmU
 1YFIEKC8g95QAtiEDfjGcedkQK4Gevf+jYk5owwhdtVqiOCwvp/rusG9W/oPehAUyGG10tkf0
 +FcSKqVbrTzX6WiViXoYgY1AqVTQcww/aLc+p8fQTg4VHh6KOih94YSz5jW0674dYIiaSfxEG
 n758oBn8MkCPcj2Wp64mbx3gYKY+B5bwHsmPXtYCvUcKC7LKu/EZEkLs5oZJEfd3NJEgj7lFi
 aODCc5JoltK2rrHuywY4nGKA5JgNq/JVYxjnM7wr9FV0vxPER4SCo19FOBBll8nAzge1HNmhd
 UYppXorGtr//W1AAuerUj2Hx1Ha6Lj7ECEueWLhIlxV6PU8z8AqpCxC9HtAf69G2CHSqC5ASx
 nc47PsRqx/Vza6Sj99uXUyxqr63NC6i1JaAphwL+xq1kP1V+KkozWQdpEIe/4J5CgbHEym6YN
 qpMjL/kccAFya8Ma+017jgPKT5Tk4i9rJa33XNWwwNdpNRrxooeoCAxvITQnfH586G2cCFYRq
 1R4VNboquWKAwpxhYn2OB00+VJF3E/rYx64TTh3MSZNi1xo0Zv8Yqla8/it+3MycVEsuwx9XT
 T57zjQ==
Subject: [cocci] [PATCH] perf/x86/intel/pt: Return an error code only as a
 constant in pt_pmu_hw_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1366
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/5b38ce71-3c76-4efc-a688-6f2651f93b6d%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Dec 2023 21:06:27 +0100

Return an error code without storing it in an intermediate variable.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/x86/events/intel/pt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8e2a12235e62..24fd18e2da34 100644
=2D-- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -190,7 +190,6 @@ static int __init pt_pmu_hw_init(void)
 	struct attribute **attrs;
 	size_t size;
 	u64 reg;
-	int ret;
 	long i;

 	rdmsrl(MSR_PLATFORM_INFO, reg);
@@ -242,11 +241,10 @@ static int __init pt_pmu_hw_init(void)
 			    &pt_pmu.caps[CPUID_EDX + i*PT_CPUID_REGS_NUM]);
 	}

-	ret =3D -ENOMEM;
 	size =3D sizeof(struct attribute *) * (ARRAY_SIZE(pt_caps)+1);
 	attrs =3D kzalloc(size, GFP_KERNEL);
 	if (!attrs)
-		goto fail;
+		return -ENOMEM;

 	size =3D sizeof(struct dev_ext_attribute) * (ARRAY_SIZE(pt_caps)+1);
 	de_attrs =3D kzalloc(size, GFP_KERNEL);
@@ -273,8 +271,7 @@ static int __init pt_pmu_hw_init(void)

 fail:
 	kfree(attrs);
-
-	return ret;
+	return -ENOMEM;
 }

 #define RTIT_CTL_CYC_PSB (RTIT_CTL_CYCLEACC	| \
=2D-
2.43.0

