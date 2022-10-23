Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CE8ECAAA1
	for <cocci@archiver.kernel.org>; Sun, 23 Oct 2022 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GVeviJyh0tdM1llmTYt7UBaFLZ9L8mIen6BVT0jzc0M=;
  b=YL0Cy14kmcV5MdKWIHBAp6f38MRxdSvQTlvl9rh2ega9WLop65qMuU7N
   88hoNT8crB5qU+PqkqPwPtTajozgtC9w6J1TYqpNy14b9/FTOTu8uI+RA
   apDz+2lR7OwHUCzz98fGRWin5ecnUB+OADg1pysk0Ac4cR8MblY+LTJla
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
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="67926127"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2022 15:55:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F235EE013D; Sun, 23 Oct 2022 15:55:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 09B17E004E
	for <cocci@sympa.inria.fr>; Sun, 23 Oct 2022 15:55:26 +0200 (CEST)
IronPort-SDR: 635547cd_NsXUqt9KUcdYVGBgg6tlT0rVhGyqH3Yb+Mfdc4+qF1PL+1c
 60NJw2b6Tb7DeGlyAMQ3txB1fPeuxQeX7TV0hPw==
X-IPAS-Result: =?us-ascii?q?A0C1BAAjR1VjhwsR49RagQmDfIEBVi4EC0UDhEuRGmmSA?=
 =?us-ascii?q?YwwDwEDAQ05CAECBAEBP4FTgnMChHECHQcBBDQTAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBEwEBARkJFwcOEAUihWgNgjUpAYNkAQICASMdAQERJ?=
 =?us-ascii?q?gEECwUGGgImAgJXBhMRgmwBgmwBAw0jBwyrVIEygQGCCAEBBoFAAYMNHywiU?=
 =?us-ascii?q?4FdAwaBESyHI4g+eicQgVVEgUiCdz6CS4F5g1eCZo8Phkc4A0QdQANGMg1RH?=
 =?us-ascii?q?DEnDgkfHA4XDQUGEgMgbgVBDygvZyscGweBDCooFQMEBAMCBhMDIgINKTEUB?=
 =?us-ascii?q?CkTDy0HI3EJAgMhZQUDAwQoLAMJQAclJDwHWDoBBAMCECI8BgMJAwIkgUoxJ?=
 =?us-ascii?q?gUDDRclCAVOBAg6AgUGUhICChEDEg8GJ0cOSj45FgYnRAE0Dw4WA2OXAoElc?=
 =?us-ascii?q?oE7L4FwwS+BATQHgh2BSIFLDIlulRIzA5ZkBpITlyGNQZozgXkjgVszGiSDN?=
 =?us-ascii?q?hIBOwMZD4hLhW6EDIRhhUw/NAIBOAIGCwEBAwmFRwEBhRUBAQ?=
IronPort-PHdr: A9a23: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
 Kc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QSO5Bqnu5qygvA+lt/VUfR8JerXpDfLe3DAbv31ZSRFFG/FwWf
 rPoB19726KtN9xYgBDpTnkAsK9qBznhPtICOUqU4tKfTOW3FdAabsSi7cKoAeNJ8SdzIFgPM
 5bGsASNDSzNykCsS4+izPIdOrIq+P3k5xA692+815QbUVNd7xq6Rt/Bz2WC0tsWWB9dOYE/e
 Gnl7F6TyHLQwVsUi1XPAh5Y8Hz4+Hq0LbrewQPCRJi1RmWgVqTmcbH+5P05H0jbw8=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="33202893"
X-MGA-submission: =?us-ascii?q?MDE72pq+K2SlABSGGbxwzs1Llmej+obBcetm3T?=
 =?us-ascii?q?Dq0tQT2fzCKx3ZTRcEKDPUk9xG2AVsGyEP10lzDWhQSgx4tcnUxoxwk+?=
 =?us-ascii?q?5Xehp9T/af6GvU6wN2xZx3Mgk1L+BLF2bkZfz9XyJPALIBnpcyeH+5hC?=
 =?us-ascii?q?lZEDSg9/UFW5UbFCh00tAmfA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 15:55:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1666533323; bh=PY+M4pmUk+7ipJEOeD+ag97R0W87pidWn9xQFSNEalw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lq+r6NT4yCCTBUlr4Tedwy9f6TQkQGEC7PA/PD4H77q3PCkgWTo8TuW+ov5uiLkTn
	 /xu5/7xfzopJFfnVyRmJpIJcoDGAdWo18Jx31TdopEdFC8pdrEqnKl4W3H44asedvV
	 mPpI0+qKGHkvrsoUUxgUASiaDpO1hN2MhPFVdsoBzptqTF/C248+DC67rWKdGcqDhC
	 xWPeQpU+/qiPJ0tddkK1u5Y9BZ6/TrNmgta8TwkpcoZJkdsxb+trwm0+uyUM3JPBlC
	 /WgbUK2+jaXIbWGQWiHOqDEyXgVYpoQK/exdypwmMg8zF8IlpCyY/DCR6hRVj16k+r
	 XpLcxz79TJNzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.80.160] ([94.31.80.160]) by web-mail.web.de
 (3c-app-webde-bap48.server.lan [172.19.172.48]) (via HTTP); Sun, 23 Oct
 2022 15:55:23 +0200
