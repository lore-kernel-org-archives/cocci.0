Return-Path: <SRS0=prLC=PX=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71917C433EF
	for <cocci@archiver.kernel.org>; Thu,  4 Nov 2021 07:38:29 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CCD611C3
	for <cocci@archiver.kernel.org>; Thu,  4 Nov 2021 07:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0CCD611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3At4sXnaxV7+phi3tF3nZ6t+cmxyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDxwgTwBnWceXGuGafqJZ2L0fNhzaI/l9B5TsJfdmtZqHQtv/xmBbVoa8?=
 =?us-ascii?q?JufXYzxwmTYZn7JcJWbFCqL1yivAzX5BJhcokT0+1H9bdANkVEmjfvRH+OkVLa?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAfNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?Niaf+akRMQ7jIPAHIhGA+t6qK20IS4H1plP9lbrxFNx8/ZzahxridzP1Gspe7S?=
 =?us-ascii?q?EIuIavBgswcVQNZGmdwJ8Wq/ZeecCHi4J3Mp6HBWz62qxl0N2k9OoYT+85+G2p?=
 =?us-ascii?q?O9OIVMnYOYwqFiubwx6i0IsFmh984PcflFIwas3BkizreCJ4OSpfORajMzdBd1?=
 =?us-ascii?q?TY0wMtJGJ72a8MfLzgpcxXEZxxGP0w/B5c3nePujX76GxVUoUyUqbEw5WTdwwh?=
 =?us-ascii?q?Z373kMd6TcduPLe1ZkwCDoX/U9iLyBQsXMsCezxKK93utgqnEmiaTcIkJCbm85?=
 =?us-ascii?q?9Zlh1qcwmFVAxoTPXOxrP+0hk+9R/pfJk0S92w0qqMx7ySDRd36WAaQon6Puhk?=
 =?us-ascii?q?bQJxbFOhSwA2EzKvZ50CdC3oPRzhGQNgnssYsQnotzFDht9jpHz10rLqNSTSX8?=
 =?us-ascii?q?bqUqCy7PSQYN0cGZCkOTBdD6N7myLzfJDqnos1LCLSygpjxGCrsziuX9Xh4hrM?=
 =?us-ascii?q?JjMdN2b/TwLwOuBr0zrChc+L/zl6/srqZ0z5E?=
