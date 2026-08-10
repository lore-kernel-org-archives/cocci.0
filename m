Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9231FC61CE4
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=u7n5nk1Q6WJ0NpVun5yyD9tXGMGsft6OO/yOgrv960I=;
  b=vjBdnVh27INAtJH/4EcevRM+iMc0/kqaKsA+vVKRNiiDadE8zPSj2Lzy
   zdaadVXdOYb8IeyHBru+tePcVZ472xpcJRnQJDW0LEBrCHUbxegyOLaM7
   dl44PEimEb6KsWVnBjr1zYG+2vXOzoFMFyCasmILTavADLBg1DmDtbEP2
   w=;
X-CSE-ConnectionGUID: zDAkvHzzTfW4vQ4EMiX4DQ==
X-CSE-MsgGUID: 7oVRn6BIQRS4/f00yvS50w==
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
X-IronPort-AV: E=Sophos;i="6.25,240,1779141600"; 
   d="scan'208";a="291206777"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:02 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A56DD8147B; Mon, 24 Aug 2026 09:35:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 6BA3F80F7C
	for <cocci@sympa.inria.fr>; Mon, 10 Aug 2026 09:13:13 +0200 (CEST)
X-CSE-ConnectionGUID: +IfYdIW7R2G1d2Zev1fVxw==
X-CSE-MsgGUID: VwMAKJchSgS5KuLCWCei4Q==
IronPort-SDR: 6a797a08_tTWDOYWh2IJ2Se2ArYzPHwMqLcBl9r9rl9gDxANMNutaD3m
 DezGkizc2/Ni9G2k1IUtnAxIvmBiGyYqO1GAOLQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GVAgCHeXlqdxpEz2haHgEBCxIMggULghgpgQpfMwcIS?=
 =?us-ascii?q?YRYiHqIeQOcRoNRAg8BAwENRAsCBAEBAQIEhH4CjWcCHwYBBDMGDgECBAMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABQ0mGTw2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQINfQEBAQECASMPAQ0BATcBBAsLGAICGA4CAhBGBoMWg?=
 =?us-ascii?q?iIHJCcDEQagCnqBMoEBggwBAQaBWxjcKAMGFYEKLohBHAEFboUFhAJ6JxUGQ?=
 =?us-ascii?q?IFNgRWDKz6CYQECAYU5gmqCJoEMjAiGXlJ4HANZLAFVExcLBwWBI0MDgQYjS?=
 =?us-ascii?q?wUtHYEMFyEdFxceWBsGBRIgKkFEIwM+HUMFgU4CgXQ/Ixk2fIEJXoErKmQBA?=
 =?us-ascii?q?hAXRi4VgjUCgnaBLQQRC209NxQZBI8qIIFTbAdhGgkFLwIvgU4BBnOlK4t4l?=
 =?us-ascii?q?ReEKIwhhyeOYIQEnyKHRi6YWoJZhyiBL4JalWAEhVWBfiSBXDMaCDCDIlADG?=
 =?us-ascii?q?Q+OIYE2AQmDA4RSxyYkNQIBOgIHAgcOAwuFQ4xZgUwBAQ?=