MIME-Version: 1.0
Message-ID: <trinity-3c34f082-c650-4c08-9ff9-f746f20e4183-1666533323595@3c-app-webde-bap48>
From: Markus Elfring <Markus.Elfring@web.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Oct 2022 15:55:23 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
 <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:gJIj5B7and9iLvjfO17aA2vrYyDa9yj7D9zNHew2y7FiImbmt1chDuZyDSjdyVkQHHnCF
 l3ViC84aYmMDrJ3Av4K9jn0dGIfYUN49sCm6LoBSQsvE/wCZ05HHCfmL44x7fxvzoRt/WK7tvuiD
 5PLPuJPQ+gYyzDDtUThQ1FeRRGnQ0FyNcNrSWcIEVbuMnzYhBzD++VAfx9vCiv2SH+Je1LKTxlbW
 aUkwNczZMR0gb76yzz9BP9iOwLCS45FbedxWnNjUmyv1TjejDwVUl3l52cd3Qhiy9CP0ip29aDiI
 S0=
UI-OutboundReport: notjunk:1;M01:P0:wzco965Zw4M=;SoSt1xTkLvC+rMadExQjrMD16wd
 nAyjsNoAYzyLm2XjGibyxUQZxCnO5Ex9RREL3u2sDb3l838mVFPqcBfG5K092HZmDBZQ++61H
 ensOUpwVXUvgSw21kWkvbrbznOcLEZCHpDTb4FUMA2+qSFTLI2wNzMaSPuVdO976Rr1/dIpkX
 +ioqFC6TgHJ0a0kwOlb0blWx9D6RmypDRCE8gL2lzO3i6o0oH1bTIx0SwtVNloocBSMQUO0uW
 D4aW06Kziyc9VFGfHkzrdwXSlHYHXaCSWCaRyxgyX8UZadmIkiEoSET6q4Xaaw+wNbwMHjJR3
 zseNCjh5nDe3DeB6oO/lql+/8nCb1FcAYjyFpkaLdqk+bWHHeuWSt1uzw785a4wUvSDQQ4iC7
 jpg8hdzgG+bve+/uJjsQWxDnuh9oXK8CRqGKZkLWUFWjtw9+bfIBW23tRuhZkDY1s4qhPYbCb
 DG+KkyrIvAc3kzJFNN1lVvKjitr68o+D2r1qexxjKmW2ZOowujao+2TIn1bmh6IXihgBpRZZJ
 3Mcn2LcWXjJRJiZAjqlKofVJDRTRQdJ/PfUEvNjVT3tOHaEXYsSneguaX519UovQ2FtuPlLS9
 IZ130nGb7NUdawfkEUBIzz88axGokDg5jX5hrY6pYZ1Ejjb2xOzmxJyKxXu8LYFfiipyuXlHP
 0NJWSC3Z8EbeSRdMnBHBcphPOQHGz+d89rBSX2djJ5TJZOWnThTbJv9lS0GZbCR9dBtkIRDkM
 R+7x1t0btMVuMGYbTDHi8imw7qIjlRn0G4tQyoQ+O75u1GsrtMXdrOLAGV9jDMKDAzurHkdCg
 PQ5zqvW8olxUmN9RWOqQJm0PsHJg0oGnbJWBe2YYCRZig=
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] algebraic simplification possibilities with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 673
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-3c34f082-c650-4c08-9ff9-f746f20e4183-1666533323595%403c-app-webde-bap48>

> There's another one in that series that's kind of interesting:
>
> https://lore.kernel.org/lkml/20221022014403.3881893-6-Jason@zx2c4.com/
>
> This one has a very simple rule:
>
> @@
> expression H;
> expression L;
> @@
> - (get_random_u32_below(H) + L)
> + get_random_u32_between(L, H + L)
>
> This worked as expected, but I had to do a lot of hand simplification.
> For example, a lot of code had a pattern of:
>
> get_random_u32_below(H - L + 1) + L
>
> which then got converted into
>
> get_random_u32_between(L, H - L + 1 + L)
>
> which I then had to clean up manually into
>
> get_random_u32_between(L, H + 1)
>
> It's not like that's all that hard to do. But it would be cool if
> Cocinnelle had some sort of algebraic simplification possibility.

I imagine also that it will occasionally be nicer if further optimisation
rules would belong to the standard functionality of the Coccinelle softwar=
e.
But I guess that you can achieve desirable transformations also by using
additional rules for the semantic patch language.

How do you think about a change approach like the following?

@cleanup@
identifier H, L;
@@
 get_random_u32_between(L,
                        H
-                         - L
                          + 1
-                         + L
                       )


Regards,
Markus
