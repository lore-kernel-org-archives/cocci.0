Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A41D3B7EA
	for <cocci@archiver.kernel.org>; Tue,  9 Dec 2025 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eSMlz8YNDhhLEpFgfBpFqdWd1hwlIiyVhH0OJAsdNz0=;
  b=lV2vghTjWa7ZYAYEenPggIbJuyH2Kn0vy3BhE6ew9nVGEBpcqINYJRpu
   C50tlJULarlnXuT7iSRnWyLopYNWouI8WVM0gCSFV5YX0WUI7+ms844qZ
   HJ/6G2NHRV5Btkny+xN9g1EkkOuuj1+MAZMcK5vn94t41BSaS6FXfs6eS
   4=;
X-CSE-ConnectionGUID: 1uj3DjmRQrOivfoZp4NOLQ==
X-CSE-MsgGUID: J9adHVUUS6eVviGQBckHgQ==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.20,261,1758578400"; 
   d="scan'208";a="253495250"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2025 11:10:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E058E0CDB; Tue,  9 Dec 2025 11:10:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6DF78E00A5
	for <cocci@sympa.inria.fr>; Thu,  4 Dec 2025 20:41:51 +0100 (CET)
X-CSE-ConnectionGUID: kJLIqQEAQUi8QgTk6hedzQ==
X-CSE-MsgGUID: 5hKNexE3REuX8Ps/tqNujQ==
IronPort-SDR: 6931e3ff_GWkxhm2auN3C5LM9eJn0fLbVf3cxKiN1BMLucH53z4Rtu4s
 +IHe/61dCiDPLiw5cTEyRe+u+HyeItbG5QM/l0A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HKAgCK4jFpj/4EaaxagQmBUIJAgQZfMwQLSQSEUYh7h?=
 =?us-ascii?q?liCJGmXU4QJgVWBfQIPAQMBDUQNBAEBAwSFAAKMZwIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBAQE5BQ47hk8NgmIBg?=
 =?us-ascii?q?SSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDIx0BATcBDwsLAwoCAiYCAiETBR0GA?=
 =?us-ascii?q?RKDAgGCIgdKAxGzNIEygQGCDAEBBt4LAwaBHS6IUwGBboQAO4NDeicVBoINg?=
 =?us-ascii?q?UqCdT6CSoFbHhWDRoJpghGBI4Yfi2OHNCYJHQMHBw4NHkYPBRwDWSwBVRMXC?=
 =?us-ascii?q?wcFW0VDAQIBKTQtI0sFLR2BIyEdFxNgVECDSRgGZw8GgREZSQICAgUCQDqBZ?=
 =?us-ascii?q?gYcBhwSAgMBAgI6VQyBdwICBIEuZ32CCg+IAoEIBS57KwMLYgs9NxQbTJUMT?=
 =?us-ascii?q?4NcEIEglDqTe59ZBwOEHIoigXyVUzOXUpMZLodlkA1mIotsgXqbOIFoOoFcf?=
 =?us-ascii?q?QhsBoIwEj0DGQ+OLQ0JiHG4EkI1AjoCBwEKAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
 sz0x08=
IronPort-Data: A9a23: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
 RzyOpE9A/Rp/qxUeA==
IronPort-HdrOrdr: A9a23:9H58Aq6cWeJ8I4ZhXQPXwCrXdLJyesId70hD6qm+c20pTiX+rb
 HQoB17726JtN91YhwdcL+7Sc69qB/nhPpICMwqTNKftWrdyQiVxeNZnPPfKlTbckWUnIJgPO
 VbAspD4bbLfCNHZKjBkXOFOudl79+d7qiyiOvSi1trRxp7crxt4m5CZTqzIwlZQE1oCZIlCI
 GR/KN81kOdkLcsAPiTNz0qW+DCopnsj5LpYRkPAloC5BOVhT2lrJ7WeiLouCv2nwkv/V7qyw
 j4rzA=
X-Talos-CUID: =?us-ascii?q?9a23=3ApheM+GjrdH7XKxrbzNYhBdy7izJucV/57W7pDma?=
 =?us-ascii?q?BNGc5cbKpSgGQ9a92qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A2QioHw6rRB7Rc3afy+fN5MSVxow144eIBVAgyq8?=
 =?us-ascii?q?rpvnUDTc3Jy67kTaOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="252851439"
