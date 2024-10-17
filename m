Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54075D37499
	for <cocci@archiver.kernel.org>; Thu, 17 Oct 2024 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ohLN2rzLow/dlnQK18fQ//cPbgZP0qMUAzH7rU5Dd6M=;
  b=TcxhH+xJhpG8egG5sSYSRfB66t5chfI8CWFocd6gglnhnA1U+D9JqU3J
   /+H+OUQHeWJJHNIOdFzsezQjKwg23Slbrgn2gf56aRWmakLSBYQEainjS
   lp8qRnlX0EnVEuCucRA0wBZmUnu6xUMmiHBIuQEkgMpmCONonPj6cQS1Z
   A=;
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
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="189444661"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Oct 2024 17:36:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 38666E0CD0; Thu, 17 Oct 2024 17:36:52 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0600EE004E
	for <cocci@sympa.inria.fr>; Thu, 17 Oct 2024 17:36:50 +0200 (CEST)
IronPort-SDR: 67112f11_qmV+CqG7CqiJX3siBtnYAW8zZtdeuMz25Nh+i283hZvaPQ6
 Esz72KdpBCQ7L2YTYysvFrUxauPDa8AJ7RMvDyw==
X-IPAS-Result: =?us-ascii?q?A0HXFAAVLhFn/w4P49RagQmBTwKCQgdbdRMgBAtIhFaPT?=
 =?us-ascii?q?YF0LYQ+hzqHVIh1gVaBQD4PAQMBDUEBAgQBAQMEggyNGQIeBwEEMQgOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAoEKCAuFNRcvDUkBEAGCABiBF?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBAQEBAQEBFwJHbR0BAREnNAImAnMBAYJ9gjABAzEHr?=
 =?us-ascii?q?1SBMoEBggwBAQaCaNdzHywiV4FjCYEaLoVqgkgaAQVthGeFLg+BVUSBPIhRg?=
 =?us-ascii?q?w6CaYdsg22GMIcdg1F8JYhRbpFJgU0cA1khEwFVExcLCQWJNYMmghSEEQiBP?=
 =?us-ascii?q?oNfgWcJYIlOgT6BWYM5SoU5gQaCT2pONwINAjeCJIEAglGBJQQFhEsdQAIBC?=
 =?us-ascii?q?209NQkLGwY9q0uCS4NVCQpDgmCSd49domo0B4I4gWUFgV4MiQOWUgYTL5dAD?=
 =?us-ascii?q?gaSeJh3o0yFVDWBNAE6RoETMxokgzZSCw4PjXgBNBaEC8ZSQTU7AgcBCgEBA?=
 =?us-ascii?q?wkBgVWDcAEBgXqEfIFLAQE?=
