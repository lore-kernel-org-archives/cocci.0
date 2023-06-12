Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCC9C7EE2E
	for <cocci@archiver.kernel.org>; Mon, 12 Jun 2023 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=t7Z6klZ0RTJSZ456XKGKAFmHcwk7dJ3Yh/agibX4RnI=;
  b=JYUwzOK2Y7iVn6C6/ViZrDBJS+QPTzEWHNvJBZw6Z2go66lYm04KLrGp
   BAhkWyobWIjsB1zdZULDjZawZWE/GPGCxsfBfcdsFyLjCPcUPZAgt/KoO
   zwO3zAtPtyi1B5d59yqQ8EPYEBuJR3XfzItyxc7sXt5KF0vF87YOTh9ZS
   c=;
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
   d="scan'208";a="112438342"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2023 14:40:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 85D06E0CCE; Mon, 12 Jun 2023 14:40:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8E8AFE00BA
	for <cocci@sympa.inria.fr>; Mon, 12 Jun 2023 14:40:28 +0200 (CEST)
IronPort-SDR: 6487123a_lBGAPvjTvErEmLcmh633zbdh3OIOnhcKuC1F0vl2ujdWREl
 /pEjEi0iAYhys8rVHr1/c54cbpyM9EQ8Y8jAAjg==
X-IPAS-Result: =?us-ascii?q?A0ExAAD/EIdkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIudQNTMAQLRwOET4gdiTSENI51hGiEBIFWgUA+DwEDAQ09BAECB?=
 =?us-ascii?q?AEBAwSBTIJtRgKFdQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAUBAhABAQEjFwcOECeFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgINOj8BAgIBIx0BAREmAQQLCxoCJgICVwYBDAgBAYJ6AYInAQMOI?=
 =?us-ascii?q?wcNrkCBMoEBgggBAQacDh8sIlWBXwMGgRUtAY0ugzd6Jw+BVUSBPAyCeD6CS?=
 =?us-ascii?q?xcEGIFGg1uCZ4skDguCaIM0jCiBKG+BHoEifwIJAhFngQgIXoFxQAINUwsLY?=
 =?us-ascii?q?4EcUj2BRgICESkTFAVNex0DBwQCgQUQLwcEMgkVCQYJGBgXJwZRBy0kCRMVQ?=
 =?us-ascii?q?gSDWAqBDT8VDhGCWyQCBzZDGyYlBA4DGSsdQAIBC3A9NQYDCx8GJgEeAimBV?=
 =?us-ascii?q?zBYcAokJJ5aA4MNfD+BTZM/g0GreIIENQeCMIFbgV0MihOVCQYTL4QBjGuGK?=
 =?us-ascii?q?A4Gki0uhzmQLyCNOppdgWM6gVwzGiSDNk8DGQ+OIBkeg3CEYYpnPzQCAQELL?=
 =?us-ascii?q?AIHAQoBAQMJhUYBAYV+AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 OzyIkHNAyU=
IronPort-HdrOrdr: A9a23:LbDTs67EvcVfzzTLbgPXwBzXdLJyesId70hD6qm+c203TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNykesS+V2mmFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:eQ0mSGDJ3Kcrdnj6EyxXyWgzQJoESH/cwEWKO2vpNntRGYTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A/cADug3OL7JTEaeLOirphrx4DDUjzZnxAn8TnaU?=
 =?us-ascii?q?6sNTcdgczFz2UsHe5Tdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,236,1681164000"; 
   d="scan'208";a="58487338"
X-MGA-submission: =?us-ascii?q?MDH2wCq1uXJhiv6e6f6Hx/e76QotD9FstLGZ22?=
 =?us-ascii?q?GyxYJhjwX9wA9e5M/P4sfaoOLwvu/Iyn5QLmPzZdc8al0ctQldy8hlkD?=
 =?us-ascii?q?+S9Lfp/alurCP1Y0h7vwKLxGlHPNEYQ5w6ylw07C01CPEXAGiqvRzYgj?=
 =?us-ascii?q?wVVsvTQwfSgFS1XlsBJNb5/w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:40:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686573620; x=1687178420; i=markus.elfring@web.de;
 bh=t7Z6klZ0RTJSZ456XKGKAFmHcwk7dJ3Yh/agibX4RnI=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=qXCx9Dc1DNmeZzbp0aNSNf3/l9Y2e5YpYFOStj7nNqrSmFFSvbnmcQ33npu1oSZPghzgm1N
 6sbNzjjDrpbT7rXiwq4Onpncn/8i65zxDw112brvK9Fut9Ia0XRVu9QKltwZ8Fd5M7mVMAI7V
 uijetkJv9juRZbX7aGpBpxdH9HsyYrbYZET6DPOqwxq72qRFrdeh/yTUK2WrL+r9cvmbLxIe8
 /EPz9WKVa08GhaQTxXEmOUy8TICIlV5YsItmhmOZ0gB42RtRTwUrp/l85kxUUwyTQ/SoUlhyi
 4jq9K9IXjhryyEX8jf1tgXvFzdlwd5Swhr+MWTfcVJGkUOthYTQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8n46-1q2rn02BFu-015wb7; Mon, 12
 Jun 2023 14:40:20 +0200
