Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A6BC021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=asA99JHuFG45J+PLamKyBXsE7OPnQTEQXbgBwGkvXUY=;
  b=EXR/6QeXyPGnSrevoj6HUQpdNkDUPBRprooiPlq5n/KTJXWLWcQ4OASx
   e0569+QuHUoliFr03MboTK4RMldp5hAYurpATQO0ft+A5x64YLvBW8aD+
   pViTBX0RX78QIalm3XCY6j81ITnynEAcayXlyd1EpfS5qLLwGDy7R57so
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211065557"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:51:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79BF5E0D1E; Tue,  4 Mar 2025 10:51:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2F23FE0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 10:51:00 +0100 (CET)
IronPort-SDR: 67c6cd03_Tu2RWj6GrM7VftwHbtqYzYG+v2klW5u+Azo7SxKHxGqSvgc
 eNaQrI4wSG4nP15FlFgLqfxFLNtm5bj19XrBe2A==
X-IPAS-Result: =?us-ascii?q?A0F7AAAazMZng07ASNlaHQEBAQEJARIBBQUBQIFABwELA?=
 =?us-ascii?q?YJDgVczBAtIhFaPT4F0LQOEO4c7h1OEb4QGgVaBfg8BAwENQQECBAEBAwQ4g?=
 =?us-ascii?q?VSCdAKLFQIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQE6Bw47hXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjHQEBESYBD?=
 =?us-ascii?q?x8BBQImAgJWBgESAgEBgn6CMAEDMQevJoEygQGCDAEBBoJp13MfLCJXgWUJg?=
 =?us-ascii?q?RouAYVrgmMBhiaEPCcPgVVEgRUnC4EJgi2IHoJpg24vgz2oXIFNHANZLAFVE?=
 =?us-ascii?q?xcLBwWBOTgDIAo0FAQZAhQcAQ8GEARqeoJFaUk6Ag0CNYIeJFiCK2oEBYNbh?=
 =?us-ascii?q?D2EQIJBUYJCghFxgReCMYVQgS2EbB1AAgELbT03BgMLGwY9oXI6hEEBUjsUO?=
 =?us-ascii?q?CaCBJMMk2mfHTQHgjiBZoFjDJ9eBhMvl0UOBpJ8AS6HZZBqIqkPgWgBOIFcM?=
 =?us-ascii?q?xokgzZPAxkPjiEZhBSPCgG5JkI1PAIHAQoBAQMJhUYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
 cIA45ZZdnFD+F7VJ4HrIexcoSg=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:54/M66CziYvwnc3lHel455DYdb4zR+YMi2TDGXoBLCC9Afbo8P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOos1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QF5SWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:E4Rx+mONUfhdh+5DAQVdqm4fOtseUFLB93raJR6FBVZYYejA
X-Talos-MUID: 9a23:RSVVOwmt0mpDssd1dbr/dnp+DeV2vf28KHkGz8g9g+KubCJAZCa02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="110592807"
X-MGA-submission: =?us-ascii?q?MDF6fmHs5WnuzOtBzLAQoiDTPdskCJZkXIeNt6?=
 =?us-ascii?q?kjYniVXnjXyLoGVkyA5tXeyDJfIdOvHKyLp/TxfAF1F+pz3XDlF90Bwr?=
 =?us-ascii?q?HzUEIhXPzqla7aD5a33VeNsGXims92D3/D3XQnq51mD/m2wgnhyFI+P6?=
 =?us-ascii?q?RgY0eYsq2tRX9p7kk/XRauXA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 10:50:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741081847; x=1741686647; i=markus.elfring@web.de;
	bh=asA99JHuFG45J+PLamKyBXsE7OPnQTEQXbgBwGkvXUY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MqkVENF66K7NM+Rdc1ebVHybRmg/N+adIGafKK9Il2hSAgU2TrzNtZgLEUq+d56c
	 BsdFiDc5Krs3ST5UQtrXMiwTgBMLtxShCEDrcUmVt6nGxd8CNbb+jm8Nk8UBUpb8Y
	 hoJcGToaD0OvNB/d9uXRChUlJoBCIJnqmpO2z12/E7a0MlKgx/TKVovj5hrV2Idrr
	 2h16/SJh8AhNNkmnrenQ2Nythb2jugKPUx+7zEV4TaITCthyCR05xbGKmJyJJGGjL
	 MOAZv2Iwl23em4EP4hIlAM2E4qMXSlPIjIszifMuYP6i/A37+8SZFVVHqTyI6B+Vy
	 DZdJHlDtUnz3USb+lQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCHy-1tIFxu3iWm-00iB9R; Tue, 04
 Mar 2025 10:50:46 +0100
