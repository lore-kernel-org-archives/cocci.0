Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6C7106F2FC
	for <cocci@archiver.kernel.org>; Thu, 26 Mar 2026 08:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FKy/j61w2V4VsSRd36vvH3Y8jeOyvK4/NmeOsD6xKE4=;
  b=OYkXvwBZOpSFZDucg6tZJ3WaelWC81WOV++lTWrSiJJNYcsKnaGE7Gco
   gmMssyI3qODjC3FV8i3G3Oktu3oA5eIm0V3k6g9Q2PwWzXXRHcMHW6QUR
   L7OaEgP7+LOnRiQ433xqDuO+vP/tIv/qMgR27MVmJMERkXSLDKRyExVr/
   Q=;
X-CSE-ConnectionGUID: QOFvFL+zQJmXEmr9+NRl6Q==
X-CSE-MsgGUID: a2QIXt1ITLmxqc4fmFVICQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,141,1770591600"; 
   d="scan'208";a="269566563"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Mar 2026 09:31:18 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 08FAF817F6; Thu, 26 Mar 2026 09:31:17 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C388C817CA
	for <cocci@sympa.inria.fr>; Thu, 26 Mar 2026 09:31:11 +0100 (CET)
X-CSE-ConnectionGUID: rRNCUfmHS3uYAslksF30dQ==
X-CSE-MsgGUID: BiE8GX6VRcG/5JvPvQvq8A==
IronPort-SDR: 69c4eecf_S4Q9yqTX2xK1NeZs0XfJj1MM4Ir13gDWZitTkxRIkM4/DCd
 m7NHRUYr0ID2ddEoABYvfnSl6m9vDTX1fs/1bTA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G3AgAM7sRpgAMP49RaHgEBCxIMhFFoH140BAtJhFiPU?=
 =?us-ascii?q?4IhA4Q7mAqBaYFpAg8BAwENSgQBAgQBAQMDAYIMgnQCjSQCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDjuGFQY0DYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QINOkQBAQECASMdAQERJwQLCxoCGA4CAlYGARQBAYJ+AYIiAQYQAQMPJwcNB?=
 =?us-ascii?q?rJ9gTKBAYIMAQEGgVhB2EsfLCJZgWcDBhWBCi6Fb4JmAYYwhD8nD4FVRIE8g?=
 =?us-ascii?q?lIxPoJhAQIBgSA+g1uCaYImgQ6FOAaEKlSHH1J4HANZLAFVExcLBwWBI0MDK?=
 =?us-ascii?q?i8tIw88BS0dgSMhHRcVH1gbBwUSISqBAw+GZXkDLl4aDiICOVxKPgoBUgWCG?=
 =?us-ascii?q?AJsNCgCAQttPTcJCxsEPY0/MYItaFcCewqBAAgwDZMXAbMYNAeCOIFngWQMi?=
 =?us-ascii?q?i6VPwYTL5dSDpMLmQYijWebOIF/I4FcMxokT4JnTwMZD4M6imeEADOBC8c/R?=
 =?us-ascii?q?TICCTICBwIHDQMLhUQBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 hNk02ND
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:4WBLyqoqa5F3oMO8Mdwx+YAaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AU6yRmWlo2d8+8LEpPwL1nbBfenXXOWfn6lztLUq?=
 =?us-ascii?q?YMj10eZSOTVyL1vg8n/M7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3APDpwHA9qVOCue62FL/ZbfY2Qf+1pzvSBOB4zq54?=
 =?us-ascii?q?p/JSmKxRuAimE3B3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,141,1770591600"; 
   d="scan'208";a="142371690"
X-MGA-submission: =?us-ascii?q?MDHRqTy5yr2RQAxpgxBGGdQpTc++Vtz7HDLDV1?=
 =?us-ascii?q?6qYHmO9h1t9mGlKKcydaMSNur/zq2p/eJ9Ty3xwUG/O6YGnS+94sewiB?=
 =?us-ascii?q?28fwNNrdcjA04YdgYb5FMv5Q8UuF8Z+z3VtmAKQcdmUY/m7k7Hj/0J7+?=
 =?us-ascii?q?NycPi7vCCGFe1BtRoImIzgkA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 09:31:11 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjPUE-1vhqZ20ToQ-00ZgbU; Thu, 26
 Mar 2026 09:31:10 +0100
Message-ID: <7182887f-b0d1-407b-8b3d-e5d075d8b197@web.de>
Date: Thu, 26 Mar 2026 09:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <1f5a4f0b-ed5e-4e16-a39d-f1289b7a50aa@web.de>
 <73d88351-640-62a8-189-4e9f8a8a24db@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <73d88351-640-62a8-189-4e9f8a8a24db@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2tZZH8oD4zvc6CQiFTRIsOExQbaD9uP0U7g4dGUCcnTozpKf+t7
 jC/cUinoJHrYuIHvADtSLnsXX9u9PbUIeFQ2OipIXGThhXFs5qrF6GQwWhFZ/LpQo5pNTpy
 BJd2r1QsK0rEq3tXY5RidM04BT+ABH17z+y3ax6KCDoh+DhP/jk8jVtljArhWYJWaD7xb/V
 6k4qgyfyhJV7jecG4vYdA==
UI-OutboundReport: notjunk:1;M01:P0:MmBmFkAWC8Q=;8hhdCennVqxes6Jyk0t980o4ZoS
 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
Subject: Re: [cocci] Searching for function calls with known parameters (by
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3456
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/6X_mZV7HpGXaOTwJGkUh8A>

>> Can function calls be restricted to known parameters accordingly?
>=20
> I still have no idea what you are asking about.

I hope that communication difficulties can be adjusted also with help of
further (software) users.


>                                                  What is the connection
> between a function call being placed at the beginning of a function and
> the number of parameters that that function call requires?

I hope also that another description approach can influence evolution
in more desirable directions.


Various functions were designed in the way that they handle parameters.
https://cppreference.com/w/c/language/function_definition.html

The Coccinelle software supports the metavariable type =E2=80=9Cparameter =
list=E2=80=9D
to some degree.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/233b5ceb1d5a701fb270e=
bdf0a9bd6be0a6ce53b/docs/manual/cocci_syntax.tex#L233

Such lists support =E2=80=9Cspecial cases=E2=80=9D accordingly.

* They can be empty.
  Would you like to exclude this case occasionally?

* More than one entry would be provided.
  The list length can become more interesting then.

  It can occasionally be nice that parameters would explicitly be restrict=
ed to
  a fixed number of items by the means of the semantic patch language.

  Data would be assigned to multiple parameters.
  But it is not directly known by this programming interface
  in which order they get passed to a function call.
  The passed data can be handled by the metavariable type =E2=80=9Cexpress=
ion list=E2=80=9D.
  There are some development challenges remaining for the mapping of conte=
nts
  with the mentioned metavariable types.
  Which expressions would refer to identifiers from a specified parameter =
list?


Regards,
Markus