IronPort-PHdr: A9a23:xmQQVBerJWNgbKH5kAAEdYyklGM+QtfLVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASXG92CoKMU1bqempujcFJDyK7JiGoFfp1IWk1NouQttCtkLei7TGbWF7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 Ri4rAjdrNUajZZtJqs1yRbEo3hFcPlKyG11Il6egxnz6sCs8ZB57i9eoegh98lOUaX7e6Q3U
 7lVByk4Pm42+cPmqwDNQROA6HUEXWoaiwRFDQfY4h3iUZj/riX1tuxm2CmHJsL2Vqw7WS6j7
 6hwVhDljjoMOiMj/2HWjsxwi79boA6kqhdizYPYfJ2ZOfxjda7GY9gUWXROUdpQVyxZA4Ozc
 Y0PD/YaPe1Fq4XxvkYCoQeiCQWpAu7k1z1GiWLs3aAi3eovER/I0RI9EdwNvnTbo8n6O7odX
 ++316TI0TbOYulK1Tvh9ITFcBYsquyMU7JqdsrRzFEiGQLYjlWKtIzuIj2b2f4Ws2OG8uRgT
 +Ovi2g9pAF+vDev3ccsgZTOi4IRy1DE8zh5wYkuKN23VU57e8OkH4ZKuCGBLYd5X90tQ39xt
 Ss817YJtoK1cjIQx5Q72x7QdeaHc46Q7x79WuicPSt0in1hdb6hgxu/70ytx+n9W8e601tGs
 ypInNfCu30C2BHe6MuKR+V98Eq9xTqDywHe5+5KL0wqlqfWLYMqzLA3lpoWq0vDHyn2lV31j
 KCIbEUk/Pan6+D9brXhvJ+cOIl5gRz9PKQ2gsGzHPg0PwcUU2SF5eix1qfv8Ez6TblQkPE7k
 7HVvI3GKckZvKK1HgtY34k55xqiDzqr084UkWQDIV9DZRmJlZLmO0vUL/D9Ffq/g0qjkDNsx
 /3eOb3hH4nNImHHnbrvc7d981dQxxAtwd1e/Z5UCK8OIPb3Wk7xutzYDwQ5Mwyuz+b8CNR9z
 Z8eVnyKAq+CKK/SsFmI6fwzI+SUeYMZpDnwJ+I76/Lyj3I1g14QcKqz0ZcJaX20BvFmLF+YY
 XrojNcBC2AKvg8mQezuiV2CVyNTZnmpUqIz+zE7Ep+mAprZSYC2mrCOwTm0HoNOamBcFl+MC
 Wvod5mDW/oUdC2SJdNunSAFVbW6UI8g1RSutBfgxLZ9L+rU/DcYtZP529Rv6e3Tjwk+9TpvA
 MuFyWGCU3l0nn8URz8xxK1zvFRxylid3qh/gPJWD8Re6P1UXAsiL57T0fJ6BdPoVA/ZedeJV
 UqmTsyiDDw/QNMx28YCbFxjF9ijlBzD3TSlA7sRl72LCpw087nc33jrK8Zmy3fGz7UhgEcjQ
 stULWGpm61/9wnWB4PRi0uXmKile7oA0iPR8mmP1XeBvERCXw5qTarIRWgRaFLOo9r2/k/CV
 KeuCbo/PwVb1cOMN7ZEZsXyjVVeSvfsINTebHy1m2e3HRuG3K+BYpf3dTZV4CKIKlUAkglb2
 X+ZPAw6TnOjvmbfBXpqHE3mZ0fE8O9kqXr9QFVinC+QaEg0+Kev51Y5jOfUcOkS2LsLtTwh4
 2FwHVCgz/rZFsCdqwN6OqlRf4Vusx98yWvFulklbdSbJKd4iwtbKlwv16uP/xB+C4Eb1NMvs
 Gtv1w1qb6SRzFJGcTqcm5H2ILzebGfor1i0c6CD/FbY3Z6N/7sXruwiogDnvQe0BmIt7m963
 9BOlXeR+MaCFxIcBKr4SV1/7B1mv/ffayg56ZnT0ChoMK+pohfNxsg0COI+jBqtYYQXK7uKQ
 Tf7CNZSHM2yMKoqllyuOwoDJ/xX/bUoMtmOcOaanf/wI/4llWj4y2ZK5IRs3EOX92xnW/XU0
 pMeqx2B9i2AUTq0zFKos8Ss3JtBeSlXBW2njy7tGI9WYKR2O4cNE2anZcOtlJ14gNb2VnhU+
 UTGZRtO0dK1eReUc1323BFBnUURr3u9nCKkzjty2zg3p6ub1SbKzqzsbh0CcmJMQWBjix/rL
 +3Wx5geXU61fyAmiQG46U/hgaRWuuU3LmXeR1tJYzmjN3trAeO7sruPZdIK6Yt96H0LFr7kP
 hbEGvin/Uh/sWurBWZVyTEleiv/v5z4m0c/k2eBNDNoq2Kff8hsxBDZ7diaRPhL3zNASjMr7
 FufTlW6IdSt+s2Z0pnZteXrHWagUIBDWSb2156MvTD96WB0S07a/bj7ipj8HA423DWund1rU
 zjYhBnheJTn3r/8Pe95NBogFBr37Mx0HZt7m407icQL2HQUsZ6S+GIOjWb5NdgzNbvWVHMWX
 nZLxtfU5FOgw0h/NjeSwJq/UHyBw8xnbt38Y2UM2yt74doYQKuT6bVFm2NyrD/a5UrVYP5gj
 h8S1OEz5HcBxe0EpkIhwz6cDbYbAURDdXW0y1LSt4/48vURPjjneKP4zEdkmNG9ELyOx2MUE
 G30fJsvB24478lyNk7NzGym74jlfNfKatdA/haQkhrGk61UMMdozqZM33I4fzyt+yd7mItZx
 VR00Jq3vZaKMTBo9aO9WVtDMyHtItgU4nfrhLpfmcCf28auGI9gE3MFRsiNL7rgHTQMuPDgL
 wvLHic7ryLRHbvZAB+351p8sn7GCNanOm/ddxx7hZ1yAQKQIkBSmlVeWDQ8g44RGR2w2cDoa
 wF16y5btRbo7xBLzOxvLRz2VGzS8RypZjkDQ5+aNBNK7wtG6hSwU4TW/qdpEipf5JHksB2VJ
 znReVFTFW9QEB/MFxX5M7Kp/9WF7+WIGr/0Ma7VebvXzI4WH/aQmcDxjM08rnDVa5TJYCUlV
 aJz21IfDy4iXZ6Ew3NTEGpJy2WXMYaavEvuo3wn6J3jtq2xB0SxuczVVN4weZ1u40zk2PbTc
 bfP22Agc2kej8lcgiWYgLkHgAxL2nEoKmXrSO5f83eXHOWKxMo1R1Yac38hbZMUqfhkgU8Ta
 YiDzYmpnr9g0qxsWgcDDAO+3JjzOopTcjv6bgyPEk+PMP7uySTj+8jseuv8TLRRiL4RrBiso
 XOAFFelOD2flj7vXhTpMOdWjSjdMgYM8I26dx9sDyDkQreEIlWjN8RriDQt3bAurnTXKStNa
 idkNkoX8PuS4Cdck/t+AGwH9Wt+MeSBgG6V4vLZJZAfrfZwZ0Y837sCvDJgk+QTsnECHqI9k
 TCattN0plC6juSDgiFqVhZDsHcDhY6Gu1ljJbSM9pREXiWhnlpF5mGRBhIW4tp9X4S35+YKk
 oeJyvK1cmkRlrCctdERDMXVNs+dZX8oMB6yXSXREBNAVjmzc2fWm01alviWsHyTtJkz7Jb2y
 /9sAvdWUkI4EvQCBwFrBtsHdd1zXzU5gZaUkdQV6XOl6hXcWo8J2/KPHuLXGvjpJDuD2PNcY
 AAUxLrjMYkJHormxwkzMUZi2Y2QRQzSUNRJsyNgdQ9yu1RW7HV7VSdgviCtIhPo63gVG/mum
 xcwgQYreuUh+gDn5FIvL0bLri89wwEh3M/oijeLfHvtPb+9CMtIXjHsuRF7YfaZC05lKBe/l
 kt+OHLYSqJN2vF+IHtzhlaUsNNZEPpYB8WshTcf2OuKa/wzl1hRtHf/raeozeTYE4ZunRBsf
 ZOy/SsoM+NLa8MpYP2LO7IMxwIOwKCDuiu52OEqwEkFNl0R/WaJKndghQ==