X-IronPort-AV: E=Sophos;i="5.87,208,1631570400"; 
   d="scan'208";a="1915997"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Nov 2021 08:38:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 238DDE0295; Thu,  4 Nov 2021 08:38:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D5F81E004C
	for <cocci@sympa.inria.fr>; Thu,  4 Nov 2021 08:38:22 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AeuFfrRXs98B1iD2BTzM/FSlkdOzV8KyWUjF92vM?=
 =?us-ascii?q?cY1JmTK2v8tzYMVDF4r011RmVB92duqsP1rWempujcFRI2YyGvnEGfc4EfD4+o?=
 =?us-ascii?q?uJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgp?=
 =?us-ascii?q?pPOT1HZPZg9iq2+yo9JDffRlEiCC5bL9vIxm7rQfcvdQKjIV/Lao81gHHqWZSd?=
 =?us-ascii?q?eRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9LmA6/9brugX?=
 =?us-ascii?q?ZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD+/9KpgVgPmh?=
 =?us-ascii?q?zkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe84RS2hcUcZLTyFPAY2?=
 =?us-ascii?q?yYIQBAOQcI+hYoYnzqFkSohWxHgSsGPrvxyVUinPq06A30eIsGhzG0gw6GNIOt?=
 =?us-ascii?q?WzZotLvO6cIUuC10bLIxijMYfNS1zf98onIchYuofqRWr9+dtDeyVMsFwPYlVW?=
 =?us-ascii?q?cs4PrPzeb1uQXsmib6eVgWPmhimE5sA59uCWgydk1h4TPm4kaxUzK+z9jz4YpO?=
 =?us-ascii?q?d23VlR7Ydi8HZZfqiyXOIh7T8E/T2x2tyg31L0LtIC1cSQUxpkqxgLTZv+JfoS?=
 =?us-ascii?q?V/h7uSumfLDdliH9her+ymxa8/VWgx+DyWMS51ktBoCldktTUqHwBygLf5tKZR?=
 =?us-ascii?q?vdj/EqtwyuD2gLJ5u1ZPEw4jajWJp07zrM/kpcfq1nPEjP5lUnsj6KaakMp8fW?=
 =?us-ascii?q?y5ev9eLXpvJqcOpd0ig7gNqQundSyAeE/MggTQ2iX4+q926P48kHjXbpFkOU6k?=
 =?us-ascii?q?qjfsJ/EOcQWvrC1DxJL3oo59RqzETWr3M4FkXQFNl5JZQ+Lg5DsO17UIfD4Cfm?=
 =?us-ascii?q?/g06rkDdu3/3IOafuAo/OLnjei7ftZ7lz60pSyAopzNBf4Z1UB6oPIf3tQUD9r?=
 =?us-ascii?q?sHXAQEhPwyu3+nnEMl91p8ZWW+XDa+ZNb7SsVuM5u0xOemBf44UuDf4K/c+/f7?=
 =?us-ascii?q?hl2U1mV4bfamz3JsYcmq0Hvp8I0+Be3rjns8BEXsWvgo5VOHllFqCXiJPaHazR?=
 =?us-ascii?q?K88/TE6CIe+DYjZXIytgbqB3D26HpJMfGxGBEqMG2/yd4qYQ/cMdD6SIsh5nzw?=
 =?us-ascii?q?AT7egRZUu1RWqtALhyrtnL+/U9TYCtZ35ztR15uvTlQsz9TNuFcid3XuNHClIm?=
 =?us-ascii?q?TYqWjs31ehbqFN0zlPLhaplh/1RU9ha+PpNVi87M4Tdxqp0EYahdBjGe4KsQUy?=
 =?us-ascii?q?lX87uLDU/VNM3zJdaRk9nGMi5yD3H0TCrBbA9iLGBQpA5pPGPl0PtLtpwni6Vn?=
 =?us-ascii?q?JIqiEMrF44WbTXObkFX6AXZQYLEwRzxf0eCcKMBwGjS+W3FwWfc5CmwtSZvXK+?=
 =?us-ascii?q?DUX1NPiPr?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A6lP7/aPD5wtg48BcTuWjsMiBIKoaSvp037Dk?=
 =?us-ascii?q?7TEXdfUnSL36qynIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhbX5eI3SOjUO21?=
 =?us-ascii?q?HHEGgB1+ffKlTbckWSygce79YET0EUMr3N5DZB/KTHCUWDcurJ27O8gduVbArl?=
 =?us-ascii?q?vg1QpTgBUdAc0+/zZzzwLnFL?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DuAQASaxphhwsR49RaHgEBCxIMQINVg?=
 =?us-ascii?q?RFsOjGER49JgXcwhBiGVoZwih6BaAsBAwENPgECBAEBhGECgmsCHQcBBDQTAQI?=
 =?us-ascii?q?EFQEBBQEBAQIBAwMEARMBAQEMDQ4IOiSFaA2CNSkBg2QBAgIBIxUIAQERJgEEC?=
 =?us-ascii?q?wsaAhEVAgJXBg0IAQGCbYJVAQMOJad3gTGBAYIHAQEGhGsfLCJQgVoJgRAqjXM?=
 =?us-ascii?q?nEIFVRIE8gX1RMD6DfUc/gliCZIMlggKBHL8LLQeCAIErgTcLnHsGFCaVSQ4Gk?=
 =?us-ascii?q?Ri7VoF3gX0zGiSDOFAZDo4gGYENAQmCdYosQDI4AgYBCgEBAwlsAQGJBwEB?=
X-IPAS-Result: =?us-ascii?q?A0DuAQASaxphhwsR49RaHgEBCxIMQINVgRFsOjGER49JgXc?=
 =?us-ascii?q?whBiGVoZwih6BaAsBAwENPgECBAEBhGECgmsCHQcBBDQTAQIEFQEBBQEBAQIBA?=
 =?us-ascii?q?wMEARMBAQEMDQ4IOiSFaA2CNSkBg2QBAgIBIxUIAQERJgEECwsaAhEVAgJXBg0?=
 =?us-ascii?q?IAQGCbYJVAQMOJad3gTGBAYIHAQEGhGsfLCJQgVoJgRAqjXMnEIFVRIE8gX1RM?=
 =?us-ascii?q?D6DfUc/gliCZIMlggKBHL8LLQeCAIErgTcLnHsGFCaVSQ4GkRi7VoF3gX0zGiS?=
 =?us-ascii?q?DOFAZDo4gGYENAQmCdYosQDI4AgYBCgEBAwlsAQGJBwEB?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398196509"
X-MGA-submission: =?us-ascii?q?MDEQdRxOM/j9WZHg0J2NDZJtu58QcnxIwfIgy0?=
 =?us-ascii?q?hZjOa2KaATbYculhuCO1tYac3QYSGrSQ8YK50KRSJsoG+d8kbVgtNBUq?=
 =?us-ascii?q?jLiJ+eIp+DEi3fTTWM0UIP3qpX7YzOXa8XVbCHOR/yQWdfoufBP8hK0J?=
 =?us-ascii?q?Ux/xguc+njw/0OGxo8b8Rh/w=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 08:38:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1636011501;
	bh=oeQ1iFniQn+UHyyP2Hv5ZHzk/WfbUQEfig3Js/uBj2k=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=FQvi46g2ELF/QviQfkhh12VM5UTrDjRiY8v00bdjFkCN8xD/gEh4K0dw3xA+1Vhkp
	 aEABnfhTatP9I6azDjeYI/2nFcQrQ6/sPsWTCLdiJcPd8ZmBzG/DJGe8roUS79OlXR
	 K8YFmX5p0j+btlXbTEPGzBfZ4DXOjc4mrnIuFhPE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.104.80]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N947J-1meOGx3L31-015fCX; Thu, 04
 Nov 2021 08:38:20 +0100
