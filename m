Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50DCC07E9D
	for <cocci@archiver.kernel.org>; Thu, 29 Sep 2022 06:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=62YBmIot/WccNIKu+YWL9/+HHfwWxOhLvCEfmO0izgk=;
  b=AmNWm+YjJ1kpOU1nnd4G3U/tGP9NBWwIZqvcsWP8HkuBvuxfyLgGX1iN
   GHmmmoz5BISPdgwNNuBmYYDedlT+Fs/le9roceBEsfR+30KXlbhSPX3Wj
   wqEqp7yB707obOBc3/DsrGdOSMBFxE8AR2XQ4Ori33f8RzxPLhLNjn/me
   4=;
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
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="55053323"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Sep 2022 08:21:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A1AADE0241; Thu, 29 Sep 2022 08:21:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EC3B8E0076
	for <cocci@sympa.inria.fr>; Thu, 29 Sep 2022 08:21:49 +0200 (CEST)
IronPort-SDR: 6335397d_2TPts10evtOQxAwlI+2qSGI5tlgoPf2HGN3JPbG0Y9guQXS
 Lb5sxXYsVFQop1G6IHY8dahKDd9boTO1wDQZKKg==
X-IPAS-Result: =?us-ascii?q?A0DUAwA6ODVjhwwR49RagQmDc4FXLgQLRYQRPZEXi0CHJ?=
 =?us-ascii?q?YwrCwEDAQ0/AQIEAQGCEoJzAoRsAh0HAQQ0EwECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQEZCRcHDhAFIoVoDYI1KQGDZAECAgEMFx0BAREmA?=
 =?us-ascii?q?Q8FBAIaAiYCAlcGJIJsgm0BAw0jB49EnBeBMoEBgggBAQaETh8sIlKBXAmBE?=
 =?us-ascii?q?SyHFogaeicQgVVEgUiCRzA+hESDVoJmlHyESjgDRB1BA001GAMUAwUkBwMZD?=
 =?us-ascii?q?yMNDQQWBwwDAwUlAwICGwcCAgMCBhMFAgJNNggECAQrJA8FAgcvBQQvAh4EB?=
 =?us-ascii?q?QYRCAIWAgYEBAQEFQIQCAIIJhcHEzMZAQUyJxAJIRwOGg0FBhMDIG8FRA8oM?=
 =?us-ascii?q?WsrHRsKgQwqKBUDBAQDAgYTAwMiAhAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsA?=
 =?us-ascii?q?wlABygkPAdYOgEEAwIQIj0GAwkDAiKBUDUoBQMNGSYIBSMXHgQIPAIFBlcTA?=
 =?us-ascii?q?goSAxMPBimbXIFogkvBHTQHghuBRYFJDJ5zMwOWYQaSCpcNp2mBeCOBWzMaJ?=
 =?us-ascii?q?IM2TgMZD445hAyKLT80OwIGAQoBAQMJhUcBAYRzAQE?=
IronPort-PHdr: A9a23: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
 cXT0r3+InFO/oCMlSP5L9fZIoSLPSh5WSc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Y3xD7a+86T7vXo7mmkBuk+AaI+orL9Y04lQ7vn2ZhyY0TiX+rb
 HXoB17726XtN91YhodcL+7Scy9qB/nm6KdwLNhWYtKGTOW3ldAT7sP0WKB+VLd8kTFn4Yx6U
 4jSdkGNDU0ZmIK6voSizPIcOrIruPnzEnSv5al8593JzsaFp2IAj0JdjqzIwlLZE1jCYAiHJ
 SRovdWvjbIQwVtUiyDbEN1INQqLLDw/q7bXQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="55053322"
X-MGA-submission: =?us-ascii?q?MDH3vBZk+KBM4jTET87Pw0z336V6vdkmMVlYCs?=
 =?us-ascii?q?78jHtGysWkvOuK2ro+BjSh6jbguAbQSCUkas3/Iv2J6xmQzdYnY3QVGB?=
 =?us-ascii?q?E+6bHpLBIxCGMXBuexbU4i/pVZmzTo9+sKBUy59S8Pb4sUBgkd9NxwfN?=
 =?us-ascii?q?nKz0A6HODLeRYdv4lyHOjvAA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 08:21:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664432497; bh=tdL0mQkm48HVrL2Ugxgtq6PjIeK63Mbe3/uM+W8Bn1E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=REzVTfNV6goZqMg0lKA6h99+2eAHijX+6X+A5d+3Hnx+JmkhRSwhEMrNK/4cUXlUQ
	 Xj6YpY97E/cxfrxCFAksUXd7DNpH/5+CrPsqVyHtwtUYxRQS1IOxaYY+tI5AKSEvbu
	 XqvF4vDy4h41hzsc06j3RSEujyLif2pHrpnsThUXv5crpO54X7m5yg2idjnugTP/wT
	 O2n/y5JSdBP7WT/Aml5M2C76sZrtHfNU/fFRNnzVtEkaB1hV9FiZv13zteZjP3Yu0I
	 EtBufFIDCw2YeZ0aGMg0UBjwXFAsLgj/Gjqjp2juwqg1E+y7PsT3YCuFAdgJ2bSo7l
	 Y7UgkkACyxolA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [212.144.252.253] ([212.144.252.253]) by web-mail.web.de
 (3c-app-webde-bap27.server.lan [172.19.172.27]) (via HTTP); Thu, 29 Sep
 2022 08:21:37 +0200