IronPort-Data: A9a23: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
 XcdHQh5fa1wdaI9/QuMtZKY9NH1cQ4DFwkVUBo=
IronPort-HdrOrdr: A9a23:5vfbtaC/afQRka7lHemM55DYdb4zR+YMi2TDGXoedfVwSL3+qy
 nIpoV86faUskd0ZJhEo7q90ca7LE80maQY3WBVB8baYOCEghrMEKhH5YvmhxLnHij56PJFkZ
 pnGpIOa+EYb2IbsS+S2mDReOrIguP3kpxA7t2+854Cd25Xg/4J1XYANjqm
X-Talos-CUID: =?us-ascii?q?9a23=3A81COtGg+zchRGvKIJMm0GYSZLTJuMVzT/XvxHBC?=
 =?us-ascii?q?CU0kwROenREHJ9p10jJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3ABIa5tA7/o8VPbXDhdkRHL+HRxoxW/IGHK2IGka4?=
 =?us-ascii?q?JgJSnKAhbBByQjWiOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,215,1779141600"; 
   d="scan'208";a="153949520"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEtMNbBr/mTaEYgtHx6aoAgu8dXyedStm5/ye?=
 =?us-ascii?q?JDwIs/GwxdRuQzUyad4CViZyU0eHwNjfroN7YoTYN+hmVjVr6VAPwer2?=
 =?us-ascii?q?5wFtU7b9OR05iSk4A0Lz7OzSMcLA5vgFQ/YbpNOSENdFqwoSq5ehaToF?=
 =?us-ascii?q?uGDHQp/Fn7/LzfCnpBuDvz5Q=3D=3D?=
