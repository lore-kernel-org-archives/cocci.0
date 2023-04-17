Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9303C77B70
	for <cocci@archiver.kernel.org>; Mon, 17 Apr 2023 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=K0VVQ1oOIled6zN1DSz3U6uSBsEMr/SWv+TSpNqCZgk=;
  b=FDgrxJzX5Xvx5aUlJNahjXIOorXMi+X5NIyM2WwdJfP+fkF/RAZf8jyp
   WgHzC2PvHERefRaWVVlphqFF37qu3FMVrtCZb+Fs7ZmctAnWub+hOEIXx
   w2hnbvDfkuziVync/krma877chSWlVrnfXAXwm++klguYjszr8o7fh7Kh
   A=;
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
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="103421850"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Apr 2023 14:40:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4693AE033A; Mon, 17 Apr 2023 14:40:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 881A7E00A8
	for <cocci@sympa.inria.fr>; Mon, 17 Apr 2023 14:40:33 +0200 (CEST)
IronPort-SDR: 643d3e40_S/E8a5r5SuCzuOTuCxaHN/Pu9f1w8JoDNvZea91AyXyB2LT
 vL2Df+L16L2hJbFIkvlFWgO4nCjHvy6tVyK6Qpw==
X-IPAS-Result: =?us-ascii?q?A0EpAADfPD1khwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHohkMYQwhy6HPoRnhAOBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4hEcChTwCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHPgMDIx0BAREmAQ8ZBgYCJgICVwYBDAgBAYJ6gigBAzEHrUSBM?=
 =?us-ascii?q?oEBgggBAQacCx8sIlSBXgmBFC0BjQqDNnonD4FVRIE8g0KEC4QUgmeaVoE0d?=
 =?us-ascii?q?oEgDoE8gQQCCQIRa4EQCGqBeUACDWQLDm+BSWNMgXsEAhREDh0lBA4DGSsdQ?=
 =?us-ascii?q?AIBCzs6PzUGAwsgBlZrAgkjERMFAwsVKkcECDgGGzQRAggPEg8sRAxCNzMTB?=
 =?us-ascii?q?lwBKQsOEQNOgUcEgQmBAQYBJiSfHwGBDsY0NAeCK4FWgVkMnw0GEy+DagESk?=
 =?us-ascii?q?wwOBpIlLocykBcggi6gMIUhgWM6gVwzGiSDNk8DGQ+OIBkeg26PCQE+PzQ9A?=
 =?us-ascii?q?gcLAQEDCYVGAQGDJIJZAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:AJ4k5KgrXvoszaFAXY3eZwJm2nBQXg4ji2hC6mlwRA09TyVXrb
 HKoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykfsS+Q2mmF+rgbsbu62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:b98GGWCFLxANHtf6Eyo/2GQoCO0dSELQ43H8cxexVEF5eITAHA==
X-Talos-MUID: 9a23:PkVRzwoKPSvuEBA2bqAez25fGf5v5f+pMlAMtqk5tdfVNwdpAzjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="53552727"
X-MGA-submission: =?us-ascii?q?MDG2CDi+gMw9iDgMJfxfcriglw+oxhJYEp10mV?=
 =?us-ascii?q?MbxH8VJWCj33szIrffYPYy4jnAuyBahCVKYD4zExZjLFs7XduOEGtEnX?=
 =?us-ascii?q?b5rU00cfRx+DveAbLkc0DMcF6yRt3prYVLXnq3T0YmJAqCmlKMv7dfC9?=
 =?us-ascii?q?Pl/0aZImg2KrNP7KRtaUJMGw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 14:40:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681735212; i=markus.elfring@web.de;
	bh=jxgSzj1XPt9cjlz5oKKnRxGu8WXDdOvReKI9ZPhLKGA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=U/FeB7S2B2jKF58m9DDJyeqFi3ueD6voK4QChtE+MSUMKAiFhF/HCQge9mWw7gRmU
	 0HTQCLACh/CmTKqMc2WUmYYz63tAEnswMCkE6HYVx0bY95dYZl4emzZdIhEgB/GN6l
	 1fh3PAow1GoszRkJOSPlDEVXGgpKVK+u5SEmMG4QMW0v/5Ao4iD5uEF5TswROsl4VK
	 Uq/jYbsPd18dCFOVON0FZpBCXkGOjvvEv2KBD5lYUDQzJcsIend0Fv5QarXUSzUIHr
	 G/mQngq7bVN4lIOQFhFdW0nvYdsvzfVjQXqDnY+SDjWI6mLZiJQZx0DCyFPULNhjM9
	 tKhDXFksnoIqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSBG-1psFVy216E-00WUDV; Mon, 17
 Apr 2023 14:40:12 +0200
