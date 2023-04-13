Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F967C77B6E
	for <cocci@archiver.kernel.org>; Thu, 13 Apr 2023 13:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XBDH5QIm2vPtC9ipF2ygNuRcMeiO3cGhG2WQbKuLHtw=;
  b=tG2ez6KrdAjNfv8pitqurJ6Kmvf3SAPlqI843Vli8THOEnh+U6BjjLc4
   nAs4MIRKGhB9GaL5WaITxnbKiB2GEURN7uFwFafji7X9GraLsA1TEFZ/G
   WJYDJGBTTp77sDiFfTjkB0PXD+ziLRq2YzJhE9T0yvbyM1CnpB3Oo5Zkg
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
X-IronPort-AV: E=Sophos;i="5.99,193,1677538800"; 
   d="scan'208";a="102922032"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Apr 2023 15:03:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 17A49E7315; Thu, 13 Apr 2023 15:03:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2D55BE0172
	for <cocci@sympa.inria.fr>; Thu, 13 Apr 2023 15:03:40 +0200 (CEST)
IronPort-SDR: 6437fdab_g+JSmdT688M+p43+t8ICi+OI4madShYLsqgWYRhYN9XaKEh
 qeEzHN4omk/U1heMrXnTRAdvuEaQRhSWH+nVkmg==
X-IPAS-Result: =?us-ascii?q?A0FCAABu/DdkhwsR49RaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YItgUsvBAtGhFORLQOEMIcuhz6EZ4QDgVaBQD4PAQMBDUEBAgQBAQMEOIFTg?=
 =?us-ascii?q?nQChT0CHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQA?=
 =?us-ascii?q?QEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?gJHPgMDIwQZAQERJgEPHwYCHwcCAlcGAQwGAgEBgnqCKAEDMQetJn8zgQGCC?=
 =?us-ascii?q?AEBBpwLHywiVIFeCYEULQGNCYQwJw+BVUSBPIEVgi2IH4JnkWeIWgqBNHSBI?=
 =?us-ascii?q?A6BPIEEAgkCEWuBEAhpgXlAAg1jCw5vgUljTIF7BAIURRYlBA4DGSsdQAIBC?=
 =?us-ascii?q?zs6PzUGAwsfBlZrAgkjERMFAwsVKkcECDgGHDQRAggPEg8sRAxCNzMTBlwBK?=
 =?us-ascii?q?QsOEQNPgUcEgQqBAQYBJiSfBAFSO0yBXkySO7EANAeCK4FWgVkMnw0GEy+XC?=
 =?us-ascii?q?Q4GkiQBLocwkBcgp3+BZQE3gVwzGiSDNk8DGQ+OIBkeg26PCQE+PzQ9AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 O88fkDSW019lNN59jwMMtfebx5YZYxe+SqLFRs=
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:9af8X6+4EozdoXBrHj1uk+BJI+orL9Y04lQ7vn2ZKSY/TiX+rb
 HJoB17726StN9/YhwdcLy7V5VoIkmskaKdg7NwAV7KZmCP0ldASrsN0WKI+Vzd8kPFmtK1/J
 0QFpSWcOeAb2SS9vyKgzWQIpIa2sCO9K3tre3Cz3FrJDsaE51I3kNDEB+SFkAzfRJLQaE0Do
 aY+6N81kCdUEVSVd6jDn0JG9Deq8HG0LLqCCR2eiIP2U20lyqh7LO/KRSCwRsEOgk/uosKwC
 z+igT86+GZv+umzwK07R6r06hr
X-Talos-CUID: 9a23:Q+szuGPMTGFCye5DUQA2qVYfGcYebl7dw0/aKWajAnppcejA
X-Talos-MUID: =?us-ascii?q?9a23=3AXqFdXgwY6IIdXrZPFe1Kyda+qtiaqL6/U3oxurV?=
 =?us-ascii?q?XgOXeJQIpHjHMsCyoZpByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,193,1677538800"; 
   d="scan'208";a="53262141"
X-MGA-submission: =?us-ascii?q?MDF/+DeX0LTaNO2cUKSxUJOeJ9zljxk5s4d251?=
 =?us-ascii?q?ubre9xKndVU0KrJJvQSw3J5TcUVidd0V1qyOJz7eeKM5YMtSfx4V1c/w?=
 =?us-ascii?q?3d5w0ej5VPIRJh2ipNb9DihVuN8fnXgu17OKOz/qUdeI/6H7RJ4xTXst?=
 =?us-ascii?q?wW4PH65Fd47xwuQn3zfSl/uQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 15:03:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681390980; i=markus.elfring@web.de;
	bh=p0jVO8TJtvETcRyi9pLkICusHBXHCjFhk9HQ2pzJGsQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=lIWaSyXmFFuIPO6/l2aav5RaohSaKQlnF6V6YsJbGdhrph3Xkm6C6CwhE90tqqxbn
	 OOUfmW6U+Pqt5KzQzEocW/o/Y8GHb64DZ43iX5qhbpNmsOdOB/CMZcBCycqnDmT3Hm
	 icjSq02LmdSY9ZYEBA0xVBf0DcxB2/YneZkyP2BbFGUQ106fWK028+ccNmsEg6oDp9
	 gOVmy5me12nwATdMZ4d6yZJW71jgBHTAXj7Ut8vprQh4E61UvOUT9z9htMtdD3uhYw
	 ZGPSFPZR5FJY8GpsaOQj6lVZFk3AJRYQtq/kFuJsDi8LT234C09QVn2wyM1JogF1JU
	 LB6VpeTX4caUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRUX-1q3ePH0wYV-00IHXB; Thu, 13
 Apr 2023 15:03:00 +0200
