Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC2AC678D5
	for <cocci@archiver.kernel.org>; Wed,  8 Mar 2023 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XTRjP52BmRENeMIZ/3RzKmpWKIX73OJN+biRFf4Yow8=;
  b=J3BBbAF9SQKUdIfVCoyfkT13M9HI27p4y/0fgy+ufHMrK6f0hJWHhap5
   zrDLKwpaf7VtuOxysoJ41D0t+bq6BknZTh1PdVbe2JWn2QDBFKLWldVXY
   NldZfcACshbD9ETerhcmujwIYeTMuOXuX8Z5j80PWU0oBwIupvGEr+xBU
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,244,1673910000"; 
   d="scan'208,217";a="96137809"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2023 17:24:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9D2F2E0119; Wed,  8 Mar 2023 17:24:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 47767E00BE
	for <cocci@sympa.inria.fr>; Wed,  8 Mar 2023 17:24:41 +0100 (CET)
IronPort-SDR: 6408b6c7_2K5rYndZ6A3dQSn/jI+cn/9BYlNU/zCvBctxy+6g1n4Oq89
 7l0V1CppJtixCWgK/jIajjcyVgFalZPipXWGw0g==
X-IPAS-Result: =?us-ascii?q?A0FVAABFtQhkhwMP49RaHQEBAQEJARIBBQUBgXwHAQsBg?=
 =?us-ascii?q?i11Vi8EC0ZAHoN1g0+LMIF3MYE0gnqXSoFWgUA+DwEDAQ09BAECBAEBAwECA?=
 =?us-ascii?q?TiBU4JzAoUyAh0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?AEBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEHAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAg06GDs9AQICASMdAQERJgEECwkCQ?=
 =?us-ascii?q?gICVwYBDAYCAQGCegGCKAEDDiMHDAaWS5wXgTKBAYIIAQEGgQY6AQMCDAJDm?=
 =?us-ascii?q?XMfLCJTgV4JgUABiRcBgzM0hDAnD4FVRIE8gwM+gVCBEgECAYU2gmeMYkmCM?=
 =?us-ascii?q?YdxCoE0dYEhDoE9gQYCCQIRa4ESCGiCAEECD2oLDnRsByQEDgMZKx1AAgELO?=
 =?us-ascii?q?zo/NQYDCyMGWG0JJBETBQMLFSpHBAg2BQYcNBECCA8SDwYmQw5CNzQTBlwBK?=
 =?us-ascii?q?QsOEQNPgUYEL16BAQYBKCScKhMqAoI9lgiGeKYgNAeCKIFVgVQMigWVAAYTL?=
 =?us-ascii?q?oVSkTUOBpIil2Agi0OBb5pFNYEvATeBXDMaJIM2CQo8AxkPjiAZHhiDVoELg?=
 =?us-ascii?q?mJ0imZANAIBAQEGMAIHAQoBAQMJAYFVg3ABAYV7AQE?=
IronPort-PHdr: A9a23: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
 SRZ
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:gIUAN60NKu0BgmQJZTDGZgqjBGwkLtp133Aq2lEZdPWaSL3/qy
 ncpoV46faUslossRQb8uxoV5PvfZqxz+8T3WBVB8baYOCEggqVxeNZgrcKqgeIc0DDH6xmpM
 NdmsNFeb7N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0YNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,244,1673910000"; 
   d="scan'208,217";a="96137788"
X-MGA-submission: =?us-ascii?q?MDE0pbdTabU2oDivmeUKt9kCMgeLuTNv2S23Vy?=
 =?us-ascii?q?UtyaUg21SjxNfNsrsUqcGVye+qBk8FcsoMKcaLSEPXr5+gl9zWw7utII?=
 =?us-ascii?q?hMzbbDqHUeycGeOgmpSFYLU10uSaYatP0woCwZ0LUkb/E4iOleoLPKBp?=
 =?us-ascii?q?PaMiGjOjdzCtjIUMttn9st3w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 17:24:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1678292679; i=markus.elfring@web.de;
	bh=4DQgkDup0EEM7GA9ahrECRhY403YlDs/0WVwbdcwwq8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=BtpkTEwRUCwY93C0Kj+hg3cmhH7xDl9IvXkiAfSkGmAM3Yer98c1fI4P3BcleZ1Jr
	 Xzw8gwnm07XbxwKt72dZg9QW+vUtAEXWW3lLCTFMs5FG59gBRThJ1f1StCYfozqxOq
	 oBEWx+dwJYoV6Gre17sHubSPPo2rRJ7YHspvIBcQd3wcsQVjkQ4PnpRyMFLsiwzARk
	 odoT7k6SFyRFUbECMeu7Sn7TouOVM1dW7qTus+HEqnM5Rg+E4zZi4Lgh09JbWsFSc5
	 YtbX4sZp6m3Q3UML56rGJ+e0k4+0D7TfKgv7ws1h4LISLU4/2Se5Qk0VYcQ/mPdLBZ
	 Vn7U6T6IArj2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8TBM-1peKJT3GzY-004l7r; Wed, 08
 Mar 2023 17:24:39 +0100