Message-ID: <1d945069-00d3-7d9e-b783-96c368ff114b@web.de>
Date: Mon, 17 Apr 2023 14:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel-janitors@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Guo Zhengkui <guozhengkui@vivo.com>, Haowen Bai <baihaowen@meizu.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mingjia Zhang <mingjia.zhang@mediatek.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <b98dcc94-13f3-a6cb-f5bd-f1f8644d87d1@web.de>
 <0341924c-7f0a-28aa-eeae-f7de69ab36d8@xs4all.nl>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0341924c-7f0a-28aa-eeae-f7de69ab36d8@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H125JCFVl/UByHBydIuIg1aOV6MBfsnUl4d+g3QbdovsYO3Cn03
 86q9GVUovq/NqWKre/ZiNbcjSstVhY8NwL6RipSrGfAd9EGMojg1A8vP2yBLXJLedh/bxDv
 LDLBytleb4JexZj+TcpJH6XCxeTofHquafu5h5O+qTsA/Ehtn4AY7sV60llxRb/2dKHoEcu
 +cJNBXleQUrH4DX/zyxvw==
UI-OutboundReport: notjunk:1;M01:P0:E5AoUfoBt90=;Fpq8OEDtf4Vj94aUeerB881ibtf
 /G8LL03f8T1cgxKXBE19EZU+GtrLL/r63P6rVbLADL1byqtUWqVV7cTz2zT2OdMob4Ndgkq6S
 W9v1OnZprcs/uXxgIZoKUpCZySkVruzsjLsBQ6mDsksSEySrWTldmuwsGgSx1b1MxBCRtUNe+
 8SFI8wYpzHePkcShTOHp1qDBXyxBEc+JOiS7NRXhxBRDtDZbs7tZ7oMZvJtbSxrRHyJYkUsX7
 w5Oo5Rypb6FhjTDPtJF4qIlt7kkgzLTWL6LN8JjF1EvOHIMXW8uwQ12novPGtM2Bl7+oh8P/o
 vME7HqZ1zJJ6uyFaLUNpJj+zgv8bhDum04OSZDTroLcRb+m1b0NpyaEJfXVs4/jC9cu1wNhcL
 XYA4BkAAr839x3rp84vIOn+iDEKrCQHXuLT/EzRxKYAWu3GtBIALbDf16uFfqF7K/rq9v1SCq
 q/XKxfjunGCJWjcD44l3gKtNgkDogGIr9SLaQHYQc4zps9iGCXREpnhYvY0uG0WVdktu3UPwy
 Wk6/K2WzstPf8KpIy+OOOIPvEpZoUQgD3tmUHveRNivJYs3cOOQPD+zY7gWKg6pdy3VUP6yVH
 rjwVMVGeto6+Rf8+dBRg1ADm5oVd+gRJn4lGhkw4ldxfQjhwPGCs2rSCWDRIjkAb7K7hCRJ1v
 5Ln7TxErw+I/SM9ukqvTnMcHs9cErWHfQVySHHo6cLTSlOe3BqvvVXjPf+entSLndl13BMd1H
 ugSILXPO8jpjXQnPBqaL8FbuGbmKYIZrDhHnfoufTRriym106AXiZAnrQnlvSjM8/n0q+3AU5
 QsN0/toTNhMbvfz56r34bwIvso+/CKPrclwEZJyIukQDd9RzbolDa6RkF2Hac7jtyA/28nxT3
 XRcH5UFjtA0QfBGfsxQcfLXj+oO6ddMj04vhReBJeD1k81EazjKDNviSO
Subject: [cocci] [PATCH 0/2] media: mediatek: vcodec: Adjustments for
 vdec_vp9_slice_single_decode()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1073
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/1d945069-00d3-7d9e-b783-96c368ff114b%40web.de>

Date: Mon, 17 Apr 2023 14:32:14 +0200

The deletion of an if statement was requested by Hans Verkuil.
This update triggered another change possibility.

Markus Elfring (2):
  Delete null pointer checks
  Move variable assignments behind null pointer checks

 .../mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c        | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

=2D-
2.40.0

