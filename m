Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EC4C7EE2E
	for <cocci@archiver.kernel.org>; Mon, 12 Jun 2023 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rpyV/JYssM73GtbINbzzLx6J++sVx4U0/++DzFBrzxc=;
  b=pOCetMXJl7b8ITUAiXYKuE6IM/ERQP56Lqns9v0QJUfT0vfnxSnJu1ij
   mgw+YwX39kHRjEnffZ+vhK0rVRQ17ZsDy7tw5YkFrHxNpBTinNPOJyiWn
   nQkmY7sVpBKFlH1rJXKs2HkjKxGu+uc/wCmog2DL4VW5g63/rzSCrGpVc
   4=;
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
X-IronPort-AV: E=Sophos;i="6.00,236,1681164000"; 
   d="scan'208";a="112506700"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2023 19:07:09 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0AB2CE0CCC; Mon, 12 Jun 2023 19:07:10 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9FEE8E00BA
	for <cocci@sympa.inria.fr>; Mon, 12 Jun 2023 19:07:03 +0200 (CEST)
IronPort-SDR: 648750b6_CeOMks+55nsnVsXkPFWbUmocRRKRyzTTb59Z94lPlJj+gy4
 VbEZNBjlgUsvsZ8unUBZzMRQ7ja2c3C544nrzzA==
X-IPAS-Result: =?us-ascii?q?A0FvAABwT4dkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYIudQNTMAQLRwOET5FRhDSOdYhsgVaBQD4PAQMBDT0EAQIEAQEDB?=
 =?us-ascii?q?IFMgm1GAoV1Ah0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAg06PwECAgEjHQEBESYBBAsLGgImAgJXBgEMCAEBgnoBgicBAw4jBw2uX?=
 =?us-ascii?q?IEygQGCCAEBBpwOHywiVYFfAwaBFS0BjS6DN3onD4FVRIE8gwQ+gksXBBiFI?=
 =?us-ascii?q?YJniyQOC4JogzSMOIEob4EegSJ/AgkCEWeBCAhegXFAAg1TCwtjgRxSPYFGA?=
 =?us-ascii?q?gIRKRMUBU17HQMHBAKBBRAvBwQyCRUJBgkYGBcnBlEHLSQJExVCBINYCoENP?=
 =?us-ascii?q?xUOEYJbJAIHNkMbRSUEDgMZKx1AAgELcD01BgMLHwYmAR4CKYFXMFhwCiQkn?=
 =?us-ascii?q?nQDgw2BO4FNkz+QaKBVNQeCMIFbgV0MihOVCQYTL4NuARKMa4YoDgaSLS6HO?=
 =?us-ascii?q?ZAvII06ml2BagEygVwzGiSDNk8DGQ+OIBmEDoRhiigBPj80AgEBCywCBwsBA?=
 =?us-ascii?q?QMJhUYBAYV+AQE?=
IronPort-PHdr: A9a23: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
 qnarEkmjajbNOo=
IronPort-Data: A9a23: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
 RHyN0Ac5iSM/6w=
IronPort-HdrOrdr: A9a23:9p4PU69eJuLZGUmCZT5uk+AMI+orL9Y04lQ7vn2ZhyYlEfBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIK6PoSjjPZL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3APwnX62lc0Qu9ITObfN06r7dP4DrXOVjzwS7bB1W?=
 =?us-ascii?q?9MzlOQaGQTlSL9qJfyfM7zg=3D=3D?=
X-Talos-MUID: 9a23:9mrHZglyKAmlx+x3pORbdnolFMg054OPL3oLmJont46nGXJcASeC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,236,1681164000"; 
   d="scan'208";a="58521398"
X-MGA-submission: =?us-ascii?q?MDGhkAbd8Y23eAd/vARFLtZ5iy72qaBgMxj5bP?=
 =?us-ascii?q?33sqSHMy4mU3xDUTWTokhsGt6rCjQv1DKyHJzS+S3kKWD0QgFY9qOZWI?=
 =?us-ascii?q?vHPfYYwB5Xa73IFyHxf4ycS7JbM2m3pi7sH0RdvXY2cc1LnEtjCFfVGk?=
 =?us-ascii?q?Gt4ZcBcICPhoSVbGYDmCdfiw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 19:07:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686589596; x=1687194396; i=markus.elfring@web.de;
 bh=rpyV/JYssM73GtbINbzzLx6J++sVx4U0/++DzFBrzxc=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=DcF0KEBMG+S+8myAjFDGGjSaQdTvD0grmJIe+zCLcDVPwTjTBV7EJ3EI0omPNdUAsK6qaxU
 qiH08/8PUAKFMmxJEFSQFSTlIFR9Lxry6lJSQmN+7whqJ7PIe6GHAyMDPnH7oDHSaVCaA79Dq
 u/brjj0OOBgOy1NznWyIfbV83ntsmJIVh6bFQ3IpvuG+GJ4q+spDcrkV0AH0gAskfIv64Fgvq
 kUcsYI3pP/+sw9ySYXAT2XIx9vxxUuHQfAYtQ7B+depK47abd2EysLxCjugLIH6cGdTQxz3gp
 HVeBS/qAtwP3A0z4OLqW9kJdClxocNpas5/0zk/df/1/BdTh0l+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB49-1qdEJp2kz3-00V2MO; Mon, 12
 Jun 2023 19:06:36 +0200
