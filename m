Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2058BCE8E96
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=T40PES+kcK+x6nET1EjAM1tj6Iv60G3UBCbJ63x6Txo=;
  b=SSH6uitulXl0aSJMEm2hmJV8qHfijQQdI0kls3FeCmfvuheJnV6Kr1gZ
   J6KTlIYeL2LafQwL5xFYWxnmdNM0NKjxFQ0OXk5IIlZe4aQBY0eAK01MQ
   dV81LryWK+d01TjWP49/B404oWIgYwXotDzlDFfdSQ4WnTuxncotLjLqd
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190609540"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 18:48:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 86E62E0D1D; Thu, 24 Oct 2024 18:48:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 37C42E0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 18:48:37 +0200 (CEST)
IronPort-SDR: 671a7a65_un3oDrYBZxBXdFPkVgIH3KEyCtPB6HmAGT8rkBma9btl2iZ
 cGwtXe1ZXCaJyYyIFGglT1tIKzmiulE/IntrLog==
X-IPAS-Result: =?us-ascii?q?A0FcAABueRpn/07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDB1t1MwQLSIRWj02BdDCEO4c6h1SIdYFWgX4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEhQACiiQCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QKBCggLhTVGDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBEScPC?=
 =?us-ascii?q?xoCJgICVgYBCQsBAYJ9gjABAw4jB7AwgTKBAYIMAQEG2lsfLCJXgWMJgRouA?=
 =?us-ascii?q?YVpgmIBhiSEPCcPgVVEgTyCSzg+hEODW4JpkgmLanKHdG6SA1J7HANZIRMBV?=
 =?us-ascii?q?RMXCwkFiTUKgxyBbiaEEQiBKxODX4FnCWGHZV2BDIE+gVkBRoJySoNMgWEFO?=
 =?us-ascii?q?EmCTWpONwINAjeCJCRcgk+BJQQFgzyBPx1AAgELbT01CQsbBj2uJoJ6gh+gK?=
 =?us-ascii?q?KcSNAeCOIFlgWMMn1UGEy+DcgGTTQ4GkniYdyKofoFpAjmBWTMaJIM2UgsOD?=
 =?us-ascii?q?44hhC3KD0E1OwIHAQoBAQMJhUYBAYlZgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:lVT1JasL7wdm+jDhe03qUX/GyOfnVEFfMUV32f8akzHdYApBsoF/q
 tZmKWrTaa2CZzfzeIp3O9609UhUuMXVmN9nGQtr/n03FHxBgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNsspvlDs15K6u4WtC4gRkDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJGAWMpE/0ewtPUcUz
 eQYcixdMDC81/3jldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaHOOVv5kBjW122ZAm8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PtvvTCCkVYhuFTrGP/qePGSRcZKp13Cv
 kfP03TzGSM2NeXKnFJp9Vrp3IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku5Rs4ZN
 EEevCYjxUQvyHGWohDGd0XQiBa5UtQ0ArK8vsVjgO1R4sI4Ijp1B1ToihZEb8E68tA7T3om2
 zdlWj8v6SNH6NWopbC1r994bg9e/QAKIGVEaSJsoc4t/Yz4uI9q5v7QZo8LLUN25+EZ3Rnvz
 jrMoCVWa3D/SyIU//3TwG0rSA5AanQEosDZK+kXsq+YAttFWbOY
IronPort-HdrOrdr: A9a23:kI07SKkZ25XCDd7fJ2SVkYtfLmXpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:b4mGsGPblFWxmO5DeQlo6Gk/EJoZVCfl1HeKPx/mKVk5V+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AYTPn0Q4O3eHGY5hcJa/7g1mDxoxN3KaDEEAOjqw?=
 =?us-ascii?q?d4dGhPABgMSyvoDWOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190609528"
