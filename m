Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC0BC32771
	for <cocci@archiver.kernel.org>; Mon, 26 Sep 2022 08:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=unEZwx7mOkxw+i1GIajmZjzqF0uKZWDYiLYfMb2qnME=;
  b=BtJc20y6zwHviHtVBVeiQruiZ53cXEIEDHEf3/O6BBRkmfxMwVGzUwZ/
   zPjQVXqhGLhA3Yuh2mLZiqJy9HKWeq/T5aasHaMxUQ2WlMc8rwVyaJKtv
   u2e4m0zO0Nbb749wYF/UGpr/bjbPBKLqfPb4/cO3dkec4iLxRy9VNQb3Z
   0=;
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
X-IronPort-AV: E=Sophos;i="5.93,345,1654552800"; 
   d="scan'208";a="54466104"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Sep 2022 10:23:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F467E0235; Mon, 26 Sep 2022 10:23:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CBB4FE0090
	for <cocci@sympa.inria.fr>; Mon, 26 Sep 2022 10:23:17 +0200 (CEST)
IronPort-SDR: 63316175_Dw3QxOnizDS2+mUmcizb2PFggqdxsVAr2bAOpBRUeXHac7o
 o7AWNnE7+taaBOq/BJTp7NgNb6hFvvXo/4vtVdg==
X-IPAS-Result: =?us-ascii?q?A0ALCABDYDFjhw4P49RagQmBUYIigVcuBAtFhE6Qbotnh?=
 =?us-ascii?q?yWMKwsBAwENPwECBAEBhQUChGwCHQcBBDUFDQECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQEZCRcHDgULBSKFaA2CNSkBg2QDAyMdAQERJgEPB?=
 =?us-ascii?q?QYaAiYCAlcGJIJsgm0BAzAHqV2BMoEBgggBAQaETh8sIlKBXAmBES2HFIgae?=
 =?us-ascii?q?icQgVVEgUiCRzA+hESDVoJmlQGEJDgDRB1BA001GAMUAwUkBwMZDyMNDQQWB?=
 =?us-ascii?q?wwDAwUlAwICGwcCAgMCBhMFAgJNNggECAQrJA8FAgcvBQQvAh4EBQYRCAIWA?=
 =?us-ascii?q?gYEBAQEFQIQCAIIJhcHEzMZAQUyJxAJIRwOGg0FBhMDIG8FRA8oMWsrHRsKg?=
 =?us-ascii?q?QwqKBUDBAQDAgYTAwMiAhAqMRQEKRMSLQcrcwkCAyJnBQMDBCgsAwlABygmP?=
 =?us-ascii?q?AdYOgEEAwIQIj0GAwkDAiSBUTkoBQMNGSYIBSMXHgQIPAIFBlcTAgoSAxOaa?=
 =?us-ascii?q?IEJghZBklKvJTQHghiBRIFJDJ5yMwOWYQaSCZcLp2mBeSKBWzMaJIM2TgMZD?=
 =?us-ascii?q?445hAyKLT80OwIGAQoBAQMJhUcBAYUNAQE?=
IronPort-PHdr: A9a23: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
 NTCxvqbwNJq7N/eu8cRVZC8FQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:u3DybqPu9ulTXcBcTgOjsMiBIKoaSvp037Dk7SBMoHtuA7Slfq
 GV7ZYmPHrP4wr5N0tQ/OxoVJPvfZr8z+8Q3WBVB8bFYOCEggeVxeNZgrcKqgeIc0DDH6xmpN
 5dm20UMqyWMbEQt7eY3ODXKbcdKaK8gdqVbfy19QYRceiGUdAd0y5JTjq6Vml7XhNPC5Z8KY
 qE6qN81kGdkU18VLXFOpGPMtKom+H2
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,345,1654552800"; 
   d="scan'208";a="54466086"
X-MGA-submission: =?us-ascii?q?MDGBhoqGyv75DBq1GWQjj1UUidjcyEOKUhl6ml?=
 =?us-ascii?q?Axs69A8JyZ8Ox7jA4zheNeGR/yM5Ak/WAA4k6UAeWGNh0pyy/ACTvb+/?=
 =?us-ascii?q?Uh9gGkF66WBU9H9bZQbMMY+jpdwU1o6dUP8XiHDActs1T5XAFl99sKx7?=
 =?us-ascii?q?rY2sUESJTZQ2CRSptI32IH+Q=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 10:23:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664180583; bh=tEP/tnEBM7KNqJmaR4m8gVV6mW6PjzSMgouCTmYaS4Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wkS8/FCSddmKx7ouNXVgyJSK9IwDtW4XLtMIF9Zo7ESJjtLnGyTsq5Pb64R9MMvUu
	 qfxYeqCcaeLfvcZpGtJMlNbGo4ZIL0RECI+YQlo9AQhotpwEc+yDhf8bhz8TCEz+5I
	 pYkEBqsfjkC7Ler9fyYICOdiLic7A6KjOsgHeCTJVMGtp5emYteYTgFOfZ9hvMFQob
	 SFc/SKOOGx8BBK0EYBDMrkHWBFHxZOGFVbeCTrwlhI1I5D3JMdcBeWzwNDds6VVDwc
	 7K4HDdniwyRSkhtqonEp3uHDW3wK/xHCp+fhbish9VkVg/R7UEsKvaHBB306g4ZmcF
	 jT85XEJxER0XQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [212.144.252.253] ([212.144.252.253]) by web-mail.web.de
 (3c-app-webde-bs29.server.lan [172.19.170.29]) (via HTTP); Mon, 26 Sep 2022
 10:23:03 +0200
