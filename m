Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A9AC433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DNXimiD9chRXFwx6cr7qThmVvfnqJvpb8DiAYnDkRtE=;
  b=DqQmCtNjog0bQM6S1B/MFtOhlf5DgxYzJ/y9bzWSHWP+xHbitQPiV060
   6G/MlPgyL3NKug3EkL9NgHyLDCX62m46fNmoJCDVZNVZlAj6KQt4IyGyM
   SWCA19JFy+mJJeIdWXD3gTW9Ybb68N573QLLLOF66dhFPIL/Yis3dpSSL
   g=;
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
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="26999676"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 13:50:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1F003E0210; Sat, 19 Mar 2022 13:50:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3FA6DE0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 13:50:44 +0100 (CET)
IronPort-SDR: jnwJ/mm0Cddlrp/dH02GdSMmlsovKquOvPzCWKSseO5RAYceFlBg+lDfNgLcT7GuV6rvWSHbBN
 hfPCH2+tsGEoEWj2/3DcRH0iVzuzgSIr0p654y8vRWVP0B76SKpDk9P80NkJ+mOFcooOkNM9lI
 hTFIO5HuCn2LnNMLmycsV0mfumLZhNMEA+YF9Nb/Lvsid8kgy4lF+ahmwVZ04xTfQvUy+tf4Fr
 8hzdfepvw/dqVIBcfp74tLd9NZB3Mp6RhfvnlxPp1Pq4pfVtjYBiY0gf8YkwB1ptKiMNfn2skC
 2p3HMZ+MsB3QIQCrWoSfiNOJ
X-IPAS-Result: =?us-ascii?q?A0BgAgA/0TVihwQP49RaHgEBCxIMQIQCflcrBAtEhFSRG?=
 =?us-ascii?q?5I8hEaHXQsBAwENNwcBAgQBAYISgnUChDQCHQcBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2Bl4GZASBSwSBdAs0D?=
 =?us-ascii?q?YI1IoNsAQICASMdAQERJgEECwsODAImAgJMCwYNCAEBgwABgmQBAw0lC61sg?=
 =?us-ascii?q?TGBAYIIAQEGgT8BgwgfLCJSgVsJgRAsihSENScQgVVEgTyCUzA+gkwXAQECg?=
 =?us-ascii?q?V6DGoJlmU0JGW+BKsA0NAeCEoE6gUEMiUKUTwYULpY9DgaRbYVTkQiNFZltN?=
 =?us-ascii?q?YFDgX4zGiSDOAlFAQIBAg0BAgIDAQIBAgkBAQKOHRmDWTOEYYVLQDQLLQIGA?=
 =?us-ascii?q?QoBAQMJAYFWg3ABAYoFAQE?=
IronPort-PHdr: A9a23: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
 ybY6NJj8QnOegan1TdtFhZD+G8juQ==