Message-ID: <423a16a5-29e4-8608-9369-52da48527faa@web.de>
Date: Mon, 12 Jun 2023 14:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Lu Hongfei <luhongfei@vivo.com>, kernel-janitors@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, opensource.kernel@vivo.com
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20230601021726.34908-1-luhongfei@vivo.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230601021726.34908-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X9atwV8p+ILWWW56LJB0N/CxTqteUy7mVlLGYCfTWwfapA6p9/A
 TuQ/e1DzSkiD6DKdFvA0kkjSkB/frXItSChFuuhfZN+wdPgeXT2LRYHHrYj/Bthoyn/rlHY
 GuDyXCpo3oQ9mwq/4a7zaRrroEIJ0OE3Mcmbp2wFDjJJBWxRH/4GhmB+oamlMf4EEK+es92
 7XYHceZbF19fzqC6Tzdyw==
UI-OutboundReport: notjunk:1;M01:P0:ROCoxIWrTy8=;/1vfNYS2D52qKLFbk98PJR5DnDR
 tIY7jzZqTtm2ZwEZ/wLDr3wQpe1DjnYR2mEQSXoR651YPUlMoOjQBoTn+HhEGRWnS5v9mfadO
 yAPSc8uGWfGvhr7T0jPlZTwN3q6apYlV5AXNPXgigL64R9o5uTCEfWgoEwGPPW3+o88UrtUEf
 yyzFiTiH/x4O5Dzy1mNFYdJ5P2ZSCuNDztpp2FGfPhNvEMutlu7OlLsC8hdVhXwx7rnpaDh1t
 QkH5gOcYEhEMWXM1wiBWpzjXFRuX1Y/XST9wkIEHlCzsouKsKMbAPFY+b19BwuEIvpkPJkqRs
 XtcX48QE4mpF9TP3DQ0QeMIHFe77H5KmTFpBM32C57Z4kBtIzqHx+ZVRT2D2MdnzCjMLV0k1Y
 L1Bv7Td++ClYnai/aEhDnkOqF6HYVPXRBLofKNO9dpix6R1Qaq27O6OhtngzomyTpGiYY14pr
 gCB2VK+rw9CNWTgAYl33aO+g3Lm8bpxjcDc0kt3IMTA3ajPaEhTzkY+XoSbOKL9gIUwBFYAw/
 jTSNM+3eFkS8YvKOxu03bxjmW69yejJqkvPtjCSV1mDuzjYGqrcVrCSH30pXFLptz+TQFuR8v
 i4vKLX/I/oVNpz2N7USrktd+x8W6HTT8XfFyLomOyyB4duqL1ET0Ys7dWUWcKEgkIj1jOfc+w
 oSVec+7AXzr1S3Gazvn2ASWuoh53jh35c3XsWg6uKTR0v9P7KodOiE75jQBh94qInRoJa9zNw
 cHZ6Arbcda7ZaaKRzYq4du8LgNjGNtcky8QymeAbMqwkyt9ww+P/mgOjsO8CLypvojyOi4G0/
 NT/FaiuahcNXdFvoHwlw8Xbn2oHM4fWzD3rrorqVTnE6bEF+HL4nR+DHLmso0lJNd2KEc/Yg4
 IM8qdj7U8hKL/1Xnmw0e18Wd4A+AIDXYtZPwRHO1vJP6iiZv1Emi30+GZVisySJzVw6NLaQKv
 JnuG8w==
Subject: Re: [cocci] [PATCH v2] soc: qcom: pmic: Fix resource leaks in
 device_for_each_child_node() loops
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1176
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/423a16a5-29e4-8608-9369-52da48527faa%40web.de>

> The device_for_each_child_node loop in pmic_glink_altmode_probe should h=
ave
> fwnode_handle_put() before return which could avoid resource leaks.

Would it be more appropriate to use the wording =E2=80=9CFix resource leak=
s
in a device_for_each_child_node() loop=E2=80=9D instead of
=E2=80=9CFix resource leaks in device_for_each_child_node() loops=E2=80=9D=
 in the patch subject
because you would like to adjust source code from only a single loop in
this function implementation?

Would a wording like =E2=80=9CThe fwnode_handle_put() function should be c=
alled
in some error cases.=E2=80=9D be nicer for the change description?


> This patch could fix this bug.

Please replace the sentence by an imperative change suggestion.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4-rc6#n94

Regards,
Markus
