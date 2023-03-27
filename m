Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F64C76195
	for <cocci@archiver.kernel.org>; Mon, 27 Mar 2023 05:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gGT6SyPQuwpA2aBNCxYzcmUcoOxE3FrrhAQOFvqbSUs=;
  b=ErtniIPStQPVHffUVCGFmL9dl3zvZPMKrOwQ2yhJfrTQkXPJzywGBu/Q
   LgUX1k9lirESC7QoA91Lzc6mkYx1AM4R2ZuG0EuheB4I7SCINEPR+kuyC
   p9dMB4Uj5KG1EvSrz28hcQd8QUoF65jiXj01Nz9LkuNX9FfYOZK7BoKr0
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,293,1673910000"; 
   d="scan'208";a="99181810"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2023 07:26:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 89A9DE0D46; Mon, 27 Mar 2023 07:26:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0F9EBE0D40
	for <cocci@sympa.inria.fr>; Mon, 27 Mar 2023 07:26:26 +0200 (CEST)
IronPort-SDR: 64212901_/a4BA7n3aQxpxgMDfqYwJkagl6seSwdSJJQ13HXG2U9cA42
 SQYf2/YYgHw1mDbetRzb/FRxQBOw7+EkgtOWivg==
X-IPAS-Result: =?us-ascii?q?A0EuAAAsKCFkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItdVYvBAtGhFORATGEL4cshzqEZ4QCgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEhH4ChToCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEA?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICR1M9AQICASMdAQERJgEECwsaAiYCAlcGAQwIAQGCegGCJwEDDiMHr?=
 =?us-ascii?q?VKBMoEBgggBAQacCh8sIlOBXgMGgRQtAY0EgzZ6Jw+BVUSBPAyCdz6IHIJnj?=
 =?us-ascii?q?huLIwqBNHOBIA6BPYEEAgkCEWuBEghrgW0PQAINZAsOb4FKAmRMgRclBA4DG?=
 =?us-ascii?q?SsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8GJkQOQ?=
 =?us-ascii?q?jc0EwZcASkLDhEDUIFGBC9egQEGASYknh4oCTalTKAkNAeCKIFVgVkMnwwGE?=
 =?us-ascii?q?y6DapMeDgaSIy6HLZAPIKd6gWUBN4FcMxokgzZPAxkPjiAZhAyPCQE+PzQ7A?=
 =?us-ascii?q?gcLAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23:TECW+RIo+glPy8547NmcuKNvWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCFuLM30QaCDNuTwskHotSVmpioYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2+5Z3ebx9WiDe9fL9+I
 xG7oATMvcQKnIVuLbo8xRTOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQ
 bNXEDopPWY15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RTiu8
 6FmQwLzhSwZKzA27n3Yis1ojKJavh2hoQB/w5XJa42RLfZyY7/Rcc8fSWdHQ81fVTFOApmkY
 oUMAeQOMuhXoZTjqVYQoxuwBQujC//gxDJTmn/737c33/g9HQzI3gEtGc8FvnTOrNXyMacfS
 ee7w7PSzTXAcvNWwir25ofMchAvu/GMXLRwccXMwkQoEA3KlE+QqY/4PzOOzOgDvGyb7+R6V
 eKujW4npBp8ozaxycg3kIXGm5wax0nC+C5kz4k7Oce2R1RnYd64DpRQrSeaOpNrTs0iQ2xmu
 Ds3x74btJO0YiQH1oorygLRZfGGb4WF4g/uWeSfLzp6mH5ofKyziha9/0S81uDxUte53lhFo
 ydZlNTHq34D1xvW6sedS/t9+F+s1iqK1wDO8O1LP107lbfdJpU8wbAwjoIevVreEiPogkn6k
 rGae0c+9uS16+nreKjqq5CEO4JwhQzyKKojltGlDek7MQUCRWuW9Oq62bb+50P2Wq9Kgeczk
 qTBsJDVO8AbpqmhDg9Q1YYj9gq/Ay2o0dsGhnYLNk9Kdwyfg4joPVHBPuz4AO+hj1ixjjtn3
 e7KMqPjD5nXM3TOkK3tcaty5kJEzQo819Ff55ZaCrEbJ/LzX1f8utvCAR8jMAy03v3nBM9y2
 IMaV2KPGK6ZMKXdsVKT6OMgPfKDaJUItznjM/Ql4eXhgmcjmVABZampwYcXaHegE/h7O0mZe
 2bjgs8dEWcWuQozVPDliFqeXjFPZna/RLk85zE+CIK+F4jPXIGtgLqb3Ce6BJJafG5GCkrfW
 UvvIr+ZWu4NIA2VJMApxiYZVKGgDYAm0x6GrRa8wL1ieK6c+SACs5/nkdp84ezPkgsp3SJ7A
 t7b0GyXSWxw2GQSSHt+x617oEpg2n+d3qVixf9VD9pe47VOSAh+fbXc1e1hF9H7XEru4MuVU
 12mT53yCj4jSdQ82PcBZEFyH9inhxHHmSGtBulR35GRBZd8yqvG3mO5c8tlwmzHz4E5hkMnW
 dNLPGarwKll+F6XT6vImEWQk+6Nb7YR2GaZ8WaIzWOKu1tKXQo2XKPKdX8ab0rS69/+4xWGB
 5ioBa4qMENkztWEI6BHaZW9ilBBX/HqM9n2eW+9m26sQx2Pw+XIJLLjZmFV+SLaEkVMxxga4
 HKuLQEjAmKkpGXEAXplEle5JwvX7eRmqH69BnQxxgWOYlwpg6Gp9wYViPraUPYa2rYJqWE+r
 C93NFm41tPSTdGHolwlNJVdfJsf4V5B22/fuEQpLp29LaFrgFATdQtfv17nyBh2TI5HlJ55g
 mktyV9XILibzUgJWjeWx5H2NfWDD2Do/w20LYPS1Evf1tm+5aoFrvg1/Qaw9Dq1H1Yvpi00m
 +Je1GGRs9CTVFJ6ufPZV08280M/vLTGemwm4JuS03RwMK6yuzuE2tQzBeJjxAzzN8xHPvaiE
 wn/W9YfG9DoMPYjzn2gdBEZJ6Z/8KAuPsWpX+SL0uinMbUohyqo2FxO+5s1yUeQ72x5Q+/M0
 YwCxqS91xGESiy6oVOvqMHxlqhbaDtUEmfsgTP8Ctt3Yat/NZ0OFX/oI8CzwYBmgIXxXndD6
 FO5L1YBxdPvZheYKVDwteFJ/WIQp3Hv2S6xzjgv1iossrLaxyvWheLraBsAPGdPAmhkl1blZ
 4au3ZgcWwCzYg4lmQHAhw6yzrVHpKl5M2jYQFtZNynwIWZ4V6Kst72EK8dR4ZIsuC9TXayye
 1efArL6phIb1WvkEQ48jHgefiupp46/shh0kmObI15soXCfdcwxjRbT6drAROJAiyIcTXowg
 j3WC16getixqI/NzdGZ6L/4Dj/nD8EAFEujhZmNvya6+2BwVBi2nvTo38biDRB/yijjkd9jS
 STPqh/4JIjtzaWzd+x9LSwKTBfx7dR3HoZmn84+npYVjDI/j4+W4GFBvGP9K9Rd1orhYXBLS
 TNBkLu3qED1nVZuKH6E3dezc3yHwdZ6IfS+bHkX3C0V8M1ATquZpu8h/2M9sh+zqgTfZuJ4l
 zEWxK416XIUtOoOvRIk0iSXBr168VBwBSX3jFzI6tm/qP4Sf2Ozaf2r01I4m9m9DbaEqwUaW
 XDje55kEzUipsl4NVvN1jX05OSGMJH1ZMgQqwbSvhPOlelTJ7oum/BMiScvNW/mvHIjwvI2l
 lQ0hMv85tLYbTwwuvvlShdDfiX4fcYS5i3ggcM81o6N0oajE48gUjQHUZ30TO65RTcbtPDpL
 QGLQ3U3rnaWH6aaHBfKsh486SiVTNbyajfOeCp8r50qXhSWKU1BjRpBWTw7msV8DQW23In6d
 18/4DkN51n+ox8Ky+RyNhC5XH2MwWXgIjoyVpWbKwJbqw9Y4EKAe+mX9OFuBGd1+pO7rQqCA
 nOWbUJEACtaPy7MT0CmJbSo6dTapqK9D/C9MuCITLGAs+1YWN+XyJjp3oYsrFPufo2fe3JlC
 fM8wE9KW3t0Tt/Ylzs4QCsSjyvRbsSfqUT06mhto8u46viuRBP36N7FFe5JKds2sUPT4+/LJ
 6uKiS1+Mzodyp4c2SqC1u0ExFBLwyB2K2v3SO5G73SSCvuKxOkOVU5cMX4WVoMA7rpgjFMUY
 4iB0Iyzj+M+1rlvVh9ETQCzwJjzI5ZQfCfkaxWfQxzUfLWeeW+Rmp6xPvn6EOwKyr8I51rq6
 FP5WwfiJmjRx2OvDk7yd7gR3WfDe0YA8IClLkQ3UDelE4igMEXkdocw12J+wKVo1CmTaihDa
 34lIhkL8OHXt3094L03GnQdvCo/a7DaxmDDtbiec81O+fpzXnYkzaQDvil8keANqnseDLl8n
 C+YxjJ3i3ehlOTHij9uUR4V7y1OmJrOpkJ6f6PQ6phHX3/AuhML92SZTRoQ9ZNjDZX0tqZcx
 8Kq9uq7ISpe89/S4coXBtTFYMOBPn07NBP1GTnSRAIbRD+vPGvbigRTivaXvnGSq5E7rNDrl
 v9sAvdDU0cpE/oBFkl/NNkFPYsxQT4u17KWzYYJ6Xe4sBjNVZBas5TABZfwSb3kLDeUi6UBZ
 gNdm+qia95Jacuihgo7Ngof/syCAUfbUNFTrzc0awY1pB4I631iVigo3FqjbAqx4XgVHPryn
 xgsiwI4b/5+kVWkq1oxOFfOozM91UcrntCwyxWYaj3sN+GdWY9MCiz7n1c8ONX3TkwmCG/61
 VwhLzrCS79L2vF4cnt3jQbHpZZVMftbULECfxIag/2aLaZNsxwUumCswklJ4vHAAJ1pmV4xc
 JKimHlH3hpqcN8/IaG4zE9h0VVawK6D7HfAPgEZxQgDOwAS/WnUdCNa4CTg2ZE5KiDu8uE+s
 GS/