Content-Type: multipart/alternative;
 boundary="------------pgebg6IKpDdj8etuTEfjlh6V"
Message-ID: <a999ee84-3e64-c6d8-5aae-13ed5c79a838@web.de>
Date: Wed, 8 Mar 2023 17:24:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-GB
To: cocci@inria.fr, Thierry Martinez <Thierry.Martinez@inria.fr>,
 Julia Lawall <julia.lawall@inria.fr>
References: <20230307104945.3125611-1-tt.rantala@gmail.com>
 <ec7c6da4-6e56-60d1-ba61-dbc72db8a662@inria.fr>
 <a68b1738-568d-1289-9929-51687b06941e@web.de>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Tommi Rantala <tt.rantala@gmail.com>
In-Reply-To: <a68b1738-568d-1289-9929-51687b06941e@web.de>
X-Provags-ID: V03:K1:gnDfMVHYBcp8/NHlKXL1EAHT/PoPsiMpkaQ54UuVtye1XbMFjpz
 DQuMtkSmCusEovn1bAsFtojX3Lz5d68U+M9iF8tjPOJCqdLKizcTcFmSv2Y9wPiGTVJpTWH
 8wBXw5/aFhUrZtf5oz2IfIFWDgXuymOivpOpcicMQvSwJwvhgmFMDJEvzaTifRqv6bmuuON
 JQgnHlxaDRNaSqucfrTAA==
UI-OutboundReport: notjunk:1;M01:P0:ZBYNgesv8G0=;6KLalNpQLmhQ4zF1fOI3p5+4BFI
 t+tR8jEF66T2rZE70adhmBFsHj8iS4IiXWSrLG22xheZrkUjelmo1GXZHorARl+Lws7axzQjx
 SFQqTGMC+ZbJC83EG1AlO+0XcNkZl9aS2ZdA7SISh8w6NSzo3kbIxvaa/YFHT+evNOd2cYwOY
 jgjWMVlKvREX+KZlPn+LY2P7UCmuh4NEDzSzXNzjM/Pk59pShRbMo3GmihH9bHnBqnBKAlHsb
 CVj8H+NDy6oLPIlalLFNwsqVLGKomzrKww+sW+8hvEhWtqKDa/84Frmi+q9K57PX7DHG7dgFI
 ZNiJ9Rr9UDn4WnheURXC3asQixbF937VGhJr4QtdDxETb75eaGSSi1diMENp8BVRCOjOUeq4y
 MeB3wjQqUBErKoEhwsbp7znHGqa14z2QQBQWnX4fKZeRNZMyIW6NjBu7YhHR9mHTsfvlECAil
 hP5V79cOfnW29wZg/YNV8NZBCIdTcTK/WJ4ZTGq+YHWQMlKoN+bnpxqdHzqwNmiupnXh+F6c3
 v6ZOrUic8CL+l4N2Fzhq0Wpvmcg0sKibeNmVxTpsssWdpUmfylMY9yUxZyppfarCiIkf/2rG4
 1WNYuiC2szuhh1kJ6FZdaElAZN7nqMB47iBkfZ295CGwBCPLV2+F8NA4ETB9wgx+k7jn4lMdu
 GmlzmaSbi6cIdZwnUlxe/p6Mwrlo0g+syyhsXwlZrqdyeylGbUHEsOECFiAR8ompew57g7xNn
 VtapH5pO4xXvgFg0Z1qDZJoj0pBbtfPmJmiAtTyzERYaXaRbquFpkp1Gci/U2thFtA086ZGIk
 xAQXZ2I8G7dr9GYIx5WlHqK5ZQyrn+swycdYIr6xlM2v4BOlt3OsDHtU/ayCsc4RIyEo7UINf
 6TuuxSrB6o/TTGvFkxara0Dqq8o4Y84LKddfrArCn+iOzl+y4dhMIhj65gXABLlx+tPqAD6gE
 uZpg6g==
Subject: Re: [cocci] Checking the software build dependency
 =?UTF-8?Q?=E2=80=9Cbundles/pcre/pcre-ocaml/src/pcre=2Eml=2Ein=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 879
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/a999ee84-3e64-c6d8-5aae-13ed5c79a838%40web.de>

This is a multi-part message in MIME format.
--------------pgebg6IKpDdj8etuTEfjlh6V
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/20160205> git pull &&=
 make distclean &&./autogen && ./configure
