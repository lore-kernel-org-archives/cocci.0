Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF0DC77B78
	for <cocci@archiver.kernel.org>; Sun, 16 Apr 2023 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pxPJsl/SpHW+vdVmYdvpBrMD1AH/oh/Hwnr/toA2xcA=;
  b=FPqD47bi7nctI7s6oVG0f5xHoI1gvCeVv5qBUCahGZeyFkK2aBeHbJx8
   0RJdEn9Y9eHu3OwuFCDodhFeBSO3lORCcKt+016FT+kwwJRx53MqXo2MW
   kPnoFs2wUCzkSrpkMJsuk8QCF8XbCvNWWdKoY/A69PBI0lBWGSU4xec7u
   w=;
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
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="103271544"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2023 11:40:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 417AFE0298; Sun, 16 Apr 2023 11:40:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C5927E0297
	for <cocci@sympa.inria.fr>; Sun, 16 Apr 2023 11:40:18 +0200 (CEST)
IronPort-SDR: 643bc282_fPzmLoLB64K6SbmJQ2J/M0IXxO+GllFfHgLHvQEkxLe/zPJ
 OQynznWYRy8887R1EQua8+Jg8NGrtfJJduPqvZQ==
X-IPAS-Result: =?us-ascii?q?A0EPAAAywjtkhwMP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYItgUsvBAtGhFOIHohkMYQwhy6HPoRnhAOBVoFAPg8BA?=
 =?us-ascii?q?wENQQECBAEBAwQ4gVOCdAKFPAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQESAkc+AwMjHQEBESYBDx8GAh8HAgJXBgEMBgIBAYJ6g?=
 =?us-ascii?q?igBAzEHrgqBMoEBgggBAQacCx8sIlSBXgmBFC0BjQqDNnonD4FVRIE8gRWCL?=
 =?us-ascii?q?YgfgmeaVoE0doEgDoE8gQQCCQIRa4EQCGqBeUACDWQLDm+BSWNMgXsEAhRED?=
 =?us-ascii?q?h0lBA4DGSsdQAIBCzs6PzUGAwsgBlZrAgkjERMFAwsVKkcECDgGGzQRAggPE?=
 =?us-ascii?q?g8sRAxCNzMTBlwBKQsOEQNOgUcEgQmBAQYBJiSfIFM7TIIqwz40B4IrgVaBW?=
 =?us-ascii?q?QyfDQYTL5cJDgaSJS6HMpAXIKd/gWM6gVwzGiSDNk8DGQ+OIAwNCRWDbo8JA?=
 =?us-ascii?q?T4/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 zYphwE4bel/rF/R
