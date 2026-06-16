Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E4FCD98CF
	for <cocci@archiver.kernel.org>; Tue, 16 Jun 2026 08:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9ULSW/zcgE5z/uVK5kC/JqeRTScRH/m1VrmMQITmnM0=;
  b=omhGyOHmhF6HAs7SeBNWnYPODferYY99fdUKaqhnKAgAmQqYXyFnGvkS
   Zq87bGjzA74ZBupQFQRpRKlczAC6btV204jW0hUPjysYYNK+hyZ8UP0HA
   3vLZ3jf+dVGXuS+6772xktDLj2ubkeA3yY3P6xCUHkq5rzhsW9CaVXJEI
   M=;
X-CSE-ConnectionGUID: 9xYhD1GwRhqRSL+0vGHl8Q==
X-CSE-MsgGUID: n9pZ5K7aSeeReije/P8Lpw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,207,1774306800"; 
   d="scan'208";a="281749628"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jun 2026 10:13:45 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 38D56812AA; Tue, 16 Jun 2026 10:13:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A9B508065C
	for <cocci@sympa.inria.fr>; Tue, 16 Jun 2026 09:51:57 +0200 (CEST)
X-CSE-ConnectionGUID: OGU1SyClR8ONQurI78Qe7w==
X-CSE-MsgGUID: szEMV6AIQ6WabX+kTBm+kw==
IronPort-SDR: 6a31009d_6H6PQUxFRnezLDuLNJxwvxXUMRg8CvNXnRqgNMhPg8PEoJV
 NuOHePnWxY7RosXBTKhoRnxfU4ChzazSRDeAuBw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ESAADN/jBqg07ASNlaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBgkCBCl40BAtJhFiIHIc3giEDhDuYC4FVgXwCDwEDAQ1ECgECBAEBA?=
 =?us-ascii?q?QIDAYR/Ao1AAh4HAQQwCQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBA?=
 =?us-ascii?q?gQDAQEBAQIQAQEBIRkHDjuGTw2CYgGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQECDTpDAQEBAQIBIx0BAREbDAQLCxgCA?=
 =?us-ascii?q?hgOAgJWBgESAgEBgn4BgiIBBhABAw8nBw0GsQh6gTKBAYIMAQEGgUYCDAICQ?=
 =?us-ascii?q?AHYTh8sIluBaQMGFYEKLgGFcIJqAYYxCYQ4Jw+BVUSBPAuCQQcxPoJhAwGBS?=
 =?us-ascii?q?hSDW4JqgiaBDINuRYxUUngcA1ksAVUTFwsHBYEjQwMqLy0jDzwFLR2BIyEdF?=
 =?us-ascii?q?xYeWBsHBRIgKkJFIwMCQlk/OAoBQwWBXQKCEU4jHwM5f4FwgSVnZhUwNYECE?=
 =?us-ascii?q?R8KOgIBC209NwkLGwQ9jU8XD4I2aBoTASkCBIEBE3VqA7Egk1mBCjQHgjiBa?=
 =?us-ascii?q?IFmDIovlT8GEy+EBJNPDpMLmQgjgjaJN4F6mziBaDqBXDMaJE+CZ1ADGQ+OI?=
 =?us-ascii?q?QwNCYQTgQuDVcMTRTICAToCBwIHDgMLhUQBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 VNpPnHISuAJ54Y=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gmOCu6vnOllv4p79TSMRe/mI7skDY9V00zEX/kB9WHVpm62j9/
 xG885x6faZslwssRIb+OxoWpPufZq0z/cc3WB2B9qftWLd1ldAQrsP0aLShxfnHDD3/PMY9a
 oISdkcNOHN
