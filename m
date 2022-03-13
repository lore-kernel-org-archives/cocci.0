Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57E5C433F5
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KmGuZyyLkH00NXRqwpgOYQ5hD5c+HpSEYtOl/Fo5TP0=;
  b=b1ZOk1VRTGXzCSS97RYCSw5kgIYD3R7xP29RBzPqzTbtFmdEpTM2tvYB
   stkx4JH7+F3buc1yz1DnEWt57Y2VzXzNRlbha2DXir1iVgBgM1YNpZkmK
   yF4k6d4NPqTnisne+JPAXs6qRQBtEjIKHqE4nvOYRFJm7p2rKGC4wJBS8
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25872859"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 19:30:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BC81BE0048; Sun, 13 Mar 2022 19:30:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 98BEFE0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 19:30:19 +0100 (CET)
IronPort-SDR: cHnb+tRewUbtkMKLI/RT0kSXnbMJXTr4agA4HSqkORegYGAj5sj7i8XKHF5DToux/wFIDQh+EJ
 Xsc+ngMfgmgPb3g4b5zqvNqYsNFbVwnNnwU9gPJD/xFspi/63YNA1q7lka/D5GaDVXkwjiCaSN
 am595rSdexHYqgXoV2patgfTG8BYWd6gz4X94bTIiuPkHlFg9NUxiLVoSrg5kaiaasei8T6wW2
 tfqVWGVRXZP8dxUKY4fJpScBD7vsTX06BoRe+kggONR17HsCl9E+Redq3nwBpBYEUm+DMJ7wCu
 nDOyxuyAXmYfJU4iGZrZ63ND
X-IPAS-Result: =?us-ascii?q?A0CyAwB/Ny5ihwMP49RaHgEBCxIMQIQCflcrBAtEhFSQa?=
 =?us-ascii?q?pJqjCILAQMBDTkFAQIEAQE8AYFVgnUChCQCHQcBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECAwQBEwEBAQwNCQUICgcOEAU2Bl4GZASBSwSBdAs0D?=
 =?us-ascii?q?YI1IoNsAwMjHQEBESYBDwsODAImAgJXBg0IAQGDAAGCZAEDMguuPYExgQGCC?=
 =?us-ascii?q?AEBBoE/ARNBgjQfLCJSgVsDBoEQLI5IJxCBVUSBPIJTMD6CYwEBAoFegxqCZ?=
 =?us-ascii?q?ZdtWcJnNAeCEoE6gUALiT+UTAYULpY6DgaRaZZXjROUTYUbgXiBfjMaJIM4T?=
 =?us-ascii?q?gECAQINAQICAwECAQIJAQECjh0Zg1kzgQuJIUA0AgktAgYBCgEBAwmFRwEBj?=
 =?us-ascii?q?RwBAQ?=
IronPort-PHdr: A9a23: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
 iff/IcGS7SOjeSFjDZqAkImlw==