Message-ID: <3d21ca13-ada8-4e07-167c-6df6521e8da7@web.de>
Date: Thu, 4 Nov 2021 08:38:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
References: <20211103124001.68e76017@kicinski-fedora-PC1C0HJN>
 <alpine.DEB.2.22.394.2111032134360.3289@hadrien>
 <20211103135714.6bfcd45c@kicinski-fedora-PC1C0HJN>
 <alpine.DEB.2.22.394.2111032200510.3289@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, Jakub Kicinski <kuba@kernel.org>,
 Gilles Muller <Gilles.Muller@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, Michal Marek <michal.lkml@markovi.net>
In-Reply-To: <alpine.DEB.2.22.394.2111032200510.3289@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WbA9mEiXAoQayt2YQss0mbl66NSFQvaletLXMGXN3ptYK6DykVX
 68hd0e+A2E3IgRjrkX+2g33wOdpEMfXk6DnnKo39EOCwNuijCDiax8gcXSnNTMwDYKHOed2
 wRoJogCCYquiMg2EphN+wxTCvwGBf8fOvP45gUEtq3NAwJ9Ryxcv4VEVRkErtPloWIO9XfZ
 LmDCXBpnrDGoWbHStXWbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SW1Mqi/cbYA=:WZ57LjB2C9uBaIPVUSvOUc
 M1sHDICF6SuAYSw75QmApyMHqfqrxlqzKRbF4v+8wUs4v0wCNPc2bK6ZC57A0gdZTYBRFMqZW
 SdWGN1zMSiSZZf8u80yBN/wa5l4T+gkSBcyrd4IzvUaDC2/sf6FEPQ8Wa3m3iApnjQDKQSK3C
 ImK51PljkblI9rojuQ19dQjD4NlEgcqB0gM1DFkb+nFeD0C0hVj06yXbLJE1vwsUKWHClUcLh
 cO1UGHD/QzEvqxUqyyCxB2CHB0HlY9N/CBQCIA6aVakQzzzEcD4eVk8znFfktwOYAnqnlXm1N
 kstTdAepeYg/NJUrVy5AUvbB0QKQBlph+a7lvHXXnQ7QqIywJ3lX1VMwpvvoZfVC/lyg280CT
 1V9r09Kjg+FU24LPNW8XcCImWyhyjpihG/3tkVMNymb1b1ujTG+nm+QIZji2EEpNSsh9U1NmW
 q6TKHgpvXuM3lYuES60ZKa6iCScvnFoJCCpz4Hol439a6z4GXBCrKrq7j05fSqd5q7Vjxv1pP
 rjMC70EvZ2QfH9XwhnzSqKFV50n4EoXNpshJUzs25xrjlzfgha1cSkbLHXFXrQgjHUSjy+mk2
 MvRVT2NKynPEiZ8gjDmgGmo9lYGZX3vPdlk22Ly39ErfvMc51KC1UEPDSGeB/foO05MiC0EMG
 kucu4Uv1zAO+X2lwUDMFJxv6QFWUcJr6mLV/GD+48lpnoJi0dT47cTFJlN6mUq9vEZxgjBTc4
 Y3X886iyZRPtS6/4qwEywYqskWEkwlzKRrIwTMRYgjIK0NUV4HdrTYav/zaSNzgtEQsz1wNlF
 ttbIwbCzpYUAbeY0zW70AxUFxQ2aTBdOodjPVzJagCNvFNaLvZ9KXyUQIYaIx275n+6/71yyB
 6BR4Xjos2d1nhCFmeXiM1On4WrFqYVkpT8HNZMroC2KHRIl5+9byOEHo3oYsHpZ3vCKrxEais
 qe246UjlefyOefdquvg0jkP8uKcGDd2Yf7cKKNQxj80I7iGFd6H0A6E5TU5gqKRNziMH3gE0/
 ecU47p0QJP/rLQuo76LcjWJtP4fGoJjjZI4KxQ5Hgre1oBdADNDZvcOu9SUaGpQOvCoR1UkTS
 a6sHIL0j5CuORo=
Subject: Re: [cocci] Best way to run coccinelle in a CI?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 67
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/3d21ca13-ada8-4e07-167c-6df6521e8da7%40web.de>

>> =E2=80=A6                               Would it have any impact on the
>> performance as well? I see running coccicheck M=3Dnet/core/ takes
>> 2 minutes now, for a 15 patch series that adds up quickly.
>
> I think it should be helpful.  If most files are completely ignored,
> the performance should improve.

The selection of affected files has got a significant influence for desira=
ble
data processing.


> On the other hand, I don't known if it would be practical to treat difer=
ent patches
> in parallel.

I hope that additional computation technologies and resources will improve
the situation in some ways.


> So the speedup might not be that great.

I guess that further options can be taken better into account.


> It depends on how many files are actually being parsed,

The analysed files vary in the sizes and code mixtures as usual.

Regards,
Markus
