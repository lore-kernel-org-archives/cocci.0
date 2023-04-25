Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71890C77B61
	for <cocci@archiver.kernel.org>; Tue, 25 Apr 2023 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8bfz41NFqOMLyEMU3/iMzHFsfhiD3AnnDtGlJF9nEDk=;
  b=mcx1VtMLA9PAjMtNmnXojd9k5T7u1gDXK8uYmN+jAFwGkUyx+q64T5Fh
   gLZ193xH8DdVGi839gowink+M6f3k4Imq8wvsuRRIF4WGbU3mU2VWBPOQ
   Gnn8oiX9TF0UyI3YEnD6Ruhb13wTRK5RhmIjfyr5HC/sFwCZjxwsWDjC7
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
X-IronPort-AV: E=Sophos;i="5.99,225,1677538800"; 
   d="scan'208";a="104916259"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Apr 2023 16:16:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 29C67E0269; Tue, 25 Apr 2023 16:16:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3C43DE019E
	for <cocci@sympa.inria.fr>; Tue, 25 Apr 2023 16:16:06 +0200 (CEST)
IronPort-SDR: 6447e0a6_DCBo3tJp4pqGhSD/gtpXc+iqe6RjKw6caWj9MGjDYHsVr9/
 xmq4hn/1DsVfew/w2XW0X0sInDBGDQE3y/+j07A==
X-IPAS-Result: =?us-ascii?q?A0FAAACJ30dkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItdVYvBAtGhFORBjGEMI5shGeEA4FWgUA+DwEDAQ07BgECBAEBA?=
 =?us-ascii?q?wMBgguCdAKFPAIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTo+AQICASMdAQERJgEECwsODAIfB?=
 =?us-ascii?q?wICVwYBDAYCAQGCegGCJwEDDiMHDAawLYEygQGCCAEBBoFBAQMCDAJDmXUfL?=
 =?us-ascii?q?CJUgV4DBoEULQGMYD+DN3onD4FVRIE8glMxPoJiA4U6gmeVe0WBM3SBJ4Exg?=
 =?us-ascii?q?QQCCQIRa4EQCGU4gTtAAg1kCw5wgUVfRoFyBAIUNA4MFwVdJQQOAxkrHUACA?=
 =?us-ascii?q?Qs7Oj01BgMLHwZEAh8RgTQfBgQkC1p3CgYBJSSVN4IlNYE3AiIkpQygNzQHg?=
 =?us-ascii?q?iuBVoFZDIoNlQAGEy+XCQ4GkiUuhzKQGCCLRIFvmk2BagIxgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIAwNCRWDboELg1aKKAE+PzQCOwIHCwEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 z0B0iWYAyVdCa2FiQreCjJXTAunKj7nKqo0xH3A
IronPort-HdrOrdr: A9a23:mpdn3q9BQidK4HNbsHBuk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:YlDG42PQMNAGFu5DAyZ+8xcdIoMcdFL25mfUAHCHAH1tYejA
X-Talos-MUID: 9a23:9DwqdgsVbtN+SzuHa82njSoyL+Ju+6aVB0kVsZAP5cO+OD4pEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,225,1677538800"; 
   d="scan'208";a="104916254"
X-MGA-submission: =?us-ascii?q?MDHbp4vM3mb670SlMzfu9gymNRkw1LC9aW4Tsc?=
 =?us-ascii?q?00VI8oCUpnHYsjXN5X8IkE7otZDEgD5dcTvSeZDEPYsWMb3c5ZgNtn1H?=
 =?us-ascii?q?zrQ7xNLGAAMoOY4ZaPGwyiQGoqyUURWEr5unuoYeJk+sruS1hENa6XoF?=
 =?us-ascii?q?OKDZz/HVWfum8RTbCsGzAI4A=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 16:16:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682432154; i=markus.elfring@web.de;
	bh=8bfz41NFqOMLyEMU3/iMzHFsfhiD3AnnDtGlJF9nEDk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=rexEqEq+iqjiHhuYy6r/fSpGllNnvYrzapxIYEYtlA1F3KK16g2xRNgsRnxtGVGBY
	 Bxxz4Ibl+qa6q9lE9dDlaGP9teejIHouXgYQwFVDa5f5o9tijQKXm82hFBEGf0v8Hu
	 Rh/GOGjslf1Unwr4x6WccZJ4h1kEesBPiAUNnTLPGGFMyJLPEaBF543KQNgOkZRZSs
	 FaFfKf+2UA7i44RCSeeEMPsBxEnDalvZgSsemm1zY/U/3bCLqzsLGPdFf6eHk+p8I1
	 7Z3seT5+Fb17QgPPmINNdYlICfhcAPg+W8yvo1RaVPi2Iv3dWA4AiHs6kBypH4TywN
	 1LKrZLBPyjLVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPvg-1q9GoW3BeA-00ue5h; Tue, 25
 Apr 2023 16:15:54 +0200
