Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E154AC30653
	for <cocci@archiver.kernel.org>; Sun,  7 Jul 2024 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QkCWcsadeXew7Ge1GeWxWG3ym+e9gGfdOrAchPLesdw=;
  b=NGB5g3PywUWbLXGARoZ69DPjTJv6nMxbJ6cQrJehr8P2u+emfJjcJTzo
   WBGWSIzYqdrH1RDY88yjLr3rvvWNOFShS7sC0PW4lnqveKLJK9+CJkUpx
   yvcxrYXpahoCarj84BwdS9CtcO+rZBZlv41mealz/X/iVUmQX/sasOzUT
   c=;
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
X-IronPort-AV: E=Sophos;i="6.09,190,1716242400"; 
   d="scan'208";a="174324059"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jul 2024 16:46:25 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 30076E0CCE; Sun,  7 Jul 2024 16:46:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 09B77E004E
	for <cocci@sympa.inria.fr>; Sun,  7 Jul 2024 16:46:23 +0200 (CEST)
IronPort-SDR: 668aaa3e_IaEHRW9Z1HYXT7HZkIyuJF5UBQBa3g3V3/RLP6w8MlCnKLn
 kX+eY3403sMtKxR+3VQ5DRYHBhSYhSD/kkA5Ygw==
X-IPAS-Result: =?us-ascii?q?A0H+AABaqYpmh07ASNlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDYnQzBAtIhFaIHYcrgXWEa4c5h1GIc4FWgUA+DwEDAQ1BAQIEAQEDBIR/A?=
 =?us-ascii?q?okSAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?SMXBw4QJ4V0DYJnARCBEoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHRAIBAyMdA?=
 =?us-ascii?q?QERJgEPCxoCJgICVgYBFAEBgnyCMAEDMQetc4EygQGCDAEBBtpZHywiV4FjC?=
 =?us-ascii?q?YEaLgGIMAGFfINGeicPgVVEgTwLgng+hAqEFIJpmVWCFolxJguMe1R7HANZI?=
 =?us-ascii?q?RMBVRMXCz4dAhYDGxQEMA8JCyYpBjkCEgwGBgZZNAkEIwMIBANCAyBxEQMEG?=
 =?us-ascii?q?gQLB3eBcYE0BBNEA4E3iW8Mgy0pgUsnhBoIQ2wVg2uBawxhiAFigQ+BPoFiA?=
 =?us-ascii?q?UuCf0qEUx1AAgELbT01CQsbBj2uPsh5NAeCNoFhgWIMn0gGEy+DcpNIDgaSb?=
 =?us-ascii?q?JhpIKhrgWc6gVwzGiSDNk8DGQ+OIRmEFMs/QTU7AgcBCgEBAwmFRgEBgyY0g?=
 =?us-ascii?q?UoBAQ?=
IronPort-PHdr: A9a23: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
 dXF0q7+em8qGzP8+MwBG47LJcjBPHdzaXLU
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:3+5Oq62z1SKzcSJUkWNfbQqjBGYkLtp133Aq2lEZdPWaSL37qy
 ncpoV+6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AIGylLmo8TGKmApn0igoKfEHmUdkDSH2A/kbXGGG?=
 =?us-ascii?q?TSn03aY+PYnnKw7wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ADXv04wyEoZJX7z7UEhQ3JQWyXomaqJ6IEWQ/iZw?=
 =?us-ascii?q?ZgPGnFzVOCSuCpzmUH5Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,190,1716242400"; 
   d="scan'208";a="174324058"
X-MGA-submission: =?us-ascii?q?MDETULb3U8XivPHTVv4EM/v5gCmKDGyj7TOSXv?=
 =?us-ascii?q?9/oQzWkDs1H6gRT8hQeJ+EGEB/QgkcppZhJ4wOmd7eWtAVveAcf0zVKK?=
 =?us-ascii?q?R17mMu9j5q83pDNkNt4c+Ixyz74Xi1DsvlmbslQKneP3RHjiM7ulBy5R?=
 =?us-ascii?q?L6sXZFCk1P8f93oW9A3pgBeg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 16:46:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720363581; x=1720968381; i=markus.elfring@web.de;
	bh=QkCWcsadeXew7Ge1GeWxWG3ym+e9gGfdOrAchPLesdw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k1IF4AyWMYMlCyoft6i2SV0t93UU5zCbsHhS+77pxkd3rVEw6j0zqRgYVLHZZo3l
	 jDCyZApxRyASguVH5gD+Bra4reeHK7Nua4AVNghglXD0fTUKWcYEHDoX6DRhqZOah
	 bDvMBWN68L6roj5IqZq4j06eweFLkkQNZOZhaOEXmD1cXoJDFKH5eE+TLN3+NVAvU
	 Nhepyyz+IzGWnuOz0jdYbJs3rkr8T82ClXcrvboAL9q8qBx/PJ55RtSxR6hB0ZFy8
	 uEdETE1Ag1aURprSh84DQOKTAHAK4Y9tuz9dU/Dn2A6BdrKbt+xSqZwHR83TVXKAO
	 pNFoEopRNAcf73mWvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mo6Nt-1s1pdG1Tsx-00a3lq; Sun, 07
 Jul 2024 16:46:21 +0200