IronPort-Data: A9a23:bSw9cq57eoDOT9/fbnvhAgxRtEDBchMFZxGqfqrLsTDasY5as4F+v
 moXWzvUOf+Ma2ehc913Pd+woR5UuMTXx4cyHldr/CwyZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UYYoAwgpLeNeYH5JZSlLxqho2uaEvfDjW1nX4
 Yir8pWFULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 MdL6I2KcS4gB+rzn9xeDgl9KRFHfrITrdcrIVDn2SCS50jBbmeq3PhkSk07VWEa0rwuWycUr
 6NecW1LMnhvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2Qu44JjWlv2qiiG971Y
 9cGSgh3VC3nbgRPP1wxUb08w8un0yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RP/0BHNmY1CbD7X+mwOPC9c/mZG4MPK++q+9QuHSa/yssDyVVCEuem8mAyVHrDrqzN
 Hco0iYpqKEz8mmiQd/8QwC0rRa4g/IMZzZDO7BitFrXlsI49y7GVjFUFFatffR77JdeeNA86
 rOet//EbdCFmJiST26U/L6Jt1te0gBIczNbPUfooSM/49TipoU6iB6KdthqFLzdszEYMTT33
 izMsyU0wbke5SLq60lZ1QCa695PjsGXJuLQ2ukxdjz/hu+eTND8D7FEEXCBsZ59wH+xFzFtR
 kQslcmE9/wpBpqQjiGLS+hlNOj3u6nYbmWB3wA/QMVJG9GRF5iLLdg4DNZWexYBDyr4UWS2C
 KMukV4NtcEIZhNGk4ctPtnrUazGMpQM5fy8C6yKN4MQCnSAXFbJpWlvY1KdxWbgjAAlnskC1
 WSzIa6R4YIhIf0/llKeHr9DuZdyn3xW7T6NGfjTkkr2uZLDNSb9YepUazOmM7FphIva+1+92
 4gEaKO3J+B3C7CWjt//qtJIcjjn7BETWfjLliCgXrXac1Q8Rz15VaO5LHFIU9UNopm5X9zgp
 hmVMnK0AnKm7ZEeAQnVOH1ldp31WpNz8SAyMSA2YwS31nJlbYv2tPUTcJ4+fL8G8u1/zKcoH
 qdfJJjaWqxCGmbd5jAQTZjht4g8Jh6lsgK5OXb3ajYIeZM9FRfC/cXpf1e0+SRXVni3uMIyr
 qeOzATeRZZfFQ1uANyIOu2ixRW9sCFFyu51WkLJJPhVeVntqdQ7dXau06Vve8xVcEfN3DqX0
 QqSECw0n+iVrt9n6sTNiICFs5ytTbl0EH1aKG+Hv7y4Ai/Xozi4yohaXefUJj3QWT+m+KimY
 ukJnfjwPOdexQRPtJdgValmx+Qy6oK39bNdyw1lGlTNbkiqU+8xfCPZgJMX7qAdlKVEvQaWW
 16U/ocIM7u+OPTjTAwbKj0jY7nRzvoTgDTTsa84LRmo/iNx57bbA0xeMwPV0X5YK6Zpdpwoy
 6EttZdOuQC4jxMrNPeAjzxVrjjdcCZfDv9/7pxKUpX2jgcLy01ZZcKOACHB4KaJN4dGPH4sL
 2LGn6HFnbldmhHPfndb+aIhBgaBaUnieSymzWPu43yMncfZwOA61ltd/Fzbi+iTIgpvi4pO1
 qpDbiWZ5pliOx93icIFU23E98RpGkiC4kKoo7cWvDSxcqRrP1Ah6EUiNOzL8E1xH6ewuNRE1
 Onw9VsJmgoGsC08MuXelKKlRzHeoQRNyzD/
IronPort-HdrOrdr: A9a23:8HXVC6s6stqeysoXSUQlQ+DC7skDUtV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="26999674"
X-MGA-submission: =?us-ascii?q?MDFd6XMstVlsrdpU3YcaSE6Jjy7du8+RAbcimW?=
 =?us-ascii?q?1lIwPk7ReiDlOWoMxfdJm7IjHx9P5cCJg3LvWWs7FN6lMWr8V02ZUsVF?=
 =?us-ascii?q?40rnswgIkfa32Iv54yoRNCVvZw7Vj+NoJdtmc8xll1eIyuUieU/GO62i?=
 =?us-ascii?q?Xm53LSnvPxM0g8p0/EK0mG7g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 13:50:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647694242;
	bh=V6c4buQT+OKTIDdEdblHH7Hy+ywYgkfDL7mKtSAvQMw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=W/REq9kB9kwieiK4YjnWQntXGGhJOPSTlSxbInYkobdS3mMAe2NgqBnC7VPtCKDd0
	 08mcOlhjy4SI2hn8OyAlSVcZMEZT+sovXCliuI91KB0zCuxlQCb+1dYXQDKhTNKJC+
	 TUmibVe8sE22UWN1ASoqZDRSZepIrLbCllaxkT38=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.182.172]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MaHSb-1nYX5z2dnB-00W410; Sat, 19
 Mar 2022 13:50:42 +0100