IronPort-PHdr: A9a23:qdRZqBVp+tkCmLHK05gKRsMA0SPV8KxZXjF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBt2dsa8dwLqH+4nbGkU+or+580o+OKRWUBEEjchE1ycBO+WiTXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwbL1uI
 BmsswncttQajYRhJ6s11xDEvmZGd+NKyGxnIl6egwzy6sCs8pB97i9eoegh98lOUaX7e6Q3U
 7lVByk4Pm42+cPmqwDNQROA6XUAXGoWlAFIAxXe4xHhQpjxqCr6ufFj1yScIMb7UKo7WTWm7
 6dsVR/olCIKPCM3/W3LlsB9ir9QrRS8rBJ93oHUepmYOvlwcKzSc9wUW2pPUNtNWCJOGY68c
 5IPAvAdMepEsYXwpV0Dpga+Cwm2A+PvzydFiHjs0q0g0OQhDBrG1xEvEdIKvnTUttT1NKEdU
 euoy6TGyi/Mb+lV2Tfg84jEaB8vofWCXbJqcMrRz0YvGhjLj1qOsoPpJS6a2foUvmWd8uFvW
 v6hhXQ9pAFtvjig2N0sio/Ri48J1F3J9Cd0zog7KNC2VEJ2YcOoHpROuiyEKYd4TMcvT3x0t
 Cg117ALup22cTYExpoo2xPRZPOKfoqV7h/+SOucJypzinF9eL+nmRq+7FasxvfiWsWq0ltGt
 DdJn9nWunwQ2BHf8syKR/Rn8kqvxDqDzQPe5vxeLU0wlafWLYMqz6A0lpoOqkTDAjH5mF/rg
 q+Xd0Qr5PCl5/jhb777vJGTLZV0hRv7Mqk2msywH+A4Mg8WUmie/uS8yaHj8Vf3QbpUlfI6i
 LTWv47CKcQaoK62HRNV35495xqiETuqysoUkWcFIV5fZR6Kj5LlN0zBLfzgCPewmVWskDNlx
 /DcOb3hB43AIH/Zn7f7frZ99lVcxBA8w9Bb6ZJUELABIPT8WkLqut3XEAQ2PxapzOn5ENl90
 JgRVnqVAqCFKKPSrUOI5uU3LuWRfIMVoiryK+A55/7yin80gUMSfa610pQLaXC1Be9mIkWcY
 Xr0mNgNC2YKvgwkTOzrklKOSzBTZ2zhF547szo8A4mnJYbFXIGkxrKbjwmhGZgDQ2lcCU2XW
 VrseZ+FXfhEPAebOMx8iXopUba7Soku/Q6jvkn2xuw0faLv5iQEuMe7h5BO7OrJmERqndQVJ
 8GU0mXXCnpxgntNXTg9mqZ2vU16zF6Hl6l+mf1RU9JJtLtSSglvE5nawqRhDszqHBrbd4KsQ
 UylX87gLDU/VNM3zPcRbkw7F9jxxgvb0X+SCqQO36eOGIRy96vd23brIMMo7n/c17Q6yXQiT
 NFOM2KOmaN1sQTeVMbSi0vMsaGseOwH2TLVsmeOyW3bpEZDTAt5SrnIR1gaYVbK68v07AXOQ
 tdCEJwBNQ1MgY6HI6pOMJjyiEleAe3kM5LYan6wnGG5AVCJwKmNZczkYTdV2iKVE0UCnw0Jm
 BTOfQEjGiespX7fBz1yBBruZU3r6+x3tHK8SAc90QiLa0Rr07f99AQSgLSQTPYa37RMvylEy
 X08OV+n3M/NTfeEqRBgeqp0ft43pltKlCrYuwF7Ip28PvV6nFdNOw9zvk7oy1B2EtAayJJs9
 il1ilMvb/vEgzYjP3uC0Jv9O6PaMDz39RGrMevN303GlcyR8eEJ4eg5rFPquEeoEFAj+jNpy
 YowsTPU65PUAQ4VSZ+0XFww8k0wgrjAYTQmoa7Q22dtN6acrTLInd4kTrhAqF7ob5JEPaWIG
 RWnWegTHcuzM6oHn1azbxQLFP9f/ug4Mon1EpnOkL7uN+FmkjW8iG1B640oyUOA+R13TevQ1
 ooEyfWVtueefw/1l0zp8sX+mIQeICoXAnL60y/vQohYeqx1e48PT2aoOcy+gNtk1dbhXHtR9
 VjrAF1juofhXBOIbEHmmyBU214Wp3OPhiayiTB52z0ktauQ2iXSzv+qLkNdfDQRGy870BG1f
 cC9lJgCUVKtbhQ1mRfAhw6y3KVdqKllbiHSTUpOYynqPjRnW6q0uKCFZp0H45cpvCNLFeWkN
 ArDEPin+URcin6lRjcNoVJzPyunsZj4gRFg3WeULXIp6WHcZdk13xDUotrVWf9W2DMCAih+k
 zjeQFambLzLtZ2ZkYnOtuemWievTJpWJGPOxJmDqTD9yGlkGxy5kNisl9ehHQVwgkqZn5F6E
 D7FqhrxeNyh8q2gMv98OGRsCkX97cVSBYx01Ic9zsJ1uzBSltCe+nwJln32ONNQ1PflbXYDc
 jUMxsbc/Anv3EAwZmLM3Y/yUW+Rh9dwf9TvKH1DwToztooZbcXcpKwBhyZ+pUC06B7cceQo1
 ClI0uMgsTYT0eQOpRZr0SiXRLwfVUAKOCvxi1GY4deks6xNaCCwfLL22Ecb/5jpBeOHpRxAH
 Xz+Z5EpEGlv4885PF+E2S/27Zz4PdLLZ88XtVvNmhHM1q5eL5dU9LJCjHhiPn/h+HY+wOkhl
 Vo31Je25c6MLGAl6qu9BlQw2iTdQcQV93mtiK9fmpzTxIWzBtB7HT5NWpL0TPWuGTZUtPL9N
 g/IHidu4nGcUaHSGwOS8iIE5zrGDoyrOneLJXIY0cQqRR+TI1ZaiRwVWzNyl4AwFwSjzsjsO
 Elj4TVZ6ln9oxpKguVmUnu3Gn/YvxutYywoRYK3KR1L8kdd6k2TPcHfpuN/EidE/4Gw+QyAL
 mvIAmYARWoNW0GCGxXiJuz0vIOGqbLHQLPjaaKSMtDs4aREWvyFxIyiyN5j9jeIbICUO2V6S
 uc80QxFVGx4HMLQn3MOTTYWnmTDdZ3+xl/09ytpo8S46PmuVhjo4N7FLrJIMsh0vT2yj72CM
 eG4mytzbzpVnMBppzeA2P0E0Vgehjs7PSGqCqgFvDXRQbj4n6hKE1gEZik1OMYCvMdelkFdf
 MXcjN3yzLtxiPU4XkxEWVLWkcasfcUWImu5OTsv4W6UOb7AKTCZm6kfgIu5TqBMyvpZvVu8t
 GTDe6cMFiuOnX/lWkL2Wdw=
