Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D873DC04A95
	for <cocci@archiver.kernel.org>; Sat, 22 Oct 2022 19:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Z0ebCrlqNiK0CeyfcX9O/ZWKBnH6eQkbLfDuDMu1w/o=;
  b=MOiRoh/Mzdouwuz1s5sSkxMq+uqeqdvKSgrxTSQ4MhA5NWJKlxFWL7Nf
   V2+i4WpLplZs8Idbt0ZkM+i02EJ6HECutL/a816JjiQKzb0AGyjSljV9n
   0wIhjLE7ynprs2CUt1JAEe91BnbPjPdpRJ7lbKW3bDwkgQxh8GR21RTHe
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67885126"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2022 21:45:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B48ABE013D; Sat, 22 Oct 2022 21:45:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D8CD6E004E
	for <cocci@sympa.inria.fr>; Sat, 22 Oct 2022 21:45:44 +0200 (CEST)
IronPort-SDR: 63544868_VYpHseHFwAdT0eJDUtoQWC+Z/0B/GHwOuFsMIp7GedWt5cK
 Bm4m3jzfNVi8vO3zcz+Dj3OD4gxYClu08fR+YBw==
X-IPAS-Result: =?us-ascii?q?A0AfBACDR1RjhwwR49RaHgE8DAILFYN8gQFWLgQLRQOES?=
 =?us-ascii?q?5BxKWmSAYwwDwEDAQ05CAECBAEBP4RGAoRxAh0HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQEARMBAQEZCRcHDhAFIoVoDYI1KQGDZAECAgEjH?=
 =?us-ascii?q?QEBESYBBAsFBhoCJgICVwYTEYJsAYJsAQMNIwcMq1eBMoEBgggBAQaBQAGDD?=
 =?us-ascii?q?R8sIlOBXQMGgREshyOEW4NjeicQgVVEgUiCdz6CS4F5g1eCZo8Uhko4A0QdQ?=
 =?us-ascii?q?ANGMg1RHDEnDgkfHA4XDQUGEgMgbwVBDygvZxAbHBsHgQwqKBUDBAQDAgYTA?=
 =?us-ascii?q?yICDSkxFAQpEw8tByNxCQIDImUFAwMEKCwDCUAHJSQ8B1g6AQQDAhAiPAYDC?=
 =?us-ascii?q?QMCIoFMMSYFAw0XJQgFTgQIOgIFBlISAgoRAxIPBidHDko+ORYGJ0QBNA8OF?=
 =?us-ascii?q?gM8K5cJgheBO4Ixwh40B4IdgUiBSwyJbpUSMwODUAGTEwaSE5chjUGaMzWBR?=
 =?us-ascii?q?COBWzMaJIM2EgE7AxkPjjk4g1SEYYVMPzQCATgCBgEKAQEDCQGBVoNwAQGFD?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23: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
 sNmdw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:7TDlM6E0q6eX/V0CpLqEGseALOsnbusQ8zAXPo5KKSC9Ffbo7/
 xG/c5rtyMc7Qx7ZJhOo6HkBEDtex3hHL9OkO0s1PKZLW/bUQiTQL2Kj7GM/9SIIUSXm9K1l5
 0QCpSXzbbLfD9HZK3BkWqF+rgboeWvzIDto/vCxHFwSgxQZ7hn9BoRMHflLqQMfng9OXIjfq
 Dsm/avSgDQBUg/X4CGJj0gU/LYr9PG0K/3eBJuPW9d1OEE4AnD1ILH
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67885125"
X-MGA-submission: =?us-ascii?q?MDEEGecjnX1v6IMReHBwFiRMB1Z3F0VKA5N+q9?=
 =?us-ascii?q?9TmuoyRXqpRy0Inh1d1GoXHJjj7SYFaB7zkHZsDJN2gfWCh9XiLhvVtI?=
 =?us-ascii?q?n46iNTeDPZwKTW/wCAlOyVUlpR5OiGguMtuCU3WzfsngND5Co5qZeBoC?=
 =?us-ascii?q?QmnrBtNhiksPbdghaVUWnyVQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 21:45:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1666467943; bh=Z0ebCrlqNiK0CeyfcX9O/ZWKBnH6eQkbLfDuDMu1w/o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gPZclnsiuacjqZFNhbs20biqp4ADwr/8BfdyIgh3HAFh7EU8iLgTBeLClgPMYr6zp
	 gam96sh9BK0GS2bukDOi7gSzSKlHsMJCu/VIwbBYLQ+aVg+qZILLZo75rgoeYsDtqr
	 +chN0FwOSaYpR1rmYMDDGLfW/SI+ylkdzqpSBqTP/pkiw8o4ATHI4m6H9QalukoI3+
	 J9Ae3pX1+mE/G8cPl/RkkVbcsJAIRFQ7yZGf2AmW+yDpdAM6fPmJP5JG17nK0ABv8Y
	 ngBtZ9GvqdVt4scIW8aAxF4lnD1MZjBv5hSkI05G8cJk3lUz/e8AdjVTL3W7El2fZ8
	 wZCTidpmq0a6Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.86.160] ([94.31.86.160]) by web-mail.web.de
 (3c-app-webde-bap49.server.lan [172.19.172.49]) (via HTTP); Sat, 22 Oct
 2022 21:45:43 +0200