Received: from out-93wp-a26.jellyfish.systems ([104.207.68.26])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 09:13:12 +0200
Received: from gurudas.dev (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hJQvP45D5z2xBB;
	Mon, 10 Aug 2026 07:13:05 +0000 (UTC)
Date: Mon, 10 Aug 2026 00:13:03 -0700
From: Guru Das Srinagesh <linux@gurudas.dev>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	cocci@inria.fr, Brian Masney <bmasney@redhat.com>,
	linux-clk@vger.kernel.org
Message-ID: <anl5_3932XfoJH9P@gurudas.dev>
Mail-Followup-To: Julia Lawall <julia.lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	cocci@inria.fr, Brian Masney <bmasney@redhat.com>,
	linux-clk@vger.kernel.org
References: <20260809-cocci-clk-register-v3-1-60d036e13370@gurudas.dev>
 <b93bd4ac-d76b-2dfe-6945-7111ff20f41b@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b93bd4ac-d76b-2dfe-6945-7111ff20f41b@inria.fr>
X-Envelope-From: linux@gurudas.dev
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3] coccinelle: Detect clk_register()
 anti-pattern
Reply-To: Guru Das Srinagesh <linux@gurudas.dev>
X-Loop: cocci@inria.fr
X-Sequence: 3696
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/NtNf-UCFdX2ApI6td14WQg>

On Mon, Aug 10, 2026 at 08:53:35AM +0200, Julia Lawall wrote:
> 
> 
> On Sun, 9 Aug 2026, Guru Das Srinagesh wrote:
> 
> > Enforce commit 12a0fd23e870 ("clk: Print an error when clk registration
> > fails"): clk_register(), clk_hw_register(), and their devm_/of_ variants
> > log their own error on failure, so driver-side error prints after these
> > calls are redundant.
> >
> > Two independent match families, one per return-value convention:
> > pointer return checked via IS_ERR() (clk_register()/devm_clk_register()),
> > and int return checked via a nonzero value (clk_hw_register()/
> > devm_clk_hw_register()/of_clk_hw_register()). Both families match
> > regardless of whether the redundant message's "if" also has a trailing
> > "else", via an "else S" clause with S otherwise unused.
> >
> > In "patch" mode, removing the redundant message also collapses the
> > enclosing braces when only one statement remains, and deletes the whole
> > "if" when the message was already the only (braceless) statement.
> >
> > Assisted-by: Claude:claude-sonnet-5 coccinelle
> > Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> > ---
> 
> Hello,
> 
> Thanks for the update, which I will look into shortly.

Thank you for reviewing.

> 
> But you are not structuring your patches in the right way.  The part above
> the first --- is what will go into the git comit.  That looks fine.
> 
> But I don't understand what is the big pile of text below the ---.  When

That is the cover letter for the patch.

I use the b4 tool [1] which is increasingly being used by kernel maintainers and
contributors alike to work with LKML.

When there is only one patch in a patchset/series, b4 puts the cover letter under the
first --- of the patch as described in [2]:

	When you only have a single patch, b4 should “mix-in” the contents of the cover
	letter into the “under-the-cut” portion of the patch itself, where it serves as a
	source of additional information for the reviewers, but never makes it into the
	actual commit.

[1]: https://b4.docs.kernel.org/en/latest/index.html 
[2]: https://b4.docs.kernel.org/en/latest/contributor/prep.html#what-if-the-series-only-has-a-single-patch

> there is a new version, I want to see what has changed as quickly as
> possible.  So the changes in v3 should be the first thing that I see below
> the ---, not the last thing.

Sure thing - I will make sure to put the changelog right under the --- as you
described for any future revisions.

> 
> For the following information, I'm not sure it should be here at all.
> Either it is important, in which case it should be above the --- so people
> in the future can easily benefit from it, or it is not important, in which
> case it should be dropped.
> 
> julia

For reviewers' convenience, the cover letter contains examples of the kind of
transformations that this script will create when used which I think would be too
verbose for inclusion in the commit message but useful for reviewing otherwise.

If you feel it is not required/helpful, I could remove everything but the changelog
from the cover letter for future revisions. Alternatively, I could put the changelog
right at the top so that it appears right under the first --- with the examples and
other stuff following that. Going with the former unless you say otherwise.

Thank you.

Guru Das.