IronPort-Data: A9a23:7jljtath5y7YRMyekgp+r4cpZOfnVEFfMUV32f8akzHdYApBsoF/q
 tZmKWrVOP3fY2v9Ld50atu29kxV6J+DndBlSVY6qn9mRn8QgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNsspvlDs15K6u4WtB4QRiDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJEo/Ps4g/tcsPU1T+
 eRHLGsrfCzAhtvjldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWp235wm8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe9/PpmvzSPklEquFTrGPf2R4HRacxWolSdi
 D6c02P5OjBKOOXKnFJp9Vrp3IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku5Rs4ZN
 EEevCYjxUQvyHGWohDGd0XQiBa5UtQ0ArK8vsVjgO1R4sI4Ijp1B1ToihZEb8E68tA7T3om2
 zdlWj8v6SNH6NWopbC1r994bg9e/QAKIGVEaSJsoc4t/Yz4uI9q5v7QZo8LLUN25+EZ3Rnvz
 jrMoCVWa3D/SyIU//3TwG0rSA5AanQEosDZK+kXsq+YAttFWbOY
IronPort-HdrOrdr: A9a23:V3RsT60Z1MWOdbGf4EJo/AqjBJAkLtp133Aq2lEZdPUnSL36qy
 nIpoV96faUskd0ZJhEo7u90ca7Lk80maQFg7X5Xo3NYOCFggeVxehZhOOO/9SKIVyaygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3iJxAyd2+8593JzsaDZ2IAj0JczpymSBNLjV7OQ==
X-Talos-CUID: 9a23:ZaN4x2AUY2neWzf6EyJu9w0sHvF+TlHAwG+PJxSeG1oqSYTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A79Qz5g4Cwr0ykhvoGICBSuqXxoxFwJnzU2wEkqk?=
 =?us-ascii?q?UvufYbwB3Ow+83DiOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,211,1725314400"; 
   d="scan'208";a="189444653"
X-MGA-submission: =?us-ascii?q?MDHdG7FPU4fAiLnxJlOKaU7X02CqdZydMmBbZR?=
 =?us-ascii?q?lTbx2eoUGOGCN5llRarjQzYXG9DZ+kZyFKQPN9mYRNJDj1faJwg+fNkv?=
 =?us-ascii?q?JtO10DUic0DiqWNLUnBokebmUt7t+RKsE2R3hgcTU6ZnvvZdn4kWNyxx?=
 =?us-ascii?q?6sB0E0d4YFYyiUIpEpKBBxiw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 17:36:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729179398; x=1729784198; i=markus.elfring@web.de;
	bh=ohLN2rzLow/dlnQK18fQ//cPbgZP0qMUAzH7rU5Dd6M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lUsIeB0q88JY0LFjy20kUPtYnuXdSlzIxl8UtntV8BQXuxqIxz+IZuSsDXBog7NW
	 5Cx/O3td/pODlXj1RVNbK2ILw45JRx435wv23VEA759P7cLeBm1XH6gX3e4zP66Jq
	 4p34Ujfnp20881+qtXMPSHAWGtB6K2NcigxvrWcf1rA2dTb5ftHD24kaPy0w+oWJu
	 ZJAdJc69RYwTFLqfFnLP8XnnUctS/3IMuKQw5ip9bx3nOtS3qvoragdVmbOJcs8lQ
	 aGZheXlijk4NRyPGBekDId6pBjjvlz+D4t8iq1y/kKUQbYfT2WILyNs+Nr3Dr7ku2
	 KV51uiAGTrEebs2Lgw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjPUE-1tmIdY2a4o-00kwmI for
 <cocci@inria.fr>; Thu, 17 Oct 2024 17:36:38 +0200
