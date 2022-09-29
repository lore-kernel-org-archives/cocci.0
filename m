Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3282DC07E9D
	for <cocci@archiver.kernel.org>; Thu, 29 Sep 2022 07:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tsfuHNzO+waKHPB0FOPrdi73+tZ+sRnvmJ9wl18tbIU=;
  b=Jm5cTQGPIGbzVWTiG+qvaBdXZAPAEHCODMhxxwI55BqF6gMNxQmmTlHb
   q1efio12jKtmVse4WH3O3yNyO9WQig4EqP6IuzXmM6Kwxtyx8oWrGbJ7A
   uMINEt8S4lkvQ6fD1Tb26k4evWEXvh1uYwQHu/BRSruXG0i0fSwWI81qD
   o=;
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
   d="scan'208";a="55086723"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Sep 2022 09:40:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2299BE0241; Thu, 29 Sep 2022 09:40:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7DBA5E0076
	for <cocci@sympa.inria.fr>; Thu, 29 Sep 2022 09:40:31 +0200 (CEST)
IronPort-SDR: 63354bee_FcEDOAw6z4X8PsEjLYsO0PTuOPlrUuExhnA+NfK1UaMEB8p
 MYcVYSq5pg5ZL2/34DjMwbpbOTfbVPl68f4e9Iw==
X-IPAS-Result: =?us-ascii?q?A0CXBQASSzVjhwwR49RaHgEBCxIMQINzgQFWLgQLRYQRP?=
 =?us-ascii?q?ZBvJQOfEAsBAwENNwgBAgQBAYISgnMChGwCHQcBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAQBEwEBARkJFwcOEAUihWgNgjUpAYNkAQICAQwXB?=
 =?us-ascii?q?BkBAREmAQQLBQQCGgImAgJXBiSCbAGCbAEDDSMHDI8tnBd/M4EBgggBAQaET?=
 =?us-ascii?q?h8sIlKBXAMGgREshxaIGnonEIFVRIFIAYJGMD6CYgWBXYNWgmaUfIRKOANEH?=
 =?us-ascii?q?UEDTTUYAxQDBSQHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAk02CAQIB?=
 =?us-ascii?q?CskDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBBTInEAkhH?=
 =?us-ascii?q?A4aDQUGEwMgbwVEDygxaysdGwqBDCooFQMEBAMCBhMDAyICECoxFAQpExItB?=
 =?us-ascii?q?ytzCQIDImcFAwMEKCwDCUAHKCQ8B1g6AQQDAhAiPQYDCQMCIoFQNSgFAw0ZJ?=
 =?us-ascii?q?ggFIxceBAg8AgUGVxMCChIDEw8GKZlJgR8Bc2lQVIFLEjcSoFuNT5JzNAeCG?=
 =?us-ascii?q?4FFgUkMiWeVDDMDlmEGkgqXDY08mi2BeCOBWzMaJIM2TgMZD44gGYNZM4otP?=
 =?us-ascii?q?zQ7AgYBCgEBAwmFRwEBhHMBAQ?=
IronPort-PHdr: A9a23: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
 twCR+0CPLTQPuwXAAJpEY5aSKo=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:NW6eQq4IhEE8WecrSAPXwArXdLJyesId70hD6qm+c3xom6uj5r
 iTdZUgpH3JYVMqM03I9urwXZVoLUmzyXdV2/h0AV7mZniBhILKFu1fBOnZrAEIcheWnoNgPO
 VbAtFD4BiaNykcsS+Q2njaLz9P+ri6GduT9J3jJ2wGd3AWV0iM1XYENi+rVnFXAC1LH4AwGp
 bZ29pfq1ObCA8qhv3QPAh7YwBJyuegqK7b
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="24979243"
X-MGA-submission: =?us-ascii?q?MDE/8xY1zrwT2mDDA7LNX/Z/peYQpE/NtPo2lQ?=
 =?us-ascii?q?wMyf+14UWlF5V/UXDZz0seBhH6i/DXwEiuj0mYQ1X2siXW8GV6iJy3jW?=
 =?us-ascii?q?7JVvU6V2xf9Yg5c0wPGkTJq3RgRCq/GQXQBy2rdBqUg4EvS4OUGXq81R?=
 =?us-ascii?q?hQzClUuQPzzj8T0TYNdlzt3w=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 09:40:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664437216; bh=SV7tfRz8orsep0sLP/GQs5XTUtvDMKKH5bIGCKc/i3k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jzfeeYOKadH0AXghFIbtNh5v1OByd9unYuLNcoRq1jJQJ2kYSHcotJCosd+Bp5EUW
	 YhCVPKI3IerNIjKj0YmfIwMXRuw79pWUHybG6bFK4W6g4AXTbp0amzNphYfJW4UC/R
	 zvoNAYeUEV2VJ5b9GP3N/ITA/Boh1M+GxeAFjHPKNVRneL6skMNBOWl76YLWnVhumF
	 I14GX4MHnZOaB1DgJ6u/o8KtbOBh8Nyk+QV1UpzMDqX3GPJwUWFb3SrO4wg58nMdUS
	 OUDg0JRmnWGWXaskjSLAbSw/qVi/SCwD0GSRDyjBeBB6cvAp1yMnAR6h0ODF0uBqAe
	 0QoHoA1bOoQ0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [212.144.252.253] ([212.144.252.253]) by web-mail.web.de
 (3c-app-webde-bap27.server.lan [172.19.172.27]) (via HTTP); Thu, 29 Sep
 2022 09:40:16 +0200
