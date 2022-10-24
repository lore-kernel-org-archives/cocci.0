Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EA7C3A59D
	for <cocci@archiver.kernel.org>; Mon, 24 Oct 2022 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=uT0opTUrXjXd2snS7pmlk/g2dG9tdizE9xaff9ea+jw=;
  b=eEb57J0kv8bjRTtvbHax4dUNSnyMhTutgX4mOsoKOYD0vEKQ+sXeDIBG
   d0D5/k3roafDrp6k9KY9X/pWhKBXVQYrmvXjJBvIXIZJVd4Qo0mOQtRQd
   o6ffugliCCukNtGjFx6c/Fd0oZVQHlYZ6YK4IaGokXdEmogeYpcpI7K7b
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="68015517"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2022 10:14:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7BE7CE01D1; Mon, 24 Oct 2022 10:14:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3BF8AE004E
	for <cocci@sympa.inria.fr>; Mon, 24 Oct 2022 10:14:38 +0200 (CEST)
IronPort-SDR: 6356496c_YifvcB6RLCJ3R0DXHB0MWbvHvlijuuU8uNufeEn4I9Il2KV
 8bXChGkJ/fv+JL6cSWSZB+kICWT7VCHB8+2lAmg==
X-IPAS-Result: =?us-ascii?q?A0CpAwDdSFZjhwQP49RaHgE8DAILFYFPgi2BAVYuBAtFA?=
 =?us-ascii?q?4RLkRppkgGMMA8BAwENOQgBAgQBAT+ERgKEcQIdBwEEMwYOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBEwEBARkJFwcOEAUihWgNgjUpAYNkAQICA?=
 =?us-ascii?q?SMdAQERJgEPBQYaAiYCAlcGExGCbAGCbAEDDSMHDKsagTKBAYIIAQEGgUABg?=
 =?us-ascii?q?w0fLCJTgV0DBoERLYcihFuDY3onEIFVRIFIgnc+gkuBeYNXgmaPD4ZHOANEH?=
 =?us-ascii?q?UADRjINURwxJw4JHxwOFw0FBhIDIG4FQQ8oL2cQGxwbB4EMKigVAwQEAwIGE?=
 =?us-ascii?q?wMiAg0pMRQEKRMPLQcjcQkCAyFlBQMDBCgsAwlAByUkPAdYOgEEAwIQIjwGA?=
 =?us-ascii?q?wkDAiSBSjEmBQMNFyUIBU4ECDoCBQZSEgIKEQMSDwYnRw5KPjkWBidEATQPD?=
 =?us-ascii?q?hYDY5cCgSVsBoE7gjGvApMcNAeCHYFIgUsMiW6VEjMDlmQGkhOXIY1BmjM1g?=
 =?us-ascii?q?UMkgVszGiSDNhIBOwMZD445OINUhGGFTD80AgE4AgYBCgEBAwkBgVaDcAEBh?=
 =?us-ascii?q?RIBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:lKRcIaptqMaAIYN7Q0QS2OUaV5rZeYIsimQD101hICG9vPb5qy
 nIpoVi6faUskdyZJhEo7u90ca7MBbhHPJOj7X5HI3SODUO/VHYSr2KjrGP/9SDIULDH4dmvM
 8MT0E9MqyIMbC+5vyKhzVQeOxQo+VvnprIuc7j7zNKURxgbb1m4jx0EwCBDyRNNXZ77OECZe
 ChDtEsnUvcRZ37VLXGOlA1G9Ti4/nGjojvbxJDOg4/5GC1/EiVADWWKXKl4is=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="33245632"
X-MGA-submission: =?us-ascii?q?MDHfFr+Q9hlwUiJ5Tz5c99eDAm6/pm6afQIqux?=
 =?us-ascii?q?Y/8/mA2759p+yk3ps0YsH5E0YN4/bpivaU6UIxWc+VbMS8ZH25s7+iyU?=
 =?us-ascii?q?+KS8z4Q1NPfZ0yNo71Bq1YQVUCAbW4Y2MaMVh7K7HcrXWXnp/fZujs0Q?=
 =?us-ascii?q?SlFmfh5iVE38pwoI3JdwDENQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 10:14:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1666599275; bh=uT0opTUrXjXd2snS7pmlk/g2dG9tdizE9xaff9ea+jw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IQSEcOn2gzMm5vW5xMZRz3ysXwrrvU7Z5kuG03Nn/K7dbt1MjOGtPQ5e0t6Tnu7gH
	 Hf1eVMs9srJLnjBNeHKFUM43lxounbLeUNAvjph+Bz5Pc1uIvmD4HtCdnQLuWp9aMD
	 yDtgbHd44IqIw4KRlyDa1hrYQlea8uouoG0Y7MNzzNQ6dBIHN8b5JkLnMm7GHvjFDx
	 KhEmPGzM08bed6u1qmm5Sb8I/NU1lDWUNQ69S42fQB6U6ejO++uT4Oyhmr5blHXKao
	 IEVNU4J9/955YR4N34cXOLWSbh4gmusqu/e89Ibsa3vUpRFgnUecPZGHcGXS1qEBb6
	 qFvMIUqua0rtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.80.160] ([94.31.80.160]) by web-mail.web.de
 (3c-app-webde-bs11.server.lan [172.19.170.11]) (via HTTP); Mon, 24 Oct 2022
 10:14:34 +0200