IronPort-Data: A9a23:IeUmNKncsFPISIvoiSlF5Pvo5gz5IERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbWzvTPvyMYGLxctF/b4Tn/UgD6MPSz9VgQQFvriw1FltH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+paHYTdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /0Q7sfpRzcuNZbCmb0UdwNISiYibZZZreqvzXiX6aR/zmXDdGbwhepjBgc6MOX0+M4tWDsIr
 6ZHbmlQKEvra+GemNpXTsFJj94gMdKtEYcRoHBmwhnGAPxgTZ2rr6Div4IIg21g258m8fD2X
 fFEOQp3Xin7QzYSN1IOUY5ghLqRiSyqG9FfgAvI+fRuuja7IBZK+LPqO9HUUsebQN1c2Eeev
 GPPuWrjaiz2L/SazieZtG2hjKnDkEsXRb7+CpXlraUzjm2UzVcdCUQfcUGr+P7l2nWhDoc3x
 1MvxgIiqq079UqOR9b7XgGlrHPsgiPwS+a8AMVnsF3WkPa8DxKxWThdHmQphMkO6ZduLQHGw
 GNliPvFKFSDWpWwTnSB/72dsCna1cM9cDFePHdsoect2dnuoYc3hxTDC+5tGaqn5uAZ9Bn1x
 C2W6jczjfMfgKbnNplXH3iX3VpARbCQEGbZAzk7uEr7t2uVg6b7PuSVBaDzt6ooEWpgZgDpU
 II4s8af9vsSKpqGiTaARu4AdJnwuaraaWSH2wM0TsVxn9hIx5JFVd8AiN2ZDBg4WvvohReyP
 yc/RCsMuM4NZyHCgVFfOd7hVptCIVfc+STND62IMIMXPPCdhSfesngmZEiM0nrrnVRkmK5XB
 HtoWZbEMJruMow+lGDeb75Fj9cDn3lirUuOG8yT50n5gNK2OS/NIZ9YYQDmRr1ovMus/l6Pm
 /4BbJTi9vmqeLajCsUh2dVPdg9iwLlSLcyelvG7gcbYe1s4Qj59U6GNqV7jEqQ895loei7z1
 inVcidlJJDX3BUr8C2GNSJubq3BR5F6oS5pNCAgJwj6xHUpJ4qitf9Ne5wydLgh1epi0f8tE
 6hbIZrdWKwXR2SV4SkZYLn8sJdmKkahizWOCCz5MjIxSJhtGl7S8dj+cwqzryQDV3LltcY3r
 7C6+BncRJ4PG1ZrAMrMNqCwwln3sXVEwLB+WE7BI99yfkTw8dE2enKr0aJte5kBcEyRyCGb2
 gCaBQYjidPM+4JlosPUga2krpuyF7UsFERtH17dseS8Ox7c8zfx2oRHSuuJIWvQWW6oqqWvY
 eJZk6P1PPEdxQ8Yto1hD/B0wKh469a2/+1WyQFtHXPqaVW3C+o8cyfcgpQV7vVAlu1DpA+7e
 kOT4d0Ea7+HD8PSFgJDLgQSaOneh+ofnSPf7KhuLUimtjV7+qGLDRdbMxWW0XUPKbxoLMU6z
 O1ntMNPs16zjR8jM9CniCFI9j3QfyJaDPh97skXUN3xlw4m6lBeepiCWCX415G4bYkeOEcdJ
 DLJ1rHJgK5RxxaZfnc+fZQXMTGxWXjTVNF2IF4+y5Chn93Ymrko0RcX/TlfosG5CPlY+7obB
 4SpHxQdyWayE/NAm8VJGWyhc+2ELAPM4VT/kjPli0WAJ3RFlQXxwKkVJuuHukwUm46Zkv634
 5nAoFvYvf3WkA0dE8f8tYOJaxAucDCpyjD/pQ==
IronPort-HdrOrdr: A9a23:CT+mJ647xzeMPR8I6APXwOzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuF+poboeVu68qT9JzjJppWPHtXg5gL1XYFNu4Rf3cdeDV7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25872857"
X-MGA-submission: =?us-ascii?q?MDFFQLJcoMULDqwVbDaqI2GcD9HrUHKao2JGcq?=
 =?us-ascii?q?wBtftir2K43axlsyU9t/76VS37/Lla+0RA/S6x6x8MmpjhaGD5X0fOYw?=
 =?us-ascii?q?EO4sQyhuAWrWqu8HZqbZVDco8KSM4PEPrU/aQ1m9+nEzq01Ej9MLDEIf?=
 =?us-ascii?q?nwvhTjiNhy02V7kCWNJOYpmA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 19:30:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647196218;
	bh=KmGuZyyLkH00NXRqwpgOYQ5hD5c+HpSEYtOl/Fo5TP0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=dpG/iWiwLQlI2YfJ6E8tkS97Q8MhqSkzxFU2hqlU3YdUsIUJ4Cph3KnIJ83HA2UrS
	 5mFY2bs6G3dbiLmuQx06+yfaUglozkLhx/P3LNq+bJyi8HObtDwEcN3we6zmae84Vi
	 s8BJlchF4ddgCtjGpdF4A65PzvDP4ikVp991YIMo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.179.181]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MV2OY-1naenE06Q2-00ST99; Sun, 13
 Mar 2022 19:30:18 +0100
Message-ID: <4ab15cf7-5c74-961f-e50b-ee84d7e55b6a@web.de>
Date: Sun, 13 Mar 2022 19:30:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Luis Chamberlain <mcgrof@kernel.org>
References: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net>
 <Yi4ce+2k03795Rut@bombadil.infradead.org>
Cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Yi4ce+2k03795Rut@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MR6km8k/0SWs8pOXS7ENOmr/OiWuq7kBM4VjgacMVK0yOfKyR6H
 UL/2m5Uky8bbQBlIwwpADa+FCOh4XNpMMjIE8gSafS+RbbcW5p9jhm2nyogESWXQs4eRXr0
 BXntSyQDUrm1RVhspT1JZn3S7x6PXJ6r84fnaZx333A9vvLByAKGQtnwb8e/FDE5+OsDdY4
 3rOQadSnsKgMifpx8zjCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F+QSbx2MCr0=:oc8Ya+huccHj3NTwnEH9Lc
 gZbYxGTXMXzonySGoxwsGcT4FpPf8mLWXD/ROOn9PEArLR2kErgNQ8KIi4escHsfZAbpjg2gH
 hXnJyMWYa32YBkqDotUtl+YcXpFzj5q/i2iK16nljD26E3ob0PpfQ6tEVODdqnZ18JIVWMj3r
 S6tOMHKB7XAJ8SdJLO2ICW4rYlRC4aCMNtz1Rtg+DK6FkxstpF31eyUsuDH6qYdxxS7RCHGHH
 E7cpxFkHxnsm2CF4/+HG6e+v590U9/1OqOlBiKxUhqyS5aODsHSsiLHTh2Q5tYNmDphuIRrbM
 OZiuUXtgx1d0qHVGgyMeNbLR1fTFU7KdUfM4GPNeQq2STFE7H3kfNiOg8F2Ka1EtJHGQe6r/m
 VaVQXzaNxkz4dpWY66xbZ+p+/yKH5e7VsOj9VcgCvmwXKIbzx0xsb2JJ2ApPsTbnPXGLOJrlA
 pNxzmVG4sY6IqcoDCJx13DQa25ehA+8/hJJCo4UWrErATuFzTwzQ+ByWOYKP7JyrPpfPZ7tPm
 TPFT88Yztfdyp6aw86gEDdl1EpNeNspkqJ0lE1UwY5knSKeapeswSsyvI903hr53glQNNT469
 bg5lzWwmkzvmyGazAIR7Qd2EwGZMF3yTKdajMVczRysGmwdQE+OnCcdD2h0CT1+b0H/33cx6M
 VPaEftaYlcVznybpFmeaR9CVwEN+8eOxnuJsw+B27miR4IOLKy/rTkmDaMRkDGmcQDYLuJuy/
 H0oxBhua2vkqptFIA+HQsy7xqrdu3jt9l10mWU8hJqpsv1dHVnmKkuJAALC5m5zjKIYbTXT/N
 HEtWItQHkeAkbhyi6stIn5WVAxJMdP7CRiG+7KWfoKHJTiThqxNnknw+F/F2iGSb90dwNBiyQ
 rs1BSY6yvqSxP1qrDw+P+aYLURHLydXPxqwrz8IBNod5+/9StS7da/28J13ituOx3e1HhNxEv
 NznN+BspMA4XwHbcc5BFkVvEtRNbhR51IjXfsl4yXCpMko5J2UQmlHn5OWB0yX6+ZDEldOXe/
 n+yyLdgRzahxwGEDLjuXzy1S9CYXiUDR0wyjX82Bg5Uz5YC6jBBThln4qQPk7mqOQ4NitjNR4
 Jz7NEZlvk6LZmg=
Subject: Re: [cocci] Checking the construction of a fresh identifier
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 225
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/4ab15cf7-5c74-961f-e50b-ee84d7e55b6a%40web.de>

=E2=80=A6
> @initialize:python@
> @@
>
> def make_my_fresh_expression(s1, s2):
> return '"' + s1.strip('"') + "/" + s2.strip('"') + '"'
>
> @r3 depends on c1 && c2 && c3@
> expression c1.E1;
> identifier c1.sysctls;
> expression c2.E2;
> identifier c2.base;
> identifier c3.header;
> fresh identifier E3 =3D script:python(E2, E1) { make_my_fresh_expression=
(E2, E1) };
> @@
>
> header =3D
> -register_sysctl_table(base);
> +register_sysctl(E3, sysctls);


I find it questionable that an =E2=80=9Cidentifier=E2=80=9D for the C prog=
ramming language may contain
quotation characters and a slash.

Do you depend on any special software behaviour here?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/20fdb67f4b20a242f2223=
37e13091115884cf6bb/docs/manual/cocci_syntax.tex#L280
https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2=
e537f97ab62a/docs/manual/cocci_syntax.tex#L280


Regards,
Markus

