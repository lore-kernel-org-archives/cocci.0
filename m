Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2361C77B73
	for <cocci@archiver.kernel.org>; Thu, 27 Apr 2023 19:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=evf0LLCgh4/Ngf2O6YC2jWLIJrzGF1pwDCahLJjQntM=;
  b=Dl2VGZ2uH1CoZjRMesL9s6O4rX+4t15KWItmAY781JaCn5ewrq3nVcvJ
   KhdXi078VM/i6SD0qwwINuqvmKQ1CiaTGMuEDOV3cOlgF/vvafJHVnKRx
   3/GN70ieXuIWRdOVmLMs0nGP/bYij9q/D4O7mseJDT8Zcmjf9x4Jc8pqc
   E=;
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
X-IronPort-AV: E=Sophos;i="5.99,232,1677538800"; 
   d="scan'208";a="105294909"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Apr 2023 21:34:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 45397E0096; Thu, 27 Apr 2023 21:34:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id ABAB2E0094
	for <cocci@sympa.inria.fr>; Thu, 27 Apr 2023 21:34:38 +0200 (CEST)
IronPort-SDR: 644ace4d_aOryU4dgrZXGX4yWIkqoPYpbZVLR2EIITUb6k+9siks9HoL
 kq7PP9iJlOcnA+3sgaMM+PAecguouHoDJEbv+lA==
X-IPAS-Result: =?us-ascii?q?A0ErAABdzUpkh07ASNlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YIteFMvBAtGhFOIHYhpMYQwhy6HPoRnhVkUgSw+DwEDAQ1BAQIEAQEDBIR1C?=
 =?us-ascii?q?gKFPgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABA?=
 =?us-ascii?q?QEYCxcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESA?=
 =?us-ascii?q?kc+AQICASMdAQERJgEECwsODAIfBwICVwYNCAEBgnqCKAEDDiMHshSBMoEBg?=
 =?us-ascii?q?ggBAQacDR8sIlSBXgmBFC0BjGCDdnonD4FVRIE8DIJHMT6EDwESASGDW4Jnl?=
 =?us-ascii?q?k9FgTNygSeBMYEEAgkCEWuBEAhlOYE7QAINZAsOboFFgxcEAhQ0DgwXBVkEg?=
 =?us-ascii?q?QkHBggXJQQOAxkrHUACAQs7Oj01CQsfBkQCLoE0HwYEJAtYewYBJSSZDIFZm?=
 =?us-ascii?q?CUBrUY1B4IrgVaBWQyfDQYQAy+DagGTHw4GkiUuhzKQGqghgWM6bHAzGiSDN?=
 =?us-ascii?q?k8DGQ+OIBkeg26PSD80PQIHAQoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 iff/IYGng==
