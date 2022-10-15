Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36427C43217
	for <cocci@archiver.kernel.org>; Sat, 15 Oct 2022 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=U+hG+/fT7ZO8y7UUlL0nfTFuqc+OL91opZoSBEiqXhk=;
  b=Zi3sRZR0Q3xI3w1ZbEX92CBclv2l5bj4OxP4X5UZ5Dar6S22frxoU6QR
   vOhHZxfPpe1EhJrwUj2O+wwuNNOptvCeYPjFPR6zVMUce7cB8FL1ObmtO
   YihvZUrisB1oG82ssoU3QhCjW+N+kfASMbBN2a2YoW9PxLnFX+S0A23fD
   c=;
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
X-IronPort-AV: E=Sophos;i="5.95,187,1661810400"; 
   d="scan'208";a="65315427"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Oct 2022 20:40:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 08EE0E010B; Sat, 15 Oct 2022 20:40:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F0CEDE0038
	for <cocci@sympa.inria.fr>; Sat, 15 Oct 2022 20:40:23 +0200 (CEST)
IronPort-SDR: 634afe97_+gZgXC6rR53e78tnFkTgogh/guhOF1Jxioyeo7/wYT3/KNG
 lOX2Vzpo7WQP/Hy/xwgEdUkwAdRFUXKm8WYNyzA==
X-IPAS-Result: =?us-ascii?q?A0CQBQCf/UpjhwsR49RagQmDdIFXLgQLRYQRPZBxJQOLQ?=
 =?us-ascii?q?YcnjC8LAQMBDT8BAgQBAYISgmkKAoRsAh0HAQQ0EwECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBAQEZCRcHDhAFIoVoDYI1KYNlAQICAQwXHQEBE?=
 =?us-ascii?q?SYBBAsFBAIaAiYCAlcGJIJsgm0BAw0jB44tnBeBMoEBgggBAQaETh8sIlOBX?=
 =?us-ascii?q?AmBESyHGIgheicQgVVEgUgBgQiBPjA+hESDV4Jmkh2CR4YKOANEHUADRjQYA?=
 =?us-ascii?q?xQDBSEHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk00CAQIBCskDwUCB?=
 =?us-ascii?q?y8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBTInDgkhHA4aDQUGE?=
 =?us-ascii?q?wMgbwVCDygvaSscGweBDCooFQMEBAMCBhMDIAINKTEUBCkTDy0HKXEJAgMiZ?=
 =?us-ascii?q?QUDAwQoLAMJQAclJDwHWDoBBAMCECI8BgMJAwIkgUsxJgUDDRclCAU3GwQIP?=
 =?us-ascii?q?AIFBlISAgoRAxIPBidHD0o+ORYGJ0gBNg8OnUkGgVsCYwwHgVCuSJMVNAeCH?=
 =?us-ascii?q?IFHgUoMnnszA5ZiBpITlxandIF5I4FbMxokgzZOAxkPjjkeg26KLT80OwIGA?=
 =?us-ascii?q?QoBAQMJhUcBAYUMAQE?=
IronPort-PHdr: A9a23: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
 NwRR7UdWFFnTpvy5Wx6EdZELJolB1sZ
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:DuZ8sarEApGKAYGCu6c3hVgaV5rpeYIsimQD101hICG9vPb5qy
 nIpoVi6faUskdyZJhEo7u90ca7MBbhHPJOj7X5HI3SODUO/VHYSr2KjrGP/9SDIULDH4dmvM
 8MT0E9MqyIMbC+5vyKhzVQeOxQo+VvnprIuQ6k9QYWcelwAZsQkjuR5zzrbnFedU17Jd4cGI
 CH7sRK4wexYHh/VLXBOpE9NdKz2OEiH//dCyI7Ow==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,187,1661810400"; 
   d="scan'208";a="31540438"
