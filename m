Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD92C6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OTr7lWxHEfTcob/7eH6zCPywWNyVFsiyxqoEqLuHVqQ=;
  b=njERPI7wUQkQ17BfM2g2y4Vm2pfE9GyHgw29h7/l3zPedKpcjvXNTQvf
   /faxe5btiNQM4WVkUXEUEeN0Jng7Zz+wWHqklhMwMep28ULdpRtesPGIW
   n7jYlCMG4DuxoqwDa+793N7rI+tSglAXDgardlLoT97p34ufjLy0Ye2qs
   I=;
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
   d="scan'208";a="99066350"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 15:16:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 238F8E0D45; Sat, 25 Mar 2023 15:16:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B91BAE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 15:16:02 +0100 (CET)
IronPort-SDR: 641f0223_+lXD97KMi7Jwt95dLmyFdt3uMb0bT1eSZTZR8N0BKbDM8pb
 d9ZdvXJsS1H2oqo5/bx12yYb+RjMdlivz8eu3Ew==
X-IPAS-Result: =?us-ascii?q?A0FgAACeAR9khw4P49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YItgUsvBAtGhFORAS4DhC+HLIwhhAKBVoFAPg8BAwENQQECBAEBAwQ4gVOCc?=
 =?us-ascii?q?wKFOgIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQA?=
 =?us-ascii?q?QEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?gJHUz0DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQexNn8zgQGCC?=
 =?us-ascii?q?AEBBoJjmScfLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBFScMgzWIHIJngiiHVocli?=
 =?us-ascii?q?C8KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMgR4lBA4DGSsdQ?=
 =?us-ascii?q?AIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8sRA5CNzQTB?=
 =?us-ascii?q?lwBKQsOEQNQgUcEgQqBAQYBJiSacQIBgmcBUjEKTCaCBJJYEZIvng40B4Iog?=
 =?us-ascii?q?VWBWQyfDAYTLpcIDgaSIy6HLZAPIKd6gWoFLoFcMxokgzZPAxkPjiAZHoNuj?=
 =?us-ascii?q?wkBPUA0OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 T3Tx5EoAiWM/w==
IronPort-HdrOrdr: A9a23:zciJb6z2aa4YBwKEtGXaKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99066344"
X-MGA-submission: =?us-ascii?q?MDHYkyqSOfgwBoiWtQ7b0HZ/Hr1Wr9GlCSefro?=
 =?us-ascii?q?JDbR1AWpuic4R+WEwHRqJwldQADbEtzV1s6YfxJC6eknAth7onPodgXI?=
 =?us-ascii?q?TvMt5WFPAKD8VHZT9SRSdKQyfrJtfmw5GR8vSoWTPJgAn8dsM8G2oChW?=
 =?us-ascii?q?2QUbkVS6d4k3jhCbJn0oujMg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 15:16:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679753733; i=markus.elfring@web.de;
	bh=oDtsw/Je2gHi5qt4kRD7JBDy2WBF4hPjqZKh0yXtieQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=edWgW3TdSpTyGEQ6cWwnzpw4hO0zQixz+pYRUb/Hxtzyn1/usvChJcDvEJh9xA14n
	 fpstrQ87gZsx46P7YqRa3WvuD2MidnFZDsK7l+1Nia8bAHYbny+Mk2fCz4B44q7aBc
	 0sT/i+xTpfZZim5Iie/hWf6RADO13rjlYBLLAy55PpDW0FxZqcuceuisKEJl2T6fSf
	 HnitJ3/tvkbKsMNMauF9g4wltt+QNRmfr/W5MSTGklSD//u8f3oKVjcLFqjKC91952
	 Obl/7FVHdvhGHFzPrD9qCfg8opgrbk8OdBynY29jLJo5+q48WkRiZluAumBhqIrAXn
	 /0aD14O50tfUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCogm-1pouNp0BrU-00917G; Sat, 25
 Mar 2023 15:15:33 +0100
Message-ID: <3a35fb28-5937-72f8-b2e8-b1d9899b5e43@web.de>
Date: Sat, 25 Mar 2023 15:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Sandipan Das <sandipan.das@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Zhouyi Zhou <zhouzhouyi@gmail.com>, x86@kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <ab860edf-79ca-2035-c5a3-d25be6fd9dac@web.de>
In-Reply-To: <ab860edf-79ca-2035-c5a3-d25be6fd9dac@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dA4JkKCJYlVXFzcbBfbuiLhZWKs5wS/RB8n7kfagHUWVLI5QRIG
 V2ymjr3p2sVFgd/f+5DilKdpL8BPsw6zOGs0ERmWzHXziDL6tIQLkpfnWrLyOaq2IYH4Mzc
 aZR9yjWlBJxYtdNxpsg6lwctWvtySyw9IR9oNY8vGw4N3doQWTKl5Pxy5HnWXOcVVzfU/Gz
 RFv5Au5mMhybBNFQ2pFbw==