IronPort-Data: A9a23:nCTBi68zruS6PvJK4nWjDrUD2HqTJUtcMsCJ2f8bNWPcYEJGY0x3m
 jMXW2+GPP2PYTP3fdkiOdnkpB8E78LcydFjSgNo+H1EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f4nW8lWo4ow/jb8kg34K6t4GhwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE/P5nLmJxAZUh3ed3UWVnz
 cYDOjY0YUXW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV695B8+ZBfybv5kHjF/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUF9A/L/fJtuAA/yiRTiqTvLOTzWOaAH+9qzkSRu
 Enn4kDQV0Ry2Nu3kGfZrCv12IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku5Rs4ZN
 EEevCYjxUQvyKC1Zub2Vj+b50KchzkdW4pUOtUA8xOL86WBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvVONB/jFGGYS/ErObF9lteLQBEcT5bPUfoWCNfu4GLnW0lsv7YZvpOeJNZY/XwHizsh
 S+Hpm4yit3/bPLnNY3rrDgrYBr2/vAlqzLZAC2JBgpJCSskNeaYi3SAswSz0Bq5BN/xoqO9l
 HYFgdOCy+sFEIuAkieAKM1UQuHzuazdamaG3QIyd3XEy9hL0yHzFWy3yG4hTHqFzu5fJlcFn
 WeO5FMMtcY70IWCNP4sO9LZ5zsWIVjITIm5CKmNMLKik7AoOlbP/SdyaFSW0nylmUdErE3ME
 cfzTCpYNl5DUf4P5GPuGY81iOZ3rghjmz+7bc2kl3yPj+HEDFbLEuhtDbd7RrtkhE9yiF6Jq
 Ik32grj40k3bdASlQGNqtVNcgpafCRkbX00wuQOHtO+zsNdMDlJI5fsLXkJIuSJRowFyb+az
 WL3QUJC1lv0iFvOLAjAODgpa6riUdw75Tg3NDAldwTgkXUyQ5ed3IFGfbsOfJ4j6LNCy9xwR
 KI7YMmuOKlEZQnG3DU/VqPDirJeWi6lvi+0BBr9UgMDJ8ZhYyfr5u7behDe8XhSLyiv6uo7j
 b6S9iLaZpshHDZdLdvkR8+u63iTvnEtvv14cGWVA9tUeWTqqJNLLQ6ohNAJAsg8Ezfx7RrE6
 BSzHjEjuvjrn4851PLrlJK0hd6lPMUmF3ULAlSBy6i9MBfr21aKwKhCYb6uRi/cXmalw5eST
 7xZ4N+kOcJWgWsQlZR3Fotq6qcM59HPgbt+5SY8FVXpa2WbMJ9REkOk7+Ju6JIUnqR4vDGoU
 H2h4tNZYLWFGP30GW4reTYKUL6x6uE2qBLzs9IFeF739Q1mzoqhCE9yBSSBuAZZDblyMb4m/
 9sfhd4r21SBrSQuY/m7jXFy1mWTL3Y/fb0tmbMEDaTK1Ac66FFwTqbNKy3x4Z3VVdRoN3MuA
 z6LhZjtg6ZX6VrCfkESS1nM/7t5rrYftC9ayGQtIwyypePEofsszjh9zC8STDkJ/i5Y0ul2B
 HdnB3d1KYqK4T1sospJBEKoJC1sGzyb/RbX52YStWiEUXStaHPBHFc9NcmJ4kod1WBWJRpf3
 bOAzVfaQSTYR97w0gQySHxahaTaF/IpzTL7meejA8ihNLs5a2C8gqaROEw5myG+CsY13ED6t
 e1m+dhrUpLCNAkSnfwfK5Kb3rEuWhy7NDR8YfV+zpgoQ0DYWh+PgAarFW7gW/lwN8Tr8FC5A
 fNAPshgdQqz/wfQoyE5BZwjGa5Vnvko7uVTI7/AeDU0jJqCnBVUsbb71Cv3tEk0SfpAzOc/L
 YLwcWqZM2qy3HF7pU7EnPNmCEGZP+YWQRLa3f+n1ck0DLcBjb1cSl4z2b6KoHmlCgtr0BaKt
 gflZaWN7ehd5alzvonrSINvOh6VLI7taeG27wyDidRCQtfRO8PotQlOiF3GPRxTDIQBSeZMi
 rWBn97m7nzr5I9sfTjipKCAMK1V6eGZfuldaJv3JUYHuxqyYpbn5h9b9l2oLZBMrshm2fCmY
 AmGOfuALYtfH58XwXBOcCFRHioME6m9PO+quSq5qO/KERQHlxDOKNS873LycGVHbWkyNobjD
 hPv8eObjjyCQF+g2Ddfbx2nP3N5HLMnca4hasG3qjSSSGWl6r9HVn0OijJ4gQwnyFHdeCo53
 X4BbgfzflK+tckkCflH5pdqsER/4GlV2IENk4F0xzKyoy+3BigKIIzx9HnA5o58ykTP6X0zW
 N0BgKbOx8kwsfSovCgQOOjeYzo=
IronPort-HdrOrdr: A9a23:JvuNwqGeKxgNWFdmpLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:4grHbm7rqcLUcFkYSdssy0UdOONiTmXk63bQc0uRMVxyWrusRgrF
X-Talos-MUID: 9a23:L+XoSQa37Eve+uBTlWXwhi1cEuVS6f6ENxAPmIstmtSgHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,232,1677538800"; 
   d="scan'208";a="54560023"
X-MGA-submission: =?us-ascii?q?MDEgtcqsiYjq+eKd4BCUjuT8eeZ7P09IAxybIf?=
 =?us-ascii?q?jwKUQSSZC4bVsjKgn8izgLqmwawZS1UPjMkYM2Ezy7iZDlrwsINFTP/m?=
 =?us-ascii?q?TYV0hz/qheB9dyvH5m3gGcOIHKfyluwUKfd1miovue66zeDO6eV6T0Xj?=
 =?us-ascii?q?TjYcsAeMnSaZe8ke1df+CsTg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 21:34:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682624063; i=markus.elfring@web.de;
	bh=evf0LLCgh4/Ngf2O6YC2jWLIJrzGF1pwDCahLJjQntM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kMGl5Lt7EZt6UrqYVR2YLJIToHfcLnGvq0k4Amnvx0tMwXlnesWR02bU1pe47WyNj
	 cMsKKmJkGYmzrChlrfpnHD/dex9Ps6lSe2YyUXs/u4vkPBSuNnFot/99ouNwdQzNaP
	 LHTY9qFyJPz15TLV3w6Yf/ss3jrZxi2VRvUEnWRLgmXxApXIyqPS3KMhqFWaIWnu8j
	 eBD9711fxaAl8dPGmlGr9sBHlnFcbzTjluxBDku20yK87fA1ebfk8OYKSj/oFK2D0M
	 S+LVZ+WmyXPcOsymLHMnsnpa6pmTONJ0HHJqnMK9S+QuzWoBbInh1L3FHT7GhJBN6g
	 U6iQoY/JmHTGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mae3c-1qOPzh1laU-00cADq; Thu, 27
 Apr 2023 21:34:23 +0200
