Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07798C001DF
	for <cocci@archiver.kernel.org>; Tue,  1 Aug 2023 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zxv5eTqIt8flt/kCVS+GVtY4UfED0t2XbCCuHho/4bQ=;
  b=G8CynBfHHaQjfWkDDiVPWlsk5LJWnT2Wb5jHkZgR0r2vfvKF4AnWCOMt
   RYQP/Kf08dbSQScrsfIGy8kAOmerYDFXEXFwUkf/KwsimvgroVo/3qdsY
   VMnJ39+m9NZR8DFhhirzkBef5qQ429qOWu0cyS2tLkeiXPoHvoWiST2DG
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
X-IronPort-AV: E=Sophos;i="6.01,247,1684792800"; 
   d="scan'208";a="119844963"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Aug 2023 17:26:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EA9A6E0138; Tue,  1 Aug 2023 17:26:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1298BE004E
	for <cocci@sympa.inria.fr>; Tue,  1 Aug 2023 17:26:36 +0200 (CEST)
IronPort-SDR: 64c9242b_u3CDzlNkH/hE7l5QYeyAKiLND116EF46mb34mBa1TP+Gr7O
 JNpOlLcY+WFNL4//0UtnBR4zdL+ocr90izhJq+w==
X-IPAS-Result: =?us-ascii?q?A0EMAQCQI8lkhwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIyeFMwBAtHhFKPOIF2hGiHM4dJhGmEBIMWPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSEfwKGSAIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBA?=
 =?us-ascii?q?hABAQEjFwcOECeFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBARcCRz8DA?=
 =?us-ascii?q?yMdAQERJgEPCxoCJgICVwYBDAgBAYJ6gigBAzEHrneBMoEBggkBAQavVB8sI?=
 =?us-ascii?q?lWBXwmBFS0Bh38BhH9DhDUnD4FVRIE8DIJ4PogfgmeKAoVNBzKCNYlKK4EIC?=
 =?us-ascii?q?F+Bbz0CDVULC2OBF1I5gT0CAhEnExQFS3MbAwcDgQUQLwcEMgcWBwYJGBgXJ?=
 =?us-ascii?q?QZRBy0kCRMVQASBeIFWCoEGPxUOEYJPKzY4G0uCagkVDDUETHoQLgQUGIEUB?=
 =?us-ascii?q?EsmHxoePRESBRQNBQh/HQIRJj8DBQMEPwQOAxkrHUACAQtwPTUGAwsbBkECJ?=
 =?us-ascii?q?54tgkDIKTQHgjGBXYFdDJ8dBhMvg26TJw4GkjEuh0CQOiCoIIF5JIFcMxokg?=
 =?us-ascii?q?zZPAxkPjiAZHoNwj0g/NTsCBwEKAQEDCYVGAQGGAAEB?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
 z0B0iWYAyVdCa2FiQreCjJXTAunKj7nKqo0xH3A
IronPort-HdrOrdr: A9a23:+J1Qnq726wtRXN/RGwPXwBzXdLJyesId70hD6qm+c20zTiXqrb
 HKoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWYtKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AjWvhA2sbL/nGw5J0JPIgUvIM6IsdSTr5nCfOGnb?=
 =?us-ascii?q?kSkdDVOeacAKz5a1dxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AQt2XVg58Qzb5XKC/u9EsxGJhxox1u5jxCxkdlqw?=
 =?us-ascii?q?3kJifbAFVPi+/jQ6eF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,247,1684792800"; 
   d="scan'208";a="62796504"
X-MGA-submission: =?us-ascii?q?MDGgj5eTcx9o7IyjGZ1hTEHSXiwpXFmBaVlWMQ?=
 =?us-ascii?q?SHYI1PSWclKaAfxkXmw8KrLp8MDd9BruryZqf2F79/s8f9Oml3YWzt8q?=
 =?us-ascii?q?z88IefrZtflj00ULrDJWJ4xOOj9BRxAxlEu3fBtksSsa56Ux14vQsa1B?=
 =?us-ascii?q?ASv33AcRI/yYg5XTGctSQmdQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 17:26:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690903575; x=1691508375; i=markus.elfring@web.de;
 bh=zxv5eTqIt8flt/kCVS+GVtY4UfED0t2XbCCuHho/4bQ=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
 b=vS71KEzsa8F0lpmM/VTA0k2U7Va0VZnV/6L6+PEQLY1iKkTROfMGy0GmLCG/9VSK4Nfi2Ju
 0JrtfUppTnn81iV67ipwKQzmkEE1RES06BwmYgugpB4yVHjYRdJ8rHcyBJT18L6oOdWU8ScSB
 QlF9ppjpmu3dDV81qEoYXmtx+T6pyI7XQQ29eMCzZsOn6qBxDWdqNRkutsXbQfKL63UBp6/ws
 4xqYZjiZZe4ypwBcuJ0ZERKhiIxNiqFufbYab2OKKEb2cWXtDrUQGEiZ70sYqy6gvLx8O4ly8
 aVMuVo+6sZsigqNricOp7nXhphPkPl9LOd0TjM9veo1lI5+Xebpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmhjw-1q2DA03bbq-00k0tA; Tue, 01
 Aug 2023 17:26:14 +0200
