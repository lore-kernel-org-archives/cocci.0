Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A56606A32C
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=ucVn18uN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=taOA9UbDWUlC58AOCilW4/hn1kzjX1JE47yYJ1jUDdw=;
  b=ucVn18uN3J7Q6nXfyFZtbg6lKOryivYh50LaoLadrHYH7YxB6f8rMLh8
   nNIpNbufPWpjzvi306gCMKA7wLnovuRv/pGrNGosixZ/8O4ysgRzBzccl
   27TB0l70veSPZPSt0QlQAwK0f8c/Mon48pcArVbYmZPMJCu5u72KAsiuT
   Y=;
X-CSE-ConnectionGUID: 2wuJgwLRRAaRYuLG79c+AA==
X-CSE-MsgGUID: PgYB6uXeQaePXvI1AsiUcg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323553"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:25 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DE4F981723; Sat,  7 Nov 2026 11:59:25 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C0A788033E
	for <cocci@sympa.inria.fr>; Tue,  3 Nov 2026 18:48:10 +0100 (CET)
X-CSE-ConnectionGUID: bxivG6xuQaewImhOf+BG4g==
X-CSE-MsgGUID: CTGRmaw7Rh6WYa6jej9eWQ==
IronPort-SDR: 6aea1e5a_2jRbVNgE8DKjs1wvpR9QL/VQUH8HxL7fQKcDP3sE9hTI6pO
 d8p0FsjFmysNQyM+DlZgH2V3i33R7lNPBHZ8x8g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FXAAC7HOpqgAwR49RaHQEBAQEJARIBBQUBgX0HAQsBg?=
 =?us-ascii?q?kCBazQEC0mEHDyPU4F0MIt4h1WIfYFVgXwCDwEDAQ1OAQIEAQEBAgSCC4JvA?=
 =?us-ascii?q?gICjh0CHgcBBDEIDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBA?=
 =?us-ascii?q?QEBAhABATsHDjuGTw2MGgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBDBcdA?=
 =?us-ascii?q?QERJgEECwkCGgIYDgICVgYBFAEBgn6CIwEGEAEDECcHoCmcHoEygQGCDAEBB?=
 =?us-ascii?q?tprHywiXYFrCYEfLgGFcYJtAYY0g0h6Jw+BVUSBPIJMBzE+hEN8gmCCaoImg?=
 =?us-ascii?q?QyCWIVCjxJSeBwDWSwBVRMXCwcFgSVDAyovLSMPPAUtHYEjIR0XER5YGwYFE?=
 =?us-ascii?q?iAqQUNbgRKBB12BKyhdAQIfRi0VgXYCglGBIwJbAgFJQQ4HRVMJJUMSRyQiC?=
 =?us-ascii?q?BIJARMaLAqBGjU8CSYEOxUMWwsLGgUaRwgCCwIMdCgREBMdHiQvBRwmQBsKD?=
 =?us-ascii?q?G09NwoLGQQ9kxiDaSMTgktYsSOUZTQHgjmBaYFnDJ9vBhMvl1MPkw6ZCCOpI?=
 =?us-ascii?q?YFqAjaBXDMaJIM2UAMZD44ihDXOCEYyPQIHAgcOAwuFRAEBjFaBTAEB?=
IronPort-PHdr: A9a23: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
 xZamdsQwqwMO4e910EwMzGSeazVFkCWUd0f+kVc
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:mnCm5qnQEtOi6PKMqLGBtIl+If7pDfIV3DAbv31ZSRFFG/Fw5P
 re/8jztCWZtN91YhwdcL+7VpVoLUmskKKdgrNxAV7BZmbbUQKTRekIh7cKqAeQfxEWmNQtt5
 uIP5IfNPTASXJByfzi6A39Kcsp3cWcmZrY4tvj8w==
X-Talos-CUID: 9a23:5r1afmAWd/AAj9r6EyN39VA7RNA4S3TQ01bVI2i2SkxGFLLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AZOe0EgzyQumjBoemMDLEh4snFViaqI+SJ3oImIp?=
 =?us-ascii?q?ZgcnaCh15ZTWQjmW6fbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,193,1787004000"; 
   d="scan'208";a="303639509"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFJA5QDuPQ2lt3Z/egbyKH33dF95mjkme2ETF?=
 =?us-ascii?q?L3zXqR0AD89g/PjPDjCB8tqBcok7xFqOEpL348+zKPf723NceO4nbTHP?=
 =?us-ascii?q?XnQww2CTc8Pz00xXQeTfpoCDCyiTw/0AxTIWRwSgXcyhTYBPapxo7z/x?=
 =?us-ascii?q?MfzYjM28voioeedvjQsO7YAg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 18:48:10 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvsq5-1wYWqM3Cdz-016gEz; Tue, 03
 Nov 2026 18:48:09 +0100
Message-ID: <aa076739-d573-43b7-85ad-d2a6e88db1e9@web.de>
Date: Tue, 3 Nov 2026 18:48:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: tools@kernel.org, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <52418f50-b3ff-461d-8e66-c10f70e35b2a@web.de>
 <161f567a-f33-7865-8787-844a299ef9c1@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <161f567a-f33-7865-8787-844a299ef9c1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+FmgXsgMq0TU4TV2pE/6jopS+3uxk/uaDUQq+AYZy9SgckjsTNB
 MEvDA/iKTB+6LPMZ1723ydpv0wLIcUFVEX9G3SuoMshdJ+LmnfLlbaP0D/xokFnAWcwUcbQ
 mEuWRIyOHr/zr0UdtowxRpxsg8dLXAnO4OwmWP+h5gorPiEbJx7EqkHf1gRhcGCb7AMqwGT
 riGfOXDR6aoLGxbkYBGWg==
UI-OutboundReport: notjunk:1;M01:P0:LcFd1KGuBpw=;tkx6WxeHQdRAOHR26JoCGZJbbeW
 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
 1JXlDAzspepc=
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [RFC] Replacing special goto statements by direct
 returns?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3777
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/OmBo6iaO5jKk8XO7-5ongg>
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I think you can do:
>=20
> @useful@
> statement S;
> expression error;
> identifier error0;
> position p;
> @@
>=20
> S
> error0:@p
>   return error;
>=20
> @useless@
> position p1 !=3D useful.p;
> expression error;
> identifier error0;
> @@
>=20
> f(...) {
> (
> <...
> - goto error0;
> + return error;
> ...>
> &
> ...
> error0:@p1
>   return error;
> )
> }
>=20
> I have not tested this.

This is a pity.


> It might not work,

I got corresponding development concerns.

* You proposed to use a statement variable in the SmPL rule =E2=80=9Cusefu=
l=E2=80=9D.
  How safe is the control flow connection to the subsequent code?

* Another metavariable declaration is probably helpful for =E2=80=9Cf=E2=
=80=9D in the SmPL rule =E2=80=9Cuseless=E2=80=9D.


Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci replace_goto_by_return-Julia.cocci
=E2=80=A6
minus: parse error:=20
  File "replace_goto_by_return-Julia.cocci", line 25, column 2, charpos =
=3D 400
  around =3D '...',
  whole content =3D & ...


Would you be looking for a better SmPL conjunction?


> or it might be very slow.

I hope that experiences can grow also for more desirable software run time=
 characteristics.

Regards,
Markus
