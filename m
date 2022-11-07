Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B8EC4332F
	for <cocci@archiver.kernel.org>; Mon,  7 Nov 2022 19:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dG7orLH5ssoW1+6oT0mmqSWnTq4N3yjVzoQRJEouHo8=;
  b=he+of6Ay3xcwVUQuIot1vfG8Kphh48VVcTfbo6c9XOeWGsNkYfsrqoFb
   wAznrZy6YnoBgN0dEyacVKBbHZQwRVb4y670nMBy5RyBh6q4pD8zqbhAh
   KqkqnsH9J3+oSFjGWzuXTeu0o3nB7hr8MAI83XGcNxgmjkDbYM15r7nAC
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,145,1665439200"; 
   d="scan'208";a="77095916"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2022 20:00:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ABDC0E0157; Mon,  7 Nov 2022 20:00:57 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9D552E0157
	for <cocci@sympa.inria.fr>; Mon,  7 Nov 2022 20:00:56 +0100 (CET)
IronPort-SDR: 636955e7_c8I5Kjpj+xf40ZwGxe/ZJIqGkrzyyrVB6Jc7MKDWfE9PKST
 GtE2UNQECU4lXiUqTBAgNUrZWZXeOtjUxXdJfAw==
X-IPAS-Result: =?us-ascii?q?A0BYBwCNVGljhwMP49RaHQEBAQEJARIBBQUBQIFPgi2BB?=
 =?us-ascii?q?VMuBAtFhE6QbAgphCmHHocvhF6HVQ8BAwENQQECBAEBg3KBEwKEeAIdBwEEN?=
 =?us-ascii?q?BMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBGQkXBw4QBSKFa?=
 =?us-ascii?q?A2CNSkBg2QBAgIBIx0BAREmAQQLCxoCHwcCAlcGAQwIAQGCeYJuAQMNIweqF?=
 =?us-ascii?q?oEygQGCCAEBBpwGHywiU4FeCYEULIxihCcnEIFVRIEVJwyCdz6ERINXgmeOf?=
 =?us-ascii?q?YgfJgQOAxkrHUACAQs7MgMKShsxJw4JHxwKBBcNBQYSAyBuBQo3DygvZyscG?=
 =?us-ascii?q?weBDCooFQMEBAMCBhMDIgINKTEUBCkSDSsnbwkCAyJlBQMDBCgsAwkhHwcWE?=
 =?us-ascii?q?SQ8B1c6AQQDAhAiOgYDCQMCIhNEcwIvERUFAw0XJQgFTgQIOQUGUxICChEDE?=
 =?us-ascii?q?g8GJkcOSj45FgYnRAEzDg4UA16BbQQ1ap5Hwmg0B4IegUyBTQyeZAYTLpZtD?=
 =?us-ascii?q?gaSFC2HHI9oIKdXgXkjgVszGiSDNk8DGQ+OIBkeg26KLEA0OwIHAQoBAQMJh?=
 =?us-ascii?q?UcBAYUdAQE?=
IronPort-PHdr: A9a23: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
 chXIle+fEM4HLUWBxY9dOE=
