Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EDFCCFA18
	for <cocci@archiver.kernel.org>; Tue, 11 Nov 2025 08:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=g3pLZY2Yfh+cUBWdhdRMVdKWUc2KluK8HnL/gI8mkCs=;
  b=ByjJQdaESJ0Pk/TAQtXDY0yulJ2tgRV88rcpDVTxp8BG/NsmrL++Kt0Y
   LFZZq2MlChXna4m0immqCrtvzx9bYKAhrW9CJAmAHCZYlb+Ze9VVQIeL/
   TnlBACkESlNHbyDVUlGX1e9XANghGkdSeyjjCDfFgYcdHLxyLgDzbEF6K
   E=;
X-CSE-ConnectionGUID: vjhjubojSmy25K01SUsBlQ==
X-CSE-MsgGUID: y/T+aTf8T0uesDq+rO9t1A==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.19,296,1754949600"; 
   d="scan'208";a="248565714"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2025 09:31:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5EDFEE0172; Tue, 11 Nov 2025 09:31:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EF19CE0171
	for <cocci@sympa.inria.fr>; Tue, 11 Nov 2025 09:30:59 +0100 (CET)
X-CSE-ConnectionGUID: 54ciUQ9EThyUA6tekvW+aw==
X-CSE-MsgGUID: XXnwHf9zTVaaOQKz8whefA==
IronPort-SDR: 6912f431_qLH9IrJeV5DXLMGV23u32LlOniRDjD9WfryALunNfjTd9pO
 x6KxIoGwdfBpuzCjcUffriSQmj6IcCJnkBGSWlA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EmEgD68xJpe07ASNlagQmBUIJAZR0GWDMEC0mEVY9Tg?=
 =?us-ascii?q?iRpg1KVWoQFgUA9Ag8BAwENRAoBAgQBAQMEOIFUgnQCjFsCHgcBBDIHDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEiIA47hk8NgluBL?=
 =?us-ascii?q?GQJOQEBAQEBAQEBAQEBAQEBGwINOkQBAQECASMdAQERJwQLCxoCJgICVhkCA?=
 =?us-ascii?q?QGCfgGCIgEGEAEDDycHDbBjgTKBAYIMAQEGgmnXdh8sIlmBZAMGgRwuhW6CZ?=
 =?us-ascii?q?QGJR4EfJw+BVUSBPAuCeD6CShcBgWFNgw6CaYImgQ6GJ5M5UngcA1ksAVUTF?=
 =?us-ascii?q?wsHBYEgQwOBCyNLBS0dgSQiHxgRYD0XQINJHAZoDwaBEhlJAgICBQJAOoFoI?=
 =?us-ascii?q?gYcEgIDAQICOlcNgXcCAgSCGX6CCg+JZncCAQttPTcJCxsGPZUUhDaCHynGM?=
 =?us-ascii?q?jQHgjiBZ4FkDIoulT4GEy+XUg4GkwWZBooJggWBepZ7hD6BbwsogVwzGiSDN?=
 =?us-ascii?q?h8wAxkPji0WhBGEYLojQjUCOgIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 7IRR7UdWFFnT5vy72x6EdZELJolBlsZ
IronPort-Data: A9a23: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
 Qw=
IronPort-HdrOrdr: A9a23:6HiiB66ihNIQ8/k2LAPXwBbXdLJyesId70hD6qkDc20wTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmslqKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ856U
 4KSchD4bPLfDpHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: =?us-ascii?q?9a23=3AjeWOd2j+KAi4HMhg7wEqsrrOYjJuLyHWzUrpcmK?=
 =?us-ascii?q?ECXdUYeOJRFyOx+BtjJ87?=
X-Talos-MUID: 9a23:jXOD9ARbjl6oUiemRXTctDd9FMk58ZiQAUkqqLYU69aEOCJZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,296,1754949600"; 
   d="scan'208";a="130502515"