X-MGA-submission: =?us-ascii?q?MDHeNQkH1dhNiiRBGcThLl92E6zi2WFkc0/cf6?=
 =?us-ascii?q?xW+zwR7zDPXRV+BP+stzIYeiqq9DgWksrNjVkjUTVTB8RFIWEXjl+7kS?=
 =?us-ascii?q?WC6L8K6MILrQlrhi01+8R8QBr4wXcexy2gNDEdm0BvSeXPRbCOzMoZ19?=
 =?us-ascii?q?i09l6o6hLNGgh1Z/w7OMc/TA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 20:41:50 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A3BC6601FF
	for <cocci@inria.fr>; Thu,  4 Dec 2025 19:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA6AC16AAE
	for <cocci@inria.fr>; Thu,  4 Dec 2025 19:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764877309;
	bh=rHT9xT6N4HwUpN3fLXWjzicPo/DomXsTboy9NbnRVjs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=INXfXsjb/N/0dD/b9PLdByET50RPyZ/boMtT07qGJwlh0Xu1tKPpABIbGrLkaHxHN
	 j9mqn062PyWkwv41udyh3TFRdSnfNbGmJY1TYzOiGTI3KbY27QW5/PT8EZoPx8iGe5
	 cCt7kJD483u06xecuZyLC5GEoLNQCq45Y7M7eSknpsvW1rKrg4gxbhC9QfBm8HMCUb
	 261T1HTodlJewh2aL8RRGqfVZjQSNugLtBvA3XB1BB9xSeCWNWBex9CfWJRaIQc9gH
	 IiPdmI9jCOuCl03SGbmTF8O56W/Ra4vvgMb1Kz2l6Tpe9N0nHC+p18DOJmRYXPbWo2
	 ZIlN0ZAKDVNZA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c6d1ebb0c4so1078328a34.1
        for <cocci@inria.fr>; Thu, 04 Dec 2025 11:41:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUP5+SSRzjM+myIGJPcj6m18gjcJnHO0HUmyVBith8KfW76HUHQ3wd6ku3N1I2js4h7esgAMQ==@inria.fr
X-Gm-Message-State: AOJu0YzwFCtck8xrFZ5FokSCydsenhYj+MRvzZaZNlEXBe56JHNjbqhA
	B12+ogwLx+Krb9X0i11a76utKQkZhKVML5Eh5/CHOANKcXLRNuCUfXZJwAaKd/rFQl1YRIMOhdC
	aPS9F9pLgm9qyghMESxC7RL7IoIlbBoI=
X-Google-Smtp-Source: AGHT+IGwb86bPJj29XUE84xmLGbyUSD6aHdtW3/1oF7NbvBJ0We7CnpySRDDctXuzQ/AonqYFaXS/BcZ2k/FtC57djQ=
X-Received: by 2002:a05:6830:44a0:b0:7c7:6977:17cb with SMTP id
 46e09a7af769-7c94db1950fmr4377333a34.21.1764877308026; Thu, 04 Dec 2025
 11:41:48 -0800 (PST)
MIME-Version: 1.0
References: <20251202193129.1411419-1-briannorris@chromium.org> <0f729108-6928-4644-b02a-fa7020cdffc4@roeck-us.net>
In-Reply-To: <0f729108-6928-4644-b02a-fa7020cdffc4@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Dec 2025 20:41:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iyR5x-FDoyoTp3ip7g7tdB_Qmii5Uy+EtCOpLyy2XBJg@mail.gmail.com>
X-Gm-Features: AWmQ_blFeKRlhzPeGyH7_dyis8rxlzDcx9cgPJbofmddeZOBxg4GSKXJcIy7Dt0
Message-ID: <CAJZ5v0iyR5x-FDoyoTp3ip7g7tdB_Qmii5Uy+EtCOpLyy2XBJg@mail.gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Brian Norris <briannorris@chromium.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Nicolas Palix <nicolas.palix@imag.fr>, linux-pm@vger.kernel.org, 
	Julia Lawall <Julia.Lawall@inria.fr>, linux-kernel@vger.kernel.org, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 1/3] PM: runtime: Stop checking
 pm_runtime_barrier() return code
Reply-To: "Rafael J. Wysocki" <rafael@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3257
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/CAJZ5v0iyR5x-FDoyoTp3ip7g7tdB_Qmii5Uy%2BEtCOpLyy2XBJg%40mail.gmail.com>

On Wed, Dec 3, 2025 at 4:34=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On Tue, Dec 02, 2025 at 11:30:24AM -0800, Brian Norris wrote:
> > Apparently this test is the only code that checks the return code from
> > pm_runtime_barrier(), and it turns out that's for good reason -- it's
> > inherently racy, and a bad idea. We're going to make
> > pm_runtime_barrier() return void, so prepare for that by dropping any
> > return code checks.
> >
> > This resolves some test failures seen like the following:
> >
> > [   34.559694]     # pm_runtime_error_test: EXPECTATION FAILED at drive=
rs/base/power/runtime-test.c:177
> > [   34.559694]     Expected 1 =3D=3D pm_runtime_barrier(dev), but
> > [   34.559694]         pm_runtime_barrier(dev) =3D=3D 0 (0x0)
> > [   34.563604]     # pm_runtime_error_test: pass:0 fail:1 skip:0 total:=
1
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/lkml/93259f2b-7017-4096-a31b-cabbf6152e=
9b@roeck-us.net/
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
>
> With this series on top of v6.18:
>
> Qemu test results:
>         total: 610 pass: 610 fail: 0
> Unit test results:
>         pass: 666898 fail: 0
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Applied along with the [2-3/3] as 6.19-rc material, thanks!