X-Talos-CUID: 9a23:kgm2dW5NHipNY5Ze/9ss02EpQ/s0WXnnnFD2GlKiKDk5cbDKVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AxClLNQ+JvYvp6jNiEWZaC0qQf9x6zoGQVmksqMs?=
 =?us-ascii?q?5ssO0di9METLejyviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,207,1774306800"; 
   d="scan'208";a="149554168"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFWc5GABWTExsTmRfP/zBVO/p0pS8PrulGrCJ?=
 =?us-ascii?q?jqXZDRUiKiUpIzYgSsfhhQMV4GHHo7zvQtplHASQ2yt3anHzZz6hojom?=
 =?us-ascii?q?q9INf/Aj/6TGF5YP4q0AvqfDyJUpk1U3sZ5gc8O5lL/EGL/UmpXDjD4t?=
 =?us-ascii?q?MAbWaCdkzOs1pYNSV+c6XaPg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 09:51:57 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmho4-1x1cba0ItC-00iY6r; Tue, 16
 Jun 2026 09:51:56 +0200
Message-ID: <0727fbb0-3941-43be-81b8-fb8b014cfe81@web.de>
Date: Tue, 16 Jun 2026 09:51:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de>
 <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de>
 <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de>
 <ab663a12-5993-48c2-aa0f-c093724cf930@web.de>
 <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
 <f059e31d-25d1-4ccc-b77d-07c4ff9d5d1e@web.de>
 <eb219668-8de8-a61-f852-4f16328e1832@inria.fr>
 <6a2de44c-b762-4f92-a5b7-661ac5214de2@web.de>
 <bd197670-dc1f-5c82-2bf-9e6316b29da8@inria.fr>
 <fe461478-4479-4384-a6fc-bce86f338707@web.de>
 <df229e71-6f2b-46e8-88b8-e5cdb321b2fb@web.de>
 <ab10711d-81ae-9254-215d-3676c361fde@inria.fr>
 <180730f8-bf12-4898-97d3-d209aac45e32@web.de>
 <308db487-90df-8ad9-4160-be6efd1bdf28@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <308db487-90df-8ad9-4160-be6efd1bdf28@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:djmwROmR8StI56MJfh0tsboqDoMtrm66aQCvSsPh5wN+dqB1YeF
 rMUBbbbf8Gsp5b2jFs0QnclhIrpr+DnypQ5bexdHXbpYlfufjO6mACAnOjaOi1HZLY+DAU/
 TN4Lv3sUoXG4h20LvsIYYHGbUIF+ncY7HM3G0MWZkN8/L7u4RIumCKXkxF6c0CxIy9nARq9
 opEqROV1zAdG1DvLBRlDg==