MIME-Version: 1.0
Message-ID: <trinity-372702b2-3fbd-4dde-a140-a598a171a852-1664180583770@3c-app-webde-bs29>
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Sep 2022 10:23:03 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <159a19ca-ada6-9cb4-90b2-fdcf384b914d@inria.fr>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
 <trinity-bcb29359-5c27-4c34-95f6-f5827e936702-1664177792747@3c-app-webde-bs29>
 <159a19ca-ada6-9cb4-90b2-fdcf384b914d@inria.fr>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:/hxnpN08oXMN2MOL0OYTcrY/zhZyE/r14al6u/E1WJLGAQdpCmjXec6vNFIC+TY2dzAyd
 NbnLzcOK293elyFoujyoA1L1dvb3ulH6Gy/Me1V+Bj2KcSC0EGGcXEunkLKEwAixedl/Gz305V5w
 yhPB4Rrf4p4lAi9lN9utA0/OnO7Cpi0W99ywk4+9kg2WF4wHugAdRx3Vecfc6Il1RVd2mB3VJoKL
 yX7gjgQbY0BN7UnezOeM8GdGNVttZxkNmZ3TVHz723Hnr3pbelAM+7c3TPC9akzycsU2PT090MHR
 dQ=
X-UI-Out-Filterresults: notjunk:1;V03:K0:D/QJ9+MF5w8=:JMCZFDcugyIcvGjph/3wlF
 m89z/TJIMYFmgjZRpdWQfwENMqT2G6PHzwsVbZ+MEQf2EPCa7sVTnzOBjrGXxkv5ryreaotGM
 ojBELvMaDOV9b6wxrKOCwR6OImY7TajcTpqUlX8Dz0CiGp/NL7auBUOhfL5IGSYSpkvQseK11
 5JDw/JhR45KVbJM3VNwtQUDSz0JZj6Vq/klTeuRxtkQ97S2jUMqM661lU7mwnxc4KoUIPkHkQ
 wBajll5imaOwc0zZQ2L0cokvZp/8QGNmx4W2hQ8VCRukJIho06KVlaU/kry9ff86DxHFkQu+y
 VL73PIi0U+TP6gfOl6OwK8j0e/vHNS2SjWcOcUPCaec6+UIGLru2/8jQ286RSgho7fr6nD7/8
 oLAM/0hbpoVJBAj13sH9/9eIv6Qy61A0vL2aFHDnI8ylxyR+npErNYVv3wNIusGjFiDLjCbIU
 FSkMxgGgsuDzXc+Ov0g4XpAho7TR1ZC1P9UWHp63DPvOwgG/U1yYeRm4XZxloElud5UZ833M8
 2s+L6xk+k8nLnq0k5hcsQQeSuXI6/U88I1tQETZL3OExgWANAeRB94pQuZdnUMSdmVSrgjkD+
 98D1a3lqikEPccQhHM/MzotGEd4v4InyZFDQsxydeqX5y4SoC0054TcXrPPtjAWuSZKmy2Unf
 kCXQSkRQgyTzJOI8tPb4ePrCsETHTQZAula7Lh2UGWznMMFzAWHNQDgFW2JPcQV5xW6T/sVjU
 EX9mU02tjYDm0orhXQDbPtcijOLpb2FnXSqQ5bigCFbWL3B9nR0DYVy0m2tBNmj21oL74490J
 jLUHqvS
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 588
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/trinity-372702b2-3fbd-4dde-a140-a598a171a852-1664180583770%403c-app-webde-bs29>

> > > @create4@
> > > identifier t,f;
> > > position pa;
> > > typedef spinlock_t;
> > > @@
> > >
> > > struct t {
> > >    =2E=2E=2E
> > >    struct mutex f@pa[=2E=2E=2E];
> > >    =2E=2E=2E
> > > }
> >
> > * How much does the type definition matter for the referenced data str=
ucture
> >   in this SmPL rule?
>=20
> No idea what this question means=2E

May the metavariable =E2=80=9Cspinlock_t=E2=80=9D be ommitted (when you ar=
e looking for mutexes here)?



> > * The shown source code search refers to an array as a member=2E
> >   Can such a selection be combined with a previous filter by using
> >   a corresponding SmPL disjunction?
>=20
> No=2E  A disjunction will pick one case and match all possible matches o=
f
> this case=2E  Perhaps that could be improved, but that is the situation =
at
> the moment=2E

Would it be nice to avoid duplicate SmPL code for the shown handling
of array and non-array variables?


> > * Would the application of iteration functionality become feasible
> >   for the discussed use case?
>=20
> Not relevant=2E

Will it become possible to express repeated SmPL code by more convenient m=
eans?

Regards,
Markus