IronPort-Data: A9a23:CAvBAqB4pvPkcxVW/w3nw5YqxClBgxIJ4kV8jS/XYbTApGkh3jMDy
 GpMXjiCafyMZGXxcogjOoSw80IFusPVm99mOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6jclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/ouOZjdJ5xYuajhOsvvb90s11BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0HgkmVZCq9oMrLlCuku3N1GHDeUfq7Pg3F1MOJ9ISoud4VDQmG
 fwwcFjhbziGgP+qhq22QK9gi6zPLuGxZdlZ4Cs/i2iES61OrZPrG80m4fd91S0zm9sIMPLQf
 csfZhJwYR6GbxAn1lI/U8Nnx7323CeXnztwjwupv6sK703p6SdVibzmDdWLaIyBWpAA9qqfj
 jubozqgW09y2Mak4T6M7XuogsfdnCbxQotUFbui9/csjkf77mcUAxYXfUCqpOGwzE+4QdNWb
 UIOkhfCtoA381G3CMbwVVu0rRZooyLwRfJBMMxk8y2IwJbSzAvAHXo8VGFLMN0p4ZpeqSMR6
 neFmNbgBDpKubKTSG6A+rr8kd9UEXdMRYPlTXBdJTbp8+UPs6lv1k2UE4cL/Lqdy4KuSGCon
 1hmuQBj3+17sCId60msEbkraRqKq4eBfwkv5W07tUr8tlshP+ZJi6SO5EeT3PFaL+6korSpu
 X8Zh46B4epIAZzleM2xrAclTejBCxWtaWy0bbtT838JqWzFF5mLI9g43d2GDB01WvvogBewC
 KMphStf5YVIIFyhZrJtboS6BqwClPa+Sou4B6yOM4YTPfCdkTNrGgkxOiZ8OEiywCARfV0XY
 sbznTuEUCpLV/8+pNZIb75MiOV7rszB+Y8jbcmmk0r+iOT2iI+9EPlceFqIcu0j6q6Y6Azam
 +uzxOPaoyizpNbWO3GNmaZKdQ5iBSFiWfje9pILHsbefFsOMD97V5f5n+h7E6Q7xPs9qws91
 irgMqOu4AGj3iKvxMTjQiwLVY4Dqr4m9ytlbH10Zwf3s5XhCK72hJoim1IMVeFP3IReITRcF
 pHpou3QXawdeSeN4DkHc5j2oaprcRnh10rEPDOobHJ7N9RsThDAsI2sNAb+1jg8Pgzuv+sHo
 pqkylz6R7gHTF9cF8r4Uq+k4G6wmnk/o9hMeXX0DONdQnixz7gyGRfN1qc2B+ouNST8wiCr0
 lfKIBUA+sjIjYwH0PjIoqGm9LWWMvZMMXdbO0L57r+GEzbQ0UT+4I1HUceOJSv8UkGt8oqcR
 Oxl9dPOG9xZo0RvrKxHDKdN8aIyw/DNto1q5F1oM1uTZmv6F446BGeN2Pd+k5Fkx5hbiFOQY
 V2O8NwLAoe5EprpP3BJLTV0c9nZ8+8fnwTTyvEHIE/awitT15jfWGVwOyi8sgBsHIFXAqgEn
 9h44NU37jahgCUEKtyF1yBY11qdJ0w6DpkIiMsoP5/JuCEKlHdyOYfRGw3n0qGpMt9sCHQnE
 hWQpajFholf+Hb8TmoOJSDN8NdZ1Lszu0Fs7V4dJl62tMLPqd0p0TZwrzkmbARn4S9W8uB0O
 2QxCUxRIJ+K3jZ3hfpsW3KnNBFBCSa4pG3w6Qotv0/IQ3a4UlfiKDUGBt+M20QC4UdwQyN+/
 ozE+F36UD3vQt797hEyVWFhtfbna957rS/Gp+yKAOWHGMMcTQf+o6rze1cNlQTrMfkxiGLDu
 +Nu2uR6Mo//FCwIppwEG5uo7qsRRD+ENV59b6lYpo1RJl7leRa2xTSqAGKycJkUJ/X1rGmJO
 /Y3LcdLDxmDxCKCqw4APpE1Iph2oq8NxMEDcbbVN2I5o+Ohjj52gqnxqAn6pkEWGutLr+hsC
 7nsZwqjE3ORj0R6g2XijtdJEUvmbMgmZD/T5vGU8uIIHa1S6e1HLBoA7ZqpjVqoMS9M3RGdj
 CXcbYD4ks1gzoVNmdP3M6NhXg+bF/L6ZN6qwiuS7etcSMzpMNjcki8osXzlAlhmBqQQUNFJi
 ri9it7780fbtrIQUWqCuZ2+O4RWxMe1Bsx7D9nWKSREoC68R8Pc2RsP1GSmI5hvktkGxM2GR
 RO9WfSgZ+wuRNZR631EWRdwSy9HJfzMUZ7hgieho9CnKBsXi1XHJez6007ZVzhQcytQNqDuD
 gPxhe2V2elZi4ZyVS80X6QsR9cyJVL4QqIpeuHgrTTSXCHinlqGvaCkjhY6ry3CDn6fCsvh/
 JbZXV7EeQ+vvL3ThsRs22CoUsb70F4m6QXxQq4cxzKyozW9EXJAMukXd5kLYn2Rfuoey7mgD
 AwhrkN7Yck+YdiAWQrx6pLvU29zw8QQb8zhKGVBE1y8Mk+L6UDpPFel3jht6TF6d1MPCQ1hx
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:P4lbUKmyOQCAQmV+juqV+JFQjMfpDfIv3DAbv31ZSRFFG/Gwv9
 yymv4BxQbo4QxhPU3I+OrtBEDkexnhHPFOj7X5UY3SPzUO21HIEGgB1+Tf6hv4FyrG2Nc179
 YFT0EWMrSZZjVHZK3BkWuF+rgboOW6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,145,1665439200"; 
   d="scan'208";a="39132626"
X-MGA-submission: =?us-ascii?q?MDE49vecDaE8KPvsGWvuvQxvc2oNtOFRZwupHt?=
 =?us-ascii?q?KXMbX9WTKZoVNf5acKubAIzA3JN84sIO32xxwkrOPJU9enxjPhNKTvHP?=
 =?us-ascii?q?4Fh5/yCsTemb/NZFbEg7oYvVaM1J9fPjvBjagdbojV+FDqofGm4RYxT2?=
 =?us-ascii?q?SvgfW81sqvNNQsznjGi4A0TQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 20:00:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1667847654; bh=sYKzI2fSRpZplELb6N06dZmtmSnu+f2NXY3dilwoVe4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=ie8+Eb9QuqRtLNILfAD6j3DcDYSHoVjgU962zp72IYf2nlb87Wjvl+MRzj5XRkEZX
	 5UU3v5cWuaMigRZBViF1UJrjjVgid4TYFjfOP58n1Waz1CrbJfR4VzLXJ8O4bsB3aE
	 0E7mERhNEYhs6VZ95QOzHz3RdnZ3ueIyQe9Ukm4SA/vtkZww1NJHcHY+xVBN2wobLO
	 CmsmcIaS3tyEBF8SJCk1DNuzdPNBBU8nbo4vYQgjW99EMfMSH/pKpoqb+MiH8UlxYk
	 k8hatXmM6ITM2E16Kziwol6m+O0P4k65T6V+XYl4f9T6Sd8zLjWyG2d4bEZpkp01Nu
	 4Vr+XQx4Y8JuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGSU-1oju9U07rm-009Q3F; Mon, 07
 Nov 2022 20:00:54 +0100
