Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA2ACD37B6
	for <cocci@archiver.kernel.org>; Sun, 10 May 2026 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7kpbqO5EWZCB2B1Bt8+H3sFLcFbZsctSTKw+ndO5vUA=;
  b=TpFf3sZR/IGbgM48xnClZGAaZ3iNVKCtdqHJACi3hSi8NsDCYMNKSvud
   ELACN7UgMwTm3uDyd6fFZL5mZ8Aa7BlIr4B7rJfdSlh4HuoyTXzK8JvXA
   CGGBHvAmBja+mW9AFyaeymLoE05+tkyNTn6FyuNVxqM3/FgMmKTdsPaii
   E=;
X-CSE-ConnectionGUID: UBFWkez4TyeDh4zE2Cq8Rw==
X-CSE-MsgGUID: P4waDZGPR6uPu/hTIp46iA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="276029165"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 May 2026 14:45:27 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2341B81430; Sun, 10 May 2026 14:45:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0113380583
	for <cocci@sympa.inria.fr>; Sun, 10 May 2026 14:45:20 +0200 (CEST)
X-CSE-ConnectionGUID: QYEBwpKuSpSgPI7XHSwqfQ==
X-CSE-MsgGUID: meuhc/uiSciGndaaQV9zkA==
IronPort-SDR: 6a007de0_GM6nTfE3MBHMtO6ND6/UJ3EqKDusH+BoWz9A3yRaH1K13ny
 FraGtMdoqkLK0nTmGFVwR1IDFUOu3FFE0GxtlDQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FFAgCWfABqgAwR49RaglmCQYFmNAQLSYRYj1OCJIQ7h?=
 =?us-ascii?q?zyHVYh5gVWBfQIPAQMBDU4BAgQBAQECBIILgmoKAo0zAh4HAQQyBw4BAgQDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQE7Bw47hk8NgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJw8LGgIYDgICVgYBFAEBg?=
 =?us-ascii?q?n6CIwEGEAEDDycHtQOBMoEBggwBAQbaZh8sIlqBZwmBHy6FcoJnAYYxhEAnD?=
 =?us-ascii?q?4FVRIE8glIxPoRDg1uCaYImgQ6PAlJ4HANZLAFVExcLBwWBI0MDKi8tI0sFL?=
 =?us-ascii?q?R2BIyEdFxUfWBsHBRIhKm5LZCxcGgMDDSE1WXUKAUkFgXQCgh4ZXyMvA06BB?=
 =?us-ascii?q?QIBC209NwkLGwQ9izwdD4Y0kwezKTQHgjiBZ4FkDJ9tBhMvg3GTYQ6TCx6Ya?=
 =?us-ascii?q?CKpH4FvCSqBXDMaJIM2UAMZD44tFoQTw1hFMj0CBwIHDQMLhUQBAYxWgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BSSLvKAsPANfhVrlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3ATB/guWt24s92yb/TmHNgmty86IscQ1D302/zPnS?=
 =?us-ascii?q?gMmlRaeKlaWSP4a1dxp8=3D?=
X-Talos-MUID: 9a23:woCH9QuEEKmpXzAerM2ngTx/NMwv/qWVA0Eil5kPsvC6ZD5zEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,227,1770591600"; 
   d="scan'208";a="146159899"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEyeJ6nv7HhFPYmbBLCs3T+f/xlb7TZ59Quc8?=
 =?us-ascii?q?DzGTp+FtDH1sLexFs34wlP6oat2P0DBa4SQ4SYFzE1zM6G/w/4RwCYRK?=
 =?us-ascii?q?GX9WK34KNNDHtjvsZ3XPAJ03pM/zT8s7091bb5/PVsv1BEGQ3kLiM+op?=
 =?us-ascii?q?yHQCYTtZ9C+GgrPSeVRSi5AA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 14:45:21 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4bA-1wXZ3s1SeI-0038R2; Sun, 10
 May 2026 14:45:18 +0200
Message-ID: <f3e6a976-2ab6-428c-ac42-ccd2281774aa@web.de>
Date: Sun, 10 May 2026 14:45:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <ffd64e55-beb3-4030-8b7d-763ba6f8f563@web.de>
 <1f97d99-bf20-44f9-8781-26162f5824b@inria.fr>
 <ef0539dd-b1d5-49b0-9c20-74c5e5d977b1@web.de>
 <e5a66d9c-5462-2f54-6abf-d2ec2cfd1d9@inria.fr>
 <26e1d3aa-13f1-4e55-88d1-68b9d027ded0@web.de>
 <806afe75-8e1-17d8-dc3e-c2e33f4ab64@inria.fr>
 <049a046d-3952-4192-9b9f-a7c2162c6ea9@web.de>
 <2437833c-e02c-736c-e96f-7ded7eb263c1@inria.fr>
 <569a2fa4-d655-4c26-836d-a86aedf4e0b9@web.de>
 <6614c14-3844-9774-24c3-e891ad57e9a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6614c14-3844-9774-24c3-e891ad57e9a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JlgYci0A8rkoRqUq55ZgQTVDgcF35BuUaaKjpRYu3wVQYVvjuwp
 XRt45I3aqsQD9fE5TtpjDTGwmUeUx2xT5OjIAbc8yMQvJ4oDZoariymLD50So5yrIRHdQc6
 v/BbCEYb7CeQJuFmkhuluNOQ+1W8Q+Qz065nfsa8uKUltqDCZkYl61lMy8lxesDFg4O85/d
 axtoOuz1dxqeoMNz85NEw==
UI-OutboundReport: notjunk:1;M01:P0:WFCJbW2otCQ=;B/whc4a3hK0gBgh8eRRVIHQON1e
 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
Subject: Re: [cocci] Merging results from parallel data processing?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3496
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/dL5LD9_2Toe5b9uAbdctbg>

>> How should users of the Coccinelle software get to know
>> that such a special programming interface is supported according to
>> parallel data processing anyhow?
>=20
> It seems that Thierry should have written some documentation for the
> manual when he implemented it.  Since he did not, someone probably shoul=
d.
> Perhaps all the effort you have put into complaining about it could have
> been used for that.
Are there any agreements needed for involved technical details
before a better software documentation can be attempted?

Regards,
Markus
