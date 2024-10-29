Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068FFD2AB33
	for <cocci@archiver.kernel.org>; Tue, 29 Oct 2024 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+MLvE92gvVkEQAGqtYBjJnkTDOAkTPD8hoSV1y76KCE=;
  b=acpJXkLerd/acAAcvroJQmnkhmjpFJGEphm5tloglCq51eVCRrN/Qehu
   PprGdNhiZMXwz5llWuLe47PCEzWy7Rr1IppxI97RInRKrJnvubYAi/f4j
   afc9lCtNWwCe1Akh8Zksvz6m7EVnplcwx74FjCrUDQLdjiuilVn4PJ32p
   w=;
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
X-IronPort-AV: E=Sophos;i="6.11,241,1725314400"; 
   d="scan'208";a="191237866"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Oct 2024 13:18:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 25113E0D1F; Tue, 29 Oct 2024 13:18:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 01952E00B7
	for <cocci@sympa.inria.fr>; Tue, 29 Oct 2024 13:17:58 +0100 (CET)
IronPort-SDR: 6720d276_fCPKYqclUIdYd728Nqf5d4OM17BD6G9rQJag4xeba6iYixt
 dyF9ti0VDFXKHthK1p7z+34nvOdOYVO2eG2E95Q==
X-IPAS-Result: =?us-ascii?q?A0FsAAB10SBn/wMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDB1t1MwQLSIRWj02BdC0DhDuHOpBKgVaBfg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSCDIJ0AoooAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECgQoIC4U1Rg2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmA?=
 =?us-ascii?q?QQLCxoCJgICVgYBFAEBgn2CMAEDDiMHryqBMoEBggwBAQbaWx8sIleBYwmBG?=
 =?us-ascii?q?i4BhWmCYgGGJINCeicPgVVEgTwLgkcxPoRDg1uCaYJVh18liDdokWRSexwDW?=
 =?us-ascii?q?TIBVRMXCwcFgSsmLgOEblt/gTuBUwFGgmZKg0ccgUU4SYJNaUs6Ag0CNoIkJ?=
 =?us-ascii?q?FmCUIElBAWDOoJfHUACAQttPTUJCxsGPZwsgWxcgS4BghhbMsU+NAeCOIFlg?=
 =?us-ascii?q?WMMn1UGEy+XPw4GkniYdyKof4FuBDKBWTMaJIM2UgsOD44hhC3MSEI1OwIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYsfgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:4docMqN3AmymeO7vrR1jlsFynXyQoLVcMsEvi/4bfWQNrUojg2ACn
 2cWXTuHOf2CYTejL4snPt++9k0AupDUy9RgTnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQbNNwJcaDpOt/vb8kI35pwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXdMF7LxvtCDngNLKgI8OMtG29+q
 NsHfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8meBf6iCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yimKWYH+A/IzUYxy0nf/CZr4JbICv3cd+yadOZ2tXfbq
 luTqgwVBTlfbrRz0wGt+XWnje7nhjL+QItUFbui9/csjkf77mgaFxQSUXOpoPyzkEf4WtRFK
 kVS9DBGhbY9/UmhT9Tndw+5pXSet1gdXcBRGqs08mmwJrH85gGEGi4bQzQHZNFOWNIKeAHGH
 2Shx7vBbQGDepXMIZ4w3u78Qe+aUcTUEYMDWcPAZQ4C/sWlv4w5yB7CJjqm/GhZkfWtcQwcA
 RjTxMT9u1nXpdEG3eO38DgrRhqy84PRQFddChr/BwqYA8AQWGJhT5Ol4x7X4J6s6Wpfokap5
 BA5piRV0AzC4VxhWsBArCXh0YxFP8q4DQA=
IronPort-HdrOrdr: A9a23:aB0B7KMwyvXZ3sBcTq6jsMiBIKoaSvp037BN7SBMoH1uE/Bw+P
 rFoB1273PJYVQqNU3I8OroUMK9qBjnm6Kdj7N/AYuf
X-Talos-CUID: 9a23:aBPnYW1Mse90lfgEe8um07xfAYMAVXjT4HXpGF6dGWxsEqebeQK35/Yx
X-Talos-MUID: 9a23:I6q1pAoRuxn3AL/9DggezxBuBO1y04qLMmcEnKUWiuqnHh0zNw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,241,1725314400"; 
   d="scan'208";a="191237855"
X-MGA-submission: =?us-ascii?q?MDERtr/B35ZKv87HFvYHqk6sM0iUYXE73vurgN?=
 =?us-ascii?q?GzqlcX+MsE4Nx1UB3PAEU1AlHBju7si5VMzpthufa0JmP2lS6SLemtar?=
 =?us-ascii?q?AFSryuo6bXK40SCLJVwGYuK6smSp6iRDo4GQh7IPIdE6SXpVoGmBO0Qz?=
 =?us-ascii?q?uEmAPOJR+sp2kq3WctlthZhQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 13:17:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730204267; x=1730809067; i=markus.elfring@web.de;
	bh=+MLvE92gvVkEQAGqtYBjJnkTDOAkTPD8hoSV1y76KCE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YKCwa0pFPscfQtg4JHAITfhlFTpYn+wx/oZhsFmiFdksYQFg72PQKk5g4OFlBmSo
	 Ptht8O6aaX/v8T9A6t5eia+YLNjZ9M+LGVgv0jlzjwB5BO3QRFApgj7YRpi1wrXA3
	 s7aS0VGBdUApqD39ySMbjVBlgQYPAbcMp51Y2sSGb50anWjhzQ+9ETjSUiCvUEN+t
	 w5HUAKkr2JZiawgqgOe+5V/uVbYV864nghLHJO8qbMCu+LAkTY41ee935k/tJVJVa
	 +5N2LKC7E6zsMz2PkJP85Ce690Io3GbVs27TYRJBVs/H73967kLG13FRbw97S4/dQ
	 gXfM0Xp1DuX7HmZxHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79RI-1tvHS322vs-00rNWc; Tue, 29
 Oct 2024 13:17:47 +0100