Message-ID: <526c2701-9659-85a4-aa10-4ce2bb499b18@web.de>
Date: Tue, 1 Aug 2023 17:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
To: Li Zetao <lizetao1@huawei.com>, cocci@inria.fr,
 Julia Lawall <julia.lawall@inria.fr>
References: <20230801094337.4145806-1-lizetao1@huawei.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
In-Reply-To: <20230801094337.4145806-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f7af7am86VHt1mIGTupfrodh59py4J6FleE4813eJLGIjlMj7S0
 M03bAvl3Tddz8iHdXdx3oSXdHkf8AFl9oc2eS6/ns2AnsP7AO7SVRGybIdzzsebNnRysRwV
 FVj8EJ68OXKwNHtDmIUsj+t0o9p3PRtmIFpK8dbf+1uGuQPhstH/owKD2rGcv2caju54ZHX
 ZXJFxkvIwOhzgRmBqOYBw==
UI-OutboundReport: notjunk:1;M01:P0:1OjcLvWxasc=;Nx2HGB1ybNHIhQCOt3eFqgQWZ+6
 tvfiDJFy3mSboKej/DxMrbgE5mV8BrVmqsa1nv0EA7W1qAi+ba8I+hOuDyYcJB0iu1hTFiiaM
 3S7GwpJLKxg/f6dQZpK8jv7BmWzzCC/vUXwTIB8JZzLnir+wrO+cC2Exp/H+2yXJwNeYCM/N/
 P2L2r/NMDHdJk/Azs8h2T2YjC8X4uG6Y8FCM32luThOYouI2Jb4zlSGIAPJZITT+ZMoz4Vtj3
 JEq2uTHUWhLCbLLJTPSATcmDC8zxxMvrZqeuMLKBnCSj48ZDEn1WpsTEbm0AwuHgs8jm/pw+k
 l3WfaqM95ynsZqK7/Fw8HPhUXH/zNSUi3qp4gSRsQWM1UMpk1VFF5C4sIYv1AZ2susrebuUQx
 xwCUcLA7HmzDFJLFpvs4lwLPyRJnYWRGGeuwskZ9Ihnjjg3UR58/t++y0P810T64IQskoRdf5
 J1cbQciPEbC6j03qAnzWzJ/TeiqB1V6Vjy6ykTlDvsRzMqykJrMDb7YNhfEHBkEeklpKhIGSA
 olMeiRbXeOKIeVweoHsHOx/PL0Q4wnVjY4RxK7GzMSoz7NTeMVdhcp2jjnjjAmQ1k2Cj73hw8
 o70QhK8FwayRrNAnJmb1dgrsf0jF1nKaVxjryTBd/wJ0FGNwt6emEHXNZGs1mIQ1GYUd/+G4C
 xXtZm96AtRbIqyYgAMFLsLLE/vvf6QbUfvtDcq8IcsYvmQoeiflS9UgcQS8c2pW8SetT9nKzb
 nNMox5Ea6G9uMf0ZDgtf6NLjAxb8r7/k9prdgVo6QeL7H9XmiYTjaDRSnqRmU6ROWSBHBlQJ/
 hjr/RnjxcMyetyJbMsy8d6APP7NUGm8IPWMpEkdlLHSGab8FBZT2xwuHQvgJav9ShHS2S4a3b
 Ya4QwpgJvs04g/M7+NCIO4sLliqYW/ZVMyzbC0vjSZOwtuWr3P0GbMMwDvTbob+gySZtxvEAT
 r4aq4A==
Subject: Re: [cocci] [PATCH -next] coccinelle: platform_get_irq: Add
 dev_err_probe() check
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1219
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-08/526c2701-9659-85a4-aa10-4ce2bb499b18%40web.de>

=E2=80=A6
> +++ b/scripts/coccinelle/api/platform_get_irq.cocci
=E2=80=A6
> @@ -60,6 +70,16 @@ if ( \( ret < 0 \| ret <=3D 0 \) )
=E2=80=A6
> +if ( \( ret < 0 \| ret <=3D 0 \) )
> +(
> +-dev_err_probe(...);
> ++return ret;
> +|
> +-return dev_err_probe(...);
> ++return ret;
> +)
> +)

How do you think about to use the following code variant
for the adjusted SmPL disjunctions in the patch operation mode?

 if ( \( ret < 0 \| ret <=3D 0 \) )
(
-dev_err_probe(...)
|
-return dev_err_probe(...)
)
+return ret
 ;


Regards,
Markus
