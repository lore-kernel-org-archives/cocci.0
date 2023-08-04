Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9F1C001DF
	for <cocci@archiver.kernel.org>; Fri,  4 Aug 2023 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZodWBghBk2EIlDd6cEA3lgUWSqeD700gOGh6D32UYRw=;
  b=OeTw2ijFTDaIXi8sk1hF5O+qFK4ReBiEIExqmKaNyaxfyASe9uOF7C2d
   /RZtBd8d8n9Q0FsMJN+yiYoqiB9jRNiMjt00tGPetKkTCu3qqzG1T0Tsv
   jsjvK/MorGqh1bumpBRi2MimW0G4ceAZJCiTy1YFZs07g4nIbHtQY7du9
   8=;
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
X-IronPort-AV: E=Sophos;i="6.01,255,1684792800"; 
   d="scan'208";a="120216774"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Aug 2023 21:10:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E2714E013D; Fri,  4 Aug 2023 21:10:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E647BE0133
	for <cocci@sympa.inria.fr>; Fri,  4 Aug 2023 21:10:36 +0200 (CEST)
IronPort-SDR: 64cd4d2d_vj9dyAuvMTFClN3/DhDcj0ISfpsFb0YwxERilupQ/YQmsc1
 5jMNRWfS3pq2EjRraucM+5sNId8+VYIlj4TsuAA==
X-IPAS-Result: =?us-ascii?q?A0EMAQC0TM1kh07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIyeFMwBAtHhFKPOIF2MIQ6hzOHSYhtgxY+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?IR/AoZOAh0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECE?=
 =?us-ascii?q?AEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBFwJHPwECA?=
 =?us-ascii?q?gEjHQEBEScECwsaAiYCAlcGARQBAYJ6gigBAw4jB64XgTKBAYIJAQEGr1QfL?=
 =?us-ascii?q?CJVgV8JgRUtAYgAAYVFhDUnD4FVRIE8glMxPoQLOYNbgmeKAJJiK4EICF6Bb?=
 =?us-ascii?q?j0CDVULC2OBF1I5gT0CAhEnExQFS3MbAwcDgQUQLwcELwcWBwYJFxgXJQZRB?=
 =?us-ascii?q?y0kCRMVQASBeIFWCoEFPxUOEYJQKzY4G0uCagkVDDUETHoQLgQUGIEVBEsnH?=
 =?us-ascii?q?xoePRESGQ0DCHwdAjM8AwUDBDgKFQ0LIQYuBA4DGSsdQAIBC3A9NQYDCxsGJ?=
 =?us-ascii?q?QEeAieedoI8gw4RX8Q3NAeCMYFdgV0Mnx8GEy+XFQ4GkjKYKCCoIoF5JIFcM?=
 =?us-ascii?q?xokgzZPAxkPjiAZHoNwj0g/NTsCBwEKAQEDCYVGAQGDJoJaAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:a+ZrcazR4uS+gjgdfV6VKrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:1wIQq2/kRJX7+oEtS9CVv0sXJ9E0SX/D8GuKG0+SA1pGRZiRcHbFrQ==
X-Talos-MUID: 9a23:gpLQ7wZWD7ru8+BTkyO9hiNYaoRRu5+3OEMHzpko4ZbHHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,255,1684792800"; 
   d="scan'208";a="120216771"
X-MGA-submission: =?us-ascii?q?MDE34TI0N4/vn4JA08MK5AjEX1/7iUR1XMx4wd?=
 =?us-ascii?q?imV2dwI2OuY5b+75YlBbm+bJQAAdIi0b2PYoLEnQStQMe7tsgpVYQmgk?=
 =?us-ascii?q?Ql4Fm421NIQICiOjS5rY3oaBa347FpiaNqLL2svHjpISKkrU1B771E35?=
 =?us-ascii?q?+oKntNwOfq+e/9MADWjhHZqA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 21:10:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691176225; x=1691781025; i=markus.elfring@web.de;
 bh=fYlnJdCnXYALQJm0Ie8FxZqgYoI8qezjzxmOuPVioG4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=eqQg/OjM5MPye90/Zn7ml1Kzs+wzxzuBMWG0Wdc1Zo+xvfwphmuUYYd3XThy8UkZD42k14u
 UlG4+TD173GeIMqtil5Uj/lXcnom9hOY4eZXbO9zOfTSwFyzInFIjl8F0N9RJLGAV6t3v5H0k
 Rq5+LytIDGrSsPI8uKLQF+obUyFuuUfwVLLV6lXgYNg1dRZ37Lx0Qz2a3upkh/P2uB9azJrN6
 3N7nBb5F7S3fcwoyMsqQ2vBBB3yQQ0T1UbItggriLoRqfiyWSQwourkMsdBParDKts3crwezZ
 q2y28fUGA/foD0Q4CFsu/Wnl53xnqkJMFYktsfj6rhlzEuTo+hfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPZj-1qETYG1b7J-00M7FA; Fri, 04
 Aug 2023 21:10:25 +0200
