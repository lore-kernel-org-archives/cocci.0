Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCB5C27C55
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2024 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ruOidOrwZOaAxxId9EG9bGAERRkK5J083Bdh6wCcIZE=;
  b=FLBC6SH9uzxhrZEYXUf2X5lorQ8vyTGM/uWhb3PFlVx5pBqfe/jFlJF0
   gp6+Dp1fx1Np42O/0hqSmYpdv9jToIKaYARoRzE9pH+nfveT8tqbw0gea
   yhMvURMCp7Le/g5KJlk6QgS9YsE3v6kBzetFuyUyxMnNQcsbDl88nhC6F
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
X-IronPort-AV: E=Sophos;i="6.08,220,1712613600"; 
   d="scan'208";a="169518589"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2024 12:12:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D03C0E0141; Fri,  7 Jun 2024 12:12:28 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 73CDFE0035
	for <cocci@sympa.inria.fr>; Fri,  7 Jun 2024 12:12:21 +0200 (CEST)
IronPort-SDR: 6662dd05_eI4/5MuMCC8qq4G+qaaV4Yua0IalQhA4Vw9a8p3/So+01nV
 avQrM4Tdd0huvvAOq0UU4nxseh9ykp2cj3FrlbQ==
X-IPAS-Result: =?us-ascii?q?A0GVBABH3GJmhwMP49RaHgE8DAILFYFPgkSBAlQzBAtIh?=
 =?us-ascii?q?FaPSIF1MIQ7hzmHUIhxgVaBQD4PAQMBDUEBAgQBAQMEgguCdAKIYwIeBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFd?=
 =?us-ascii?q?A2CZwEQgQ6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAQECASMdAQERJw8LG?=
 =?us-ascii?q?gImAgJWBgEUAQGCfIIwAQMOIwexB4EygQGCDAEBBtpZHywiV4FjCYEaLogxA?=
 =?us-ascii?q?YV8hEAnD4FVRIE8gwM+hEODW4JpllANgwaCJoh5fyYLiktUfRwDWSETAVUTF?=
 =?us-ascii?q?ws+CRYCFgMbFAQwDwkLJioGOQISDAYGBlk0CQQjAwgEA0IDIHERAwQaBAsHd?=
 =?us-ascii?q?YFxgTQEE0QDgTcGiWsMgwcCBSGBdCmBJIJ3CENsFYEJAoJlgWsMYYgRY4EQg?=
 =?us-ascii?q?UGBZgFPgSGBbVklZR1AAgELbT01BgMLGwY9riJ3Wh7FRzQHgjaBYIFiDJ9IB?=
 =?us-ascii?q?hMvlzoOBpJrmGUgqGqBbAsogVwzGiSDNk8DGQ+OOoQUyj9BNTsCBwEKAQEDC?=
 =?us-ascii?q?YVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
 4qX/J8=
IronPort-Data: A9a23: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
 aXZhYyJfa1jdXPMLA==
IronPort-HdrOrdr: A9a23:PwO9TKyOJMff1x5pcRjIKrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:t+NvUG5XraeyAz0yfNssz21OEOwGXEHh00zgKUPpC0xARuSycArF
X-Talos-MUID: 9a23:jLcoQQnqqeoB5eoqH2SxdnpZbMw35oasDHxKsrMCt+Tdb298Nmyk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,220,1712613600"; 
   d="scan'208";a="169518567"
X-MGA-submission: =?us-ascii?q?MDGx38lKTxz3EGnzPYfvAISPvYy6YIzfG+3sAX?=
 =?us-ascii?q?8I43XCIBtEnfqL1vCKSaeXkIyZWBLQkMoNV9nF6E7F+k/IiL9m439WTl?=
 =?us-ascii?q?GtDdd0R2+LoY7hoGzUt+c7trll8U0Gb+rnbUFhnfzzUPl5r7+K6nR7e/?=
 =?us-ascii?q?J0HY4GhnFkcjVrbcX1MiGOqA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 12:12:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717755140; x=1718359940; i=markus.elfring@web.de;
	bh=ruOidOrwZOaAxxId9EG9bGAERRkK5J083Bdh6wCcIZE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L/68/PiPtOrSmuT0r1u1mWV12xQZAnt3STxZZXvfZOu5n5uOYgCinIy3S6gYaTyC
	 EmFaGIKk178buBcwAANPVRRo7lMynhFvBCvRTrt+ii8NLVg/HMRSSLzNrX/Rzn9Gs
	 Pl0gwcJH4tJZET0JVhX71KRQk67ghf7iBiAS08cfEr6MCzqlBA/sePxD1WtC6AmUz
	 czAYbxWWwTbzpQ0+LpI1O3GkV6ze+uhyDvJGF8ArducwcqKqSf8zwFfK3CJ00e8Ad
	 tDQQaqEVxv6xr+yft259MVEwHAzh81EU/n7dU/U9djiUeN0iRRKzvjNA96Il7b7Nl
	 g+QrkvpHydcEtBF0oQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79NA-1sVp3g1SdY-00xJNz; Fri, 07
 Jun 2024 12:12:20 +0200
