Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBF5C7EE2E
	for <cocci@archiver.kernel.org>; Mon, 12 Jun 2023 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FUtXAHbDBT7UW9+WkziAxljJpEvPxXc4L9n4bVAZmPk=;
  b=utmrlu5NKx7wET4pRXGtijQ4DI9NhWEa78synlXhXwsxv0y5MpmnHF8u
   SKIr2iQBUhvMMJOf9SFEa5QXNAnIa3qmP3QjPIPRoMlOZ3cKZCwax5gnf
   EKS4CFDaaN29RP8gV94wnxyF2c+QUBel8r9slhexyH/TFuuDSQRjnmdIY
   o=;
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
   d="scan'208";a="112498260"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2023 18:03:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 82608E0CCC; Mon, 12 Jun 2023 18:03:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DC5B6E0AF1
	for <cocci@sympa.inria.fr>; Mon, 12 Jun 2023 18:03:07 +0200 (CEST)
IronPort-SDR: 648741bb_PYn7bqO33bcoq5VUhQmkhi7KdEJYH1x+zxNtYsf0Zmt0l+9
 iysG4HnwJKeMSjBlKp04HV2Z++pYlNb8KySLFsg==
X-IPAS-Result: =?us-ascii?q?A0FyAAD6P4dkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYIueFMwBAtHhFKRUYQ0hzCHRYRohASBVoFAPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ4gRSDMwKFdQIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEjFwcOECeFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHPwECAgEdBgQZAQERJgEECwsaAiYCAlcGAQwIAQGCeoIoAQMOIweuT?=
 =?us-ascii?q?38zgQGCCAEBBpwOHywiVYFfCYEVLQGNLoQxJw+BVUSBPAyCeD6ERINbgmeJE?=
 =?us-ascii?q?4USj2SBKG+BHoEifwIJAhFngQgIXoFxQAINUwsLY4EcUj2BRgICESkTFAVNe?=
 =?us-ascii?q?x0DBwQCgQUQLwcEMgkVCQYJGBgXJwZRBy0kCRMVQgSDWAqBDT8VDhGCWyQCB?=
 =?us-ascii?q?zZDGzslBA4DGSsdQAIBC3A9NQYDCx8GJgEeAimBVzBYcAokJKEMcoFEPZRss?=
 =?us-ascii?q?Rc1B4IwgVuBXQyfHAYTL5cUDgaSLS6HOZAvIKgXgWoFLoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iAZHoNwjwkBPj80OwIHAQoBAQMJhUYBAYV+AQE?=
IronPort-PHdr: A9a23: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
 SgLbEeeEUwinuL5//UhMM3fNUdKYsAU+HWBJU6z
IronPort-Data: A9a23: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
 RHyN0Ac5iSM/6w=
IronPort-HdrOrdr: A9a23:5F3JuqAgvyCxv2HlHel455DYdb4zR+YMi2TDGXoBLiC9Afbo8v
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO0s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEJSWY+eAb2SS4/yb3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:hDW8nGCzVyRrDiP6EzNhq0IuA8oCTnP+kymPJWSiUnpvC4TAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AepLzsg04DcXE2/3N5syVPPupVDUj4J+kL1gcmo0?=
 =?us-ascii?q?9isCfKzN8AijEhRDpe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,236,1681164000"; 
   d="scan'208";a="58516115"
X-MGA-submission: =?us-ascii?q?MDEl5FimmshTbQ2DScyNOZPf9++oKA96DYs+hZ?=
 =?us-ascii?q?EAmpIA39rwb0NoMAc5WBIkyKrvIFGrhKjzKWgYWt5f927ttLT3owKD3I?=
 =?us-ascii?q?WlPbWVmtSAM4Zu3jIuBQs8BtRJNFVumdRtBjaJRxoIbGP9cwZZRMXuGG?=
 =?us-ascii?q?8W4AdwHipLbeqm86cKJ5InVw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 18:03:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686585752; x=1687190552; i=markus.elfring@web.de;
 bh=D2y3Sud6CfoHWYer8m/17aJkr/DLWNiAYU2COMA5w0U=;
 h=X-UI-Sender-Class:Date:To:References:Subject:From:Cc:In-Reply-To;
 b=DhQDmmcmXFCIk6SxhlKYaH0OsaSffmxYMdI19pQVo4ksimpsKL/L+cQGns76an/sNFAAxZu
 neTHNHM8k2NJNBDtQz1/cb7QhuruPy+OlaiBCch+P5olhcA25kQChk0pd0aWCvpyY/KcL8iga
 QO2JN6XK2P8x2Ztg3F2Zv8phBgAXxnASB1UYvTVkEWAZsvNO5DLDAU7jQPBb1CQq/7Fqu4EaT
 06sglkw9zKbkGGjafJ5DyZ9ec7n+s7da7NelSdZWeFKEEDZr63/XvnwcLE4YY5xIQSNkjkFf5
 df02Xy1Nh905N4wU6ekvLpeQ2X2QmBaBwknxjEzl9240N8fvFvFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MmQcf-1piEor0rJp-00i0iW; Mon, 12
 Jun 2023 18:02:32 +0200
Message-ID: <fbbb84c3-f3a9-1761-e5c0-227fcfce0a63@web.de>
Date: Mon, 12 Jun 2023 18:02:27 +0200
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
 <moudy.ho@mediatek.com>, Sun Ke <sunke32@huawei.com>