IronPort-Data: A9a23:nWarYqsVXW2NsH80WbOEfBf9J+fnVEZaMUV32f8akzHdYApBsoF/q
 tZmKWyFP63cZTDxeIogYIu+8EtUvMOHmINrSQRsqy0wFigSgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbyRFuspvlDs15K6p4G9B4wRlDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJBhtH6chwr5WO0Rhy
 NY4JBFKXEyatv3jldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWp23aiiHt6GD
 yYdQR9mdhfdeFtiPlkNCZQxtPiljD/zflW0rXrI/vZpvDKKlGSd1pC9PfvcYdq0Y/xxuUK5/
 lP0/l7lBzMjYYn3JT2tqy/w2LaWw0sXQrk6H7qz/f9Cm0yW3mVVCRsMVFL9r+PRt6Klc9dYN
 lBS5Sck66Q/nKC2cjXjd0TjglS9hkY9Yf9/Lsca5CDK+PbN0hnMUwDoUQV9QNAhscY3Qxkj2
 VmIg87lCFRTXFu9FyP1GlC88mvaBMQFEYMRTXJdE1BUsrEPtKlv0EuVE76PBYbv1oWdJN3m/
 9ydhA4a71n5pfwGyai9913djD+qznQiZlJquF+/so6NyARjeI7tTZah41Hd8Z59wGuxS16co
 D4blsLY4O1m4XCxeM6lEbxl8FKBva/t3NjgbbhHQshJG9OFpi/LQGyoyGsiTHqFy+5dEdMTX
 GfduBlK+LhYN2awYKl8buqZUpp6lPWwToi/CK6JNLKih6SdkifYo0mCgmbPgAjQfLQEyvFX1
 WqzLJvzVi9DYUiZ5GPnH71NuVPU+szO7TqOGc6ilkrPPUu2PTDMAbYDLFaUaO0lpKqLyDg5A
 P4PX/ZmPy53CbWkCgGOqdB7BQlTcRATWM6qw+QKKL/rClQ8RAkJVaSLqZt/INMNokigvryVl
 p1LchQEkwWXaLyuAVniV02Pn5u0AMYl8StmZHF0VbtqslB6CbuSAG4kX8NfVdEaGCZLkJaYl
 tFVJJ3SMecFUTnd5TUWYL/0qYEoJlzhhhuDM2DhKHIzdoJpDV6BsNL1XBrdxA9XBAqOtOw6v
 +KB0CHfSsE9XAhMNpvdR8+u6FKThkIjvtxOcXHGGOQOR3W0wrNWc3TwqtQVP/AzLQ7yw2rG9
 gSOXjYdi+r/g64019jr3pK7jpqbPNZ/OmF4HGDry6m8GgeH32ikwK5GCP2pexKEXkzK2aySX
 8dn5NCiD+8ig3BxrJtaL7Zn6Ykc9unfjeZW4So8FUqacmnxLK1rJ0e3+PVmt4pP9+d/ghS3U
 EfewetqE+yFF+29GWFAOTd/SPqI0MwVvTzg7f4VBkHezw0v9ZqlVXRiBTW9uBZ/HpBUbrx8m
 fwAvfQI4TORkhApa9aKrh5F/lS2c0Avbf8ViYE4MqTK1CwbkkpPcL7NOB/QuZuvUehBAmMuA
 z2ThZfBuYhi+1r/QyIzO0Tgjet5rrYSiS9O124HdgiomMKap/oZ3y9x0DUQTyZJxE55i8Z1N
 mxaNhB2F56v5BZtvtBIBEq3KjFCBTqY203/8EQIn2vnVHuVVnTBAWk+GOSV9mUL2jh4Uh1E2
 oqH2UDZUTrOV+Pg7BsYAEJKhaTqco1sy1fkhsuiIfWgI7A7RjjU2omVemsCrkrcM/Mb3UHoi
 7Fjw7dtVPfdKyUVnqwcDrua35Q2TDSvBjRLYdNlzZMzMVDsQhOA8hnQFBnpYeJIHeLAzmGgA
 c83Js5vaQW35BzTkh8lX5wzM51Gt993wupaYb76B380g53GpBpTjZ/g3CzfhmgqftZQrfgAO
 r7hLzKvL2jBqkZXyknsrdZFMFWWedMrRhPx98Hr/fQrF6AsivBNc0Yz3uGKvlGQCg9G/g2Vj
 izHdaT53+xv8qUyvorOQ4FoJRS4FsP3b8uMqDuMitVpacjdFOvzrCYXlwXXBBtXNr4vRNhHr
 7SBn9rp1kfjvrxtcWTmt7SeNqtOv+OeYfF2N5/pEXxkgieyYs/gzB8d8WSeK5YSstd85NGid
 jSoevmLat8ZdNdM9kJ7MxEEPU4mNJ32SaP8qQeWjfeGUEEd2DOaCuKXzybiaGUDexIYP5H7N
 BTPhM+vwdJm/bR8XEpOQ7ksBpJjO1bsVJc3b9C753HSEmCshUjEobf40wYp7TbQEHSfDcLm+
 tT/SwPjcAip8rT9pD2DX1eeYjVMZJq8vQUxQq7Z09txliz8E2MMa+gQWXnD5le4jQSqvKwUp
 hmUBIfhNck5dStJe1Pw7bwPmy+BU/cWNI6RyiMBpiuphuTfOG9EKKRs/GFs7h+av9clIP6Pc
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:dRO7dqofoK4f8cNX4GHgGzQaV5r/eYIsimQD101hICG9vPbo8/
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWvbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAamSS5vyb3ODXKadE/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3At6eV5WpAoGBEcOd2G64OdCjmUZl+UFfk9C/xGWq?=
 =?us-ascii?q?XNExJRJzSewOJybwxxg=3D=3D?=
X-Talos-MUID: 9a23:jxnBCwb0sLaXfOBT5zLNjSpkCuFRx4OqKRg8o5Q8p8ymDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="53467210"
X-MGA-submission: =?us-ascii?q?MDF8gbpKHycuU2w9gu1LThRcDdbitJf7Sp+lov?=
 =?us-ascii?q?1fpcbglUFf41cCGwlHmvVJGueMsLb7M6n60dPeOZccSjXOZBv8P3PncE?=
 =?us-ascii?q?xPzXfGhxSHsQug0bGAy7I9gv3Y40cVHqT1nmEVS1jw/qV5XLxvbrOwdU?=
 =?us-ascii?q?3Zowkael/7goLwGVKWYakRUw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 11:40:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681638014; i=markus.elfring@web.de;
	bh=+NCsfkXOgfuHgoQl17J8LhHx9x3ANJMwQ5mx9xKblt0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=pzqg3t2qAM3m219l/pA9avqJGTNlIlkgDmHDFLaYF5w29VTNZ/QOZ12N7zw08tCAr
	 q/9XG1SYZx1okSEYUjbNGPrDpsI10RKVN7XwyPs0xMmWMGhMM9BenohNpJWzfY8fGV
	 fdYSHCpVwnIRTqj/AHA9FzjhRcHRp5ENsUpf5ga7K5cf7lJN6KApaodVE3TV2Y1aaE
	 iVt6wJH93/8BFokSbwyO6GPeMmNizJ+RA3rO0i+fBHxVRZxeu1jA3lCboB6ykZcMc9
	 r/+/ubID8CRdvYm0WLtVQFgiX9qQLNRP8jxG+fDGCp6NQrr8r9nIKdtgQ/mO1Y4DA0
	 967tp06U3k9MQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8n46-1qRyYK1tfq-0162Pr; Sun, 16
 Apr 2023 11:40:14 +0200