Message-ID: <cccf7214-3a98-4c4c-89ad-bfaef1776261@web.de>
Date: Fri, 7 Jun 2024 12:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <7eb9626c-da7b-414d-bf50-da1eed27be31@web.de>
 <alpine.DEB.2.22.394.2405261847380.16852@hadrien>
 <9d79a2de-10fa-479c-b720-1c4a2f51782d@web.de>
 <4bad748-afee-713a-a2d7-30b6e5c1cb28@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4bad748-afee-713a-a2d7-30b6e5c1cb28@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bfb/J339Xa287nZwYLQi/yoI8Toq/qUJdi7sxahdJtul9dYZrhE
 34dfn0sqJwkECFcJaZTr17NineLPcJJKezymM5W1BGxZR6AsRcMrvT+A2XaYJ6C8IPdtSlh
 LFI/YI7G7HPiBkTBWqkLMyKNIRskolAtulGUcEzWHFw0zh0lr7L204M0TDDd4L1wKB0ZcZI
 AmLeBMixVLbsxCy08zoZw==
UI-OutboundReport: notjunk:1;M01:P0:ep/9XwZt/yQ=;1Ict5Q3FnzFA0FxlurPvJFLsb3W
 tyVnSCzVdtqSaCa+MqybCgY9qvb6UrDigbKH59iCWPfa5LY2fzcAKA4qA4DfcaTdJ/Sw+IjiA
 NxxE7e+UepxMbacCbpZGja6EtPGMm9E9DWpPVJ9HcR4kGfIjLMVAsMabL8zO4bhfZ3IsK0lXo
 fYIy3n4ltjwH2yQ7z3xUaYAHDr8e1lc3AVMHlSrvhF5epM3MXlRf1stklHP2vwsnfEpEtEKJz
 +UcdATn6CsvXxXxZxkUmLrZvXTw2ls9IroMnRIcUr9sUMVQZlIh7Kwaagmf7BUB8szQncnH7z
 Y5AsKVw8pCA7Hw92KFnoi1q2bMXsPVOgbBVQTxX1owGiB+N843UAiE9xRJ9s+L/kXo4JoNLfh
 YRuk5pAjijoVqmRE2OCnas+6QBaA4rG5ZVzCFS3td6p+Wxu4VWO1r7xVqrjlrBar73vfnoVQN
 lyFpMitheNAp7/jZuckd+cdFI7IQOlgTmLpEysZwblfZgqyYR319PpZRVWTFFpPIncNI5rmJ4
 pvDSxxM6X4ruM75BLE2MtpH3sjEhpiYgnQzNDyXxODEhLOukklLBTAOww/a0qFz0uIA2+JmK1
 1EbHvmEMKej0evdoc1CpdeCo2+7RKpqmoU5/IfYc5A2RWpWWDuaT7Y5bmEE4m73Hg4kGlMsRu
 SDGsKv5NZd/F9aU9u5Ubvg+U5hDTBhLYxgyFcG7hIDh9kYTggDoU2czGG8gJmtIirsjPLiem1
 G3uLcnLnPNSjx4wYogAan/xge7EstyXSvUDAiikNmuAdem47AtiL/H23KEWLYirpb/gBz5qmj
 9jkuodFQRG4eLQk/dz0SoeQZNMglYY6cOnpLTJy2LkxRE=
Subject: Re: [cocci] Increasing usage of spinlock guards (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1780
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/cccf7214-3a98-4c4c-89ad-bfaef1776261%40web.de>

>> Would you become interested to support the conversion of another tiny s=
cript
>> (like the following) for the semantic patch language into a correspondi=
ng
>> SmPL script variant which can be used together with the tool =E2=80=9Cc=
occicheck=E2=80=9D
>> any more?
>>
>> @replacement@
>> expression e;
>> @@
>> -raw_spin_lock
>> +guard(raw_spinlock_irq)
>>               (&e);
>>  ... when !=3D e
>>      when any
>> -raw_spin_unlock(&e);
>
> What exactly is the problem?  I tried this rule and it worked fine.

* Such a simple SmPL script is working to some degree under the constraint=
s
  of some known software limitations.
  Thus there are challenges to consider for the rating of the correspondin=
g
  application confidence.

* I would also appreciate further positive indications for the integration
  of coccicheck SmPL script variants.


Regards,
Markus
