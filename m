Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215FCC4345F
	for <cocci@archiver.kernel.org>; Sat, 13 Apr 2024 12:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=G//ALFcPH2Ek2BJDiDGvigtfBsj+w6PKViXqIjnJ1Ds=;
  b=s+BcjthtIEMQ8RLY5ySpii1roPSQCp/5rJLa1Hrb7xOApRxgwBso2XkW
   +DQi5Po9FNNNyBAWPXiurFFsiIU1Um4z7Z610bjmRvfeAOvdHbI8yTyxg
   FElxXyjr8VIldnc8b/Py5GjYMOqHz5Lq+isVvZP+KW/OzYKSZ/Krv7i++
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,199,1708383600"; 
   d="scan'208";a="161412660"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Apr 2024 14:25:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E879BE0CCF; Sat, 13 Apr 2024 14:25:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2CF6EE004E
	for <cocci@sympa.inria.fr>; Sat, 13 Apr 2024 14:25:55 +0200 (CEST)
IronPort-SDR: 661a79d2_P77vXPrIc5UDPP9rVk8ohEtzaSYXe3wLge3albrC/LEtvLv
 BOzaLk+ETdNUdMeET0lgjtn3H2hQzFqSSO/jEFQ==
X-IPAS-Result: =?us-ascii?q?A0GlBgDJeBpmhwwR49RaHgEBCxIMQIFEC4JEfANTMgQLS?=
 =?us-ascii?q?IRWj0aGYI8GiHGDFj4PAQMBDTsGAQIEAQEDAwGCC4IuRgKIGAIeBwEEMwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFbQ2CY?=
 =?us-ascii?q?BiBDoEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QECDTpCAgEDIx0BAREnDwsaAiYCAlYGARQBAYJ8AYIqAQMxBw0GsSKBMoEBg?=
 =?us-ascii?q?goBAQbaWR8sIleBYQMGgRouiC4BhS9NhEAnD4FVRIE8gwM+gmEDARiBRoNbg?=
 =?us-ascii?q?kYimDCDVYV4VH0cA1khEwFVEzILBAwaAhsUDSQjAiw+AwkKEAIWAx0UBDIRC?=
 =?us-ascii?q?QsmAyoGOQISDAYGBlsgFgkEIwMIBANQAyBwEQMEGgQLB3WBfoE9BBNEAxCBM?=
 =?us-ascii?q?ooUDIF9gTSBeSmEMwhDcRWEBoE5A0QdQAIBC209NQkLGwYiAR2eAwGCDXRgV?=
 =?us-ascii?q?wKBG4EixUA0B4I2gWCBYQyKIZUkBhMvg3KTRg4GkmiYYiCNVJsRgXokgVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIBmEFIELg1aYDkE1AgE4AgcBCgEBAwmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
 DTfpJhirgP++gFu4j9gTQYItTtBwo6G7x0KBA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:mtBfxqgILqaFezVGYQJBiTgxvHBQXgQji2hC6mlwRA09TyXqrb
 HKoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhWYtKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkdNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AidoTfGqvxlgHeYZlO6xAI83mUfg1aiX66y+OGlC?=
 =?us-ascii?q?9VGRzSbPOb2SbwYoxxg=3D=3D?=
X-Talos-MUID: 9a23:GWEYNwutGtN5eOXqd82nvmFHLJhT45SVGm8WgLknl/C5MiUuJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,199,1708383600"; 
   d="scan'208";a="161412659"
X-MGA-submission: =?us-ascii?q?MDEWvtieAVuCx2TuchyID9xzrMEgfRSniV8JuS?=
 =?us-ascii?q?1bUCaneFXg0jMNsAg8Ue0CynEo6ca7LA0KY9NEaqTN5BFNitEvVWWxfu?=
 =?us-ascii?q?+BkxtMcOZkP8vVkFN2cdS0Jf9t/fCVg5DEAUaxO3X81J/+74ObhcAiYa?=
 =?us-ascii?q?N3iiHwbY4P3cZqhKYIKHzhEw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 14:25:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713011153; x=1713615953; i=markus.elfring@web.de;
	bh=G//ALFcPH2Ek2BJDiDGvigtfBsj+w6PKViXqIjnJ1Ds=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=k3LxXi1yZ7Sf15LyjWKMz4x5exoQCnWB/5emDzilVzkFIJZICK62LlCEzkh+ytVL
	 KwDwHRR+M4pn7ZTa4EbizwjYMVRTitSAHW4cu409lPuKKsgS7ASuPjwLAPScQw4HR
	 Se2iJqJYfkHPM/i3ShYoZATP7rf0u1fx4ceT+NDZdb+A2hOBm8SOI+dMDtbbSEOag
	 wGQnrkRSiH6jaisRuESfNy6IG7XBSWVJzxQ/OsF6OG2cex3NAB8J3iSV+5ui3wNtf
	 2XqrQ1qNITBd+/evsiH4BeG6QH/cuOC6nYekcCJs1fg+GwZP37UhmWJ09AxCbLBwW
	 3wTfK3YF44qPJV7I0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNwfK-1s6WWu3Zn6-00ODwG; Sat, 13
 Apr 2024 14:25:52 +0200