Message-ID: <0b0058e2-22f7-a32c-5c19-236d31391480@web.de>
Date: Mon, 12 Jun 2023 19:06:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Lu Hongfei <luhongfei@vivo.com>, kernel-janitors@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, opensource.kernel@vivo.com,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Arnd Bergmann <arnd@arndb.de>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Moudy Ho
 <moudy.ho@mediatek.com>, Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
 Sun Ke <sunke32@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230530094541.23396-1-luhongfei@vivo.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230530094541.23396-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Ruroc8CIE+JtrTDOvKRG0cpRV3LH0KYLH5tAkDz/RkCui5Cujs9
 M34smmQXOG2mZOr2L+4v3uGHYdOQC/Z7tToVxm9Z0/Z48o1HGCOB/nsIMCWl9jske3sHPV3
 CgsXcPkCThVPn2pZWaikdiL3UzO+FrDu/l7tZQXbtjALrCTYNTcM+GShmRELTgr2r9uqLww
 m7aYeVzUqYzQliycY/O7g==
UI-OutboundReport: notjunk:1;M01:P0:Oxxp+12H7BU=;AOFeQmX931wjAXbRM5jLy9dYEpx
 ES2R6SY52tuYw52+LizInYpSdVK+swOnZC8LvwypTC8hfj/uOwQ5EfvEju3OZ0jNGv+/B0M7Y
 DZrMIQS4HOih/dh1YmccDfKVecVmgMnBTysxFf1kPx1TWDo+uzavrNPKV35HrCpytJA41uC8I
 r45azSc+GbquH8Xibli1A7ZtHzKBB95B8SvD/ICXk2YwK+eJPPoYW5ajpLcbyp5buYiIf09Tu
 4rb6i9+YodKttoNqJF6F2YUjAzoUVuuxe+ovrM5P6zV6V8C9fNxeJBSyQmo7dp1JfFN0/68ZX
 +JxcXC9zbgR0GkcKn85zFJa4S2709S2wKQKDsJTHLhtEosth74K0NjG+6kyjhwxjAQkOk6A8q
 4J6WhTy5igs1ZRjUGMa8c7trrBy0kx4cLDM2PT/fBlzHJeKjrtrZU8/pba68bOSNkRiOg+Vw8
 Arh3mxIKgvmBL5bWDVciFUi8DKdt6y1pTO/47r0MRoVRFuLXsXJygHxTGURolFzs1KSN0yKrX
 KaKUDx4+Ec5H5+NfxTehBLhQxtpliPEG+GOBP5L54zvNwASoj311Az/57SmNv3NnpEUuDKcOk
 zcZqXFz3I13NTF/o+SkSZe7F6jBhzF/xzFoiOREw2Y7XkOs5m6T9wfS3vADYRkcXr6UxjGrSX
 WRxsldMR+3rKnIdvG7tOH2K2IGWycWEuVf1sS6i27xavyBDLq9lpa2Oo6OxTOM0zWaa2WFn6y
 LKh3Mm11aXZg1dFDJsQN/oxUqaOG+A0ZazSa2PGDShFfkvG+1DyFj9bnVew9I9gjvGN4VYeMa
 WAnAwEFIuP7cLLO62/v0YNqhkRlufFWdXq7PwVzh9JhOM3NofsQcgBKAeOYvjNM+XV+vKcucB
 dzICpXxy8pwyiwXc5Coc0//NjMCUMDoqKNLxQQo8eSDFsmKSPTMeOm5q3pxdQ0BUPiNIBAxOK
 61bD1g==
Subject: Re: [cocci] [PATCH] media: platform: mtk-mdp3: Fix resource leaks
 in mdp_comp_config()?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1179
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/0b0058e2-22f7-a32c-5c19-236d31391480%40web.de>

I would find an other patch subject more appropriate.


> for_each_child_of_node should have of_node_put() avoid resource leaks.

Please replace this sentence by an imperative change suggestion.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4-rc6#n94

Regards,
Markus
