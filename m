Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CC6C4332F
	for <cocci@archiver.kernel.org>; Fri, 18 Nov 2022 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=I7Q8LEGfyZWoVnPZg409ZXAn++4rAOYgyyiZox4U7pM=;
  b=mRMHKLjkOqPTjB2dHT5LHityEJZjgale1ywGpFTBr/peoKa6PnwfC2gl
   PUsOxTzCXGDjgTsNZM4k60/dczbOKM015mVGv8tzfACJwKwTouSBQCPI9
   mrYIHCuvrgjHzi+c9TAEox3VA5cNgeMLE2aEyRPRN0lTeLU251mnJqNs1
   k=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,175,1665439200"; 
   d="scan'208";a="79016794"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2022 19:30:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 48429E02A3; Fri, 18 Nov 2022 19:30:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3B644E027C
	for <cocci@sympa.inria.fr>; Fri, 18 Nov 2022 19:30:21 +0100 (CET)
IronPort-SDR: 6377cf3c_H9RibvOSnavlYrnt+UlAJA7d5YLOA5FljG+9ilLv+vkF7am
 lCSkd0YwT8pIms38YJRg9bjjEM2W6db2MyKDsIw==
X-IPAS-Result: =?us-ascii?q?A0FlDQCozndjhwMP49RagQmBUYIrgQdTLgQLRYRPjnWBd?=
 =?us-ascii?q?4EGg1SHIYcwiGGDVA8BAwENQQECBAEBAwSCC4JpAYULAh0HAQQ1BQ0BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEZCRcHDhAFIoVGIg2CN?=
 =?us-ascii?q?SJ9gQgBAQEBAQEBAQEBAQEBAQEBAQEBFgJHU2YdAQERJzQCJgJsCAEBgnmCb?=
 =?us-ascii?q?gEDMQewToEygQGCCAEBBoJhmSUfLCJTgV4JgRQthy8dV4MqhWkQgVVEgTyCU?=
 =?us-ascii?q?4V/gwqCRSKOdIhyJQQOAxkrHUACAQttDUkbMScOCR8cChsNBQYSAyBsBQo3D?=
 =?us-ascii?q?ygvZyscGweBDCooFQMEBAMCBhMDIgINKTEUBCkTDSsnbwkCAyJqAwMEKCwDC?=
 =?us-ascii?q?SEfByckPAdWOgUDAg8gOAYDCQMCIlNzAi4RFQUDCxUlCAVLBAg5BQZTEgIKE?=
 =?us-ascii?q?QMSDyxGDkg+ORYGJ3QODhQDXoFpBIEbgQ8KnH01lSyvRjQHgh+BTIFNDIhSj?=
 =?us-ascii?q?x+GdQYTLoNlAVuSLQ4GkhSXNKI6FoUogXoigVwzGiSDNk8DGQ+NeAEzDQmEA?=
 =?us-ascii?q?4osQDQ7AgcBCgEBAwmFRwEBhRgBAQ?=
IronPort-PHdr: A9a23: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
 d1UbE5H6LGdv3swvw==
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:uIChJamWsa5Y611dUcX0u65qpP7pDfIO3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE7wr5OUtQ/exoXZPqfZqyz/FICOUqTNWftWrd1ldATrsP0WKK+VSJdhEWndQtsJ
 uIHZIfNPTNLRxdkdvw5hW+Hu0t2d+d7cmT9J/jJjtWLD2DcMtbnmFE4+ugYzRLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,175,1665439200"; 
   d="scan'208";a="79016787"
X-MGA-submission: =?us-ascii?q?MDH2PvgBOc4I2s8IkoXb8o6uQetWWL4cqM6KyV?=
 =?us-ascii?q?rkgwp/QqLfn3eAWpjxybE99a0KmBKHxckQ+JPmcTJ/z/kXnAzsJ5xqrn?=
 =?us-ascii?q?0webonjQ4QE8ff9nf7mtYu3QuDBddlToz8fEvW61d3qzQ4Z+TKP5/CJw?=
 =?us-ascii?q?dHmaR5fyaFU7l/Wj3gJ/tNhw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 19:30:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668796220; bh=I7Q8LEGfyZWoVnPZg409ZXAn++4rAOYgyyiZox4U7pM=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=tpk2+YNvUHXtaELEc0c/OUtso+Ll2BLBwc7eRt4xeRA2qfe0gVTDgKxe+UJf4iDX+
	 z4/FIpylVUoZ9k0Jm1bhE1Z3d382FaRRA+OH3++MWw74Jhv2mzh/hN5kudRZO7J/fN
	 MuACyExqq8Zr2dB3zV9Ds4q2x2SZqRplNBGvri0/xNg+1cp4AK6XN3KNKFzg3aBDHJ
	 zMFjO4x+iYoD4CDaJO4jnTrV1uEqRmlk84qJvBuf2E/iIYviUIhMW5+CTjHYqZ5Hmi
	 jkmlRP5xjIZZyexC7kuw0aeOujyACg2QqsAMblNOwE3SZUOwwq0870H4zmzx5D7ppL
	 AGub9E0IldgQQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43GO-1ow6833t56-0006gV for
 <cocci@inria.fr>; Fri, 18 Nov 2022 19:30:19 +0100