Message-ID: <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
Date: Mon, 7 Nov 2022 20:00:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 cocci@inria.fr
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-GB
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, kernel@pengutronix.de
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kQyL8DOm78YrC7h2nJr7B76NLio/X8JeIfs51Vkrk8U08GDqtYM
 wjQ4mpb0S+FwBNuxidOB6GtpScNSlhyNoRRw6qBJtHcwXkmM/jGEmei5gfB1HrddPYQFG6g
 WC6XmXtfEhBJArBcc290Wpd8h34XitvfhNo1aKYtq6YKdiZv9BdK1QdiVjIY0vAef914lw4
 cvu693hpJT8CtMW4AErjQ==
UI-OutboundReport: notjunk:1;M01:P0:lwifD3y/pBY=;G0Hpk9Q2zab9wH2CwgK2eq2LueE
 RzmyAh1I3FruPbHg/cvaT57Zp1e33LuBsIFwiAzDMfvTPUdgINFR10q/JMOxLYaOXn3JTdkxl
 CzdNWDCyD5fbB4ACCNrMIb1d+7j3/w3A8ylf3ufHw4Z26eMfajnDyXBucUYcOLf+jemcOArsR
 N1nQBQi7QlMg6th6JSTE8Sa9V4m+9kBdBusKmsE8yIVFkqkoXFyR0Jqgqqb3LuuXRG3yNARV2
 MnHMg30Nd0cQPUCK+t0q2nytZo8BfTqcvjr6xD/OGsobAVl+dzOcb3kbvJ2JBMBSeuIp0l1xC
 eDcHIGZn37j0hmwxFy1PO3c7sLTfSk4mdLFRhC6xJKP9Zil60MjW3A2YjndjIVAbmkWUD3vAE
 08r4+8hp3Aew3f7EwY1ojJl9wHnijrwviOQfqKu8i8El9bMyQb8mzrVrePiWm63HJlGI/pL+L
 WJtGRX0PQ/F6IpbirlFNbdbe9IGNH0433Depn/9fNCIIUoQ4c4Aqix8Z2qDpY15TYT37P0J/c
 Lf5tqVp3SoPT55enmYBHVBpQVSRsaCmrE2Zx6+tTIuvSG5xxQGqDz4mgTqCgcxYWVvmegsABt
 i2vXvGGTl+44Db+CQc4zYg+ppqaI0jYNFujKEZgtyJQ6pc8QZcwUiBrXQe2dFwTYxLcVkIfwY
 nktYVUnFOkhjXePXffqeve5KpAdl8jSG3a9Grh39NixdW2LSnhpQd+pNV5LICMqKrTu+jJyp4
 1fkCf+OX+uhWf/cuZfp+T0CM7VOH7TF5gkITCPynWxC3XDhuHOiavbSg8F4/Nyjr3W6aNWZmC
 ZVfkTj+QrNKNemORJ7SRa+O07ilPPXpAJeBiyEFUKIf8DyZ3llNvyqKKynkI8JZE6mNnfAKDb
 076pBXR5GY1gZtLOZ1IED54JmqCBnzAM+anpb7XQ/h90Om8AZ2LoswRgw5ZYMtYSWGzCxfbid
 zHh5Bg==
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 719
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/bd13da2d-6d18-4f33-0987-a193e3c9b761%40web.de>


> devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent =
to
> the shorter devm_platform_ioremap_resource(pdev, index).
=E2=80=A6
>  create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resourc=
e.cocci
=E2=80=A6
> +@depends on patch@
> +expression pdev,index;
> +position p !=3D r1.p;


Why do you think that different source code positions would be required fo=
r
your transformation approach?



> +@@
> +
> +-  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
> ++  devm_platform_ioremap_resource(pdev, index)

I suggest to use the following SmPL code variant instead.

-devm_platform_get_and_ioremap_resource@p
+devm_platform_ioremap_resource
=C2=A0(pdev, index
- , NULL
=C2=A0)



> +@r2 depends on !patch exists@
> +expression pdev,index;
> +position p;
> +@@
> +
> +*  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)


I doubt that the usage of the SmPL asterisk is appropriate for the operati=
on
modes =E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D.

Regards,
Markus