X-MGA-submission: =?us-ascii?q?MDGW9o+jPLdDrK/KZ1F8sxHGGSd7425mcIANwi?=
 =?us-ascii?q?Z6pdv/JplFYi30In27NLVL+Uih0hF18N0f5TkuIM6cOLzIJI8cUez3xB?=
 =?us-ascii?q?mMxqNWNTpxDYSfeipPSVcl6EvUz6VaimkTz3pr+dUH7EBcOXQqE8L5sz?=
 =?us-ascii?q?vdIO45BXmGivHMMd6hdfpDgw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 18:48:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729788506; x=1730393306; i=markus.elfring@web.de;
	bh=T40PES+kcK+x6nET1EjAM1tj6Iv60G3UBCbJ63x6Txo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wzJQPbJa2jgNphmdlkodABwJtCPzKzcfnb5GlDQwNhECYqAnjct0alGhuEjkTMY4
	 c2D+kE69mvSGHvxuq/l60MXflijN7qLaoatJEXtDAUekhIsH81vUyeOR2NNv58ITM
	 cmV6wlKVMjqRIC2P0vlWvDlFeglStyPrywAZyrzC32jUhM1xor6oXFx15V54fQVWg
	 n8ltm6hL9kPaqHBd9Zlv+rDgRL3yQG/HW9+gmcTVuP13TbUddlVDDvFmvRqkQsi5L
	 dpZGLa/Ze+PEHR13YYXkvQLcHAiYoTfl5cpaLSzEuQR2YN2TuKKMVDA/eWdQsZKGn
	 0j82gG16V2d/BRj0QQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MREzO-1tIETG0JXA-00Qjqz; Thu, 24
 Oct 2024 18:48:26 +0200
Message-ID: <db8a6990-f7ae-4e2b-b3a7-bd157fa7158e@web.de>
Date: Thu, 24 Oct 2024 18:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Derek M. Jones" <derek@knosof.co.uk>, cocci@inria.fr
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3lsLViXICPexlu8OeBAOSGXpbEfpiWlaxLobn6SRmQQQBHjnz71
 DjnIPFZqdAOZLtqCeRBkHiE62GlV8tSBfeSWCLTJCJMj9nzoB74t7P7hcg96Nby8cNG9X13
 l40kZ+jqQnUhBRjg2U2DpSSd2yvHmY664+NBzMSfSIRi1WvwJIf9FN/CuLI49COIbrFKjLR
 9FoTDsLqaFBnwLFek0EYQ==
UI-OutboundReport: notjunk:1;M01:P0:n4+aHiYN5JY=;h9nKdtb8BnC6+4qSUnWKY+vT1EU
 uInTBNA4bnuC/DgNRX9y6h0I6ueTxld+mh+cjmEwga7WEyN9BBoowON31P1dhu9LGVLg0Ym56
 kcS5vW5mjzXc2pVQLmquJWd9s6zaFd1hgdwmtI5Tpoi0M79xAS536vgjZxKEO5aP3Ivdmi7Uy
 52YpUIVs0NQuo4dyX6FZGdtFb2AVe02sXC2CF7xEnvrNrq01eu+tpZx9QIHcJEsO9pAr8TL46
 yErIwD4Mmso9c+WNBi0/U8sAG5ermrln3NGZ65mV29rWPhFbMutqXW2YCOkZnI7W2br6nUd3e
 cnGBODHDzjvBcEnw7WzDBWAtdVngTiMEVp0/qfnNitEjxKloRGVQx1eCKGD/UZj/8AZRessyb
 Ju58yXxSfsutsvebbWa4AyyVLhU+If9EWFk7+QtGgo9NhwCt2rIN75Y13/CPKud1guTxQlhSN
 l7iS+drvXtXrFIR65RpNJkyYVu+kL9OzLvaFI5eLuxAuSPIjjmJvr4vGDHoK1LBEmZKPrCMl2
 zNo1zD7s9FIHTiKN04pAxNzNVh6JXGXSPrSERBU/Np4kyb8NOPN3yxzVtxb+zsQ4oBOd5S9/D
 S242QFBpVaYnxMpXsIe5BlZx/iZFViNo1UqKaQ+nMS3oSFQ2IS1zautn/zq3+pd1Fas9f5LFk
 bdlQbwadV9fsRzPF9MMLfgxvBjalfco5fbHzKU/O45ongYkTWtkBSBZrT8SKDJPenmCtpc3qw
 jla+XLEMS67C2mYd+f6IhdidjpmelngZOEW60JDN/e2gn/A/Wzs0h47rZs56dO8brHJZCWty/
 WgvdAUfzfVKkPr2VoRVsuJ9Q==
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1933
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/db8a6990-f7ae-4e2b-b3a7-bd157fa7158e%40web.de>

>> Every position variable contains complete information about the enclosi=
ng
>
> Thanks.=C2=A0 This will simplify the scripts.
Do you transfer any source code position information into higher level str=
uctures
so that you can eventually benefit more from parallel data processing?

Regards,
Markus