Message-ID: <bd7db60f-cd1c-4a34-9238-d59ade6506b1@web.de>
Date: Sun, 7 Jul 2024 16:46:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <8d145e35-33af-4f81-a77a-2bbc5c734045@web.de>
 <ZoqY5GQlpKwZ3SEo@shikoro> <1d7aa71d-be7e-4750-b1cd-c1ee34e877c3@web.de>
 <alpine.DEB.2.22.394.2407071635530.3414@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2407071635530.3414@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b3kibqSaQmTD8mbZp9D/Wk8p7LDbZRiiqj1T+lLlPzkeSDjIi2u
 c0Btw9kSCpAYDlyiqjkDpeOWUB+iyymfuUAirk16+4TrGqoGchEJ+u2OLmDsYSx+rYaHYlF
 Y013vfhz+fH0rGYM9YA0B2bX5PFEAQ1g99WqI4GPnDN5/sWMsv/O4QvGbxZNOnHr3UbM/vJ
 VGEnZ3YNb0nA75iT47lqA==
UI-OutboundReport: notjunk:1;M01:P0:Y9wsW3Pk4tU=;wIRIm5tiaabX1l/IhyA5Dtl8kxz
 x+uLJIhM1LknZscQv8oXWWP2CNpwYMDxYsj763Y60NKbanWkjZhnpxzzMvUO/RFh2ynv4z03u
 5VzeBr6XPDypl5uOT0f6wRVQq4vbaoSlB5ZJ38dUCxyOCcykesvER8DMOjr+yZqoDxsg0yVnu
 8tpIFQvht0D/x0VBZQMoKp0BsmPSSzMKIofvzMZgLEeSt8JSWYj6pnwnROhAmH1DEPsI/zuvk
 efYByi35v8T4Rfat8Y+zZR77Io6qunbCI8p3Pq6v8U/j9utgHt36dWyawFTKQZ6G7ebhN+Ege
 hbPVg5uSTC6ObdPVy4ri6wWAfflLXrbxG1SHFpMsKmnewY8YV0fNvZje1uTpSgeL8Jiv1yGDW
 oTZKYOysa8e7flZCNZrZZHLJyngGW5IGnaFLYQ8cCvetvGS/1hL640FjGn5egP++cg5bJesAP
 LINigdg9zx1H2061DFX6CVF4DX8udaL3V4JtDNgGKsAgbkDbUueGvv5IO1v25IprmIt9kOyFa
 8LSA6duON2QHiJa0bUsNHOXJNJfcZcSJ3yPhbp83dNmGntpsbcQcHxzK8Z1dqn5/80K8vkLKT
 CLCWbpxK/0cK0vE9TpzucrNdVLiTWVvLPMRkxa6y9ofj+DhSvz2K4F4s9WQ7uZAI/RGy2iTML
 FscO8SupH2p5boQF2PCMOFzgZzz/3xLOdtXls4fHjl6veOZYeFzOSB3/akx0ZbvOwt9Atgd0B
 QvA6qBg+Ln3XC3SVnvToTgWzUjN1OIZmZ/kiprula2CnknU6nFKluMZ/EpMaMUGh4HSkq54xi
 pZ/C8tiN6xwz6ewnuUTW2gTsP+/OIXRor5zwfHGvrsBQg=
Subject: Re: [cocci] Deleting unwanted semicolons (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1805
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/bd7db60f-cd1c-4a34-9238-d59ade6506b1%40web.de>

>>>> @deletion@
>>>> @@
>>>>  return ...;
>>>>  }
>>>> -;
>>>
=E2=80=A6
> On the other hand if you mean that you want to find ; after the end of a
> function definition, Coccinelle won't help with that.

I hope still that such a source code transformation approach can become
supported by the means of the semantic patch language.

Coding style concerns according to the usage of blank lines at such places
can eventually be also reconsidered.

Regards,
Markus