UI-OutboundReport: notjunk:1;M01:P0:j2k9+zyPFH8=;HnX7GfJHZezT91ACU92LN1Z+Z5a
 du/xxWLh/zC1qM6OA6y7mp3PlvPrEx/6nsLFZKIaTWA633cH0qUxsReyR3uHH+bZ5VoQUrbPm
 zVOyynBthU7j5y/39jaregk3m6nwRXVOLMtHEPs174H3oG3cF4q7Bkt7LWoQUjiB12gjShuGo
 C+OVqXXCvoJh20MN6PrBO2dtqKX0qBWj8WgAqI2eAmvbdlvnXOAbvd96chwmVmI/Drd7e6voU
 hRvxMsGH7Yvnl2EcfDUnFss60tkJFqGiMqHNjfTJvJLOHgDe+6y42yeJX2n5Q3cED0t45IZXD
 oIYCcYb179eF7fYt17TJcIba5nIs6jY0NQOHyKlMKUmv3gESNOsW83XTCZ16OVkKtCaaCJp/j
 Uqz2FhVfxmQasVnZZxfHlXQdrvUVIJJ3uTrkoRHjqSN5cwTDcj9F/pulQzqltL8FDSQWpjOIa
 qktITNrARNbbeVknIVlJVb092oi0imx7821q207PyH7E5a5EDYUUciUEjg+Lf7jscPrCFKf6r
 J2E7KdX+iKHOKFkFQt7WHCc0B0rYevjV/ueeA4H4nYavuKB43gCTLZq/tWv0bhRsVCbUVrFIG
 uke2KGhMQ65SmM36u5W9SKYdu64YQOC+GNfiiZ5vrAhUcabnew46yLI5EvphxdclmbzPDbiTj
 YtKXp0SGMnLZSRvVTDK6aRqihAaS+gCs8oHxOycLIPladB7nqefcbwlE6M1QK/wu8G1tuu/07
 zLhKVO9JUMeDg4yaf5yxLORzCeJx8MBCJxrmiG1IWavpV/K2jvvGfGcb9F93xE2aCp6RFuW4G
 gKQ6yME96nb08xxVy78dHf1B7VxcK994Gu0afmZpAnhjV023hvKIJZFYsVpvbu425UoI0A0/x
 6NC2cMcPDghBg2Dadtu1FnQGRqUa35omW2eaufwz83lTxQHyphaFslOo+
Subject: [cocci] [PATCH resent] perf/x86/amd/uncore: Fix exception handling
 in amd_uncore_cpu_up_prepare()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 951
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/3a35fb28-5937-72f8-b2e8-b1d9899b5e43%40web.de>

Date: Fri, 17 Mar 2023 13:13:14 +0100

The label =E2=80=9Cfail=E2=80=9D was used to jump to another pointer check=
 despite of
the detail in the implementation of the function =E2=80=9Camd_uncore_cpu_u=
p_prepare=E2=80=9D
that it was determined already that the corresponding variable contained
a null pointer (because of a failed function call in two cases).

1. Thus return directly after a call of the function =E2=80=9Camd_uncore_a=
lloc=E2=80=9D
   failed in the first if branch.

2. Use more appropriate labels instead.

3. Reorder jump targets at the end.

4. Delete a redundant check and kfree() call.

5. Omit an explicit initialisation for the local variable =E2=80=9Cuncore_=
llc=E2=80=9D.


This issue was detected by using the Coccinelle software.

Fixes: 39621c5808f5dda75d03dc4b2d4d2b13a5a1c34b ("perf/x86/amd/uncore: Use=
 dynamic events array")
Fixes: 503d3291a937b726757c1f7c45fa02389d2f4324 ("perf/x86/amd: Try to fix=
 some mem allocation failure handling")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/x86/events/amd/uncore.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 83f15fe411b3..0a9b5cb97bb4 100644
=2D-- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -440,13 +440,13 @@ amd_uncore_events_alloc(unsigned int num, unsigned i=
nt cpu)

 static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 {
-	struct amd_uncore *uncore_nb =3D NULL, *uncore_llc =3D NULL;
+	struct amd_uncore *uncore_nb =3D NULL, *uncore_llc;

 	if (amd_uncore_nb) {
 		*per_cpu_ptr(amd_uncore_nb, cpu) =3D NULL;
 		uncore_nb =3D amd_uncore_alloc(cpu);
 		if (!uncore_nb)
-			goto fail;
+			return -ENOMEM;
 		uncore_nb->cpu =3D cpu;
 		uncore_nb->num_counters =3D num_counters_nb;
 		uncore_nb->rdpmc_base =3D RDPMC_BASE_NB;
@@ -455,7 +455,7 @@ static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 		uncore_nb->pmu =3D &amd_nb_pmu;
 		uncore_nb->events =3D amd_uncore_events_alloc(num_counters_nb, cpu);
 		if (!uncore_nb->events)
-			goto fail;
+			goto free_nb;
 		uncore_nb->id =3D -1;
 		*per_cpu_ptr(amd_uncore_nb, cpu) =3D uncore_nb;
 	}
@@ -464,7 +464,7 @@ static int amd_uncore_cpu_up_prepare(unsigned int cpu)
 		*per_cpu_ptr(amd_uncore_llc, cpu) =3D NULL;
 		uncore_llc =3D amd_uncore_alloc(cpu);
 		if (!uncore_llc)
-			goto fail;
+			goto check_uncore_nb;
 		uncore_llc->cpu =3D cpu;
 		uncore_llc->num_counters =3D num_counters_llc;
 		uncore_llc->rdpmc_base =3D RDPMC_BASE_LLC;
@@ -473,24 +473,22 @@ static int amd_uncore_cpu_up_prepare(unsigned int cp=
u)
 		uncore_llc->pmu =3D &amd_llc_pmu;
 		uncore_llc->events =3D amd_uncore_events_alloc(num_counters_llc, cpu);
 		if (!uncore_llc->events)
-			goto fail;
+			goto free_llc;
 		uncore_llc->id =3D -1;
 		*per_cpu_ptr(amd_uncore_llc, cpu) =3D uncore_llc;
 	}

 	return 0;

-fail:
+free_llc:
+	kfree(uncore_llc);
+check_uncore_nb:
 	if (uncore_nb) {
 		kfree(uncore_nb->events);
+free_nb:
 		kfree(uncore_nb);
 	}

-	if (uncore_llc) {
-		kfree(uncore_llc->events);
-		kfree(uncore_llc);
-	}
-
 	return -ENOMEM;
 }

=2D-
2.40.0

