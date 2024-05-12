Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758C5C10F1A
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 06:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fQ+5JoJDFixwce01rW8ldvHT82HM2FfWwvPsGm2xIjs=;
  b=Zt7F1QWgls3jvIBdJtIllCmCJ3pg4tsQ12OUzDlJ7WIabj7U7+EQJ8Ed
   QAHyuxuJbe3TO2mWDeWMlLw77b7DokQfE070t15b4WRNXDpNEdVjmrlD7
   wqPBp13VZEDPinVpU0b8A7KznC8c9fYpSnzKUHkeCc4LYIkF63HVioDoh
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165226997"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 08:48:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 65B78E0AF1; Sun, 12 May 2024 08:48:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 52007E004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 08:48:54 +0200 (CEST)
IronPort-SDR: 66406655_QOXyMdHuysyBD9YyZEnVtdQLH4ucOor7ONlssHWpSe8MorE
 ccOMzjgILmMoH5I2lnVozKeNLki3EOfpsi8izZQ==
X-IPAS-Result: =?us-ascii?q?A0GwBADjZUBmhwwR49RaHgEBCxIMQIQTgQBUMwQLSIRWj?=
 =?us-ascii?q?0iBdTCEO4c5h0+IcYMWPg8BAwENQQECBAEBAwSCC4JqCgKIPQIeBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMXBw4QJ4V0DYJnA?=
 =?us-ascii?q?RCBDoEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEBAQIBIx0BAREnBAsLGgImA?=
 =?us-ascii?q?gJWBgEUAQGCfIIwAQMOIweySYEygQGCDAEBBtpZHywiV4FjCYEaLoguAYV8h?=
 =?us-ascii?q?EAnD4FVRIE8glIxPoRDg1uCaZockDlUfRwDWTIBVRMXCz4JFgIWAxsUBDAPC?=
 =?us-ascii?q?QsmKgY2AhIMBgYGWSAWCQQjAwgEAxA0AyBxEQMEGgQLB3WBdoE1BBNEA4E4i?=
 =?us-ascii?q?XUMgy+BdSmEHQhDbBWDdYF3DmGDWIROZoEnHUACAQttPTUJCxsGIgEdpmFEU?=
 =?us-ascii?q?VvHTjQHgjaBYIFhDIx1kk8GEy+EBZMzDgaSaJhiIKhngXwjgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIRmEFMsPQTU7AgcBCgEBAwmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:Ug3/HKE8dXveYV8WpLqENseALOsnbusQ8zAXPjNKOHlom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4xgPM
 xbE5SWZueAbmRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:2g8+S2P0RYstQu5DYgt8xEROA/4fVGzYw3brPE+UBmdER+jA
X-Talos-MUID: 9a23:gxnkHgnJehoSMi7R/pKNdnpAPdxUxYmKCHsqnKwhgtS8Nx03F2qk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="86791336"
X-MGA-submission: =?us-ascii?q?MDF8q81tX+UqXsV2HffDCPpgcYkdwanj7D1m9t?=
 =?us-ascii?q?dm+QvZ3jm2W+JdI993qO6UgW9EGxepJWqjvWxfU4qBf5IWOXbJ43ggsj?=
 =?us-ascii?q?cFRjqwAa+ZbIHTU/PaENcCmYziQx85zd+waZPPGG3iM+hGqrJerxvGvp?=
 =?us-ascii?q?PAvVJhm5YjwVIU7LZbrnR/7w=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 08:48:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715496532; x=1716101332; i=markus.elfring@web.de;
	bh=fQ+5JoJDFixwce01rW8ldvHT82HM2FfWwvPsGm2xIjs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JXJS+GJBJrzn9rFY5nuQq+aPwhyIkseKBELcCuXSUP95DH27Bd6HHDgtkTuk2ik6
	 EG/eAzCV9mylRmW5J6s5DTazL6R2nfJVy9e8JpOxk1nUIxUXF8aXWqnNVG0xwgAgJ
	 Wh72JVd5DG2RaaMcP2MUa9/LpvSvd3+ykvWjqLy7Bwy3TkZQ84X3WV9wVJUkufKy6
	 7zyFd13FKvNVdoz//koH3DFDfjnq0NQNlw06+8B/tvP3lG8PRl2KjeC26zwhZUDdx
	 vaS64PC4WCx7qQNq5kBKK5aeoklvP1L6KK4DKndjLtXQcJ3llP7LLWIoS5ZwuX/Ok
	 5g9cOZTg1V+hO+iEgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhFlo-1skLdm0Yvy-00eI5K; Sun, 12
 May 2024 08:48:52 +0200