X-MGA-submission: =?us-ascii?q?MDHUZaSv1TZAkDTSAfh5qiu0faMhY/PMcM4k5Z?=
 =?us-ascii?q?7T036e22YlgssyP5TPFNbocpbZAElTrUDHsTBuOM3SebcQZvPKmWMLTc?=
 =?us-ascii?q?6stdT3kVCHn021ZIfD8TXU6csz+RAHVOXtcznK294NnU/Zbz2QKWYD2j?=
 =?us-ascii?q?BFg+giVCoaGlVseGe6aobxfQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 20:40:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1665859217; bh=WRUyojq9KwwaOELCpyQByTvzABJer9e83S2SQZgRMmQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oeMBs0CM3owOuksCCJq4vSjTfg8iJxscvq5ReS0c3MXxpBw3fVeeb6W5XdSAWNoCa
	 MguqTt0gNtDj8gNdIEr1A2W3hfTrfpeJYXH26LJpa7n95Q9Rz3UVR9NYbBTSsWq43o
	 NSUJjsClBZyzN+69+L8/I4vy1D03hMqDd/qw567h6wO0fQlfgsyilnN7P8/+GYmOlq
	 vwjndNm+ctWR3WlLxmg7KmQPLqHfNQmA7BwV+U2RJO8z6X1V1Ada4CT+t9NR6ux7no
	 7TmKaS/iDrKCmi41lmOOqZMRTV3+OUo10AumbEMHy8laMb481r1Zny3F9k1po8VbOl
	 Bams+DVny2UyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.81.160] ([94.31.81.160]) by web-mail.web.de
 (3c-app-webde-bap48.server.lan [172.19.172.48]) (via HTTP); Sat, 15 Oct
 2022 20:40:17 +0200
MIME-Version: 1.0
Message-ID: <trinity-e4c22e7c-257f-411a-8393-56884473a1de-1665859217158@3c-app-webde-bap48>
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Oct 2022 20:40:17 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <alpine.DEB.2.22.394.2210151733130.2759@hadrien>
References: <7bda3ec2-1335-4451-dc59-b70faa216750@intel.com>
 <90ab83bb-6ac-488-251a-5f5dac2f2b6@inria.fr>
 <trinity-1ddd0e69-3785-475f-ac01-ba838dac2762-1665846759728@3c-app-webde-bap48>
 <alpine.DEB.2.22.394.2210151733130.2759@hadrien>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:lJfglVlClgQqL8qh8/SHzYHMKjAaU4kuA6BudgtML2R2Z8qi3RJqbVlw8wdo5ehKfpddQ
 o7nSi8KH/jIpj/fpQViYR6he7M2X/5FNTZsngzRC8LYMZphXxVUdESpV45umY/lSRzcMcglaBxk0
 qQw7T31KqAhR0r4Nc8gDKlhaUmWNOpEKVbIUq3HNS7RfbkX+tDfpaahs/yKbVRfTRr7pBrq+QW/v
 pmFR3mXfXMTkTVi59kbnuii03t1U3DgxWE0uyt3eEctUlx6vpnbFXDM6lZD9kwN1dulZ0QgISdhR
 kY=