Message-ID: <9c059950-a17c-49e4-ad4e-ffab2d6c0ea9@web.de>
Date: Thu, 17 Oct 2024 17:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fcQL/JpMyZKVDgfi7N5N9WeATxPchdpLNzRdFsi1PFIPWkq1sPu
 TmPR9IIF52Vka0qQfeaau0eqeRsFlyk9vq7FMQUS45bb/gcdvoWBNYLhe0KknTBn+7ee+oF
 2Aego8LW3rdCZDS434tseVguDe/nYiMh4isk8dtNYbo9mYTWvtS8PrV3p5gTHtfAiAHngez
 Qu95jM/e0TbwipwbkbQCg==
UI-OutboundReport: notjunk:1;M01:P0:FabdB69swwE=;2yXhIB2R13VTMbSkpRJRW9d07qi
 W/RCfJuk/zgliSL57kFu/d4b51DdDpd7sJKld4NcKj7Vc3xKe9GKvE0IM82XOOMmt5d0k/MFf
 GSWeCnbq52h/QivJ9fCQWMJfdCySNKklfuiLtHXxviGrp6I2Qd1iiGlE792EPf/BUBaO4kzWy
 aMkF3oLMv7KAbTtQV2PjmZCQBd/oF3v6p8vQaBVhI25iRWx4iZXqgbUAtt9GxCoIGoa7jn0zx
 13qn7INuW4NR/0iG/AtzXvj8G5TpO91arKlGP1M0BVSXdgzs/LRRXp26hAmdgE1uIoG7QlHKJ
 PQG6LJ6/DfnjOsXnOasMKUhyubyq0XgWJtQd14ElmJfMQ6vwp5CxyM43SeG+HiuMplkzF/Wti
 fdLRuODuoAZLaQ3NJJnSMbX8m7DG6knPuQ37bT3jaOxejrUHwZwyfx6dwS+UNo3fa/HxhDFRC
 2j2Qg8rjScTmpWGtufvBNC24YisO9eVh4vIUn14Ut/bwyrkC14z7zAoW2/9hNg8wvZkWgWMje
 jFK1jQF2nfENcoEPfrP27H/+BBhiYZ0RuVsapj9Zj7kgmIb++pAr2vxXy9Muq4ppHoeY29Mov
 6am4bp9EBjS/tIx35RPq3Eg/rfJVd5Vyt/tC1RvE9Cuszf7aXpM1NtB80WIGpGdGmsANHJu1f
 QT8ypMf7llQLl7Mah5zoAD6I8Zkd27rZV+JMQSwZzf4bA26m9vOKniv6kLS0bjeiSbRwitW/q
 E6Bbcu4TYqrtOhePJtUtuTJcDS8xdzx4Ctg0XZ3hQWRkvvRqc1lLxv4qsDLbYgsAjUkcJ3d8z
 wFGni9oBeEBAYlqnZt38XRiA==
Subject: [cocci] Clarifying a =?UTF-8?Q?=E2=80=9Csyntax_error=E2=80=9D?= in
 SmPL Python code?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1909
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/9c059950-a17c-49e4-ad4e-ffab2d6c0ea9%40web.de>

Hello,

I constructed an SmPL script a while ago. It contains a bit of Python code
for querying a database by the means of the class library =E2=80=9CSQLAlch=
emy=E2=80=9D.
It can still work (as expected) also together with the software combinatio=
n
=E2=80=9CCoccinelle 1.2-00038-g2297fc0f=E2=80=9D.

I adjusted this SmPL script for another source code analysis approach.
Unfortunately, I stumbled on the following information.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch driver=
s/base/auxiliary_sysfs.c =E2=80=A6/Projekte/Coccinelle/janitor/list_free_a=
ttribute_usage_incidence.cocci
=E2=80=A6
SPECIAL NAMES: adding __free as a attribute
  File "<string>", line 19
    name: Mapped[str] =3D mapped_column(String, primary_key=3DTrue)
        ^
SyntaxError: invalid syntax
Error in Python script, line 1, file "=E2=80=A6/Projekte/Coccinelle/janito=
r/list_free_attribute_usage_incidence.cocci": Python failure


I did not modify the mentioned line (because it was working before).
Will any more software testers and developers (besides me) get into the mo=
od
to clarify such a surprising data processing result?

Regards,
Markus
