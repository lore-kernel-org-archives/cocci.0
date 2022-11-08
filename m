Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEFFC433FE
	for <cocci@archiver.kernel.org>; Tue,  8 Nov 2022 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=T3/MhtG+aBjZqVDrM/YgMCB2qh36dVB/g1Gq/hV7P0U=;
  b=Vaj5WVJ6OVW57UNGT94H4VCOYI6MzjZNfdyosam/iuIlbiSTqZ9OfbLn
   1XuKnN9fGqhNdLZ2ohEI+GRslN7mObTHEAgIYVrcS+lNNEfc428kbnkfu
   C9fE+256U+AsZc9Sl3Guchl7aTgHK08ztd2MpH8xcFKGOLOkLlvrOSC+w
   U=;
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
X-IronPort-AV: E=Sophos;i="5.96,147,1665439200"; 
   d="scan'208";a="77229131"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2022 13:21:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5FB4BE039C; Tue,  8 Nov 2022 13:21:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7DB50E0076
	for <cocci@sympa.inria.fr>; Tue,  8 Nov 2022 13:21:53 +0100 (CET)
IronPort-SDR: 636a49e1_7DCV1cnCWPGVMjG+X9igUfv1M9kqIW5zb8IJ4bMymAA85HM
 l6kPeUNq731XjANKzhEFwGuBQoSm387p87k24yw==
X-IPAS-Result: =?us-ascii?q?A0EiCgCwSGpjhwwR49RagQmDfIFYLgQLRYRPkR2LR4cvh?=
 =?us-ascii?q?F+HVQ8BAwENQQECBAEBAwSDa4ETAoR5Ah0HAQQ0EwECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEAQECEAEBARkJFwcOEAUihWgNgjUpAXSBCAEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEWAkdTLAECAgEjBBkBAREmAQQLBQYaAiYCAlcGJIJsg?=
 =?us-ascii?q?m4BAw0jB6pFfzOBAYIIAQEGnAYfLCJTgV4JgRQshziIV3onEIFVRIEVM4J3P?=
 =?us-ascii?q?oREg1eCZ45/iB84A0QdQANGMg1LGzEnDgkfHA4XDQUGEgMgbgVBDygvZyscG?=
 =?us-ascii?q?weBDCooFQMEBAMCBhMDIgINKTEUBCkTDSsnbwkCAyJlBQMDBCgsAwlABxYRJ?=
 =?us-ascii?q?DwHVzoBBAMCECI6BgMJAwIiE4E3MSYFAw0XJQgFTQQIOQUGUhICChEDEg8GJ?=
 =?us-ascii?q?kcOSj45FgYnRAEzDg4UA16BbQQ1ap4glmWsODQHgh6BTIFNDJ8LMwODUQGTF?=
 =?us-ascii?q?QaSFC2HHI9pp3eBeSOBXDMaJIM2TwMZD445HoNuiixANDsCBwEKAQEDCYVHA?=
 =?us-ascii?q?QGFFQEB?=
IronPort-PHdr: A9a23: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
 twCR+0DPGE=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qY9A8qqiq4AdPYyPkAQLqakaV5rZeYIsimQD101hICG9vPb5qy
 nIpoVi6faUskdyZJhEo7u90ca7MBbhHPJOj7X5HI3SODUO/VHYSr2KjrGP/9SDIULDH4dmvM
 8MT0E9MqyIMbC+5vyKhzVQeOxQo+VvnprIuc7j7zNKURxgbb1m4jx0EwCBDyRNNXZ77OECZe
 ChDtEsnUvcRZ37VLXGOlA1G9Ti4/nGjojvbxJDOg4/5GC1/EiVADWWKXKl4is=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,147,1665439200"; 
   d="scan'208";a="77229121"
X-MGA-submission: =?us-ascii?q?MDHyCvOMZPu1yyOhi/535oVBg72oPNnH7eHA9I?=
 =?us-ascii?q?xESpI8hG6B8ELaAewXx4K0YWdqORCSxwZwAviVzjx5kMfYPZMUNf5oRg?=
 =?us-ascii?q?kKtXdmsDD/qr7trC2Je7IXS7SKebhSrj/8g7CCJJTLc7J/uHBFVFl8AU?=
 =?us-ascii?q?orTrZrfmZhrBYAo6KFWkZHGw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 13:21:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1667910111; bh=T3/MhtG+aBjZqVDrM/YgMCB2qh36dVB/g1Gq/hV7P0U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AfIsAnh69EdRkhVy1wm8W3/KVZ8e0MgWhgd8bQqsWr0/qBzMV3VMegnanicBdTF6Y
	 JoXjgxIx/5FPcPnP7jj6+faVtuzjm1XWlG8mIpQ/fCN71yJctTnFJ9tPfzNwSbVLvG
	 VfOOANFNEIqey88IPOFFBMUYqOoV/NuOr3GJPgH3uz8F+iiX5uFNrxAERKdrHkVZZ6
	 JBbxwmXUfkieSgwP4sApJcmKqxU52zZSEk/J+ePhzl95mmD69leDF+m7pJW44GoXNO
	 veebzKod4goQlty3Qzyh6rBIg4vE8MseBoch/cznfN1vkC50xJfRuE2tsND/CIyI5M
	 dVmEwXv0nKRfA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [212.144.252.253] ([212.144.252.253]) by web-mail.web.de
 (3c-app-webde-bap11.server.lan [172.19.172.11]) (via HTTP); Tue, 8 Nov 2022
 13:21:51 +0100
