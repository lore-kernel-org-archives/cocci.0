Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70884ECAAA1
	for <cocci@archiver.kernel.org>; Mon, 24 Oct 2022 16:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nm8LroXfGEbdu0lodvOl5UyE/diTXKQ2I7eUckAGfvY=;
  b=BXkPeG/15YI1GK7J8c2h48xVZogwcGWcM8D+sr1mWpnnUgGbuWMpecFV
   X61ckthwijwvqdowM3upKeIHjeV1iEnD+fZz7EmH4aSXS+FBKLdBXvZVk
   kc0ws4kheQILQmf2hEqKpn23yVcFzQy6u1H8eOKoFkCwYGy+jbC2euY5o
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
X-IronPort-AV: E=Sophos;i="5.95,209,1661810400"; 
   d="scan'208";a="68155331"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2022 18:30:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6A16EE01D1; Mon, 24 Oct 2022 18:30:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D4374E004E
	for <cocci@sympa.inria.fr>; Mon, 24 Oct 2022 18:30:41 +0200 (CEST)
IronPort-SDR: 6356bdb1_/qo7DW/0BJD6R/At4daRvXidJApF1LYq3f8l2yZZDA+7Gde
 aNnsitOYr/uK47bCHv59KqicHwybz5QFtnaXocg==
X-IPAS-Result: =?us-ascii?q?A0C0AwDevFZjhwQP49RagQmDfIFXLgQLRYROkRqLQYcpj?=
 =?us-ascii?q?DAPAQMBDUEBAgQBAYISgnMChHECHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBEwEBARkJFwcOEAUihWgNgjUpAYNkAQICASMdAQERJgEEC?=
 =?us-ascii?q?wUGGgImAgJXBiSCbIJtAQMNIwesCoEygQGCCAEBBoROHywiU4FdCYERLIcji?=
 =?us-ascii?q?D56JxCBVUSBSIJ3PoREg1eCZo8Rhkg4A0QdQANGMg1RHDEnDgkfHA4XDQUGE?=
 =?us-ascii?q?gMgbgVBDygvZyscGweBDCooFQMEBAMCBhMDIgINKTEUBCkTDy0HI3EJAgMiZ?=
 =?us-ascii?q?QUDAwQoLAMJQAclJDwHWDoBBAMCECI8BgMJAwIkgU0xJgUDDRclCAVOBAg6A?=
 =?us-ascii?q?gUGUhICChEDEg8GJ0cOSj45FgYnRAE0Dw4WA2OdXsFYNAeCHYFIgUsMnwAzA?=
 =?us-ascii?q?4NQkxQGkhOXIad0gXkjgVszGiSDNk4DGQ+OOYQMii0/NDsCBgEKAQEDCYVHA?=
 =?us-ascii?q?QGFEgEB?=
IronPort-PHdr: A9a23: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
 8SJi6/5bjtPoYq8wA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:KUErrak96IIHJJHJYo2wd4POmpfpDfLe3DAbv31ZSRFFG/FwWf
 rPoB19726NtN9xYgBDpTnkAsK9qBznhPtICOUqU4tKfTOW3FdAabsSi7cKoAeNJ8SdzIFgPM
 5bGsASNDSzNykCsS4+izPIdOrIq+P3k5xA692+815QbUVNd7xq6Rt/Bz2WC0tsWWB9dOUE/e
 Gnl7B6TyHLQwVrUi1XPAh4Y8Hz4+Hq0LbrewQPCRJi1RmWgVqTmcXH+5P05H0jbw8=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,209,1661810400"; 
   d="scan'208";a="33311330"
X-MGA-submission: =?us-ascii?q?MDEh6IyZsAb2qaPZILZL9M3eA7sZZPYRse2IU3?=
 =?us-ascii?q?4PDAKVWPWRDndDBzV9xXlvLOCX3DE8xYn+rKHfpWPzsIv+PDu2zmlYh0?=
 =?us-ascii?q?QtvndyIeWVA/Ol1IdCkJOYBMCJMsXzyA2ii0MOFJajMz2kcmCt6AV+RV?=
 =?us-ascii?q?/uQPE+KfI97BnUq1AD5oZ56g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 18:30:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1666629040; bh=cpHs5xdtNMCeb/l5ZUorbO/hU2okr+9C3MmQMYxOr/Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o5Z8rOtrFSJAU5QQXcMzcuJfqn3z3OIReRHr3vZsv12CsoxBMPd33xXqpo3SUmu+5
	 0mhO07gNbNdUTyo46c6bALH9z3tX7A1xtZ5kZdkJw0j5OCn6jfpkFb8u9FuVojdGf6
	 yevdrlzq7o935vAObXaE6HgmoQPexzAovAUCR+iK9FSGfjOG3AKWE/zrwdLcpI4ZIg
	 MM01ZWS/F8VcA31qdIjD/OSAexEg9LR0U2Ad940B8U+w0CqM8wJmDeckS2feek65er
	 K5k4cv66d9z4Q8MQy3oTDKR6y26U/BmzJ3rsJJr5eEtQ7sf2UKMAz2kaATI1DpqMQj
	 IJpnL5tVs49sw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.80.160] ([94.31.80.160]) by web-mail.web.de
 (3c-app-webde-bs11.server.lan [172.19.170.11]) (via HTTP); Mon, 24 Oct 2022
 18:30:40 +0200