MIME-Version: 1.0
Message-ID: <trinity-5b69abe2-b503-4cbd-9d94-699da8dff88d-1666467943254@3c-app-webde-bap49>
From: Markus Elfring <Markus.Elfring@web.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Sat, 22 Oct 2022 21:45:43 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
 <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:6th4XJm76LQZKfF5RFJeIRglPk+4TWGOa5as2Eh1AYTANeRMdTLDe20m24lcCqCyL70pa
 Zx45gw2d1kqGYWVEmedUL069Ux/+29tASVNqBIzbjt+grTZibO+6/pzwXvXuFEYdfw30JasEQcxp
 Dn8KAxeT9U/s+R5nv46jVIfsJ5AUTVuduzCFzbn37UHOmwEJU9qGgc9h8HypZ/MSDsu/V6VRAWEB
 rhvdMXGf3og891+NnjCQAcjzFEYGTOj19Dl11NV2ROr5y3OWe2Hb0N9DCTaVKEiQixdkXRCyvFu9
 Ro=
UI-OutboundReport: notjunk:1;M01:P0:1gJx9WDF0Xw=;Zy9/HfFSKfpB7757M59lpa2jj0j
 0Ov6SRbLVq+EUbyCR3mmPKzxIkgcaK2St+GOIiLCyR4mGqirxko5Y5rD4zflW2GnBMqSyWTFi
 6hnGZbMhJeyXBifZMtDWpMblGROLNiPaDRTr3MxVa/xV+R/EP+HrAXtS+zNtFJ4yf8+sFcp2s
 Ez0HDwKixdBxy1C2jz6FUjtLaXwpKNoQeFK6Y0Hnf79gdbcq2TrhcTWxzWz+h9U8V1UCCrUUb
 M0Ae4cvKZO0rKLgncgwjomxzTmcdUATEOOEkE61rZWG0xHBbMvdTTC9GvTdzXSB+1fxuklgOy
 e77WLe/OJvFKB6MzYYZqrb2f17Wi0Qw3oKm2zlKHmRXe87sfBlVLb9F3j6z1q1Sz6C/MD7A4p
 BUeNBEhlffAnxoIwLIkV5zPgPKsTB88PykA+DezWDcQ0DsCPF9j0pnUSkFhor7mk6JeyNhUmJ
 x/vLveR1325K9C97yak7wQFE6sNjszXu3gKZW9xpl3FKf1wGbRke9/pDafVj9/DA83xXSzh1m
 pjbN85Pc03KMZFeCDzq+v21z9vIkwFANmgh/ky5ooCy8kMolRJgSC7cHW1EX1IvDYK0BQumvn
 duZBPYS1iLKp/yCfrQ8/6ZokPSjSZUbd9C5BZwcRv5fDVOq6eivun3lQ/hMTVOojSRTspxeZN
 +hfu/RaQj6dqopRV8aDEKJ9gKgStn4+Z3adHADzU55oxa6hBoMHppa9/O22ey4LRRFNWADci7
 yKZ88zX5xHCeGtkWVek40WZUCjXykGIQOAcfWcddFwp0p+NX6qv+9fYKVci+3kX1c/E8I1iIE
 3XoLfdG+mL4mXlbsn8UUZUMA==
Subject: Re: [cocci] Replacing special do { =?UTF-8?Q?=E2=80=A6?= } while
 loops by selected function calls
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 671
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-5b69abe2-b503-4cbd-9d94-699da8dff88d-1666467943254%403c-app-webde-bap49>

> I just sent these in:
> https://lore=2Ekernel=2Eorg/lkml/20221022014403=2E3881893-5-Jason@zx2c4=
=2Ecom/

I suggest to reconsider the usage of SmPL ellipses in more detail
according to your SmPL code demonstration in the description for the chang=
e
suggestion =E2=80=9C[PATCH v1 4/5] treewide: use get_random_u32_{above,bel=
ow}()
instead of manual loop=E2=80=9D=2E

Regards,
Markus