Message-ID: <14083012-2f19-3760-a840-d685fcedc15e@web.de>
Date: Thu, 27 Apr 2023 21:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To: Robert Foss <rfoss@kernel.org>
Cc: kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Allen Chen <allen.chen@ite.com.tw>, Andrzej Hajda <andrzej.hajda@intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Hermes Wu <hermes.wu@ite.com.tw>, Hsin-yi Wang <hsinyi@chromium.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <14636275-4d26-d639-5f6e-293fc6d1c4c6@web.de>
 <CAN6tsi7caOQZLLvbL7phMEtNvBLaWgJuHLkLo3YWdqQw7Vxnaw@mail.gmail.com>
 <6f758653-36c9-91a2-7bbc-278ae3f8ccee@web.de>
 <CAN6tsi4WBDOyzvXJ8vV=xJYay1JbBGo+UzZ+vudTBm5Fk5nB=A@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAN6tsi4WBDOyzvXJ8vV=xJYay1JbBGo+UzZ+vudTBm5Fk5nB=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ew/MhLanHGTxlVGzoVRSMOmlLHvXkCxwBu6IffK/fe+h0Ez/gSE
 rVv43dTa2d04iDBNY0dkPB4vL6SOAc0zVWm5KLKVs32rRE6sTZz4CzVhbgyOrNO/GgjyGkq
 QD4MG0H8NBv+GU3Zij7V2LAWaI9eJsAvgFTQaQZ0w6CMUbTOwDhW4hAoV8wBxV3PMct+ruR
 yCglZjcKV4B8hiA86keIA==
UI-OutboundReport: notjunk:1;M01:P0:wSj3m/EJPMw=;KMw51G0X6SFKIp9AUZ1JXUPDB/c
 1gVHZzGOSwbXajzbDKEFfyl9pJN5Oi830GfU/JKkgSKStO+Kb0PQYfYWP5nH/3RfmNN3HxLJf
 BAsDAJRDX8FwqMgoRmrv9WquSm1LRj4bQ2M6U5A8BcDgKZgdu55CdWLRmpgWocgNLM5fJQeXY
 I4sJtzeDs/7NcvdVjqXJI+ljmrUmAgGJrE0ph/ZgxlkdNOqCH3dqseLesS3xaa6zUaPxV5G6C
 qIVOeWgn2grSuw1/nmSAQ2TR5YRnj45VErYC41Rn+ujPsNKAriM9p145oif2fCNfLgJAcme7i
 ALGXauTjzia4eJUQ0npaGPz00m5CGHuPQAKsD/GnXhEdFLK0C/H6s348L9oNrd/aSKSIzvw9P
 kE/2b0ptMRlX1ulanIk4wuQin+Kq5ehT5wWY7KJu1Hg9SwCg1Q28ccaDCMKyS/iAbgVs3VLU3
 sYFYJAkBK6IjN7eOolPfKHrH28iqcK3YzvnCSBURHIUdBCi4qgqrwqc4Z6ssgOMRr3zRN89pH
 y1ZxEcZ4M42Ap1DekX/zFX7OK5DbGS4XaTZSaEQIEEJHiIkV/le8BenJZYQw7KqYuc20aFFWZ
 ZqziWsFk7BJmdV9UorJmYkT5gHwchzyCIU9d5L3AbIeYEzqjl17DFMIGc5ERozX+9rXQMZaEA
 BFpe1K83aqQrYtQuFmxs+FfQ4IJlZxVpW7QnFP3amy2/biueu7GucabF/vcufgyzVy2eBsa9J
 2OMKnEkTHAftJw/FwxueamoupD7I3BIF3T8Q2btNdrRtonYqRLjv2WRYO5iDmKD7P0396jqu6
 0TvK9cB2tl6PlElCoTv9tscxdzJ4shwx3nrSFlWVZjAP79uTBOjAESBnaa09xW2ybfWU3n/3A
 f2+111m0C/pGPGwAKI3poBbjBDcaYpsEmdwi64ScE74ELI3X+PYtnIJI0I+OVXqpldvtkiEM9
 xK29lg==
Subject: Re: [cocci] drm/bridge: it6505: Move a variable assignment behind a
 null pointer check in receive_timing_debugfs_show()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1132
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/14083012-2f19-3760-a840-d685fcedc15e%40web.de>

> Fix the email Sign-off email !=3D Sender email issue, resubmit and I'll
> be able to apply this.

You can pick the email from my tag =E2=80=9CSigned-off-by=E2=80=9D up also=
 directly
as an ordinary patch author email, can't you?

Regards,
Markus