Message-ID: <4a4a38a1-67ef-432b-816d-9e8e7e9e7b89@web.de>
Date: Fri, 4 Aug 2023 21:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, Julia Lawall <julia.lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Li Zetao <lizetao1@huawei.com>
References: <20230801094337.4145806-1-lizetao1@huawei.com>
 <526c2701-9659-85a4-aa10-4ce2bb499b18@web.de>
 <a22f1cd0-9a9c-7ef6-f36d-a04119591d2b@inria.fr>
 <7343e191-7775-dbec-265d-6bd67fe50cd5@web.de>
 <8a77bfa1-267a-4455-9614-ef3392e526ff@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8a77bfa1-267a-4455-9614-ef3392e526ff@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nIpUsAKIwpphph0r1Dr+Jypz9TOXYbEMKRXySzBWJjCQ1P0wSd8
 5XcCp9Khp5yLIK6cgflSsM4bnxF6fxClKqDAGTr6jiG8GfNCnp0R0lFgoNw8C7iD6wgWkvp
 lRGS4ueGAAqOE4tDO1kfY0l6Q5xEy3Xg4HVD1dsNXnj19kaLs5SmoeApA4n9aYMM34kl8kF
 wCdq6pwBVur35Zg5Uh24g==
UI-OutboundReport: notjunk:1;M01:P0:gddXPsaiyPI=;63Ww8d3nNk8CE7sbwVdxTm8EwbZ
 b0j+N6PtEo9/OvwONYVyVxgIu3M0rHhKC5/+GKNP+5dTF8UHP7FJoyG8yCAuKuLvIjscPc2ZJ
 DBfHkCXrosd22dW0/0FRMrF5Qvrw5K9Mg8RC9TvJuVik9FnzxsQuu0p2CVrH7uxpR49Tc9B0/
 WKAOwCLpJecvWoggGEZAp7B5KWVoOPZ2OU5hfPmcHAPhUW83OkCoEZj+A0uM3PDx6zyD+oF5U
 LVEmT4kgTtVw7OAViwU7Xh0LGFzk3elErudLlw5KqNo95HvmzVv64RPMFM5hvkeDVAX4IX/JL
 e6qmDUcxyNjg90J3cYSx2z7xP5fecAOCwOlF8s9Jz8dUgkGhdjwPOhOO1RG2SJZlfIoxGkYQZ
 fWYanZzvBYhmVScnQXpTrxiO0q02xwfb2hbLAn4D5laKC1rabfC2KiTvtJR2h62cs66YmSPK2
 OlJAJPsDyst/eV181Uxqv/NdV6KE6C4FgT/faG0xlPB1KYgk/g+dT108jPh/a/zlxs3vIYTHC
 1S1nxF4+A+deRxwx9DomRmn3U70ZTA+7lD0pZQDtJXrVOzqVMa23m9b7UG/9wZa8YozGyhI2a
 eLo8v/ASSijf9TkHKez6sY4cUXlDtk+GkEr3GSDKH2wMBv1hMugzrY6chZ6uiTp9lknaKr1In
 UToULq7jWUI3tIbIwXEm7nV11IBEZs+zBIX6u3S2UOjhurzm8QltfQg+Wm5g6Yww2LrbLwvG8
 HBUhKCaNkje4waCeORtBpU45Bf0DRlYI/u4LbX5vt/tmozu5FBFS5YHzZMElpuPPGDzja0aOy
 3p5lbAZbenSyIaX07rC1lZHa55I7o6MeZz34JrO1XFCxYtKsL37RjZsVIpbB/lJtKxR8lOxX4
 sjMCiwLEnCVyqm5Bko4cpTp6DgHT9VslZ/oK5lmevSjznO7pgjxziyMfXJBcfqGn1BAXJdu2p
 gYQt5Q==
Subject: Re: [cocci] Improving support for handling of optional items in
 deletion patterns
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1228
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-08/4a4a38a1-67ef-432b-816d-9e8e7e9e7b89%40web.de>

> Normally, you can't put + code after a disjunction.  Because the two
> branches of the disjunction might cause the matching process to end up i=
n
> two different places.
>
> The fact that you are suggesting to do this seems to suggest that you
> think that the Coccinelle semantic patch parser accepts this code.  But =
I
> have no idea whether it does.  It should not in any case.

Will the chances grow to reconsider involved application concerns any more=
?

An SmPL disjunction is used here to achieve the deletion of a statement
which contains an optional item (like the key word =E2=80=9Creturn=E2=80=
=9D in the discussed case).
Regular expressions support the quantifier =E2=80=9Cquestion mark=E2=80=9D=
 for such a purpose.
Do you see possibilities that the semantic patch language can support
such functionality also in a succinct way for SmPL deletion code?

Regards,
Markus