MIME-Version: 1.0
Message-ID: <trinity-6a1e80bd-4b4d-40fb-a944-50346c34f58b-1664432497287@3c-app-webde-bap27>
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Sep 2022 08:21:37 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <alpine.DEB.2.22.394.2209282137030.2984@hadrien>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
 <d9ba411d-2b5d-061e-f985-ff5158b5521a@web.de>
 <alpine.DEB.2.22.394.2209282125470.2984@hadrien>
 <c2f73ccb-8106-7cc4-7c06-9e9eaa8d0638@web.de>
 <alpine.DEB.2.22.394.2209282137030.2984@hadrien>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:lUe58ApaNmZ036ZSMDMHFBKSbd1AqC65DEoXhasvqRRlkv8zZ0dJeLQS+5qRbhvhx4ee7
 NANX+0QmUqYk9+AQQrQwFwvs2lqFDHdU6X9kosSsu4yoOxzkBOUTRs2PgSVtcDvx9Y/ZY3Mg0or0
 3Htlwf1PAFfFpFOQWlQO7CZPpe+crbVHsJmVnY3Jzz+0WXwws//7YPoox6tGrrcxZUzc7GsrV9mO
 gAf9XPm5cYnVnNf1FrPBsCzirdl+YWNnmD9mrD7IaJmMZBuek8ZoZ5d+EsmB3kU/V1S4/dxzdHtf
 58=
X-UI-Out-Filterresults: notjunk:1;V03:K0:t2DxD0Xks64=:axOP7gfyjCwWV16E8cChKe
 x9LZGNPyGdff8QylG3w7EzuoOasoVGL45V3EWgxDTHdO5H5G/f2D0zHkwHzKsc6b2FLPo7A7i
 YOcZJxD/A+Y3KVonLGaPgjJ0+MAtC+C1M2lvfLBRBKMmdvk4MccVefYtrfSyYysj+mVCwPeu/
 1bkx5+Bk6Cx4w99Fz6GRb44G1Efk7LlkVmW+zCsF/8+6bRzxDMB7rxIwifWQ1XF05AmgY9MRZ
 zjM+kklVDpgktyh2TrwLut2vfYe6Ug5ixRjPng6uCgzIsiT7KM0fYPPhkx6QNmPZ1PtlHiP8M
 NotGKJu7xzklTGI/s1E4UVRBg/6ivMNEIyIFl6ZCjat69FilRRpwX1AKqRGjBt3iLifLhBFdP
 UmQGyLIthR3tK8ImVLn6+/ZI7KQTW3xSNBl6hiZhLLgxoN9pX7647cHg8qtsSbd2QZiIQ2pzT
 r//vLGLgZhuq3VOAL/guuANJzB/SdurG6VyKFZVoN25ZZmSLczhhfqdGQnBL+4+DOGYvwZtx7
 oFo66j+JLlwBV1E8R2zDHwRgG7kC3Mt+HVV0Tp9iDoWtCoTzhHg3EHHGeuZX6vJXR9zGegpCw
 K+1I8ktbTxgcLWfuOWKv4zTKRJFcMQmaLhtUJW1n/pSeOv9myJFh9J8sBPh8vgJi3UOvowvf4
 +ylxkGwrxQXIok47FEb76sbfE8wo1EzI6SzRxCXugfFyM3x8HJ7i0RAm9nzfcmknMaLO3roer
 QmhNBuR9Kd4/yNPvn9lSKw+KVR6FDsgRzjhNRzYgwmW3PZ0CsUPpRTgF1ajsO3iPR7CCYAlgl
 jwvto7Y
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 602
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/trinity-6a1e80bd-4b4d-40fb-a944-50346c34f58b-1664432497287%403c-app-webde-bap27>

> > > t is a metavariable that gats bound to the type of o=2E
> >
> >
> > I would use the kind =E2=80=9Cidentifier=E2=80=9D for the metavariable=
 =E2=80=9Co=E2=80=9D which is connected
> > to a known data type=2E
> > I would appreciate if the usage of your SmPL code can become clearer=
=2E
>=20
> In SmPL, if you want to declare a metavariable that matches an expressio=
n
> of a certain type, you don't have to write the word expression=2E

* Would you like to restrict the source code search to compound data types=
?

* How do you think about to check if there are differences in the software
  run time characteristics for the application of the metavariable kinds
  =E2=80=9Cidentifier=E2=80=9D and =E2=80=9Ctype=E2=80=9D?

Regards,
Markus
