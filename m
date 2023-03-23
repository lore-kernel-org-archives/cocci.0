Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F320FC6FD1C
	for <cocci@archiver.kernel.org>; Thu, 23 Mar 2023 21:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2QoHUqgKgPVGGmnvMJM/u9TaRfmUDTOL7RGE/kHxu4U=;
  b=HsQzu+49YwYUm109OX/ylDsuSushXq4kfVlMShEvnFZ6uezcbH/oq4pl
   Nm7zUtFX6ifVaQ+Ckqsnu4KnOJrk/Qn8TipVfnTaZToxV/NskzyYDBs1E
   2TcOyuFLCck8hc2MgseuftiJBCk21aLKhHdSEQSZEg+BkdW+epUqGvbli
   g=;
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
X-IronPort-AV: E=Sophos;i="5.98,285,1673910000"; 
   d="scan'208";a="98815786"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Mar 2023 22:13:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7825AE0D41; Thu, 23 Mar 2023 22:13:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 960D0E0D40
	for <cocci@sympa.inria.fr>; Thu, 23 Mar 2023 22:13:17 +0100 (CET)
IronPort-SDR: 641cc0e4_cwDsuiHzzvBu3hrNLbC9fhr2QTpJ1qtxtrrKApaOHuXl563
 RjU2owZKr8BQGYmz56Cexz7pWtfqSkSIwg8Re7w==
X-IPAS-Result: =?us-ascii?q?A0GIAABcwBxkhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYItgUsvBAtGhFORAS4DhC+HLIwhhAKDFj4PAQMBDUEBAgQBAQMEO?=
 =?us-ascii?q?IFTgnMChTkCHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEA?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICR1M9AwMjHQEBESYBDwkWBgImAgJXBgEMBgIBAYJ6gigBAzEHlmOcF?=
 =?us-ascii?q?4EygQGCCAEBBoJjmScfLCJTgV4JgRQtAY0EhDAnD4FVRIEVJwyBCYIsiByCZ?=
 =?us-ascii?q?4Iqh1aHA4gqCoE0dYEgDoE9gQQCCQIRa4ESCGuBfUECDWQLDm+BSwJkTGYlB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PzUGAwshBlhrAgkjERMFAwsVKkcECDkGGjQRAggPEg8sQ?=
 =?us-ascii?q?w5CNzQTBlwBKQsOEQNQgUcEgQqBAQYBJiSaSQIBgmgBUjsUOCaCBJJYkkCeD?=
 =?us-ascii?q?jQHgiiBVYFZDJ8MBhMulwgOBpIiAS6HLZAPIKd6gXkkgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?BmEDI8JAT1ANDsCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 hNk02ND
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:Rz8R1q3TaT7TrhKH+QjSSwqjBGYkLtp133Aq2lEZdPWaSL3+qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPjUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrMd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,285,1673910000"; 
   d="scan'208";a="51080924"
X-MGA-submission: =?us-ascii?q?MDH/T3WtGgk9lhrVxw14uFjF7oURVJxEhIy1tI?=
 =?us-ascii?q?m0YeIcrpQ+mc3jqBqZ2J5jn9UOy7CQppdKhFpEz8kSi79HliOzsKrXg0?=
 =?us-ascii?q?n3Bk7e15ehPfxTS/aVdivKwR51YFAiQRugdPA1GNeEyVYgi7KuU4B8Cv?=
 =?us-ascii?q?4ATETaWqsvKZXOI9IH//RCNg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 22:13:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679605966; i=markus.elfring@web.de;
	bh=2QoHUqgKgPVGGmnvMJM/u9TaRfmUDTOL7RGE/kHxu4U=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=volyLI75I91H894VfgMqGkX+uTvWcV6Xk0OBFAfx5H7Yc+My6vThtawSWZ70wl/Qx
	 73miKzgSjpe/icDbBlOSZnA0HmCO3KvpzXh0J5iP+2OJYHCVZSKHrVEWvNA1lHiJ9Q
	 sVoK+Ha/4abPNsetviDnBybpmpnCKvDLemdPwxaYPZtOhUyeF2p7zLvpDwjOGdDHxS
	 rqSLSNLyTTeMI6C4GW6KU2hEeuhwLkb5mCXL2mCwmJXwpG7gksw8BZ5xPlyZLfNpEx
	 bDDcDVbKlwbGarHNdDY1YNWjQNxDVMryLQs0Yy4qfQYQDSkeM4Q6ZkgPkolhf/auAT
	 l5OBOwWRfYBXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MALeD-1pmvQb1ptL-00Bp4j; Thu, 23
 Mar 2023 22:12:46 +0100
