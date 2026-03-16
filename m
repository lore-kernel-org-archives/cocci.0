Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518CEF4644A
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2026 10:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ItnIhc/ZRVZr/XO3cNqCMKiUdGxtolfwETHwEZ30vEk=;
  b=SIT32TilW4rgp6emSfz+qLQ5nD3UVLd9tloc+aIbPYZpdwQBTd0YwD+V
   5Op/lqqCgohgOhUIcayaxNLIgoy39HEK/5YvHWOySGexmkCkg9x/GQ09x
   t6SFmVXZaGsjwEFvytgF4Vrsb8rSnO87fZXpe9MLQ3klM7FGGDzpcaSg3
   U=;
X-CSE-ConnectionGUID: Wz8xKlxFSLeQjXRf4hbVig==
X-CSE-MsgGUID: w3hs/k+XQ2GBtvtlDPJVTg==
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
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="scan'208";a="267939174"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Mar 2026 11:46:29 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EEA128201F; Mon, 16 Mar 2026 11:46:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C74348201A
	for <cocci@sympa.inria.fr>; Mon, 16 Mar 2026 11:46:22 +0100 (CET)
X-CSE-ConnectionGUID: FdNQ4uBUTtKatMK4hIoIJQ==
X-CSE-MsgGUID: uK8UgnXwRh+NdTbIgsb6Kg==
IronPort-SDR: 69b7df7f_NBGcNTSd7l4vLj3BcV+yt9p9URj/krvmZ8+5Qw+YKlyqhu2
 tD7uoU7D5LF9olwm5Z66S/5NmSSVvBAtzcKG5qg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EXBwBI3rdpgAMP49RaHgEBCxIMhFGBZTQEC0mEWI9Tg?=
 =?us-ascii?q?iSEO4c8h1WIeYNSAg8BAwENTgECBAEBAwSCDIJ0Ao0jAh4HAQQ0EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBBAsLDgwCGA4CAlYGARQBA?=
 =?us-ascii?q?YJ+giMBBhABAw8nB7c2gTKBAYIMAQEG2mQfLCJZgWcJFYEKLoVvgmUBhXQ7g?=
 =?us-ascii?q?0V6Jw+BVUSBPIMDPogegmmCJoEOknFSeBwDWSwBVRMXCwcFgSMQMwMqLy0jS?=
 =?us-ascii?q?wUtHXAMJxIPHQ8IFB9YGwcFEiEqTniCAQ+GZXkDLl4aDiICOVxKPgoBUgWCL?=
 =?us-ascii?q?AInAgELbT03BgMLGwQ9ji08qyOhRTQHgjiBZ4FkDJ9tBhMvg3EBk2AOkwsum?=
 =?us-ascii?q?FgiqR+BfyOBXDMaJIM2TwMZD44hhDPISEUyPQIHAgcNAwuFRAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:C2MXBKBkK6lTPJrlHegSsceALOsnbusQ8zAXPh9KJSC9I/b0qy
 nxpp4mPEfP+VAssQIb6Km90ci7MAThHPFOkO0s1NuZPTUO21HYWr2Kj7GSpAEIcheWnoUzu5
 uIG5IOS+EYZmIK7voSlTPIdurIt+P3kpxA692/815dCS16YaBp6Al0Tj2cDlB3Qwd+A584Ho
 q358ZMpTasEE5nJ/iTNz0gZazuttfLnJXpbVotHBg88jSDijuu9frTDwWY9g12aUIG/Z4StU
 z+1yDp7KSqtP+2jjXG0XXI0phQkNz9jvNeGc23jNQPIDmEsHfiWG0hYczJgNkGmpDi1L8Yqq
 iCn/7mBbU815rlRBD5nfIq4Xig7N9h0Q6j9bbSuwqanSWwfkNANyMGv/MaTvKR0TtbgPhslK
 1MxG6XrJxREFfJmzn8/cHBU1VwmlOzumdKq59gs5Vza/pvVFZql/1twGpFVJMbWC7q4oEuF+
 djSMna+fZNaFufK3TUpHNmztCgVmk6Wk7ueDl3huWFlzxN2HxpxUoRw8IS2n8G6ZImUpFBo+
 DJKL5hmr1CRtIfKah9GOACS82qDXGle2O4DEuCZVD8UK0XMXPErJD6pL0z+eGxYZQNiIA/nZ
 zQOWkoxFLau3ied/Fm8Kc7jSwlGl/NIAgF4vsum6REhg==
X-Talos-CUID: 9a23:Z0S/4W3ygEt100UjAOP9HrxfNMwDSyHA5krsP2yxFUNKFL20Tn6ywfYx
X-Talos-MUID: =?us-ascii?q?9a23=3AMmsIuA2rZxdUZCD7P4ZFy3LfbDUj/of+NU8LoYo?=
 =?us-ascii?q?8u4qiORB6GjiGhmqUTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,124,1770591600"; 
   d="scan'208";a="267939142"
X-MGA-submission: =?us-ascii?q?MDGGp5bybXG8bKDTFDcaLRzPs7FiGMfG/7AWo7?=
 =?us-ascii?q?iUpTU2Ui0eI8OOmLNyduIggCkYr/SR2DXbxLfDdXyjWvtZUqQTmLcHO+?=
 =?us-ascii?q?+qfdIUiA/fQqeCzKYWOH9vdpxLnjLjbOXbJBiLlkeapzM89Tr+pHnrEo?=
 =?us-ascii?q?10UYbUKqKygrkX7hCCwSkGaw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:46:22 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MREzA-1wE60J1LCW-00SQYt; Mon, 16
 Mar 2026 11:46:07 +0100
Message-ID: <202abb30-1e4a-47bb-a1c9-898d3779880e@web.de>
Date: Mon, 16 Mar 2026 11:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alejandro Colomar <alx@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 cocci@inria.fr
Cc: Nicolas Palix <nicolas.palix@imag.fr>, Kees Cook <kees@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <cover.1772752564.git.alx@kernel.org>
 <9fd8d3d1e7ef3efb6e6dae0972dd515ff02e42bd.1773058287.git.alx@kernel.org>
 <806bcb6d-3ebb-4454-973c-f9d6530a17c2@web.de> <aa7XD-rk_KWQvTQX@devuan>
 <abblv3nCut5aRk7q@devuan> <0c5eded9-f56a-434c-a04f-b229945ae4c5@web.de>
 <abfdDqYbRWZ6UNjB@devuan>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <abfdDqYbRWZ6UNjB@devuan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:m9nRV56Xw9nR+aIkzNCOcQk7L3QlwyUAdyeSpFRnjqhEW9hJXbu
 nH0Xj9Sy9RRUhPVUaSC4QDAHNWHJUIncRC17FBdlUCuAL7DqVdXeyolSy03mK9UK9Njp4XL
 6vS9dtUtv1AQ4Ht2NFsFgTiZHrkjCxy+XZRac4p1PMJDpc08op43u4lz0Dp5O/FpxJ2Y6Sf
 ZUDlxakPWwiwzGXrVUhnw==
UI-OutboundReport: notjunk:1;M01:P0:GSyc0HB8NOo=;qvF4wXITxIKBycJ/KX7gbG305TU
 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
 ZIZekyUm81g+x0IHYLLX
Subject: Re: [cocci] [v2] scripts/coccinelle: Add script for using
 ARRAY_END()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3438
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/5GLrBhhnjj-1YhMAzdR27Q>

> There's nothing we can do to improve the patch.

Can we influence the evolution any further also for components
of the Coccinelle software?

Regards,
Markus