Message-ID: <6f758653-36c9-91a2-7bbc-278ae3f8ccee@web.de>
Date: Tue, 25 Apr 2023 16:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-GB
To: Robert Foss <rfoss@kernel.org>, kernel-janitors@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Allen Chen <allen.chen@ite.com.tw>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Hermes Wu <hermes.wu@ite.com.tw>, Hsin-yi Wang <hsinyi@chromium.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <14636275-4d26-d639-5f6e-293fc6d1c4c6@web.de>
 <CAN6tsi7caOQZLLvbL7phMEtNvBLaWgJuHLkLo3YWdqQw7Vxnaw@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAN6tsi7caOQZLLvbL7phMEtNvBLaWgJuHLkLo3YWdqQw7Vxnaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:X09Tc0Fni7Q32vRjvx6Lp+ADugqqF6S21Vw8flGxT5heb7er/Li
 AFO/7m7Lzeui3BgqiJHd4CN+4l4HhbPcw9h+kP2UZLH/N14HDgbOXt2gsqx3sY982J8lcKW
 UwDDhadaphfDvadYPz1V00u2ysKo/roTAosogp1LMpjr5vXzhMvfaBcXEtQFjGy9nLB0S0d
 CfugamEsimiANerTueCDQ==
UI-OutboundReport: notjunk:1;M01:P0:bNQDFXSB7t4=;t6nlYVYwi47XzLp0Xmqi5UGkjUN
 /qm543QuMN3bW6NdsEBQStYh5aIT9LcblkafEy+GR34SpbL7TGKtRZcFiUEkIXsP47on6nDsS
 hYN7WT8h7r/pw3I+hSqyHj1aGNuqbFj2beLsUxohN9LTofH6+vy3h3397CaMTLYhdXvF26CQS
 kOTOqcM/3ZuaYF3Fuk5C3IUwDYd61QkQAhVaL69a237thickNdlwhY2r2i9zXLOSUJAp97k+I
 X7Hw/QvzJQnUBF1jd1SBEihCyfKlWNsRg3thImKirIPsDk/sD69RKUwbN3a9aQcrnKJb86oBI
 IwTk6tVvNysDnwWd5tclaHUAHZCz1+2G56G/YHvICX6OvrGLWdirLglYwJnOmllts2X4vo7Ow
 tcZ0bx3S3fbcMos6D3HsLfOA6fQH8UxfpZSdkPnZVoPXRV2juT6wZUrgwZ7L0Nmg0QUyMveoj
 LItSf7LK8t7wdHYB+4j98I+Io6ZjhDZdYr4wzf/kIZ6gMdZtBqTgmHiqamw/AUaS+28SAi/yG
 HBtNzs+SqdipMRFKNHb5hCwRoPOFaDN0ZIJhkOnCEujURIkgPBLEqBmbUiGkQrvJiVmnAytaw
 nVPotL7kc7/xhyg3DvaYz3wYUpsR5yVWpSu1r73qeo4DAEDvgSDtNN41npAzRRn7vyw0kNTgM
 KumiGf6Y9MWVR3e1XCJDUg6R8Zl3AGzl0H3KpeCFgLoBE64ODghTjbGfC5pIb5/LZ3A+klRAM
 eifCPS/umibEXbssnZ3GNTl8NNforeywv5QGw/CkC/KyGgz5o48barkakFuF37+Obvz8wloM/
 rPeK9omYA1F1RnvX8j1ds/wAAXhVCo3rm+QQ8qlR5T+Gd9QKZeA/H3RzCNFx7UgcWGg6ZT+Wg
 vdF4wjKKTf2Ym1Rx/Nx1qrc/9JoAVHrDTPM20vHiEE574EtwWfWAzVpeJekBYAYqSnTvRGewP
 2Ub4dg==
Subject: Re: [cocci] drm/bridge: it6505: Move a variable assignment behind a
 null pointer check in receive_timing_debugfs_show()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1131
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/6f758653-36c9-91a2-7bbc-278ae3f8ccee%40web.de>

> This patch seems to be a part of a series without being marked as such,

The mentioned patch affects only a single function implementation.


> this causes issues when importing this patch with maintainer tools
> like b4 which automatically pull in the entire series and not
> just the specific patch.

It is a pity that there are special technical difficulties.


> Either label the patch as being part of a series ( [PATCH 1/XX] ),

Further software modules were similarly affected.

See also:
Reconsidering pointer dereferences before null pointer checks (with SmPL)
https://lore.kernel.org/cocci/1a11455f-ab57-dce0-1677-6beb8492a257@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-04/msg00021.html


> or submit it separately.

I thought that I did that (in principle).

Regards,
Markus