MIME-Version: 1.0
Message-ID: <trinity-c55cc02f-abdf-476b-831f-51ab24af4a03-1666629039920@3c-app-webde-bs11>
From: Markus Elfring <Markus.Elfring@web.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Oct 2022 18:30:40 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <Y1WYWT0xU5hv1Gr9@zx2c4.com>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
 <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
 <trinity-3c34f082-c650-4c08-9ff9-f746f20e4183-1666533323595@3c-app-webde-bap48>
 <Y1WYWT0xU5hv1Gr9@zx2c4.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:+5Rdwn6EUxY9/mB2rzGOmjC0KQnwg7oYhl7kTnxu8bUvuVB55hDi/PFkF1N2W0Vnyz/QM
 ywGU36v0W0Lt0EsY4hmGZfaWlV8Ew3eFJNZjUhl7I3LLMhv2z8CfHaVx/2DDkx06ibVjz4zYUxYG
 DvB1VVv5fzPxcWhS0P/s76V1U6T6Oa9GpYaDAe8kvrsfDWW9o6lNfKy9K3uiqmaKZfdT+OCqBjch
 BAfJczEMD07J8ghuutm1ms2ft4A/aZ/3ly1LSWDRZtiFuO2sQJw1dY5Rul4pwU6WVUaqmFIO410q
 Fs=
UI-OutboundReport: notjunk:1;M01:P0:cACRS2ZSS00=;zi8kTxz/A9OhF1IAwYqnuD55WZu
 WgG+XYlHEn3phd94iBTxfVOolnXlYCS63NxcAWS9oyTakLSC1dI1NczSa8C3T6sJ2zldiU+On
 IEPowJS8BLrftb8oyUDmg6Aa1oSoDguv5SRKkbdgXkfEms4DcPKzmBCjiaOHaL51dybzYsEEK
 Ak5elZj9byEPe6QbzOACmzFhgAH2q/35EGNrMGY9sSiJCgb+Ci9QoTuvKCHvrITJ9us0t2CO6
 kAfLsgKpj7n8vqk1eaT5J8h+xtKzee+Vs4Ngsg6vLT/IJ5kWvxAqlfVFXPUa20VPre/G9XM5l
 LBeGIc8eop74uUS9s6edVa8RRNY8oYjwllrMz90CSVoovHVOFJ5V6XWkzCY5+FaO7MO/EuxiN
 EuGSUUK8cVUJjk9zBmsDmT3ybKmElkGgv2OQEsV2+dC5JkzYXwn0vcTEtPG9OB24ijslM8eTF
 0VJcvcGpslb87egfRt3lBOk3pQ3VpcYSrOKGshxZJAL2FypFh2tLXqGi45avR92XspineNvsv
 nG88V/M9IlijjUc7ef+1yW8XDd8dy27/TMMNuN4HksNJw07BBkbV8jQXSFftwvjdIgI3xKt/B
 8xdt3HuWgJ7J9gpV81UVj1DiaAZtlnr3h0TVvwv7FfpxL3Q4SI9E8OUWVi4nJM2GvCqgFgpT0
 NwWN3uTEQ9oCs6SuhGVT/7llJYrBWyV5i9gVL0gjw3pNbohANBY2u7IJoxILpdmf2XV7Ob1dR
 2GqeotR7ytJ7Xp3IZiluPYGLDXV+08b04WZoHiRmO1vZzihiLtQrS+B10CuntIG9phjcQp108
 D1SJMZen9yjNcIuTXxO+/9Bg==
Subject: Re: [cocci] algebraic simplification possibilities with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 684
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-c55cc02f-abdf-476b-831f-51ab24af4a03-1666629039920%403c-app-webde-bs11>

> I can do something like that=2E These seem to work:

The software =E2=80=9CCoccinelle 1=2E1=2E1=E2=80=9D gave me the impression=
 that the following
SmPL code variant can be acceptable=2E


@replacement@
expression H, L;
@@
-(get_random_u32_below(H) + L)
+get_random_u32_between(L, H + L)

@cleanup@
expression H, L, E, F;
@@
(
 get_random_u32_between
 (L,
  H
- - E
  + F
- + E
 )
|
 get_random_u32_between
 (L,
  H
- + E
  + F
- - E
 )
|
 get_random_u32_between
 (L,
  H
- - E
- + E
 )
|
 get_random_u32_between
 (L,
  H
- + E
- - E
 )
)


Regards,
Markus
