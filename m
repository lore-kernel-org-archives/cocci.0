Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3C2CF9C68
	for <cocci@archiver.kernel.org>; Sun, 22 Sep 2024 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mliSrRoyrTiLo9XBzHpJS45Wx/xmY/6czICjQ8Hmdxc=;
  b=uZvpyTwfge+YqDiombs9Cwza/MfEC7z28JxluMXV8FGYKQKkLZ7vqMGL
   DTRXCL+alKTdZxkSIXpt0nxzyD8VMSBPpUpyvx67sLRtAFLMj1ptc19gF
   aX/C4t2DGTPWlar6uo3y9sIz0bwQ68PihEUN09v/SzzX9PLE73f44ciQs
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184403098"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2024 10:42:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A6A6AE0141; Sun, 22 Sep 2024 10:42:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F0883E00B7
	for <cocci@sympa.inria.fr>; Sun, 22 Sep 2024 10:42:32 +0200 (CEST)
IronPort-SDR: 66efd878_GmoCGtd7qCHoLw0Eq2E5dusgBhfwbBRb4JB9tRqvPu/Igvx
 ri3fTG9u+ZeKbvLGKFM/g3/NdXMx8EjLkGxZVFA==
X-IPAS-Result: =?us-ascii?q?A0HSCgCS1+9mh07ASNlaHgEBCxIMQIFEC4JEfVozBAtIC?=
 =?us-ascii?q?CWEKY9NgXUwhDuPDopMgUA+DwEDAQ07BgECBAEBAwEDgUlDgnQCd4kMAh4HA?=
 =?us-ascii?q?QQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBAToHDjuFd?=
 =?us-ascii?q?Q2CXBh5G3QwAgEBAQEBAQEBAQEBAQEBAQEBARcCDTpEAQEBAgEjHQEBEScEC?=
 =?us-ascii?q?wsaAiYCAlYbAQGCfQGCLwEDDiMHDQa0Y4EygQGCDAEBBoJn13MfLCJXgWMDB?=
 =?us-ascii?q?oEaLohLAYpdJw+BVUSBPIJLOD6CYQSBXk2DDoJph2+KHoIQiV4liGJwkGZSe?=
 =?us-ascii?q?xwDWSETAVUTFwsJBYk4CoMcgW4mhBUIgSsTg1+BZwlhiEmBDYE+gVkBgzlKg?=
 =?us-ascii?q?1CBeQU4SYJRa048Ag0CN4IqgQ6CWoEvBAWDah1AAgELbT01CQsbBj2rX4FbS?=
 =?us-ascii?q?INBEyyVVbJZNAeCN4FjgWMMiieVKwYTL5c+DgaSc5h2jXubIoFnOoFcMxokg?=
 =?us-ascii?q?zZPAxkPjiEZg2EzxmRBNQIBOAIHAQoBAQMJhUYBAYY+gUsBAQ?=