Message-ID: <b555eaba-9cf8-860a-a06c-01302d59057a@web.de>
Date: Fri, 18 Nov 2022 19:30:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gr/xFLqt/BQ7mJ2L7mX1wm0xq1HTsqQtAeIo6guw4WJS7a42bre
 +fFilPuvQHMtcHR/naY0j1K3DLR9+a9jC6DO9NjkUhjSe+3nG4VqYbwfm0tnkyyHy5661cz
 4gwCcOCln8zOzYOmwtFutCZDIgVwV1b4eTZqiuk8QpoysrujUFwBOTJdZBe7BF/+Z3NmyBa
 qtUwIu9b6IVbE1iW+eafw==
UI-OutboundReport: notjunk:1;M01:P0:+N2uX9AGXoQ=;CGEyv/XfMCJ4r3KBHuaD5gXVXFO
 k8prkFUGXuAbuh0yZCa7dCIs5tbxM6tF1ZpU/CbM8EHRugpe9C2E55TO0KBsa2ZXXJJcddkEw
 e0g1WO+DlJw6QnBj71XT0wzkhltkPhMN+5mnbSkVqM9d4vY5vJ0EomXW8jFVD+ShgdT8IB7jy
 YCwvWLjFmTVik6LaeoHwrmHM4u3Khq+/Q5gbwpCJeI307tfdjqPFpHtHoZd4Y2rpt+innGsun
 nN9D1RAxqd+n9T6Or1cY0gDuK3BmQnyFrSQqkm9tHhmjr0OO2AGWSfqPuDZkc1jHvQgIEVuL5
 V6+fGzfR3SyQuTGv80dvtDS1zlAqS+8n6vsCOgE0XNgygwV1oDE6pNtCYf5HUTfIxDluCg3D+
 4VwBog4W3Q04hq+TF+G5hA+YKjKYaPAIf5LkdGX1IBf+8hMFmKVAHdabi8kQIcN7hmkDzLKqj
 fcApVSsQe0qi4C3DdPFp2pdNoqu45foCoo0QsNNWm70/yfGPT1hcb7eTAIn9JkgyuKagBYY4s
 CeBgjFGT8dDHA6LxEkwcL4AktIpw8bv3YcVDYDp9Jr0GSwvNY/hpx4y7YWz0dhCAvOg9u+Tal
 GbiaFB/Sp75AYs0gG0wSckVqtEI92jLziouWYtTH5rOHcjhxTTMPKLtVD2wjJdnVfFS5CYm0e
 pTIiMbfhVeQmC25eBOEoqVPqhydDd7xziFdMUfbw3jK/tBFwKETn79Edzpr2XZeRg1aqVoBJ2
 YBU8XaINYCv4rPainwBn/c1po37hya0Q7O1jXTkj5UaEZ2reB+pUBSrLcwxTzN0NEoUYkYL6U
 nZwRy0AyVnjfomkO9y0OuGHHeX4WBE4Ul0Dkc7Io0kyPYAMziBftRebgLG4WiitbYPv2anC4N
 7kdQojzCXlqmUSF+Vy18MlyDJxgWNHNWDvLZgrJXtBvSE5vo/n/3MYzSkolVq3Kxd4brUC1Gn
 +2FfYg==
Subject: [cocci] Using SmPL variants with more file formats?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 748
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/b555eaba-9cf8-860a-a06c-01302d59057a%40web.de>

Hello,

The semantic patch language (Coccinelle software) demonstrates various pos=
sibilities
for source code analyses and transformations.

* Did you notice that any more researchers and developers would get attrac=
ted by
=C2=A0 algorithms and parts of its technology?

* How will the chances evolve to increase the application also together wi=
th
=C2=A0 further file formats?

Regards,
Markus
