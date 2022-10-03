Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADEBC433FE
	for <cocci@archiver.kernel.org>; Mon,  3 Oct 2022 07:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9cXsR1fSqNAD6ptHKqOtESOXAwGvxiaBZezRbP2U0bw=;
  b=rv3qxMJ3Rm1MU27AUmTIQMJMTJ0t1aPHUyj5xUBjSD4LMi1lVYIO+0+J
   8otF261M1My4drcmOOGTsSWSw7wZUIs6RwM+0lVzoz7niqE45KaaV2QJh
   aNblhlLfTdEhPLNs/MHR+giuYxvYp44YQkTiVH/kgnMuxliVZrTJ0+Ej6
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
X-IronPort-AV: E=Sophos;i="5.93,364,1654552800"; 
   d="scan'208";a="55604498"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Oct 2022 09:36:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 72B3FE028F; Mon,  3 Oct 2022 09:36:32 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5B8D3E0076
	for <cocci@sympa.inria.fr>; Mon,  3 Oct 2022 09:36:28 +0200 (CEST)
IronPort-SDR: 633a90fc_t1r74sYX2oBiorkZghTizfbS1oyB4Hj1jvegXJai+fC7vkh
 9xDBrWBRL4I+ia7beL1/k1W7ABKyGsswO1XwTqQ==
X-IPAS-Result: =?us-ascii?q?A0DEAwDYjzpjhwsR49RaH2qDc4EBVi4EC0WETpBnMYQoj?=
 =?us-ascii?q?j2MKwsBAwENOwQBAgQBAYISgnMChG0CHQcBBDQTAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBEwEBARkJFwcOEAUihWgNgjUpAYNkAQICASMdAQERJ?=
 =?us-ascii?q?gEPCxoCJgICVwYNCAEBgnkBgmwBAw0jBwypD4EygQGCCAEBBoFAARVBgjcfL?=
 =?us-ascii?q?CJSgVwDBoERLI8weicQgVVEgTyDAz6CYgEDhTSCZpR1hHEmBA4DGSsdQQIBC?=
 =?us-ascii?q?0I1GAMUAwUhBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCBhMFAgJNNAgECAQrJ?=
 =?us-ascii?q?A8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHExgbGQEFMicOCSEcC?=
 =?us-ascii?q?gQaDQUGEwMgbwUKOA8oL2krHRsKgQwqKBUDBAQDAgYTAwMiAhAqMRQEKRMSL?=
 =?us-ascii?q?QcrcwkCAyJmBQMDBCgsAwkhHwcoJDwHWDoBBAMCECI9BgMJAwIkWXYCMREVB?=
 =?us-ascii?q?QMNGSYIBSMXGwQIPAIFBlQTAgoSAxMPBidKD5lnghNhWYJKoQyBM58RNAeCG?=
 =?us-ascii?q?4FFgUkMiWeUaAYTLpZoDgaSCpcNjT6aLYF4I4FbMxokgzZOAxkPjjmEDIELi?=
 =?us-ascii?q?SI/NAIJMAIGCwEBAwmFRwEBhHABAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ydCiyK5DZn+LR/LbbAPXwNHXdLJyesId70hD6qkXc3Fom62j/f
 xG88526faZslkssRIb8uxoRpPvfZq0z/cc3WB2B9aftWLd2FdAQrsSjrff/w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,364,1654552800"; 
   d="scan'208";a="55604492"
X-MGA-submission: =?us-ascii?q?MDH6p4CJZs/ZW0/H0tuZjTYQtbLoFVnoFq02lp?=
 =?us-ascii?q?dw/K387blVmy4mVdvkBgxbSBQAj1Tu4dQ2wb+6aDDu6hSpIln4R1eb21?=
 =?us-ascii?q?6Nm+3dIvp/cIcVGnRF7kcvje9nYTSWudIf8txLutZ1WtThKGjzuAK+mZ?=
 =?us-ascii?q?c13khRjkghpdtnpgpE5spURg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 09:36:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664782576; bh=9cXsR1fSqNAD6ptHKqOtESOXAwGvxiaBZezRbP2U0bw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MyZ5ou1i+JXOdo/qOhw0wF2M9yZxW/vJdAAQhd1GA+mV4m29AG7HKCzyuV8swCDgt
	 ns+Q1PR5UfPVIYiarUzpLuRFKyMGsN5TdGjNnf3DgCRtfwu1GGyAfz5G3SPwOpVQyB
	 WwTNQKTTEXhClrDxqZFvcMRUUYS3xgKVMLn5f40GJxF+UmPAvOyGmDIeyksXfAERDF
	 L7/j/AsdLLXR5dru+qmTVA8iDDWnqD6J1W64zJkhXsstZ8lZo1TJJQRV1vGgkAIlJu
	 tEVl/Z4GJf4AVIbNsyvdEUd8k5FB/UwSjOkBLOT3NveiSQvBF7PQ3KRvdbI/taFmOv
	 lbn/HyudcxgPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.160]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5Ug4-1pG3xa3Sm2-0177SS; Mon, 03
 Oct 2022 09:36:16 +0200