IronPort-PHdr: A9a23:dThw6xXvMVATIBkXpG5oh/AOgvPV8KxtXjF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBt2dsqMbwLKI+4nbGkU+or+580o+OKRWUBEEjchE1ycBO+WiTXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwbL1uI
 BmssAncsssbjYR+Jqsw1xDEvmZGd+NKyGxnIl6egwzy6sCs8pB97i9eoegh98lOUaX7e6Q3U
 7lVByk4Pm42+cPmqwDNQROA6XUAXGoWlAFIAxXe4xHhQpjxqCr6ufFj1yScIMb7UKo7WTWm7
 6dsVR/olCIKPCM3/W3LlsB9ir9QrRS8rBJ93oHUepmYOvlwcKzSc9wUWGpPUNhfVyNDHoyyY
 JACD/YYPetCs4Xxu0UCoBm4CAKxBO3v0DhIhnru0KM9yeshCwLG3BE7H9kTv3rUqNv1NL0TU
 eCzw6nD0DLOYfRM1jfn64jIbwshreuDU7J0f8rR00gvFwXKjliLp43qISia2v4QvGeF9udtU
 /+khGE7pQ9ruDev2tsshZfThoIT0l3I6yZ0zYg6K9CkSEB2b9qpHZRUuiyEKoZ6XMwvTmF2t
 Ss0xLAKp522cDUUxJg52hLSb/KJfoyV7h/+VOicICp1iXR4c7yxgBay9FKvyuz6VsSsy1lKq
 S1FksXItnAM0Rzf8NSISvx4/kqnxD2B1BjT5/laLUwpl6fXMZwszqAqmpYOtUnPADX6lUf1g
 aOOckgp9fKk5ur6brn8pZKRNpV4hwX+P6koh8eyH+A4MhUVX2iH5+u8zqDt/Uz4QbpUlvA6j
 q/Uu43AK8sBvK62GQpV354j6xmhCzem18wVnXwALFJYZBKLlYboNE/VL/ziEPiwnUygkDZtx
 //YIr3sGovBImXBnbv7f7tx9VRQxBc3wNxB/Z5ZCLIMLOr2WkDrtdzYChE5Mxazw+biENhz0
 ZkRWXiMAq+EK6Peq1CG5uYhI+mWZY8Vvjn9JuMr5vHwlnA1g0IScrex0ZsRc3+3Bu5mLFmBY
 XrwntcBFn8HshcmQOzwlFKCSSJTZ2q1X68k+j47D56pApvCRo22m7yA3CK7HoVMaWxcC1CMF
 23od4SeVPsWZiKSOJwprjtRXr+qQI4J1Be0tQa8xaA0APDT/3g9vIjgycM9yundjxA0+nQgK
 s2H0HyWCUxwkHkJQTAew61150BwnATQmZNkiuBVQIQAr8hCVR03YMa0J41SDtnzXlmEZdKVU
 BO9Rc3gBzgtT9U3yttIYkBnGtzkgAqQlzGyDeozkLqGTIcx7rqax2L4cuN00XXbz+8Mi1c8Q
 81AHXKrjOhz+lubHJbHxn2QjL3ibqEAxGjI/WaHw3CJuRR9WRRzTL6DcHQRfErQovzm60mEQ
 7L9Qa8/PF5nzsiPYrBPdsWvjVhCQ6L7P8/CZmuqh2qqLROP26/Kc4fgPWkQtMnEIG4DlQ1bv
 XOPNAxlQzykv3qbFzt2U1Tmf0Lr9+B67nK9VE49iQ+QPQVn0PKu9xgZiOb5Kbtb168YuCont
 zR/HUqsl9PQBd2aogN9faJaKdoj6VZD3GjdukRzJJulZ6xlg1cfdUxwsSaMn11SA59DjNNsg
 Xck1gt0JoqH3VkHez7ZlZH8N7vLK3XjqQi1Yv2e0VXf3dCKv6YXva5h9BO85kfwRxBkrCU0t
 rsdm2GR7ZjLEgcIBJf4U0JssgN/u6mfeS4loYXdyXxrN6Cw9D7EwdMgQuU/mXPCN59SNr2JE
 AjqHogUHc+rfaYPkkKqcwlCEeRc7q8yMOu5evHA1KPhb4MC1Hq2yH9K5oxwyBfG0iNmSfPTm
 bsBzeuZ2ASvSDr2ylus+JOS+8gMdXQZGWyxzjLhDYhaa/hpfIoFPmypJtW+2tR0g5OFt2dwz
 Fe4HBtG3caofUHXdFnhxUhL0lxRp3W7mCy+xjgykjczr6PZ0jaci+jlcRMGPCZMSgwAxR/JK
 JK3kstccUymdQkvmzO66Ey8y6UTqKlkLmbVSFtFZGCsdj4kDfH27+vYJZEfoJoz+T1aSuG9f
 UyXRtuf61MB3iXvEnEfjDE3eje2u4noyhlziWaTNnF2/zLSfcB9wwua5cSJH6cOmGVcAnAp0
 3+IVgvZXZHh59ifmpbdv/rrUmugUsYWaiz31cabszP942R2ABq5lvT1m9v9EAF83zWosrsiH
 SjOshv4ZZHmkqqgNucyNGxhHlzh8IxXHo9kk40/rI4d0z4Wi9/GmBhP2Xe2Kthd1a/kOTAoT
 CQI3sWTzQzrwkxlIVqWyoi/WnjXka4DL5GqJ2gR3Cw69cVDDqyZuadFkSVCqV29tQvNYPJ5k
 2RV2b405XUdme1MpBs1w3DXHOUJBUcBd3+J9VzA/5Wkoa5QfmrqbbWgyB80g4W6FL/b6ggOX
 XHkZtE9ECU24sg3OQDJ12Dvr5Hqf8PPZMgf8AKZmVHMgo03YNo4xP8NmDYiM2Xgu3YojfE2h
 1pi0Nmz7o2ANnko97mzHxpbcGT8Yc9KvDrqiMM81o6fjYWoA4kkES4AW4HwC6uhFj5L8//gM
 k6YGTk44B93AJL5GgmSoAdjpnPLSNWwMm2PYWIe1ZNkTQWcI0pWhEYVWi87l9g3DFLiwsupa
 0p/6j0Lgzyw4hJR1uJlMQX+WWbDtU+pbDkzUp2WMBtR6ElL+U7UNcWU6u87ETtf+9WtqwmEK
 2rTYAotbylBQkufG1XqJaWj//HF9PWEQPWzJb3CbPTGqOBTUeuJ2YP60oZi+GXpVI3HNX1jA
 vsnn0tbCCogRIKGwXNWGnZRyHKeCqzT7A2x8SB2sM2lpfHiWQa0oJCKF6MXKtJ3vRa/naaEM
 eeUwid/MzdRkJ0WlhqqgPAS2kAfjyZ2enyjC7MF4GToRbjTh7QRIhoVcSJ1O+NX4qh60gQHa
 qu5wpvlk6V1iPI4EQIPTVv6hsSgftAHOUm4M07bQlmGPvKKKHeYpqO/KbP5QrpWguJOshS2s
 jvOCE7vMAOIkDzxXgyuO+VB5Ml0FANTssexf0Q0YYAGZM3rYFu3PY0v5dXX6bgzm2+MKmMWd
 zRxIRslkw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vTTNsKCKuti3A8flHely55DYdb4zR+YMi2TDpHoBLSC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBDhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:QI0Is2P4RHblFe5DXA1e9xYVJcQeYFqE7ivifVDlBTlPV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AmrDjBA6LRtrA9wcYGjT29pcKxox08qHzU0cBwK8?=
 =?us-ascii?q?75cmWaCFVChS2gwm4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="97027231"