MIME-Version: 1.0
Message-ID: <trinity-d301d4d9-2fc9-4a1c-bd74-9d0ad23731ac-1666599274940@3c-app-webde-bs11>
From: Markus Elfring <Markus.Elfring@web.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Oct 2022 10:14:34 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <Y1WXpHI5mhLNEn5x@zx2c4.com>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
 <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
 <trinity-5b69abe2-b503-4cbd-9d94-699da8dff88d-1666467943254@3c-app-webde-bap49>
 <Y1WXpHI5mhLNEn5x@zx2c4.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:RBtWfYeRneP8QZK1aD0mO2f9PiejGzmnj6NAaatskkporuH6ZVy618PkqKhD2pPgXaOXm
 0mNW5E2Q+k6inzgJzQLOmmMuXYuuDTnAzMVIVVQNgJ83cvYhr/ys800QjZwgFLZNBu/ObBa2qyMH
 Fo+lPGFG07f1N35qYrfECOXiJYf5nwTFmLZNGK+aA2Pw/hd/cU8V6SDE4kGAQfMAtlFkG/NHZnm/
 M3Cjy6oI3q9U3+zJD0JrE1a/cA5u/Uyud/SdxuXULJ0ZMO4ATOIz/+B7MBOPTIhJcSETud23uXmy
 S4=
UI-OutboundReport: notjunk:1;M01:P0:5gPV5OvfNKs=;uxBFBMGk7nHbggqH0qPld9FEBpX
 yE31D4QqyTM3cOtTmpbjzpMyI8grDIQOYsr/lGH0c6q/O/tN5k+EEfnmx3wh3ER2d+XJ2ebMw
 NJ1qKH5NqoeTx4gQSyVwC85citcYmnkyPD1svpul4spqvWmlUAwA/zsja3uUyjGOEMmGX9rtH
 wykMNVmfgorTv11SmNFXf/+FvVW3xcVdPUebVLCL75C52RDIFaVEp0PkfKSgqonyD//FohMot
 rVywTXwcmvSoDmlWUhcQOZCOwv3Q2X4SPzsCJYn1tXrXw4D58NRJAyDQcMeW63Kg15drU48uB
 +YJl41ZcacG4Hk+TUvxHg0GcClFolvsvak+bZQIGTk1PAkXghyM+jJuCOgLzW36a018po69Ps
 41SVruSlcjDT3aPDs9Bd2CVVmHdC1iV0Mc/EkPaS3dal5eaO5IMhklQ4lfTKVqs2cuRxctu9H
 2y7BHsCznpH3zdGEz12B0ttQHXQh3arsel+aV5Ua/iUKEZvg0H76i9/ZKIaMh0GuJBVkJ9Ahw
 63/ehd/dgoY24lYv6NxBQ6Z5mVNvKU2JuhUD1MUZv36a4N/jJzQ4mnzn4SOZkHuB2kAT+OtlU
 SdoTIenX0uOAWg0YrFSNWzGF/Z0CpS+2vRPar3wTM0GCi0knbdWkRJGOmITD1+NQxY4uUwCk3
 GfzJTWk0GtV2p7hUGLYjblFwE11HyTlUXnFTPdoT3fh8Clx6s2aLvLORRVHc+l+rfg+v5KaUr
 5Q49lUhx1EQZotGyq9MGw97fYNLJaTEoRXhb3fiefgLlb8jQOIv6k6r3wRaJdhFc0h0Kodzwm
 xFxRlyZ1fxXPgP6bJNHqdgxA==
Subject: Re: [cocci] Replacing special do { =?UTF-8?Q?=E2=80=A6?= } while
 loops by selected function calls
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 681
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-d301d4d9-2fc9-4a1c-bd74-9d0ad23731ac-1666599274940%403c-app-webde-bs11>

> > > I just sent these in:
> > > https://lore=2Ekernel=2Eorg/lkml/20221022014403=2E3881893-5-Jason@zx=
2c4=2Ecom/
> >=20
> > I suggest to reconsider the usage of SmPL ellipses in more detail
> > according to your SmPL code demonstration in the description for the c=
hange
> > suggestion =E2=80=9C[PATCH v1 4/5] treewide: use get_random_u32_{above=
,below}()
> > instead of manual loop=E2=80=9D=2E
>=20
> I'll do `=2E=2E=2E when !=3D I`=2E

I find this feedback too terse=2E

Code exclusion specifications can occasionally be helpful=2E
I imagine that further case distinctions will point a need out to consider
clarification for additional SmPL code design variants=2E

Regards,
Markus