Message-ID: <e92157ec-d270-06a0-972f-a70ae04221d4@web.de>
Date: Mon, 3 Oct 2022 09:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Yuan Can <yuancan@huawei.com>, cocci@inria.fr
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
 <fbdb47a7-1673-b741-08cb-5703931a8b2a@web.de>
 <20be8691-3860-8c6-a169-1cbc332015e2@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20be8691-3860-8c6-a169-1cbc332015e2@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3jWP+6ndzrkTp3WMUXbwuqLP1+bkCLhXb+ZYkxvtVyI6iWjVtVM
 xzqHuQuZ+fOTMW5kaHqBPmGCQD8iuOHdIqCocintrRoUsDEmJfKokfdXvwtftNM5L80U0dp
 olYyLbOEd0hYcFdgnAT7dK61u2jSZGeb1FKAvy3enGTpl2eJSHQOj30qeGjcNH0bgZ0Av08
 KDDnn7uSRyVvzghwQfWTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5AijY4d3bV4=:7qENTMhkIw89E4E7T2LIQS
 FdXh408t7xiijCbJKYEgjqHPOlOD0SGqPpTFh5lgvioaFZdVofOm0deb7+ttxWcFVSP8Lk77E
 /ioj8eH/lChInUt/ccCWBofm8OFlS54T95Cx+wmDvTZ3GF4AwraI0vZwJ/w1mHtJWQ4hKOM1h
 Ly0ix03fyWTjbfU96Le678tXBdpdkr83NA01zuAXm1Br8zdgvUNS0MH6WW2SeZKVANAwNWvFG
 tMk7PiAFhRGFWSfvULjnp1bSgCJ1RM21528l3Rcql92kJVQ+rbX9g9+yCCIJ8EPQgB9Jn0hhO
 L/5OXAbUFonHln0rA4L3fkqgUdOh4/piWgZUAPpITaTlAkihEm8vUC2xwgnLNgVaW7MLsKrOR
 xPr8A4fBG2bMqwVqDlHRwPhO7mG5rKR6TZbylDJwsr1sjG10jpQk6vBsDAA5b9dQjqbCWldFM
 MK2bI5vasyrN2kClJh8iXhGPljnCJuSgUgsXjwQ0uWEdlGvTjNqZb2l1U+YrT/U3U5aw4jA1O
 YYn+clgoH2gAfOioEhIH/Q5l5xx1jQY5u0Hxlv5tAsf8h634b7nZy1E0wFIquwsXgEC7fOOrQ
 4GeLDwO0rBro+hFmJXJqoCRxukERjhj3cQTJgTXobVP3JNp5t0DWs6N6TKW/WAsCZexjdbRBf
 zm46rgVMkQxejdrF6G4z3wiJhFZhN+gVRigVhbXW9noKqoLSP80uKdd9Z0t3+VEDeoovVwx4T
 GQPYssHQvWvcdd1ohZnZ5uK0DI10ij6BHneEJhLuBp4qDt+rX70uh9tveHVwznpdZ7gYJqmDK
 t+zC2KPsfdMFPjkH1kRWchFqW1QjsFpBSXQTO6V1A/eoOnv/y5Db9vPyjUpdwZWXUHzR0YT/h
 0dEL4NbAtgd8iQxsI3E8+NaJFn2hnSgf570y+BywnEJQ+Uk192keUjpDBVwnsM35CB2I1Mvz8
 kdtMsbn1N2xrDnB7YKsWp8uMUHuubCO3V2VeW2XzvxvAiflLnVwgJ9xuc//eyl0Zt3YZX9HjG
 AqWMZM8HH0li96G1uY83ZSP9GZ0JCUt6WQx4Zs2WTuY2XjI2RiHIPoyt8GiPCK3wZ5rabhU/u
 MWtCCkHqFW3wXtt2Zehax6lqb4Q/zuw2sBOnPFgPi3Qi3uqa7kU119J2lygbr0tdTdLRB9ANw
 RzG3J19pD3GQOfUGEA3kMTQd00
Subject: Re: [cocci] Checking explanations for SmPL functionality
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 611
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/e92157ec-d270-06a0-972f-a70ae04221d4%40web.de>

>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/19454bc12f6f8cc0a7a6091edb28e8a2ca4518c2/docs/manual/cocci_syntax.tex#L199
>>
>> Which metavariable declarations may be started with a metavariable name?
> This is what the documentation says currently:
>
> It is possible to only match expressions of a specific \NT{ctype} or a set
> of them with a pointer level using {\tt *} by writing these instead of the
> {\bf expression} designator pattern.
>
> It seems that that should be changed to type rather than ctype.

Would you like to add any more helpful explanations to the manual for users
of your sophisticated software?

Regards,
Markus