Message-ID: <eeec899e-0510-4005-bd00-b65fbcba33a4@web.de>
Date: Tue, 29 Oct 2024 13:17:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: "Derek M. Jones" <derek@knosof.co.uk>,
 Victor Gambier <victor.gambier@inria.fr>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
 <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
 <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
 <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
 <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de>
 <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UyabiOk950CejWYofnT6c4CXE1/s0LNGQrAcKpX+gm3fvGG2nKS
 38zRwSfrGAPnVQJ/Gd1UGBWjj8qpTG9+xfT9nZZOPQHSu2gO0fJxhOX0Mv7hXSHYKUt+yz3
 zuvEoZ+rgm4M9DZkn2TUtM3hBE1AIi/5TaySfRksdb5B0djdup0+sG9RQmUtJf9XcyOah0S
 kZTpIEPEa66oqTIh2Lc8A==
UI-OutboundReport: notjunk:1;M01:P0:PvBIgqZWvso=;1pymovxxjnJEtx1hfdfYX5us2kg
 q3vEhQbFMA+fYVmv6AibSTD0ApFl7eSUY6iN+hJspFgbt6vy/wPAld/+cNQlBrFmg3qp+GbuJ
 MaJNoIfJHf7xUhDpkvKmnSYjUxxgkyYSg8Z/j157GZaawSfaLH1w45i1vkHUcTE6iYsz3Im6l
 LqjxW/2+SSkaXpbOr2Qgdb2L+R/uSh7JSYQ00xR3iqCbz7F/m8YC3IgLulkkNp4Jkzxqm1gw2
 d8XHC33ROsLpkTEX5z6SLiBxUisA5qAzyMoXSdmPMEnGdzYbCxErJDPHOh3f76f/8kkTGceod
 LqWpYeveMnyUUv/sJ39c+KSSNb68nKMFjKLbSRhSkdjUzPi0TEqpFP8xyT+BPAcuY2PcMMkHP
 jrMeM0R4SP3HmW7Mqp3E8B4DmLG4ojPeM59t4cmLtV6mJwRiO0oVefh37qMNWH4gAjqvNMvzC
 fNSTKa3CofQegPKncr+QkgLfHkdBbAleANus7KYKYOuxZqiiYo2wUopuQ37JLpizNKwNrXVLM
 S3DGCA1Gjfhw6ucXLrrGcDL4A5V+sdxjh+RkKojNSrUH0ZkHfG9kHM1wSac4elB5EffnAerOP
 VVLK+5E3akU3vxNXrv9nL3gk25I4/YnCeNHtuHHJQjy/I64cFd9I8Vn784MoDSLDaIkZqsNQo
 ML+Y2qLey0r74L04btYBoyO5TyxqcFkApjFRmNv1adRHGWBZCNx/hMKgOJQqponRukT9uhgtA
 aYmF9iMp3J8WW7qzPAifS1RBkQ5pVSDC+oreAemvY+JPrOYqWmat84Dvr3JIHpBBoCNUHhLqa
 aqVwdA4RCfaQ6muLoeEOGl3w==
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1958
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/eeec899e-0510-4005-bd00-b65fbcba33a4%40web.de>

> OK, that was much more understandable. =E2=80=A6

I would like to add another development idea.


@initialize:python@
@@
import sys

records =3D {}

def store_data(places):
    """Add source code positions to an internal table."""
    for place in places:
       key =3D place.file, place.line, int(place.column) + 1

       if key in records:
          value =3D records[key]
          actions =3D value[0]
          actions.append(place.current_element)
          records[key] =3D actions, value[1]
       else:
          records[key] =3D [place.current_element], str(int(place.current_=
element_line_end) - int(place.line) - 1)


@searching@
identifier f;
position p;
@@
 f(...)
 {@p
 ...
 }

@script:python collection@
place << searching.p;
@@
store_data(place)

@finalize:python@
@@
if len(records) > 0:
   delimiter =3D "|"
   sys.stdout.write(delimiter.join(['action',
                                    '"block size"',
                                    '"source file"',
                                    '"block start line"',
                                    '"block start column"'
                                    ]))
   sys.stdout.write("\n")

   for key, value in records.items():
      sys.stdout.write(delimiter.join([str(value[0]),
                                       str(value[1]),
                                       key[0],
                                       key[1],
                                       str(key[2])
                                      ]))
      sys.stdout.write("\n")
else:
   sys.stderr.write("No result for this analysis!\n")


Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch -=
-python /usr/bin/python3 =E2=80=A6/Projekte/Coccinelle/janitor/list_curly_=
bracket_positions_for_function_implementations7.cocci arch/sh/drivers/pci/=
common.c
=E2=80=A6
action|"block size"|"source file"|"block start line"|"block start column"
['early_read_config_byte', 'early_read_config_dword', 'early_read_config_w=
ord', 'early_write_config_byte', 'early_write_config_dword', 'early_write_=
config_word']|3|arch/sh/drivers/pci/common.c|36|1
['fake_pci_dev']|17|arch/sh/drivers/pci/common.c|13|1
=E2=80=A6
real    0m0,164s
user    0m0,133s
sys     0m0,028s


Would you be looking for more powerful computation resources if you would =
dare
to repeat the shown source code analysis approach with parallel data proce=
ssing
on all Linux source files occasionally?

Would you become curious to take another look at the software run time cha=
racteristics
according to the biggest function implementations (which can be found also
by the means of the semantic patch language)?

Regards,
Markus