>
> =E2=80=A6
> configure: creating ./config.status
> config.status: error: cannot find input file: `bundles/pcre/pcre-ocaml/s=
rc/pcre.ml.in'
>

I got the impression that the following part of the build specification ne=
eds
to be reconsidered somehow.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8e007c83bbf35ace2f879=
b790e24057e39053c01/configure.ac#L570

=E2=80=A6
=C2=A0 AC_CONFIG_FILES([
=C2=A0=C2=A0=C2=A0 bundles/pcre/pcre-ocaml/src/pcre.ml
=C2=A0=C2=A0=C2=A0 bundles/pcre/pcre-ocaml/src/pcre_stubs.c
=C2=A0 ])])
=E2=80=A6


We are also waiting on further information for the topic =E2=80=9CSupport =
for PCRE2=E2=80=9D.
https://lore.kernel.org/cocci/alpine.DEB.2.22.394.2207222129160.2321@hadri=
en/
https://sympa.inria.fr/sympa/arc/cocci/2022-07/msg00027.html

Regards,
Markus

--------------pgebg6IKpDdj8etuTEfjlh6V
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    <blockquote type=3D"cite"
      cite=3D"mid:a68b1738-568d-1289-9929-51687b06941e@web.de"><span
        style=3D"font-family:monospace"><span
          style=3D"color:#000000;background-color:#ffffff;">Markus_Elfring=
@Sonne:=E2=80=A6/Projekte/Coccinelle/20160205&gt;
          git pull &amp;&amp; </span></span><span
        style=3D"font-family:monospace"><span
          style=3D"color:#000000;background-color:#ffffff;"><span
            style=3D"font-family:monospace"><span
              style=3D"color:#000000;background-color:#ffffff;">make
              distclean &amp;&amp;</span></span></span></span><span
        style=3D"font-family:monospace"><span
          style=3D"color:#000000;background-color:#ffffff;"><span
            style=3D"font-family:monospace"><span
              style=3D"color:#000000;background-color:#ffffff;"><span
                style=3D"font-family:monospace"><span
                  style=3D"color:#000000;background-color:#ffffff;">
                  ./autogen &amp;&amp; ./configure</span></span></span></s=
pan></span></span><br>
      <span style=3D"font-family:monospace"><span
          style=3D"color:#000000;background-color:#ffffff;"><span
            style=3D"font-family:monospace"><span
              style=3D"color:#000000;background-color:#ffffff;"><span
                style=3D"font-family:monospace"></span></span></span></spa=
n></span>
      <p><span style=3D"font-family:monospace"><span
            style=3D"color:#000000;background-color:#ffffff;"><span
              style=3D"font-family:monospace"><span
                style=3D"color:#000000;background-color:#ffffff;"><span
                  style=3D"font-family:monospace"> </span></span>=E2=80=A6=
<br>
            </span></span></span><span style=3D"font-family:monospace"><sp=
an
            style=3D"color:#000000;background-color:#ffffff;">configure:
            creating ./config.status </span><br>
          config.status: error: cannot find input file:
          `bundles/pcre/pcre-ocaml/src/pcre.ml.in'</span><br>
      </p>
    </blockquote>
    <br>
    I got the impression that the following part of the build
    specification needs<br>
    to be reconsidered somehow.<br>
<a class=3D"moz-txt-link-freetext" href=3D"https://gitlab.inria.fr/coccine=
lle/coccinelle/-/blob/8e007c83bbf35ace2f879b790e24057e39053c01/configure.a=
c#L570">https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/8e007c83bbf35=
ace2f879b790e24057e39053c01/configure.ac#L570</a><br>
    <br>
    =E2=80=A6<br>
    =C2=A0 AC_CONFIG_FILES([<br>
    =C2=A0=C2=A0=C2=A0 bundles/pcre/pcre-ocaml/src/pcre.ml<br>
    =C2=A0=C2=A0=C2=A0 bundles/pcre/pcre-ocaml/src/pcre_stubs.c<br>
    =C2=A0 ])])<br>
    =E2=80=A6<br>
    <br>
    <br>
    We are also waiting on further information for the topic =E2=80=9CSupp=
ort
    for PCRE2=E2=80=9D.<br>
<a class=3D"moz-txt-link-freetext" href=3D"https://lore.kernel.org/cocci/a=
lpine.DEB.2.22.394.2207222129160.2321@hadrien/">https://lore.kernel.org/co=
cci/alpine.DEB.2.22.394.2207222129160.2321@hadrien/</a><br>
    <a class=3D"moz-txt-link-freetext" href=3D"https://sympa.inria.fr/symp=
a/arc/cocci/2022-07/msg00027.html">https://sympa.inria.fr/sympa/arc/cocci/=
2022-07/msg00027.html</a><br>
    <br>
    Regards,<br>
    Markus<br>
  </body>
</html>

--------------pgebg6IKpDdj8etuTEfjlh6V--