IronPort-Data: A9a23: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
 RwjFqXMAyWM
IronPort-HdrOrdr: A9a23:xoyzT65IE3yNXkd8RwPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,293,1673910000"; 
   d="scan'208";a="51313606"
X-MGA-submission: =?us-ascii?q?MDFHWVSY1jTjUEFhnorI3W4hvnz9u78MnIl1pc?=
 =?us-ascii?q?OWdRPiKVPBcE4qvhcnAXbo8aNwydQ/pukkWFyDXZQ6kLLk3V12dGmCWv?=
 =?us-ascii?q?twCfwbf8ZiHSHFqEjDeedAzFGMALF4eqS99WKfv9MWiMvxnVlDrvPQru?=
 =?us-ascii?q?MzD0fRq0+mInm0BeghPMERaQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 07:26:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679894763; i=markus.elfring@web.de;
	bh=gGT6SyPQuwpA2aBNCxYzcmUcoOxE3FrrhAQOFvqbSUs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bnF1tbVG4YXWvf48RS5FZQFW/AP+ou3bXJtiJ48CsfP8lMtQx2QwGs46XIkO7vo9P
	 x2PIxV7yCRsnM7fuCKJaCdux/hnxJqznGQXGGmmx/pQ6GGRM2l2csZ2eIYMhPKIGrI
	 EUdlohVjqIiTgYWGUtK+IBTLfhI0rNuqDDGPpdk1Of8f4VkWz0/yU2JzwQ/foxF6Xh
	 g22xhxbI1G6thkSNNvUZX/W9Cxb5CC2syyqEvfjUQz0Xi6+yGBXHB6yASR/DKmpbni
	 RVKs5yne8ColdRjPqDD3jTWcA2wkcjNQAwi0JUgLJ0aZYJIaGY0l0istwVR1q/8Unk
	 orFpzqp+reeoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JF8-1pjPSC3bMw-002kbW; Mon, 27
 Mar 2023 07:26:02 +0200