Message-ID: <47febea2-a444-5e8d-f1c9-faa973371912@web.de>
Date: Sat, 19 Mar 2022 13:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net>
 <75237f17-66ae-21c3-8796-c656315d99d0@ewheeler.net>
 <db684d7-8b40-d3be-969f-cb399e39d4c3@ewheeler.net>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <db684d7-8b40-d3be-969f-cb399e39d4c3@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MSbID4nJhqiyySGVc6NGyoYNTexMxIh5CCFIqlJzrjCUz5J2z9y
 9ltVvzWWwWXLM5PsY0JqxAVS+RixvE2SN03xzRtv6dFeEgwjR9MRWOuAi/WymY5foQWYUfo
 pQ79D7Dm27PvnbLBa2smAobG1FXIUpHslvYQMtJBWX2CrygrhALSZttAo4bPZ9RF+hmQ5YY
 DDPNW6cQbZK3q0nVAVRUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uA0ukL3Yi5E=:jo4xHXXsFraujTyv3Pb5qv
 eot2t3tTwkddMEADQqyyn1MiiU7u5cIbV8NB9DHZ7JNQPUpZKAfipoRYrcxdptMMIaKhrx9fz
 AMpmltjXrKOkEsn8R0F2/Jap4bfTUKcJLMYl/jcXMV205S2TS6kN+iFxKQY0AuCZqnLXImiGJ
 +iHnl4+DN9juLbaSRqgVoNb8QEkWiAHWF0XpA7kI4ioEtpRt2kRoPCJV5FmkzPdBY7aIllQ9j
 yv0ZaHIpfv9R6c4dEyf0T31XnJkQxTp5UFmWNdXlHPwMvRY8Xueld+J8Hgvm7D+J+xNnYbSyS
 LDz1VVot3wBKCzWTN0qXKTKYGRD78YU6mRZ9KiHOZgnBTvKSH6EcTogZhzkW5ois+gZSSSbFk
 DSFf/LXRivOLMjjCOFFW1S9UW0YI74/fbQGdSuTpcb8ZfocBaO2KGIXs/BdUvD0Ke4UNctPfu
 RXIhXxHBhDZnxq3L1WfbSoi18RepL5sizIT3X9fXLpLPrDHCRvGnOHqNrZXgVLq1Aeevs21dw
 IiWfJK6/B5Bg+JhYkwDJ94S4zjC8Hm5f5vo1i4+nzh0yP8vlAy7/Cgt0RQt7xQqEqhwWyd6+t
 iXwC4KmH/zVR3PA4Njkr/Qnih//6iiRKDtDuanycspkopsV55ARI4kovN2Bri/+Jg6X6tPYEn
 cS2SBZVpvxWmUzu47JdDeEQ7wqniXnSnpxSmDFcgH66gwUl+t/NZ27Ue7Frka/TS1g7B/j4BU
 httPBD5B0psna1sK9cjkzrq1mnEzBBNgPISnkbAXyjKamgpQfD+cnMX8qjQjZJatM90PoO9vt
 1nbB+NrLecv4sdOwAmW9jJ/hBiE4TiqrpZ80qqcdUegk2zv7KGuPmhvb7m2LosG4HhwylmDe/
 nbRmDMaQmN1A9EujQoDUMz6dzjrgKGE0rIe6BjhZ+iCpDRdX1LXIozAsQUidbDEBN8hC82/uP
 biC8rmoCOwIyzAE/dQmfuXcQ4hHS5Dxq6KKN/QOWmS/q5BaPAQYyR8VPPdPrG2NyB/nnKgVlL
 8w+0BOEnv8TadtKaWizFBsxnJ7NBukAqxLYmjU101oauahDSfzScLuldUwygHj50U2yLjtBGM
 S0nlOfuiI0S2FY=
Subject: Re: [cocci] Improving the implementation of the software
 =?UTF-8?Q?=E2=80=9CXnec2c=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 242
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/47febea2-a444-5e8d-f1c9-faa973371912%40web.de>

=E2=80=A6

> We are working to make the xnec2c EM simulator thread safe
> (www.xnec2c.org) but we need to figure out what is being modified betwee=
n
> frequency loops to isolate the data.
=E2=80=A6
> src/common.h and src/shared.c are in the xnec2c codebase if you're curio=
us:
> 	https://github.com/KJ7LNW/xnec2c/tree/master/src


I suggest to increase the usage of advanced static source code analysis an=
d transformation tools
so that remaining open issues will be improved also for this software.

Example:
Would you like to fix signal handling here?
https://github.com/KJ7LNW/xnec2c/blob/956d33d923849a4f80ec47fb8afb90258e83=
cf24/src/main.c#L521

Regards,
Markus