References: <20230530101724.31412-1-luhongfei@vivo.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
In-Reply-To: <20230530101724.31412-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zg+3HTJ6MQcWA0or0u3MIHtcb4jkdAN1mdyQdG6Zhl7w5IjLvMU
 XfsTthbg/VOAg0kJzr1mURfiQNrQBRwoS62uu/zTxwEgJQWn8uraSTQTByI7oQzkvDVfJIb
 7goAKBWYrADo0cKUoKONEaknTkZElJVNrGOTmbzD4SWK6xwjwMgnmBObkPbD8/sHpqCBpmN
 9FyL23s3oxkgx0AQge8sQ==
UI-OutboundReport: notjunk:1;M01:P0:OHPynQoPObA=;4cQyXJCqdgCC9teMXT2RhWyK1kx
 AVX6JVjYulx9AoEWYg4DnDYKzwSnmaqEe2orCixdWdZbw+y6g9i/RHH7iGr4+LdcSKhO/sqTu
 sjy9QqI6Ar4Yl1DZUDkQsZo5SGUxnsnoYovvH0YIoIYUK0AIpsBu6s1m54ixB5gESDwD8wMO1
 IAsX7fmia0kI+6XOrETVFl01JxUyMegfJw/OlVvcWM8FWDWhZnxA0U/74Qvxl7OYRDq86B8ft
 rkQxtAbNqiWGSQNwP6cGQx+B3HE2dGWq6AelmCyjSEmIiTjLf3+Qfj5U4SmV9d1XimEm0Yjrv
 bHWZB6m24GH9trc6rZRgAtUyC4IXYJv8HyEsV6JHAjCDFryNrUKQd4O8CxErjBqb+VJD0w60v
 TfSv5Rn1ao70CjRcKmOjaqVb5nA9u/Cx5ojZqkj6ygYJd7L5tSlr3/VQah6x16lYNzRxQFr4u
 8VVq8PKR/gcJMH9wZ/R8ipfBtuPXLZqJnSYKG6U6LrPIrRepTqp9IwU6y2vyTPhcuER0+9q3I
 xfshSNmI/QjBvlm3ePTuGGGDyuMrmovkRcc/Ax4VywyEtcB02Y0BwtgKhDBkm+hf4l1VxDrIE
 VR6uMsjKWuYCSA/ateMKAXnurZFSLYshCuWSgvwSvyz7gckca8Ikou9h99rbMPu5ovwuMt5IW
 53bdfIfUd7XRi9v9oIMzzv/qenUmR5gF+9wzniVSMnSPbOuzdb4lI6ALcVm2a6mzsb7XYDWuw
 mtkg5AMr3Euq2cUefOAZf/zxYkcgiakqdPI8HK+k46Zm3BLWWXrrSaAMX6TuZwKY9g5xXIp0c
 yHhMvKk6fOaoG7XugTPcA317HGzT/k8N+0sgfGUyLYdH9YKIOfqmIQHhqFWK2Dk+pWotzFqvc
 Z5zHTYnUAYRxK4uvNIfgPvKWMuZsX+1SqriyimeGxECXaJP7VA1enGiZUuxd7imQa2livqSzV
 KxlJKoL+SoI0xuNMxgXBmH4Y5tE=
Subject: Re: [cocci] [PATCH] media: platform: mtk-mdp3: Fix resource leaks
 in mdp_get_subsys_id()?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1178
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/fbbb84c3-f3a9-1761-e5c0-227fcfce0a63%40web.de>

I would find an other patch subject more appropriate.


> Use put_device to release the object get through of_find_device_by_node,
> avoiding resource leaks.

How do you think about a wording variant for the change description
like the following?

* Add a put_device() call for the release of the object
  which was determined by a of_find_device_by_node() call.

* Use an additional label.

* Increase the usage of the variable =E2=80=9Cret=E2=80=9D.


> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> @@ -892,11 +892,13 @@ static int mdp_get_subsys_id(struct mdp_dev *mdp, =
struct device *dev,
>  	ret =3D cmdq_dev_get_client_reg(&comp_pdev->dev, &cmdq_reg, index);
>  	if (ret !=3D 0) {
>  		dev_err(&comp_pdev->dev, "cmdq_dev_get_subsys fail!\n");
> +		put_device(&comp_pdev->dev);
>  		return -EINVAL;
>  	}
>
>  	comp->subsys_id =3D cmdq_reg.subsys;
>  	dev_dbg(&comp_pdev->dev, "subsys id=3D%d\n", cmdq_reg.subsys);
> +	put_device(&comp_pdev->dev);
>
>  	return 0;
>  }

How will the chances evolve to integrate the following change variant?

 	ret =3D cmdq_dev_get_client_reg(&comp_pdev->dev, &cmdq_reg, index);
 	if (ret !=3D 0) {
 		dev_err(&comp_pdev->dev, "cmdq_dev_get_subsys fail!\n");
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto put_device;
 	}

 	comp->subsys_id =3D cmdq_reg.subsys;
 	dev_dbg(&comp_pdev->dev, "subsys id=3D%d\n", cmdq_reg.subsys);
+put_device:
+	put_device(&comp_pdev->dev);
-
-	return 0;
+	return ret;
 }


Regards,
Markus