X-MGA-submission: =?us-ascii?q?MDHs7mJ1KMME56fUANF/Uur/DHQ9tPFueVb1Ie?=
 =?us-ascii?q?QIgLwoxVALuIu7aoGVLR/WA6odV+YsyX9vBUNS1kOm4O2z81INGF0GUN?=
 =?us-ascii?q?2PijDHhsnSPc/m3uIxcmts/70YM4aaifx42W69cC1OKTp52C1Y7c0DGC?=
 =?us-ascii?q?tXDEX+Rh5NLTS+VqzQJngyUA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 10:42:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726994551; x=1727599351; i=markus.elfring@web.de;
	bh=mliSrRoyrTiLo9XBzHpJS45Wx/xmY/6czICjQ8Hmdxc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nimbxOUgfA9nJuSxpBpW+KHNBHaossCnrSr/gddjcFZXSNxeLlma14qp8NYeoZE8
	 k5T2dwMQGkn7y8Y436zGd5Sj4YXHFlsdJP7ETOJhsgu3vMnASjbdFwJF1Mn01femn
	 wR+V2aMpHGJuXp9l0cFss+kzcRoU1LLSj2JELQEwcAR56B5YPcuUGiC98I9HQ9/X+
	 Dgt1uRQzMvz6dBJYGsbHmXEtKofnu9Cx7mPZd1U0z/zvHIG6WU6X6O54artcvekyD
	 MMhl5D+uj0guaUmOoMJ21cpbQHKLTvGb4xzCPLNX7DG6EP2ohx2dvUq5euo+6WtKO
	 UmeG5C2sPJlWOVRQyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MECCd-1si9oo1NzB-004d7c for
 <cocci@inria.fr>; Sun, 22 Sep 2024 10:42:31 +0200
Message-ID: <9b9c7d4d-bb7d-4f58-98d9-ee0504e7f2bb@web.de>
Date: Sun, 22 Sep 2024 10:42:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de>
Content-Language: en-GB
In-Reply-To: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wZ6SZ4jE9FPygcT/OekbpZcSe/bjssCWx17VRVhGsfobqyT/9II
 lRroy/DLYOGzFerZXCbAAMhqc+SIuxUMWhjh1MAQyeXYl15F2MG2y1sAb6YUh+31QdbsHFx
 EGFEQLsAQKBl3u0YR7fTVT5Fn5FtkfN7gktFkvQ4r+tJcOZf35kpe+ODLf4W/p8Q6s4+zQ7
 R5uAfQe9WPrH9QFcCtdCA==