Message-ID: <54a21fea-64e3-de67-82ef-d61b90ffad05@web.de>
Date: Thu, 13 Apr 2023 15:02:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 German Gomez <german.gomez@arm.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D6SJ4JHvUsp/2twJ2Z4lqyBInPhgK25ZgGXdjTzB431zBMIhBnJ
 M64VlZOqoZK/Fv7rFmOdMVc6WPksmoXKzwCe4/+SlQVhee3Y+B8syIqx02xRRhm3nakWCjo
 Tg00BajQ1t/yMo6Pz0mqazpwhCc5KIXiU/o0ORGpBgN0/+gtuSw7oym8llHN4KVbAKFom6d
 VoO6J8CxuD30WlyfqnrJw==
UI-OutboundReport: notjunk:1;M01:P0:ViMt04JHs4I=;6FbUXobVg4+OqYbHuQ+wDxnyIHq
 vruP8/cxj//z1EC26XC0Q4TYuWtcvhTR3JAM5vxEtaThg8ySRxp1P6Zq9XXG7flWvPidxbqt6
 dCQtZ5HTBLklgB+dm18QJC1MI+dG2AHqQ91Dx+ai5jmOabz5WIRFiLrT6sEUvAyICd1z/DvXc
 hB6wJpMayZTpHcdUDXkMD4QEPrpU/OcBo21554KGtNWg8YuOFEO+J60PKoWhdqcY+UOwjiRJ0
 stEcb8icqmXIJeSajcLeb5hgSXD+ySK6qV1+gxTO02cx/aoR19H1O2K/eFXTEFQvnUyjhaVFB
 iAHaQBPZpycj9WS9MdiZXi9Hk3ja3qCOOUaatQkv3LOcroRFagF7zVGSiYmw+weMWjeuF6KLt
 t1ve2w3mhCvv+HpY7HgwXqASUZgFDOCl42nONoIJX7Wg1YCW/jiayCusj8JWNALIyMR1Cuyal
 oGGXQbSuqxCNit6sTpsrmnH+3/7H8btlCLDnge2cHVscCVcuKYeSiwHsuQMAcqtyXH3X6NaZt
 smU6/hWArq/AZpYU5zvbEnwZscb0qsx7d2xxfuAAjw8ZYCykoe9efwk9OlOYAoF4YWIj9ssqV
 WyuM0HpeifSQr2B2HO/QZGAw3YIkEYX2R7EVv2ZpeDIjwHpyj7odLJ2aPAAB0Nq6Ec5QmvDMY
 NNnZjCQ+0lN6bnpInf2SfhPQaJOB+qKBrCD1sTT7eW+/vajE0eGsP3hhUHYCioEusJX0x6MXL
 7WRpI7AjjVdW7GqwONB6rD8kPBOsNYVIjChO7qeo4+cNfOLjYA/XvE7xYG31HLD1Z60LS6CSf
 HDFhjF4T24H8PqLGxyzYl6vaPHW41JZkfLNxe9BQNa5ZGOUej2i6CSHo9Y+zH1vAe9jACMtLT
 D3QlcFXqgBJ+WvyDEC7SnXHYpMuskkI1+yytqLXE9MeO2vyf5x50o4XBw
Subject: [cocci] [PATCH] perf map: Delete two variable initialisations
 before null pointer checks in sort__sym_from_cmp()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1040
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/54a21fea-64e3-de67-82ef-d61b90ffad05%40web.de>

Date: Thu, 13 Apr 2023 14:46:39 +0200

Addresses of two data structure members were determined before
corresponding null pointer checks in the implementation of
the function =E2=80=9Csort__sym_from_cmp=E2=80=9D.

Thus avoid the risk for undefined behaviour by removing extra
initialisations for the local variables =E2=80=9Cfrom_l=E2=80=9D and =E2=
=80=9Cfrom_r=E2=80=9D
(also because they were already reassigned with the same value
behind this pointer check).

This issue was detected by using the Coccinelle software.

Fixes: 1b9e97a2a95e4941dcfa968c4b2e04022e9a343e ("perf tools: Fix report -=
F symbol_from for data without branch info")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 tools/perf/util/sort.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 80c9960c37e5..f2ffaf90648e 100644
=2D-- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1020,8 +1020,7 @@ static int hist_entry__dso_to_filter(struct hist_ent=
ry *he, int type,
 static int64_t
 sort__sym_from_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	struct addr_map_symbol *from_l =3D &left->branch_info->from;
-	struct addr_map_symbol *from_r =3D &right->branch_info->from;
+	struct addr_map_symbol *from_l, *from_r;

 	if (!left->branch_info || !right->branch_info)
 		return cmp_null(left->branch_info, right->branch_info);
=2D-
2.40.0