MIME-Version: 1.0
Message-ID: <trinity-83107000-6c16-4ec3-a6d7-11d2bd7cc14c-1664437216657@3c-app-webde-bap27>
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Sep 2022 09:40:16 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <59318b60-5c22-e774-6b2c-eb1463681ac3@inria.fr>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
 <d9ba411d-2b5d-061e-f985-ff5158b5521a@web.de>
 <alpine.DEB.2.22.394.2209282125470.2984@hadrien>
 <c2f73ccb-8106-7cc4-7c06-9e9eaa8d0638@web.de>
 <alpine.DEB.2.22.394.2209282137030.2984@hadrien>
 <trinity-6a1e80bd-4b4d-40fb-a944-50346c34f58b-1664432497287@3c-app-webde-bap27>
 <59318b60-5c22-e774-6b2c-eb1463681ac3@inria.fr>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:bc2rcNV5M1alaeogTh1QPzukrgRafMssNU7fxFECK4um5OhkKMC9U+Wk+EK3lXAr0gauA
 bljCZI+iCfu7W151Ch8WwBwmpyvxBLr/KiDRK2r6vPTHSy+Q6iGRPZV3JtAE8ALewcGrJpfGlpNK
 /IYVyqYjbJCnqyKgEXnA9dRRRgyWdIEuBvHrX9JtUy+OHP13lGOs72pEkY83y4MVUAAZ0+ZMaWNk
 ddXnpGjORbFS76tE4FkoNgNsrH8Q5p9aMQiyDBwGRxHEVLIBIfbBo0sOMXk7gH75UkGk1bRSbzTg
 QY=
X-UI-Out-Filterresults: notjunk:1;V03:K0:vwNN08OAQP8=:PzZ+voHxxpYX0cepEp/eUY
 tWT7xELbryaOMoHIp4uUHj3qLg0GpFdjSbNiSrh2YFVAWha59LTQ12Y1xSOHzxC/EfghcagBM
 lKMaNVrK16Hpx9d4MhdWmi4zL2rVifXvgbozWF+7FTAfGcCrbh23R0zzVhcVqUZMZWzt/Qecc
 pq37LAKwW2K2LGuzDwmqkX7DpwtYr6F22TOxrMFMuDJNsZe5yghYQYFj9+H1PQciCSx1CRpPm
 R32Aa3ZclfHXguz3dU2+P3z3prjnxPAMfy1ow7tY7LLfRNRRbNvvZ0xEyCakw/WJzqzjhRYyl
 YtQuw796p59bVBMq1mDq1J7TWzA9BHc3li0IZJp32G5Yieg4gpTs3gl22iXFriDAYn9gAjdjM
 uQxvvAUJj3+QmJObsc6PgKvgRDno7g/RoFUJ0ytfLkDOOBhnJS1OYt4GogkyW2HG8m7VoYOCP
 EwV1ADP4oHT6NbDK5OgnsWtxh3JT2y1b0UIbI5hhs/temVe+WK7iNQz6zY9EaUYKZKNSXygur
 4Rdu2cMIrIA/cOPlGbGQJPdbCiEVZIfqiC5uj5DQa6rxFsNUL0lYMPx584qTXtjvaPe3TBYom
 eM3QuXjROeFeBeAp6vfNgony5z6AIus5lxw963+APND10fbKhOgiehbDkhajkT+flBprW/Pk7
 MmStLg0Y+Iq2to65psUbeW/MxJ4DOOgJMRjM1rADrSe+OOKCBW/XBhUA+6sDEgnbdFjQB8wbb
 NGvb0Bt9EEoaN4LbH/gFaYijEGQxVx2O6knSCmHCxtf3WDrECgwBqwv9ULtwQNG6pJDLODh+a
 ybp5zIu
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 604
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/trinity-83107000-6c16-4ec3-a6d7-11d2bd7cc14c-1664437216657%403c-app-webde-bap27>

> > > In SmPL, if you want to declare a metavariable that matches an expres=
sion
> > > of a certain type, you don't have to write the word expression=2E
> >
> > * Would you like to restrict the source code search to compound data t=
ypes?
> >
> > * How do you think about to check if there are differences in the soft=
ware
> >   run time characteristics for the application of the metavariable kin=
ds
> >   =E2=80=9Cidentifier=E2=80=9D and =E2=80=9Ctype=E2=80=9D?
>=20
> Huh?  Why would I want to use identifier?

I interpret the SmPL rule =E2=80=9Clock=E2=80=9D in the way that source co=
de should be found
that fits to calls of selected macros (or functions) which get addresses p=
assed
from data structure members=2E
The address determination would usually start with the evaluation of a var=
iable name,
wouldn't it?


> First an identifier doesn't have a type, it's just a sequence of charact=
ers=2E

Can the view be appropriate that identifiers have got the data type =E2=80=
=9Cchar[]=E2=80=9D
(or =E2=80=9Cstd::string=E2=80=9D)?
They refer to additional information=2E


> So I would not know the type of the expression,

Maybe not directly=2E

The effective data type of expressions can eventually be determined in way=
s
which are supported by available compilers=2E

It seems that we usually expect also that appropriate pointers are passed
to selected macros (or functions)=2E


> which is necessary for matching up the various uses of the locks,

How would you like to improve the desired scope (or name) resolution furth=
er?
https://en=2Ecppreference=2Ecom/w/c/language/scope


> and second the thing in the matched position is not always an identifier=
,
> as in &a->b->lock=2E

How would you call the item =E2=80=9Ca=E2=80=9D then according to such an =
expression example?
Which terminology would you prefer instead?

Regards,
Markus