Message-ID: <c69c79e4-04a3-4182-a694-809a5fa36083@web.de>
Date: Tue, 4 Mar 2025 10:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 Leo Yan <leo.yan@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <b1c70348-6459-474e-6a0f-d956423368d5@web.de>
Content-Language: en-GB
In-Reply-To: <b1c70348-6459-474e-6a0f-d956423368d5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zwnxKwlzGB6lzUwzmSXhy5SzzNCA5khP3HuvwjAnzkkTSsl+oIG
 DWOKj06jnDp9rAYXsw/PmjRcrC8kxCSzERqmbAssiny6VokvGklOFI3UVmcoUz1bKebDrR6
 jiet48jwrUEis7A8RSdOhtkr8AotZkLyqlfLHfYdYo4FAltrtYdFPdS4GdaLrrLa9Qk+X63
 9qVgzazeoL3JAQOY5jeEw==
UI-OutboundReport: notjunk:1;M01:P0:v/LKQqKo3yk=;2xU/kzBRtU5lDFHf7glYk9cze/y
 gg1qF5dIYCm3Nzi0/mGVb3B1sBlZth/yoVVtNWj+M19J/2pqcxNM3esgC+j6y64p/0Q6BE7mt
 2M9Xd/4Tv3rMT5m+r1GfAHh1GP8vsTOIJ9iLRMs1qOhI5edxfAt/hxCyBh9WpkSTbOZv90AB/
 571Q5b9Rcm28BVFAYk7ai6Wg/sTnwACL1Q3mt3/+CToiA0OfI25W4ZKS7PeUumYrJz5KqdUNk
 /9HtLExm8xEz0FwwTmREjksqHGZBetuczVsnHFuDikKLJMYgdmuMm7/aHEd8fY+kQGgsC9Jf+
 0wBabKaYHDnWvBM8cshHa9vJdaFrMg6BLRo/mquLVX35ryWJ8+lccSZ5KwTP0CXytIEIbnE0S
 MylDHM13/8p6gD76hbpaD8bbjEuZrgTHj2Dmbr7biy45PS0D3q1uHpfBSY9o+F7DtNCMYvDvu
 lJIgSn4/J9rTRQbRXeeB+TWtMUryzTLC1rK+Z7A/svKwupl3qPdgKyrBz4cXuz0dYNpOuhr5x
 5YXxuOt/Gfe9ljpUA6OgtLg6gynzkxkIqdLpJeSRhzvSFqEZ/DmMi9MUuVFl7Idtr0zxLvKOy
 bZ3jRPXiPcLdqcX5GBfx9YsuFaD9kqzN3zDHB1UjxifAlDo8qVHtbvhZH6FWmBYuJtK4mbxA4
 R1Cja56gQt07lOGpQXcDGbQMukfnjiLbqYS6+t8bEcOTCajtyvNaNmPmD8KNWpAknbqY83AN6
 6IaRVfdOQV3I0I9/U1iF7mLe7N9N3vLFMv+0H7G/q6Vf/MoPU+PUB2xZ57IcA08TxqO8VIaL3
 HvL3wmzzqg9p4ZNngJu9UdLRqyZXfjb5ESP1R+M6qx/YjcMBdStz615TRQGElDIlDesJO8jKx
 Uh8QLaUBOlPdaSGfG1kwwdy1BdHIznBRD2kFF+Yw9o+dsGKwRshSIBzpYfFXUG4NIXbXlDXHo
 oiksC7f2prXB0VxgoABgjan5P3HhURYUcbsjElfzyGsYPSpw0YlZOr/szVGpLSq1OHMOsWtyO
 yOipxcqzI8ZwzBbM8RQDDG1FFG5PbNKC9lEjzW6MBSX/gww7NgroM7ss+7PVsLyqvO2KdaoHc
 xnKH/WPMGHCrQTCZg4K5r2Ta4h4Ey9jvnOsHfbJX1RbU200YsUvp34y7skAxZrbkSKu+77QjC
 yjqSUwtrjSV0AQu6iP9p9HoGWha4V++3AjN4fKg0rUYpEhtcs3wfAwU/2+wkmJukDxk1/Pxlp
 dQHeBF7phoe/a7HjoxLAo/1Be4ootv7uJ1p3aXxdt/CU5O5pXv1WwKwfUwrjEq0VH3XfitT1p
 Nd5yZAL9nJgMWhsxSbrJHSDOkPA3nPpx6P/kSNtfmxcpt2wLtHieh4oM+whMC16of06gHrJfX
 DIEPVcymD64LXUOe/1xIuQ2EK4+MbJYa357qjo93/YHcGP2koXiyp5/lC1h3J30JEMGHpfx05
 NzvA8yrnqjq8xv9FX1Hh9Kj/scg8=
Subject: [cocci] [PATCH RESEND] perf cputopo: Improve exception handling in
 build_cpu_topology()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2487
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/c69c79e4-04a3-4182-a694-809a5fa36083%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
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

Fixes: 5135d5efcbb4 ("perf tools: Add cpu_topology object")
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