Message-ID: <45c1c3f5-11f9-9c63-3413-990841de0fd8@web.de>
Date: Mon, 27 Mar 2023 07:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To: Ruiqi Gong <ruiqi.gong@qq.com>, kernel-janitors@vger.kernel.org,
 selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=c3=b6ttsche?=
 <cgzones@googlemail.com>, Eric Paris <eparis@parisplace.org>,
 Michal Orzel <michalorzel.eng@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Ruiqi Gong <gongruiqi1@huawei.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <83763b78-453d-de21-9b48-1c226afa13a0@web.de>
 <tencent_1C472DFEAAEC903262297C9B9C978B365909@qq.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_1C472DFEAAEC903262297C9B9C978B365909@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KbE5tUs/cTZNfBwpFyF1ToYWXeJyYBbfRl6yFoE+XmsKNWI4PzG
 Q0rCvPbIToYJwQNeMcJLMq6ybupBXWylxGaWOgwoFaB4u2G0nuiwGcoVeTQsmxWZ1cdr7WE
 dFq2TZgNI2uIYfkjGnfpGWRlctF+jnJjxCQT4wghN31opWNqj410VMbaNOhYJrB3AKogXJ1
 wjqnEJL3+lcA0P2oExq8w==
UI-OutboundReport: notjunk:1;M01:P0:6Bx0UxJtqhU=;eKMJU7+g9e831jbxBtew3T48l3W
 zGp7UwyESNg7p0ldzNTuLxUQqLsB3INRAmHZb41WyEXZiVyftiD1f/B193EHYAzqJ4ecSpUN2
 XIjIQJ2oMLJtTUVqpaYxcT8arabL5I8CWebAN8EgpdnvTviE/XEsD5Cc50qnI9jmMHqLp62mB
 YinsP5qa5AZAwdcXVZmtauCd4HOiiBvvZWHMcu5qbS7e9/BlOBTya+LQci1expPUrCHiVq21N
 x/mtktaliQs1drPdcFTMzBgoNAAVcW1pEQg/RY5a9n7SSISiKT4CbhvR/EZH1eB18wt+/XwsZ
 fGG2OCADFO0n0KXUVistabP7+1uG+CsXFvcDLdaKTyoQrmXlRYqDeBu1wTPn9hqTI5rVoxFFb
 YUye5LK1iACwDiAsg/TaHX2gTdzDexsfznapYg1CbHVf5qWPi0Beh0CO3paAPbyXn7u5djMkK
 duJ7JyGDdKkd3tv7NN+jszgUd4/8s0BsJcR+30SUv3vkg2z6qHpyCx2vWxm6LwnqnRg7EtdUe
 qORb4KurqdW28kWh1kuQRR9Ee6p1ftLQOTzZJV88xx3kISebzt5fAefZgBwJYsQDCKMauZNLH
 z/YmKRAVtiboiiS2lcbJLqcPFNGSrem7v6OA99aA6KBX99TzYTkzjGpFgtHWTuEWgY5qcdZxc
 1oG2OlcdpYgVGvq2eLr57Zeq4TQ6oHigsOzVm87+T09/ug679aJDkZREUAzAR2B+08jftS8eb
 Bzdtrh08V2lZXFJ1QGN3nAQxIEO7mYmAnhxsvWOszBaketEHBJmPyJ/WJicp4692cxHC9pXEM
 jrwtd8zGQB48J1YA2M4JxtLaDVfzini1PsmfRM3r1YoKa9jq6hyqr+gXaTiQrWNgT4lK0xniv
 287905v/VUVw4KAwaPCaCH4wEklDTeTAcuqAHsS+4SlG2WpysFuOE2rTT
Subject: Re: [cocci] selinux: Improve exception handling in
 security_get_bools()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 961
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/45c1c3f5-11f9-9c63-3413-990841de0fd8%40web.de>

> So I don't see the necessity of splitting the error handling here into
> different parts.

I generally prefer to adapt the exception handling better to a detected failure.

See also:
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+resources#MEM12C.Considerusingagotochainwhenleavingafunctiononerrorwhenusingandreleasingresources-CompliantSolution%28POSIX,GotoChain%29

Regards,
Markus