UI-OutboundReport: notjunk:1;M01:P0:tGNxZFD64q8=;gFa+JdChncZpf4RZg4v8ns7duPV
 +q3HqyEiCOl3rMFQ0wtIluZzsSO3lGc/QLKr3CyU5aq0EIsdvg83BGHOIdYQbH+0jhjAvAysU
 08WuykedMRNQXCdAkLbZRnNe1b6yyBpgIlcxA997tO+1ZFVYDksJLeEEzKX353zPQqyE+g7vc
 QD3UcTv38B2dPvdS3Ppu123/v7q2e6f38FCO9Z6wQZOxblYujhEMWJMmx7I6lTFu0bNKPF6Qv
 5MTJNBEwjFXWHHH/xeCk/diUPqt+k1/xjy5/een4fEFUyF5CxwdPaOA9MOeL2gB970irwJhrb
 lZSCWbI473ZfOinNkp1kdut412KxWtQiOJf2Xfj7xwYLpqWmsNOZ16PYN32NTgSHDjNEwI503
 NbPJMDGN1vwLAAB1OZQtlhsDA2ENYX7gTIsrds5hbWWWaZIirfilIGPqxSEF9X05DGDFAjmOd
 4xzqG3LkdW7DI5OsOL6OC2pQ762iv9oi4KDmoj29xq835W8t8E/bX7hIifYHKIcr1sp1etX07
 lsp+t12NI9JrbTYWk7RQmdadjL7H+nsVT9MgGrPhLx1mCMc18ZF8HVRxA9Mz18ptanH4/ZBYj
 RWZVWUDczULZIg26jU389DJRZl9jzfA1ChCO3rdcPgX5cq8kevrGlp4WkmlE6qV0AKclOLPxY
 NRJGl+/HXl9QMJvzLwKIRV4p4b91c21v5pdc6cNe9t22rbryI2IF9XuWhTD59Vv//DtBrTJ6z
 yB/QbMVMJEiNrIggL7ZSydWSoN6Jx2ViqP5C6Rn9hD5FJVz/XT8SolxJJpMqySk4ijS8YFRX7
 JLnq69WI3PCWqpiFHDZtW8ZA==
Subject: Re: [cocci] Swapping branches of SmPL disjunctions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1875
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/9b9c7d4d-bb7d-4f58-98d9-ee0504e7f2bb%40web.de>

> How can involved software components be improved?

I extended my source code transformation approach in the meantime.
Another small script variant for the semantic patch language can be handle=
d
by the software combination =E2=80=9CCoccinelle 1.2-00038-g2297fc0f=E2=80=
=9D (in principle).
My SmPL code variation fiddles also with disjunctions.
I tried then out to swap two branches of such a detailed SmPL disjunction.


// See also:
// ath6kl_usb_submit_ctrl_out()
// https://elixir.bootlin.com/linux/v6.11/source/drivers/net/wireless/ath/=
ath6kl/usb.c#L872
@adjustment3@
constant c;
expression a, b;
idexpression rc;
identifier rc2, x;
fresh identifier target =3D "free_" ## x;
@@
(int rc2;
 <+...
 if (...)
 {
 ... when !=3D \( x =3D a \| b(..., &x, ...) \)
-   kfree(x);
-   return
+   rc2 =3D
           -c;
+   goto target;
 }
 ...+>
+rc2 =3D 0;
+target:
 kfree(x);
 return
-       0
+       rc2
 ;
|<+...
 if (...)
 {
 ... when !=3D \( \( x \| rc \) =3D a \| b(..., & \( x \| rc \), ...) \)
-   kfree(x);
-   return rc
+   goto target
    ;
 }
 ...+>
+rc =3D 0;
+target:
 kfree(x);
 return
-       0
+       rc
 ;
)


Questionable test result:
Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/janitor=
> spatch --parse-cocci use_common_kfree_code4.cocci
=E2=80=A6
minus: parse error:
  File "use_common_kfree_code4.cocci", line 30, column 1, charpos =3D 474
  around =3D '<+...',
  whole content =3D |<+...


Under which circumstances will this version become better supported?

Regards,
Markus