UI-OutboundReport: notjunk:1;M01:P0:+b35Kc54Ptc=;cZXSp7pil/AIOnbbCJbSQZHO5cf
 ZUCYk2XHeSnhBnIfd7f+AvBS0JFuS3eQorScDJZIaMkzbkdQz7Q4cOqcbanWq79I6lhmmzyl0
 8u4IGY2LqzNY0hv6mGuodhCz/29lAuNlwsyZtTUf40AJjB946piKUwjkTdoMXjzeuiojAGYmh
 ExIPRj7AwccIQda47GaVV0hNduRkyCB2ZobwQp+QLmLCHOWVcIP4Dy0/+zjK7YhSFu1DYnWIA
 gQkHhzB2GAKItggN4Zs7duH+SuFuG4IokAsldfju6UK0CcuofaV6wtDCUJVnL7GA4OWovt+zv
 FMuAlw4eXU6fzlqdNyMXm2PaMiGI903NyacsLYjMVTpkCNkZ4sJUZR53LP2UtBtClAF2xYShg
 BEQ80fo7Z285aNDM0ty5RcKjTW2hVIpH5GoGDIxPK/yf15XPjNFBcJ95GJ2Q22f3OquWef22V
 vEzohAKUvqlldC5vgZwfLne2ayV8Qor6lZ7OqRcUsQFidLNHVQPgYWYd5ftrRZ4XBkjE+YFh8
 g7kGit4bol+R+oMl2s7bzG/0eBkvkN8kciYIZd4IF5U4TISVdPkbC/VOrTQU3bLCv2IMZzBdc
 AxKbgbCQomS0MZc8vJStnekx6io6HVE225GA2odEV2jt3TxRrNLzc5B1OLo37Z3SrJztWKynB
 LQiCl32vCpr3GoVTSyoEigdNhhL7SxDV74nE9ABXe4qe3nxdhczg7q2K5r20ChXIALWppjvuc
 RSaaIlUAskhzLO5qBtNmUKIJ2wOPRJsHP8bgCQsv9nwD7Ohd5F37rJ5N5MiA6CcqZ83JMKSwQ
 02iKtC3RQTQ461R8jVOi38xFtsmUabxnbWKcZ40o2hA0/WI5MgYUzmIDFr2dPZ6VfDaogw3G8
 yUzFdZcanfyNjzQ5ES9rRMpX9pxiHWtD8CXO8Gz+ibJFbZIIj+HXm3tXTnmX66AJWjiTTiQqh
 gxCff7Riv9706Hib8qkim5lLZLqaoUHPMQWAHWjR1+LNroL8z6TBQKOOXZfomcUSr3b1LNRq8
 s8/ug/hHKzsIVRHlLvJohZ5biFqoYryTzWd+G2dRh7j9NKJ26ZGN87PlTuXdwJNsS25QxmrKA
 hZEPVy6VuZQJHcuJgXX3qIuB5RB24jMn4QDQuCYSOrm6EUrxmj9A5O7oFDvzuDJZxc57pybix
 wR7SZjMVAi8CHOA5Go6pe31PvIYKitGYzRTlCF8utw/vP/z7Ac2/qcvJxazOLjaUM5kCCgQ4u
 ouZTKfBsn1HVkpJfgmzBLdh4Mfqm0SJu8BVrQVm5RhMlRUFJWXUDfDkzMG8zTrvT/ZAJTQ64H
 Xdin57/lfPyYRXH8fAXYFUXgG88pDmVLjsyYAKGyHz/DyM3E1DJq0MHyuboC4w7EXzo180E4w
 6UteInF/K34dGc25sz6gBOlPY0Iivr12aZ4vbz6YNuKotzuq632bkz4pjgFgPLa0YIhCzpfSj
 fkfJk6FD3IlOWGbO4xjwNF6yqyAyIqoH2aymm7t8g8TV1KdeaHfODXhqe1m9SvJhdOhoJu6Hc
 27DP3D1m5p+J53v+/RtsklxUNUDIM5+jM1KdEfseSNBtWcC07JsM+tAYimPsGuOlJRORAxqfd
 PzKrk2Hft8us+16VT09/c2AnkVSyUoK8jE/CaodAPLdSK8cJdwFSqDdLosVfmCwGbNm/UWeUH
 RsWKfqHNawRTlKM0AmQxDHvaiDX7aB4YyLlspPYjKepFLg2/CEdEJkUAWH9CgFbZ2IIkiDubq
 Kr4PjYv4x6HgaaNdxGCDVPvdhPPnKQy2BxXP52vHIQfHrOxMHu8gQLHokLhiC7PhU0XpDVs1w
 Xp1K3o52bRw4aIOOdbPevCVj4Qaf3TE7FfPqyYiEpezBPyKTyFtSa0/Q9v/ekCOtzfX1rWmHk
 yK1eLAvfa6Jo7T8wH+ecZJ1fdeMYUyJzuqaCueemVoMVF1yV3bRAU4+bHvv/H5pfcYcxRX2mk
 UFqMuUVA4qAAucKgmrTs4KahNPDULFFqH5G9C9QwHL++CxuIXSqvIrA6Y+bd/XwVt4FOtVcgj
 gE6HtN2kxDkfX+YNvEoEmXKVeTwtOu9iSz++CisQU4cQPKNwVSnRlhOKK8ifWZvlC6HNg9fj0
 6OOyp2PPto+3mgGSR+rguex8VMwXZvJyRK1RzeZH8Uoys4QgjlF7IAkbCuJY279z3zNdTJ25E
 BW2irVHchOY3vWtIfG4E2n65eo/VEG1aTI1rD9gb2DpEqQ2Y8n/19vVIFqlreuRaHPGb82HF8
 d6Rjma9UkV3XfZ3nYYiGgqNiWFPNjYNxUi1DK1PcVFRKqf7k3U91+yhf/E2SN4GZBJBMlnh5s
 u7vYKDVG8lxVfRl9jtSfgDghtR7Nx0Kk/SNRkL3Xz45x1RYQ+n0dD8npgb/z7q9IUn7IfxV0W
 07Cqdjp5juQgux2zvqA/6zdzF2mbiCGvmYFbrcrOGve4o5Ugdv9jtKVU3HL7h8WsWw7PwYMaK
 DjmDlXKH/pRC3t6ThJ1ciDQxxr2lfJ0QTTnRsOkrEI+YqchNeHmITlvy6KQSTncggE01fLs4o
 11aDbdT9Q/GhMh/QFqZxK4C8tkBGPvyZdzdYt6XHhqqITsHS54wO8g69uDAynVBd+5Nd39k5Y
 Uht3LoEUt7M1j/JelnpyOuFDKPxAnkoqe4A6jDlfqcyC3MQ96wT+dFJuCaQvPKqv6GVfoNaBp
 h9apBdlnKKOaqEENCLt0LFK51BbALcYC0jCzuD+mU2imy9n9gjHodJTv7VI1nZpNlwwHCrFLD
 eCJKRRf26ImJ5uXYNbechcXxqBRLil6JoVGhHM16hqTHN0daiwZUf33JikH8xxfscGrYTEQCK
 ni/tIc+sGBPYLNH2Azx98b9qDi3DyiZJCDdqgEsRskZEhmHbUL4F0zWuIoiV1fXZzsM4hUlN9
 sHPRrWyEGg0BOdorP2AjjEfBdy+7TysMci9VlEg43Eu5WNvqI9JcEsL5ksPhVKJPTfyJFsiit
 d+yLJTW0LrnC1hPpItqd/yDUVpTfctRPXECEbaloj26qlD0E2drjjiVwBSdRScgO4i3T5hG0g
 hiJEWWNdKuMOfblWwriaHosLYVp+FVvy5dnGYpWjcqAXUEnAZHt2ykiskoG4xB/+uh5/Eg6xJ
 2BCzYLm5WLJrI16f6M03cpZ6IQahU9M8SautkX9VOgTzjAtGi7xJBxY11D7i5X1HUTlKzxoBW
 1WfheRL9+17cPKVSknlm8Cog/Rl7f6dZZcgb7o6d6IpawUfRPx0ctwGw9wZziK7AfaPTOCAid
 8nBf2AwuZ8Y1xPcuDtB3Jyd0PyHqC0mTKdViphftEAcsD9aHg9rhYVbsFXLnKPCvLnqesedzr
 N0Ct9HLpNXfunbhpfDaz/rcBjncaNxlsw/mp5YA3onkS16MW0eh6pQ3z6pPpmR7+8IAmrffaT
 JzwPAdNTrxgu2DV2rPRtPe1opXejLC6TQNxvTNfAEGBICY2Yw8agjoUI2JOyN3y2v2S/Stell
 D0e6veCEK41llaPLxFFR1BhfvoKXu16RY3Sgmwnxh7omkB739JwKTtQEf0dl1gJ5wyF/IQCIv
 Fp1eoKwHTEIGgriqtB0O8MVLc3gQUGSUbSgZPH/WN2UtSbwnn6lMhBXHRcnyo1kc5wxPdvO6/
 N3hb2N2nZaaLwlwhP4LIyWjMT857dCcjdzHwDBXA7Z/pEb08JTpwKKgC9FLGYcMN38pbDrhAd
 xgVp9rzFB9/W4y4kdOTnm+ACW/+bjpMtCqQDUe2ixe5+1f51lplIi3wqfM23WyxkpPNFe+PJk
 6ln8LpPZpKLCIx6D+6dyQnbJNYDJEXWMH4WMh/zIvzzW4lSGLDRXAlwYCDkVGJK5cQ28/9/IV
 O+b5f623JLIe3Qh9R4NB9xnejhlqa6C8oc/lIAI7rZ5NH8fQi4oXAARmV+JbkmEjfvmuXYL2m
 wzTau1LtFnLDuxMyeNp0pgN1kNSq4sM17YcdFlmmeRKzvLEhqRQgiC+dCPcfLClbarkAT7oQy
 WwWEDFALw6G9LDpQMYi8cORf29lUt21VmH660hhk/HJ+H/pepx3xS2o8BQkPcAxpt+T+bI1/r
 DMNg5tI48EeICA4iNwY0IJPMcPF/wXwzrdbfosDeUmnSwN2fgiceDA06bDjUmsTr1tYJaJi2X
 FgAf/QU162vLGFJrQFDsjWlufwqie1KOjT6XkY/WzGAhRju7Jr7VvyU3fQdVx+eukV8yHMwXJ
 GUgvYqeD2QkYmGU2nq/5OtbEIf8R0gGdQZvjj2LsSrIe21zsuykSPXbiyt3xYxWNqwVk+re8i
 B807BxjE1nvvcUXFl9daXDnXkKexLTMxYi4UUsAtqz/RjpMF/ZNdBM08XVdSTHrBiXA9FzXtu
 zpoEpw/WU0t16/5QPYeg+L3yQ9GKcqVi4Vq+vX0adn3m0EJiO49rjvmJ4e7n9vQqNoh1hkOjF
 8ardz8hqO8R8ceeY4jjRAC7IY6Tllzisp5wv4guobvJWx7zGnP0oM4aArijQWYDwGRTGIP0ro
 JruVXCIWG9JWfqAzQkre/F8sqSXa8UAvMPq2dwJd7Bf9vmh56KIow9Wsxpfg8dI2XWRioviVk
 93kdsKTaXcTqhGJHin/lPAN5cpMZTWIBdAQGHVi6lUmztjWSgFElTnDa7EtzG3Xj/wkBfsRm1
 QoaJAOIqgXmyDbU51ounoqlcCRgh/D5Pz45+le2l+Fu+9RWjqPUIc+sDv4/mKkOMFKWzL70jn
 L1kDDK4tMkNuakoNsEAxXU1dk7jYHvYywkFHZ0FVPaZwXYh4vaoHy5SmHJwUMqLMkzfUVFS3N
 8FQivF5hXlBaWEYE5yV5pbetz93+eXBWG45T9qxyzeeukYSJbvQX3K9QT+tt4i/TL45PQhDqw
 8tP616/FB42PScaJq4BczPyhNOzjltQcxmRHxOqP6VAysgA40Oaijo3jUh4+HXkjxUl7A0B1F
 RTp1A0acmrghRK1oS7lFlmi0/K9sonKnla8K0RKtN8JouGIRME//TjrdvvUXYKbKO/VmkxD//
 e5GhsQXgqX2xpd9Fx7LKsqi4qigOUQThdvkURXFhHJ76tQXvrQ27wNTuBl8W+buRCD4uaOFxp
 ZDHwOSBhMsKHZCLRpsSI2McxQ8ycIgnZJn/4zhbbaoaOfKPwZaJMS152qBfeJJJ+qtiNLqF/m
 A6mzy6QuqysrXLkawNC2+GCB6hOWJylWf4mMAkSqF9gy9EJLh85aqETZ2FlDBUfUbCqd4ruET
 0yXK2PpNgxoTxztfhqwxi+6Ah1+HTeWVgPLBQmnCNlNK9ayeSGt3k/PecgYglsKh5k4GJqe77
 nHFls5klKA1DmKQLj979rcS6yZmDUG6tneH3cJNCqaGrhQ5Oeff/VzGw4Vii/TABvSzMHnBqg
 jRhyKMzVKEDkjchLHHq7QNSscKQHZMa4B1E9Ohi4pR/YyJSvRPeguZnqk4ZI9od1H+YZig+eO
 xS9+1pw4MP+/ZqJzwqJeC1pLHksGIMqF2O1NzZMQ7iOPGmYgr7+17qnNK5+34c24qliFKgnQX
 RvCSa5Wt0HTih3oW4Mt8VkbcEUMcTdc6TBLDQGuWKNsWaOGyKivtIlXZ07aCsNtisgSXtBRAM
 kFaCShTN1dA4VL+2KN4AaEcozCVYTyk5eYWW3QN59L8axOPJ1yox4Bn7hbVl2P/wBPtVCnAp1
 4IwQKxtMxsocdYwAg4=
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3577
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/bz4WdjSbj0ug81J56dRk6w>