Message-ID: <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
Date: Sun, 12 May 2024 08:48:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
 <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o8mMhU3XvEDT6mi/tZGTmO9vHKWhgSMsy1h6/ailtF3VDKtBtWi
 2onbs+BBO51VPCjvWMo0beUXzv9Dx6uMLpKK0Jhsc2LGcPbbDKqUJGnglu6ATRnqDs15DVY
 nmmpEQA3dY4aGy2GdKkKqhLEWCM2i/1VDT8NRq9sQL+KaSkBDmjka+B+x1i7z8YGiMDRR2R
 dpfQEXlkDAXShp0brmxLg==
UI-OutboundReport: notjunk:1;M01:P0:G3e7onY1rws=;GD63GFLMxArfjGuxKxBiYQyd8ZX
 dOCEWNfvPBqz2tvWFQE8F4u8z24ut1SE0Oj1xOa9RttyIQkGpNiC0Co4F0L7k6zWDlY6hYDWU
 kKp9o1ay2kFH+m8mE/K+8y7ihAF+sdkmU0NDSwpjiq9M6W+w6M7EowFzQHNLG98bkWh5sT21a
 jhY5Y4uCYj1SAi40u5/6kXHW8Vufrx5Z1OJi0Lh7tCGaZn/aPtztXfNk0hZ72wU1SMJVC2nkB
 Ca7A7lhqboFH4NhJN4eykiZqw+VeTYnyxCMwvLzK1Lh7uV9ti/PqhFktzroIPHwh0u0nXgjI8
 JbqW09b9LsJBQ2ezTdgiPw1dMD4glGA1GSdspcwzI5yJEsPy8ZRpXKq+MZ6gaF+x/frqa0TdN
 om4mD4OxdyhZz2VfhstmBaHh1hTgzmd8m1gdVT1q+6q0xorlOAgAMVbvoy9uTtlTIJTrQgfEq
 DtAdEU31O03yH0JarFAzLlHWSVrQrLEm2IzWc+KvdJph4FlKcdw673awsYyuj6F/7W0E8a2Pu
 h/syo0YgqmMS4+QQWal8w/67dz1Xv5XwFUZMP3ShX+coLBfokPRt/WJtXqJVvfmxwqHE0Rbmw
 6YyEk30YQ2UJedOu8txUCyhBSbK27cxdaYlBMRPGvM6GFN/aaASrrmeTKXe39g/ZVt5xzfUlP
 jQ1NM/J3ovEFAwM8S8rlg+gbjNHOul64UIfUSUrrXbzhDbNVjbKurFIa9YnZh7t/tSj9o4lU6
 uJGAmuDkThPTGw547Nvb35hTgUFK9//zQ6Ji80sQmb34CLoIcMxHo6lBH1Sjd4V2U/RrvWZAR
 1KE8Qyryut+EoPU91hMKNAexcGkSES3sJxnPMduQyW3vI=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1722
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/c26d41ba-7d55-402b-92a0-5c3d4112893a%40web.de>

> Your semantic patch needs to be:
>
> @display@
> @@
>  my_action(...);
>  <+... when any
> *my_action(...);
>  ...+>
>
> Without that, a call to my_action is forbidden in the region matched by
> the <+... ...+>.  Because any kind of dot thing matches the shortest pat=
h
> between what comes before and what comes after (here the end of the func=
tion).

Can the Coccinelle software inform better about the case that the shortest
path constraint was =E2=80=9Caccidentally overlooked=E2=80=9D in a SmPL sc=
ript?


There are further development challenges to consider.
See also a corresponding transformation approach by the means of
another tiny script for the semantic patch language:

@adjustment@
@@
 my_action(
-          ...
+          0
          );
 <+... when any
-my_action(...);
 ...+>


Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch use_one_t=
est_call.cocci repeated_three_calls.c
=E2=80=A6
previous modification:

  <<< 0
CONTEXT

According to environment 0:


current modification:
MINUS

According to environment 0:


adjustment: already tagged token:
C code context
File "repeated_three_calls.c", line 4, column 12, charpos =3D 48
  around =3D ')',
  whole content =3D  my_action(2);


Can the data processing be improved anyhow?

Regards,
Markus