X-UI-Out-Filterresults: notjunk:1;V03:K0:QpLO3udCvzc=:N5Hv7iZSEouHWzJqiH5axe
 Y0qT709hPFaVC3FDmNltH1yOj0jfugnkU49aQHbcJVPzEO4fhYI1NaSm0Gqufh9oJpXeF2pXj
 1zdjgbAqNbyB/bglaSLBQf2G6y7g3PNlMZgayPpEuLlbTq+lAck5nddYe+w9wcWXDEYLKuVQl
 hraBR4P/WK6OsxPOavi4rJRsEmfkAjl+zCbFDLJMMNgm33AeHYKJZXWLp3aUvf7Iezfyjn5T8
 hLaiaNp2npQXOsGckglTjtgcsAacPAoJ2pdWUvv7GLzVzghe/sVxivvoeIIwiJFoyBfGZBtha
 X3I7KFZZVtQIwJiuTS8Zygx1NheRyN8hTYf9zrw1orc15JluVvXVPPYlXAN+pqcwaTHGtWxjc
 p04WwGMAIE868axqAVs9VJ2fgHoWpvvb+qWvOAoaYSHzCCfuKZUhpHzjhyhvelU14RuwCD4BQ
 cB0OBhPegojhdtbxHv6ZbNUxNbVxmIxs/bO2s1xQuLQyq9RmljDfxRK9g4g2zp0lnFbUc+X/n
 nSJtVFS4cYwMlHMGwJbycJZILm4IpzABcvViEFz0Z7/ChOHwii1LK00t3NQisuRH+49Vgh/vO
 6S2PWoSTu4YMZxsPhCOYZQbQpC00ZE/VGIFSgZff/CWFAacUC9v1RkDcKONYmhFq/Pk13Xr/d
 E8tPd1G3mzFe0wkjLz6V0a3DQIS8siWKdD2GHAQNXbORUeZZ7PF10QYWc9waX6WPki92LxpKw
 dRFLFkSIJSqFPti2mMfqUp0GGq6hUT92NaW7irH4mtxMlHB0saxlQsIzc7Uq6kaAZVrWW5Z1E
 pCUQiI67FvzjsxEQlomi6gyUnFR877YpkvZWjDQLdC310WhuUy+bIafSNrjIPs6PItkiblIER
 5kqzS+xaA4rYpbZh/NKyJh1UlCmjYhnDWqK1/rorWc3R+WbdaSnrtQn32UkCiOh81TmaPbJFc
 3vWCOtTfzdQz0cWYRwXv2KCkcDZVCBmhWKEMDAGZf2TdphWdHm3HlbcOu3bjAzwo0goVDUn0d
 Ul0Di5db1VellflcjqzmvcxGSaD7lVo6VmKBYQ1+hCC7h7XGuevNoDQhwSC9IzOAqIxH60Mvx
 aKqm2JRtMJWCkN0SGADjyJ+NMXgR1QWNAqyWkheqJh7pCQduZpUCf9cs5dSN8aNXWF9HjBc6L
 1vgCCud+n8O4wuLH+cX8CY0+YiMYJrUy+W2lvXBaxZaSc0qeg/wY+GFRZ0aNE2pSvHMt5gElh
 z90Um6UqUm6nlOMCCEsgxAvSsCmLRuqmm5RGbeFpO0BmU7Cw61x+8yTiCwbaRDvfIbT1xcNpc
 EEStyyJp
Subject: Re: [cocci] How to fix diff generation for adding if statements
 before return statements?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 651
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-e4c22e7c-257f-411a-8393-56884473a1de-1665859217158%403c-app-webde-bap48>

> > > > Following script:
> > =E2=80=A6
> > > > @@
> > > > @@
> > > > + if (1)
> > > > + printf("b\n");
> > > > +
> > > > return 1;
> > =E2=80=A6
> > > > produces:
> > > > @@ -1,9 +1,15 @@
> > =E2=80=A6
> > > > int b()
> > > > {
> > > > + if (1)
> > > > + printf("b\n");
> > > > +
> > > > +
> > > > return 0;
> > > > }
> > =E2=80=A6
> >
> > Open issues:
> > 1=2E Indentation for added if branches
> > 2=2E Number of blank lines
> > 3=2E Return values
>=20
> If the return in the original code is not indented, then the if branch i=
s
> not indented=2E  This is not a bug but a feature=2E  If the return is no=
t
> indented, Coccinelle assumes that indentation is not wanted=2E

I suggest to reconsider such a development view further=2E
I imagine that other coding style variants would occasionally be preferred=
=2E


> Coccinelle doesn't change the return value=2E

Do you care for this software tool if the value =E2=80=9C1=E2=80=9D should=
 be found
and displayed from the implementation of the function =E2=80=9Cb=E2=80=9D =
according to
the discussed transformation test case instead of =E2=80=9C0=E2=80=9D?


> So the only open issue is the number of blank lines=2E

I got an other impression=2E

Regards,
Markus