Am 16.06.26 um 09:19 schrieb Julia Lawall:
>=20
>=20
> On Tue, 16 Jun 2026, Markus Elfring wrote:
>=20
>>>>> Is such a number suspicious together with the information =E2=80=9C9=
620 files match=E2=80=9D?
>>>>
>>>> I adjusted the implementation of the function =E2=80=9Cdisplay_data=
=E2=80=9D another bit
>>>> so that a questionable condition can be checked and displayed directl=
y.
>> =E2=80=A6
>>>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle>=
 rg 'hit' list_selected_duplicate_statements_in_if_branches4-20260612.txt =
| wc -l
>>>> 254
>>>>
>>>>
>>>> Such a number looks more promising for possible update candidates,
>>>> doesn't it?
>>>
>>> I don't know what your semantic patch does,
>>
>> Why did you not forward original background information to the mailing =
list
>> for Coccinelle so far?
>>
>> 2026-06-14
>> https://lore.kernel.org/cocci/bd197670-dc1f-5c82-2bf-9e6316b29da8@inria=
.fr/
>> https://sympa.inria.fr/sympa/arc/cocci/2026-06/msg00010.html
>>
>>
>>>                                             so I don't know whether th=
e
>>> result is useful or not.
>> So I hope also again that the following SmPL script variant can influen=
ce development ideas
>> in desirable directions.
>>
>>
>> @initialize:python@
>> @@
>> import sys
>> delimiter =3D "|"
>>
>> def display_data(fun, source1, source2, x, y):
>>     sys.stdout.write(delimiter.join(("info", fun, x, y))
>>                         + "\n")
>>     place1 =3D source1[0]
>>     place2 =3D source2[0]
>> #    if place1 =3D=3D place2:
>>     if (place1.line =3D=3D place2.line) and (place1.column =3D=3D place=
2.column):
>>        sys.stdout.write(delimiter.join(("error",
>>                                         "same position",
>>                                         place1.file,
>>                                         place1.line,
>>                                         str(int(place1.column) + 1)))
>>                         + "\n")
>>
>>     else:
>>        sys.stdout.write(delimiter.join(("hit",
>>                                         place1.file,
>>                                         place1.line,
>>                                         str(int(place1.column) + 1),
>>                                         place2.line,
>>                                         str(int(place2.column) + 1)))
>>                         + "\n")
>>
>> @searching exists@
>> expression e, x;
>> identifier item, rc, work;
>> position p1, p2;
>> type t;
>> @@
>>  t work(...)
>>  {
>>  ... when any
>>  if (...)
>>  {
>>  ... when !=3D rc =3D e
>>      when !=3D item =3D x
>>  kfree@p1(item);
>>  return rc;
>>  }
>>  ... when any
>>  if (...)
>>  {
>>  ... when !=3D rc =3D e
>>      when !=3D item =3D x
>>  kfree@p2(item);
>>  return rc;
>>  }
>>  ... when any
>>  }
>=20
> So why do you think that the number of relevant files diminshed?

I find that further development considerations can become more interesting
also according to the presented checks for source code positions.


> Coccinelle informs you of what tokens it has considered, but I don't thi=
nk
> you included that.

Which data would you miss at the moment?


> Furthermore, it seems strange that you declare rc to be an identifier.

I obviously restricted the source code approach so far.


> -ENOMEM, for example, is not an identifier.  It is an expression.

This is fine.

The detection of duplicate error code returns can eventually be achieved
with another SmPL script variant.


> And you still have no checks for gotos,

This is intended so far.


>                                         so you will still get cases wher=
e
> both kfrees are on the same line.

I hope also that further case distinctions will become helpful for corresp=
onding clarifications.



>                                    Another approach is to just adjust yo=
ur
> python code to discard such cases.  I see that you do that already.

Interesting =E2=80=A6


> But why not just ignore such results instead of complaining about them?

I see opportunities for corresponding data processing improvements.


> Is there really nothing like printf in python?

There are constraints to consider for the application of such programming =
interfaces.
https://docs.python.org/3/library/functions.html#print


> sys.stdout.write(delimiter.join looks very primitive.

See also:
https://docs.python.org/3/library/sys.html#sys.stdout

Regards,
Markus
