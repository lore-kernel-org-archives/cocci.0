Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3297C369D9
	for <cocci@archiver.kernel.org>; Wed, 25 Sep 2024 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=BdRoCWbMj6yhO4yjw/vYTpJLRazTUoSLjnmeIXDc2ZM=;
  b=aTPAdw7MBeKfpaoYFXUQhLn5vkqimTXFosvjXHFqQODNC5v0BSZIGvhs
   Su9OlYhwYmbd/I7tUjEVIlephJF8vmaKEwNi0GckowA6qRajXyq02Ezh1
   XrhGrKKbazZWrju29W3uVM1QaCyqMrrKtndbgGfScJdOJ0uSeEp0So5GV
   o=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.10,257,1719871200"; 
   d="scan'208";a="185065058"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Sep 2024 14:40:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7EEDCE0CD2; Wed, 25 Sep 2024 14:40:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A1226E00B7
	for <cocci@sympa.inria.fr>; Wed, 25 Sep 2024 14:40:50 +0200 (CEST)
IronPort-SDR: 66f404cb_cSTeELgUvBsjl4jAE6M4jAdsA5lRe5y6QUI2R/5ESOmISvP
 fINCL6Wh3N4WBMaPDD0XLQd0v6Jq/LWDxIp1qRQ==
X-IPAS-Result: =?us-ascii?q?A0GWGwCz/vNmh07ASNlagQmBTwKCQn0GVDMEC0gIJYQpj?=
 =?us-ascii?q?02BdS2EPpgEgVYUgSw+DwEDAQ07BgECBAEBAwEDgUlDg22JDQIeBwEEMQgOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQE6Bw47hXUNSgEQA?=
 =?us-ascii?q?YIAGHkbdDACAQEBAQEBAQEBAQEBAQEBAQEBFwINOm0EGQEBESc0AiYCcwEBg?=
 =?us-ascii?q?n0Bgi8BAzEHDQavWH8zgQGCDAEBBoJn13MfLCJXgWMDBoEaLogxGgEFbYoSD?=
 =?us-ascii?q?4FVRIEVJ4YEHgSBRWaDDoJpkg2CEIhifCWIYHCQZ4FNHANZIRMBVRMXCwkFi?=
 =?us-ascii?q?TiDJoIUhBUIgT6DX4FnCWGJVoE+gVmDOEqFSIEGglFrTjkCDQI3giiBDoJag?=
 =?us-ascii?q?ScEBYNQJR1AAgELbT01CQsbBj2rNSmBW0iBS4ESeCyCd5J1skI0B4I3gWMFg?=
 =?us-ascii?q?V4MiQOBJJUrBhMvhAWTOQ4GknOYdoJWiyWVToVUgWkBN4FcMxokT4JnTwMZD?=
 =?us-ascii?q?44tDQmDWDO/WkE1AgE4AgcBCgEBAwmFRgEBgXqER2tgAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gnCKjKg76PbQZdnyO3VOCrHcAnBQXvgji2hC6mlwRA09TyXqrb
 HMoB19726StN9xYgBFpTnkAsK9qBznmqKdjbNhX4tKPzOJhILLFu1fBOLZqlWMJ8SUzJ856U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ds2g00NcelwAZsQiTuR5zzra3Gfz2R9b6YEKA
 ==
X-Talos-CUID: 9a23:FsH55WOB6dxryu5DQwRmxhc1JZgcY2Dc60z2YEiSIkdkcejA
X-Talos-MUID: 9a23:5INoHQZR8jH0VuBTmSLu2TBmHvZU+J/tFhwLiJoMlpO0Onkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,257,1719871200"; 
   d="scan'208";a="97382423"
X-MGA-submission: =?us-ascii?q?MDFB0kjgRX9lSihbR8z8EW09f38JRLmtCsfryi?=
 =?us-ascii?q?a0UdsWiUqL2hqtER8GC/U4AwxnnsdkFl9ZJKRE4AOYPtNqJq01XEPPzp?=
 =?us-ascii?q?owxqabmfquKq/HcdKm23eTIoDEw7UyKMElwuv9JeaAneAZIbzxag+vNm?=
 =?us-ascii?q?apXuOAO31tSdxgQAPHDdQ1Sw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 14:40:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727268028; x=1727872828; i=markus.elfring@web.de;
	bh=BdRoCWbMj6yhO4yjw/vYTpJLRazTUoSLjnmeIXDc2ZM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=u/0u0YBhufAgKAjR8C1sgeXQklbD3wyQ3NZ7x5YqufNoG90IwTL8IXQr+w5Tr4jx
	 9+aMuYuQulBC9kQ09dA05D5uLHPtkgIIiUA02dxBhlNq5k/6yfWomFi2ZDc/Aa09x
	 naW2/BZcXWdGIYSlJYtrOaQbhGyddWUpRkNWOw/k53QgQzC/jII6Ce0WB1HGB6bfE
	 pbW45NC2zOKrMLw25jRqQerhu6sP/DplsqFXi1bqRBovZikonwyQsaRkKck5DpvNa
	 +/JtoVrjscil6prunCBkjl6GTY9C9fwSEfmpRDRVXXuysMnfcIfIA2B1kEDKODRVX
	 1ZIByaZXpD45mBEADw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwjJo-1s1E862f18-013mDr for
 <cocci@inria.fr>; Wed, 25 Sep 2024 14:40:28 +0200