Message-ID: <45e717c6-80aa-4ac1-b682-821e73328e77@web.de>
Date: Sat, 13 Apr 2024 14:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, cocci@inria.fr
References: <20240413065726.2197-1-wsa+renesas@sang-engineering.com>
 <20240413065726.2197-2-wsa+renesas@sang-engineering.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240413065726.2197-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PXrur5W7rBcNX48422yZIAR6bV+4ZzPTZ6WMMnOFPsZogMGM+GO
 GVOEVFb9hmBvmXrPm7dIZ6qxcEFD941tMQZpErA+fONHHb8CMtIU+pUzpE9T2uDd1+NQmXU
 2LuLsU38ek5/J7CiZxfkx7D74266KTKtjACdtludAryAVG1gKjbOmjipYo8N61B/lxK6AWi
 a84PdU2bqaTrAIBY1iSKQ==
UI-OutboundReport: notjunk:1;M01:P0:CGjUx2MlSn4=;Zu0j4o0tAJEK1XKVQMsKDFph9Fs
 C/K/FlSMxHCRFPiwPkrWmjv6aMsAlZfP/jj06h06nEPUIqJ2j+4ZyzwU2k890hns5Lcb/N3wy
 JZQAKiTJZkoXUXGkfN8v5HCrU7QWFSnK5U7YVDYn1LkCQRJRhChLdHJ7abSnDkZhRgi3QIrMF
 QFzdlncRtE3EPJh17TRNuAAUTdL+/zBY9f0gdFuuyHpQaufiN/1BLYHUo/sNYi1oMOS0gYbhG
 ikHF8TBGjkndgsDVYd47JkSKvsGkeat+4djzs7x85o8NSt4j01slgknEwvGwtVz53YlZuup+Y
 6a+EBAwMzVGNXPrvv3bzhwbaatzlCYJOanx9VZo8ofQ3/Gw6axL88TxdL8gLSYsXc4Zx0jsoW
 Rd0dK7nF5+A1wGe7FPe+PoL4KWw0Ze+XME5I4iVyjV4Zh6hIphZL8IMCXoWdKucxg2kFdxH3Y
 LeQSgrWCIncq/qSlZ40KGxt2YZyxHE7WxvX0URwor/GnSA6mpbCml0s8lA59LlKyUSIyNanuE
 b+RhgdiLmEiaAhXFfTEBiFlI6taEUrUTtJk9CBoUldj2YgTOxoEz/mldKPWJLU6ZrVDNBOI8p
 8xpbrsbyyUIvLK9RwSPCV05dons/SysDp5tht6bfog2bGnPZpSJkP+TMUeth1/dJ9e4/VdAPd
 F2vMuWnwMWpFm6RA9D/Oi3Kq2nMT0Vq1BVEbFiFJ7LUIo0HOSAz133qjGEJAto4GK9kWqVQUO
 1J66oK4G3+cfa8nEgpIkZVWPwtV3L3HqsgeEekjEKHBYiGFs7juLrlpjTBudtw3vSb549Qucu
 VkAG46odbO0DkPQ9r2qFhqTG3vDfgycDRoBBngt+WV7po=
Subject: Re: [cocci] [PATCH 1/2] docs/manual/Makefile: check xxdate only for
 HTML builds
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1650
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/45e717c6-80aa-4ac1-b682-821e73328e77%40web.de>

=E2=80=A6
> +++ b/docs/manual/Makefile
> @@ -6,12 +6,6 @@ ifneq ($(MAKECMDGOALS),distclean)
=E2=80=A6

How do you think about to improve the software build system accordingly?
https://gitlab.inria.fr/coccinelle/coccinelle/-/commits/master/configure.a=
c?ref_type=3Dheads

Would you like to support any additional build options?

See also:
Choosing package options
https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.72/h=
tml_node/Package-Options.html

Regards,
Markus