Message-ID: <bdee7e41-094a-91d1-3f6f-56df402d70b7@web.de>
Date: Sun, 16 Apr 2023 11:40:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
In-Reply-To: <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DOJiTspO1yVyqj5IRQ7Ck8IrgQpJ3wpqDiP4YB6SicStSNsT1Wn
 zp7gzbThX2mCd7NQP9lFztsSN3AbdrHL4LBRg4RzusLl0mqq2AYR3d88j7ApbbiVAZQyWUK
 LY2CTCL3HOldVjlLD6FREpXfB9psxEG6m/vbkd+VHWgzOPwxmgJDzVHS2+xrWwaKbxmmvZH
 Xawl5dHvP8+cF9FOr3jfA==
UI-OutboundReport: notjunk:1;M01:P0:vNiijIQRaJM=;tWbqBgSB+ngyZfoRofZ0uVvXENa
 Q8zDybNEY/Kbdtz7HRgy3rueuLGY9NaCbEDrLjc5Aa0VlPfqGWWf5V7r6u4Byl6b+QbIDdjsC
 45awXuBGjpYxOqZkq+9aqTifX/KR3uPR+Bfyctu8hXxJzjB61zIXpG0lYj8h+HGBxECJxRMbw
 UTnjLEsC2x9LaiBrmawNJ9GUhyNfFRxA4XQjKEKfKCClZ380ZdkwCxXQOYmcQkyohRhbkUnWV
 0mQh32fGIhe9R2VxLzHNW++qDVB1xqWS/MDgezikZp5Yf18ht/GHAii5mDk2ucv5KTLPtTRjV
 znGy5eBwFRRAfelcyP72FokgLm+WeWeVqlptFdCOcZfPcYnIDLqW5f/glKWfZg3sD07UPJ4jc
 shVu7LcdDbMGc4BUIrBSYOYlP8rZlz4qzuHLzd8Lws91J9ZwLLzcAW7UMuq3OsMN0qWW8Z72w
 uPVpre+Nmc6Xfnp2UPg71NNL6nmz84oVCo7o1x0CgYhoSn6WWnBGAQNRCZCSqRwNgS05gCrku
 CPCGjDobwoeHjdf5SYgfNgXu5yOU6oll5bkfJ6HYZsWB8DMq9cARlLx1sYVTxYPSEQcG4TVQa
 bw44HMYJ4ZXGFJwqfJfQPuCPB0LV23+M+I3sYIkph/J8v/V1DnHj+L8d0RmVYApLHFOnmLUfl
 DEs+GdhYvLSKjAVHhk+pdmRAZ6Sku33p3TmlUEHIhRQ1ItWw+74ROlG58nCAkwhYS7oeVWIkh
 jZLAPS1MwBv9QRLSe+TE/YYiTY9FOdno237aX5Ux4dQzyvl5eV9EVp1m/yNYnn+HI9aFYNwXI
 Lxeetawd00ykyklv2ji/zl41wEfRzE6/cri1mRCrB8j1ud5lOFqzY0pTPb1PeIu0QTe7o3ZUv
 eHdDLj1y3Czq+OS11ZBrOmbuNGN9Kre8l3hx9pfWiOwAsJuGdz++yHI30
Subject: [cocci] [PATCH 4/9] drm/nouveau/debugfs: Replace five seq_printf()
 calls by seq_puts() in nouveau_debugfs_pstate_get()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1064
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/bdee7e41-094a-91d1-3f6f-56df402d70b7%40web.de>

Date: Sat, 15 Apr 2023 22:02:31 +0200

Five strings which did not contain a data format specification should
be put into a sequence. Thus use the corresponding function =E2=80=9Cseq_p=
uts=E2=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/n=
ouveau/nouveau_debugfs.c
index 13c82eea8828..99d022a91afc 100644
=2D-- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -120,16 +120,16 @@ nouveau_debugfs_pstate_get(struct seq_file *m, void =
*data)

 		if (state >=3D 0) {
 			if (info.ustate_ac =3D=3D state)
-				seq_printf(m, " AC");
+				seq_puts(m, " AC");
 			if (info.ustate_dc =3D=3D state)
-				seq_printf(m, " DC");
+				seq_puts(m, " DC");
 			if (info.pstate =3D=3D state)
-				seq_printf(m, " *");
+				seq_puts(m, " *");
 		} else {
 			if (info.ustate_ac < -1)
-				seq_printf(m, " AC");
+				seq_puts(m, " AC");
 			if (info.ustate_dc < -1)
-				seq_printf(m, " DC");
+				seq_puts(m, " DC");
 		}

 		seq_putc(m, '\n');
=2D-
2.40.0