Message-ID: <b18aa73c-0c3b-449d-bd81-a1b6e604b6fa@web.de>
Date: Wed, 25 Sep 2024 14:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ost5BxW2Woimj6/fTslEY+dMMU2aV1OGyJ6ODDf1Lw8BqkjLFDU
 YRiHEtamV+8ERlSCguii6ZckUX6wHbVopDWhfvQNEd7TK6jjRbqzQWwJLwlPoglHfepIxGp
 /gcXQuSQdUyUriSzw/nUYdGFxPJSahJ7YVG5s2rctQibM17o/ckQje3/g5hN/BAYBfw3lJV
 NCI6/h5R+E3f29RGws7LQ==
UI-OutboundReport: notjunk:1;M01:P0:i+mMOpP5saA=;GH7UjogC27RZgZ1T02HxUpv2F10
 UGF0o0flCgBwlQMdggNZJZm8KiDsByyVgFUFM2h+qhWSgxtFCvJHDdVWaCcNewyDy7iQG0C7f
 /rwbxy9tKFmW3Ll3SWP6ZP3lMW7M2h0aWwwQ1EV/oGBIgfS/+gewFut1mUdUByedKaFfRiL51
 fl2EehS/lRXIx4l9pAs2JUpYx78DOws5ED0mKuu4zBMcImRqn+cbtvWcBG0HsBaIF3/A0llgZ
 +2EMDknqdRbqGHvTSDQ6cyUUJEKHjz4Y1LHnZfCXsJvhYNsn+LgHVZbtHN8GTVH4SyciFrEem
 WES2G4MSsIcBobO07mAIjlgwN79WXJlCQOGQiMCEut+XlP0+JQxxgxOpMLYDQzvEadZ4lpGlF
 AITvvxmRYkxzc5cEdjwdqhA0wW7lRlQFioHGp1dEbzAIdPacdD2pV02ghydGkGjp+3UUL0Jmb
 B8/bbL/boZlIZm03GnNlC+gELBfVFAj7AoEy/JXlT7kGWfXx3Yd71cpvafB3AAl7X29gYjz7N
 iT52oQc78vYJoacsU0uCypxfQPbEXC7Dvfc/NwXrAQOwNqclejQBtyXHOPUExneL6YgBcSe4a
 AUJW6hTfaD0gFB70tarIf6jOPJUed/VsKaNIRqaDQCrJdUjWv2GT0D+BYtu+ydD8fCw3dYSaE
 jz+VmpNTWcEyY9MAI4kNEtEsNdUbL2O38055qlbDBxjB5eqll2XRpY2WA8RU+skUDtcHYc7bn
 Gl0DdsI1KFJqYSMD53xtwDjWm0AtB8jukMTI/64xGjjRSHrZ8xUcTS+nLPu+piReK19xiKTBS
 lFQKFo5Mll/ks27kI+sNl+VA==
Subject: [cocci] Avoiding duplicate statements with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1888
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/b18aa73c-0c3b-449d-bd81-a1b6e604b6fa%40web.de>

Hello,

A source code search approach pointed a specific function implementation o=
ut
as another update candidate.


Source file example:
// SPDX-License-Identifier: GPL-2.0+

// See also:
// https://elixir.bootlin.com/linux/v6.11/source/drivers/tty/serial/fsl_lp=
uart.c#L2788

// deleted part
static int lpuart_global_reset(struct lpuart_port *sport)
{
	struct uart_port *port =3D &sport->port;
	void __iomem *global_addr;
	unsigned long ctrl, bd;
	unsigned int val =3D 0;
	int ret;
// deleted part
	ret =3D clk_prepare_enable(sport->ipg_clk);
// deleted part
	if (is_imx7ulp_lpuart(sport) || is_imx8ulp_lpuart(sport) || is_imx8qxp_lp=
uart(sport)) {
		/*
		 * If the transmitter is used by earlycon, wait for transmit engine to
		 * complete and then reset.
		 */
		ctrl =3D lpuart32_read(port, UARTCTRL);
		if (ctrl & UARTCTRL_TE) {
			bd =3D lpuart32_read(&sport->port, UARTBAUD);
			if (read_poll_timeout(lpuart32_tx_empty, val, val, 1, 100000, false,
					      port)) {
				dev_warn(sport->port.dev,
					 "timeout waiting for transmit engine to complete\n");
				clk_disable_unprepare(sport->ipg_clk);
				return 0;
			}
		}
// deleted part
	}

	clk_disable_unprepare(sport->ipg_clk);
	return 0;
}
// deleted part



I constructed another small script variant for the semantic patch language=
.

SmPL script example:
@adjustment@
expression list el;
idexpression result;
identifier action, work;
type t;
@@
 t work(...)
 {
 <+...
-action(el);
-return result
+goto action
 ;
 ...+>
+action:
 action(el);
 return result;
 }


A corresponding test run did not generate the expected patch so far with
the software combination =E2=80=9CCoccinelle 1.2-00038-g2297fc0f=E2=80=9D.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch ../janito=
r/goto_last_function_call12.cocci fsl_lpuart-excerpt-20240925.c
=E2=80=A6


May I expect that such a simple source code transformation should also wor=
k?

Regards,
Markus