X-MGA-submission: =?us-ascii?q?MDHe9XKikrnws5ZCVh4ghfa2BYwrSDO4sDBNpd?=
 =?us-ascii?q?JmIfdoqFQQhTfB79vJ2kSwiR2Nt1gykHLdgXkZGd6+YO6mb8gJECuBp8?=
 =?us-ascii?q?0wlMn1wO1hLVp4ET1sU4/7upZ1W3GiejSsJ3bMOmQRvnk/fDQZlLd4Na?=
 =?us-ascii?q?2qN1pj9kYfsH9FYFP/o113kA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 09:30:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762849840; x=1763454640; i=markus.elfring@web.de;
	bh=g3pLZY2Yfh+cUBWdhdRMVdKWUc2KluK8HnL/gI8mkCs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gbNNkVp6KHoT3C9a2fMbO3nmXdW7+J2asNerQzYCuFb8pkFMwCDJD++JyJwk2Fu0
	 fO4ZRhP/0Aiixr7Mn9A5ZcDr6oOV+XPx9bQYaOLh+lXC8pSGiWqLJXM1vwop2tpTa
	 ErjPPy5yt5IsECUua7oov2VjYwbnnO3cEuf0cTL8y7wpGZpF7vget0Q1CiTpvb0SB
	 z94wmkQPQM/H/aSm+GQd3YI9UMhPfGjqf43CXUR5UQfMA/9z2zqIVpa+tiV4claTu
	 9b48bUNEZFlSKw9ZfgmlLkxSgkx/LWNhexy2doTgrKRxD/KlQZVyB9PIk4N4dF4ZH
	 uCgK5K8h64ARmc3PqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M28WJ-1vLDoE3j1l-003zrN for
 <cocci@inria.fr>; Tue, 11 Nov 2025 09:30:39 +0100
Message-ID: <35cf08b4-4861-4c25-9ede-a4a39de5508f@web.de>
Date: Tue, 11 Nov 2025 09:30:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <a2551ccb-edd1-403c-bcd6-3f9cd5381bcb@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <a2551ccb-edd1-403c-bcd6-3f9cd5381bcb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XFO4sr8pt540fh8eoUzJVDZFPcDtJ3I90oCCcJ7bhX7Ccoa9ZOD
 Hax7sUufH3xv71M9yhnL6ntPudeuEq80sIDmwokLUwnzv/166taVXDVb/EYbWmnVJRxdTtW
 FxVYNgtX/5Qhba43G2Mg7fsA4iEZKSfMQJ9p9MykKdrEbfr88m382rbeVWdJXAeTajavwLU
 yKTP+4yr45ik51ern42Pw==
UI-OutboundReport: notjunk:1;M01:P0:EmYDd98jz88=;5kk2RxPj21AxrXaRz/G5G7C4mWu
 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
 kqyvQ==
Subject: Re: [cocci] Moving string literals with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3159
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/35cf08b4-4861-4c25-9ede-a4a39de5508f%40web.de>

> I would appreciate if another source code transformation can be achieved
> also by the means of the semantic patch language.

Will another SmPL script example trigger constructive development discussi=
ons?

@searching@
constant char[] last_literal, literal;
expression context;
@@
 seq_printf(context, literal);
 seq_printf(context, last_literal, ...);

@script:python recombination@
x << searching.literal;
y << searching.last_literal;
text;
@@
coccinelle.text =3D cocci.make_ident(x + "\n" + y)

@movement@
constant char[] searching.last_literal, searching.literal;
expression searching.context;
identifier recombination.text;
@@
-seq_printf(context, literal);
 seq_printf(context,
-           last_literal
+           text
            ,
            ...);


Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops crypto/rng.c =E2=80=A6/Projekte/Coccinelle/janitor/comb=
ine_selected_seq_printf_calls2.cocci
=E2=80=A6
@@ -81,8 +81,8 @@ static void crypto_rng_show(struct seq_f
        __maybe_unused;
 static void crypto_rng_show(struct seq_file *m, struct crypto_alg *alg)
 {
-       seq_printf(m, "type         : rng\n");
-       seq_printf(m, "seedsize     : %u\n", seedsize(alg));
+       seq_printf(m, "type         : rng\n"
+"seedsize     : %u\n", seedsize(alg));
 }
=E2=80=A6
real    0m0,493s
user    0m0,249s
sys     0m0,109s


See also:
* Clarification approach
  Propagating values back from Python script to SmPL rule with other metav=
ariable type than =E2=80=9Cidentifier=E2=80=9D
  2016-10-22

* Contribution
  [PATCH] crypto: rng - Combine two seq_printf() calls into one in crypto_=
rng_show()
  https://lore.kernel.org/linux-crypto/d9574f40-8d0f-4f14-bc9f-b29c56069b8=
b@web.de/
  https://lkml.org/lkml/2025/11/10/1357


Regards,
Markus