Message-ID: <b1c70348-6459-474e-6a0f-d956423368d5@web.de>
Date: Thu, 23 Mar 2023 22:12:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
 James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Leo Yan <leo.yan@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
 Suzuki Poulouse <suzuki.poulose@arm.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:todXHgwiJuv1Oh1HRvCUxlzNP3uYyjVI/J5R7+gwlMYGmPviLgU
 oQtls7FM8Ot0MdX6jYDqDs5RrYizEw/pMREUl5HIVgDTbpphB2n6eth11Y4Jux9byNKValZ
 iDxfJkZrbog8Uwdec0xB+lHGaGxaly+y0qFNi4Y6UEEzuorbPkC14j5OdZlA518OxYIETZ/
 N6Fsytjimuxx8TicI8lJg==
UI-OutboundReport: notjunk:1;M01:P0:yIEQvgXGh0U=;t0+g1nvd0HtOzfX3Hv0gnwihk/W
 siMT5qfeuztwH42mT8UmRbvrGi/+L1obDvG/O/PI69rKe7E87dxnsCtQKs7yjuM+CrVCnYSQ1
 VhoAPdV3eXjelHjDmobAHXGHz/X0buaQ4RWnZZn/FS2zMpweI27viZykiCFHavu1sDim8qhGa
 ooE3swfkJLDuTnx7KPP62cNTjvGZibKiZvZJ+aX4KMuSIU2KyInKGXnOdO8wuhSWDTtgwMHSx
 qIe3OCMmzOLn24intk8eRWjuFSA/ThhCDuSeQ0IDjH2SByBJozDWefmgLbgncShY5hJBnKrIX
 gkMRTYd0FyBwgMJjppkwAiCksU6XRKnsuUxLwdl5HeV2xPQueXUlB0XFDWoyn1L/wtgAVQCf2
 DiftLVwMzR4SIQA4roQV0+IAC8/XTEG/qor+snRCcaxsoKPAETRtj8DZdIv+uqd9JgZViL1hh
 AuXaIOyHE3fkzA+RAlDwTt3pi61y8+N/KX8sAwKBqGGKgudGpVijaawpGmnQpsh4XPB/nzDCC
 qndTBwCIhenz7wIklBXRy7pee+JlHPTFHyT8SWIR19Ihp+DPe3/houmDl4Whz63gO9gVgpwEQ
 ccYi/Z24LZ7gXHmemtoeJM8RHPtvkkIMJLkGcEVdrZVOjjPApnf3zgBYYzAKdeL8wvDt++JFr
 AxjAz49FvREqsxWWPIXzJgvXajUES1/sdBozCyk0hJoZZeB2zdKT9q5v62m74MK9RzU0yRRxO
 cU9MVUwSgkPYZhjrMy12IekbCatEUGLfnl/H98MtX3pzNM3cp0vtkR+pxFu00Ygj8F1Cqi976
 tp5lR/g4b5lFUq7f7iaZA1BqucxuNljUyRuSBW28NKTfHSkiGO3viotCv9z0poIB3ZyqQPd+I
 Rjjj+ywT9QShd+jBXQsFEgj3ZIOmzDBI7eSGIhIK70U4yMQ5J+Y92slAl
Subject: [cocci] [PATCH] perf cputopo: Improve exception handling in
 build_cpu_topology()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 914
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/b1c70348-6459-474e-6a0f-d956423368d5%40web.de>

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
=C2=A0tools/perf/util/cputopo.c | 10 +++++-----
=C2=A01 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index e08797c3cdbc..fd185951ee2c 100644
=2D-- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -112,10 +112,10 @@ static int build_cpu_topology(struct cpu_topology *t=
p, int cpu)
=C2=A0=C2=A0=C2=A0 =C2=A0}
=C2=A0=C2=A0=C2=A0 =C2=A0fp =3D fopen(filename, "r");
=C2=A0=C2=A0=C2=A0 =C2=A0if (!fp)
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto done;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto exit;
=C2=A0
=C2=A0=C2=A0=C2=A0 =C2=A0if (getline(&buf, &len, fp) <=3D 0)
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto done;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto close_file;
=C2=A0
=C2=A0=C2=A0=C2=A0 =C2=A0p =3D strchr(buf, '\n');
=C2=A0=C2=A0=C2=A0 =C2=A0if (p)
@@ -131,10 +131,10 @@ static int build_cpu_topology(struct cpu_topology *t=
p, int cpu)
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0buf =3D NULL;
=C2=A0=C2=A0=C2=A0 =C2=A0}
=C2=A0=C2=A0=C2=A0 =C2=A0ret =3D 0;
-done:
-=C2=A0=C2=A0 =C2=A0if (fp)
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0fclose(fp);
=C2=A0=C2=A0=C2=A0 =C2=A0free(buf);
+close_file:
+=C2=A0=C2=A0 =C2=A0fclose(fp);
+exit:
=C2=A0=C2=A0=C2=A0 =C2=A0return ret;
=C2=A0}
=C2=A0
=2D-
2.40.0