MIME-Version: 1.0
Message-ID: <trinity-538688c5-6d3f-4ebd-98b1-48a9d75391e8-1667910111160@3c-app-webde-bap11>
From: Markus Elfring <Markus.Elfring@web.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>, Julia Lawall
 <julia.lawall@inria.fr>, kernel-janitors <kernel-janitors@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, kernel@pengutronix.de,
 cocci@inria.fr, Nicolas Palix <nicolas.palix@imag.fr>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 8 Nov 2022 13:21:51 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20221108095425.6x6hkyzzm3yuofi6@pengutronix.de>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
 <20221107200815.u7hcwejileeabnct@pengutronix.de>
 <257596884.6156222.1667886713273.JavaMail.zimbra@inria.fr>
 <2fcd7fdb-7984-a2b7-7995-d164754c5eb2@univ-grenoble-alpes.fr>
 <20221108095425.6x6hkyzzm3yuofi6@pengutronix.de>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:C6U2rJHDvoVC5GaZAW1k3XDO4OCcxlGAb0uj21Pke0cugEifh66TmzI6V8EX/u2QTvg/Y
 EgXTF6klZNfYZ/sQ7tRlTcgs2RZE6qN9PBfT9wxpipMHKgwWt6OFyu+C8NnLOb2mG/tLGYf/klD6
 5pazT89dweitNmakP2zLi0T0o70ndoWPLr2rCU0Jx9tLT+cUph8M3/8LP09YPNdgjsa1mPPTCU9J
 VvE/RTyDu3ssa8/NhD26zulzeHvfmObWd8OU6dGOR17az+HCMGDaxOAdWmzFJE1X3w39sbN1WUfw
 Dw=
UI-OutboundReport: notjunk:1;M01:P0:Ln8Ungg+1Hc=;RLwZgzOX12K2dmPzUZQMFCkfgiq
 S4RbMvRD1Zjx6PcpnVUGAF5UtaGNWckzZl288dflB7FXvm+Q2YxoectRX0Xaw2gIf1B4OUo3s
 fOo1oJVlVfQfQPe5TlqojdQffgby4XyMm41T9trhQ6D1Szaz7Vb1z3s52JTIB6ybkh9wbWoAW
 IVeIp82ClGECUrFIjI/LQi3tEc0gpBxAbefm8meWOo0KmxtHY5BstfMrcJfMSYhRLYFM/oOY8
 8oZTOxJ90l3O9AJbqRt/hb1IXnrIzgR8x4ksML8jqOWCIvc8kUzpGh6kMZzjmtajV71My7R9R
 X2SHZ5/1VFiAlTytI0NFpiaN3+Xh66XMsxNRHzkcMU1TUvGYw9mKsKtcaYO8/X6x8f3yYqr1/
 sSMuFgo8r59NWpNlTTmYq5DUicYfrtSFPf2BUbD5Mh1SbOeIbvaP9XyrR+PmzABdqPXc90+US
 wX4va1I4F1RIu1khC2aec95McrVWYvzw3f7VAtYiWPUoP8lFFttn6lK1u3f8+mNBNOOwQgqBx
 jT1kyr8ugBFD38B1qvSSFJ2Lm1VI0NLgi3uDH9W/YPANC2ZhHVOdcEtnoVBwoRcNevW5W85sC
 9cu4EGDup4cbp3EVIUGmafpoDFc0VenDQcDtf2R5hNh2hzvYnjUlq1EJKequCmh8PljBt8Yal
 OoxHro0hNXBcS4ROwOAo4cRA++RN5ctziGUSebuHhHMc9eLypsO+KL8mDO/gbqm80smwj/lYD
 0fgsWcunUi0ZHY/Jtwn2T4J4HmbVgNYZ3HK6N96d+z3/bUfGbGdeKc1uK2qiVDS8JkJFmxwQT
 MWjdhtlHLc5id15PAm7CiKF4Dzce5ssH31CNlML2E66RQ=
Subject: Re: [cocci] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 724
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/trinity-538688c5-6d3f-4ebd-98b1-48a9d75391e8-1667910111160%403c-app-webde-bap11>

> After installing python-is-python3 (which provides a symlink
> /usr/bin/python -> python3) it works=2E This is on Debian testing=2E

Would you occasionally like to use the parameter =E2=80=9C--python=E2=80=
=9D for the program =E2=80=9Cspatch=E2=80=9D?

Regards,
Markus
