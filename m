Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D26CC77B6E
	for <cocci@archiver.kernel.org>; Sun,  9 Apr 2023 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Z7RnORVTfD+zTzM5jfDN98WqYTpK457wWIVBrtP+Q68=;
  b=h9++gSnaobJq2eADHfgzO+ezsHfdwVMuVjg1/ojlFyyiBy3TNat3nO4b
   tzIkLBVH4/WRsh86Z3TMbnhaWQI1GdeDViaqhyrHQgUCsTX2FkFaC0E4e
   qGUSB+7JAu7ZA5Gelwf46bEykRgnSq+oXlrcNH0/xnH8iyp/Oh9deKgNx
   I=;
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
X-IronPort-AV: E=Sophos;i="5.98,331,1673910000"; 
   d="scan'208";a="102222747"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Apr 2023 20:41:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 06C58E7312; Sun,  9 Apr 2023 20:41:10 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6255DE72F8
	for <cocci@sympa.inria.fr>; Sun,  9 Apr 2023 20:41:04 +0200 (CEST)
IronPort-SDR: 643306bf_EHkdORDE01H7A1Ksv8ZH2xAfaXzwKdqJhrkTFxWeDP6sV9g
 w3jW7kl8B9NV54UtpvkofbPI7xgcGX3Jkw6E+Xg==
X-IPAS-Result: =?us-ascii?q?A0E6AAC4BTNkh07ASNlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIHoolgx2HLoc+iGuBVoFAPg8BAwENQQECBAEBAwSCC4JqC?=
 =?us-ascii?q?gKFPQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABA?=
 =?us-ascii?q?QEYCxcHDhAFIoVoDYI3IhlkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR?=
 =?us-ascii?q?z4DAyMEGQEBEScPJQImAgJXBwwIAQGCeoIoAQMxB6sCfzOBAYIIAQEGgmOZK?=
 =?us-ascii?q?B8sIlSBXgmBFC0Bh0oeWIRJhDAnD4FVRIEVJwyCQAcwiF2CZ4EMjVqKW2qBN?=
 =?us-ascii?q?HSBIA6BPYEEAgkCEWuBEAhrgXlAAg1kCw5vgUmDKgQCFC0lBA4DGSsdQAIBC?=
 =?us-ascii?q?3U/NQkLHwZYawIsERMFAwsVKkcECDgGGzQRAggPEg8sRA5CNzMTBoEGCw4RA?=
 =?us-ascii?q?1CBRgSBCIEBBkudYgpzgQ6VbLA/NAeCKoFWgVkMiGuWIgYTL5cJDgaSJZdzI?=
 =?us-ascii?q?KI9hUKBYzqBXDMaJIM2TwMZD44gGYQMj0g/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23:6klSxxXQPlkauGz+mkOSElR58AfV8KyKXzF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB9idsaIcwLOM4+jJYi8p39WoiDg6aptCVhsI2409vjcLJ4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTajYb5+N
 gu6oAbNusUZnIduNKU8wQbVr3VVfOhb2WxnKVWPkhjm+8y+5oRj8yNeu/Ig885PT6D3dLkmQ
 LJbETorLXk76NXkuhffQwSP4GAcUngNnRpTHwfF9hD6UYzvvSb8q+FwxTOVPczyTbAzRDSi8
 6JmQwLmhSsbKzI09nzch8pth6xZvR2hvQRyzY3abo6aOvVwY6PTc80URWVDQslfWDdMAp+lb
 4YVE+YNIehVoov7qlATrRW+Hw6sBOb3xzFPnHD2x6460/k6EQrb0wIgG9wOsG7VrNXzO6cZT
 Oe4wq7SwjXZbPNWxCz95JLHfBAlr/GMR7NwcczeyUQ0GQLKkE6fpZb4MDyLz+kAtXWQ4OV8W
 +y1kWEntx1xrSa1xscqkoTFm4YYxkzL+yh43Is4J922RkB0b9O6DJZdtSGUOoV2T80iR2xmt
 zg2x7MbtZKmfiUH1IorywDQZvGIcYWF7QzvWeCMKjl7nHJoYKyziwuw/ES6yODwSNO43EtOo
 yZbiNXBtHMA2wTX58WIUPdw8Fqt1SyM2g3d8O1JIk45mKzGIJA72LEwjIAcsUHbEy/2hkr2i
 KiWe10h+uiv9uTnfq/qp5GCOIBvkA3xL7ohltS+AeQ+LAcOQ3CW9fqh2LDh50H0QqtGgucrn
 qTdrpzWP8YWq62hDw9QyIkj6hK/Dzm80NQfmHkKNFVLdwidj4jqJlHOO+r0A/i7g1Siijdrx
 vbGPrL6D5TDMHfMi63tcqtj5EJEzgo81shQ54hIBbEZPPLzRkjxucTFAhMhKQy73/7nCMlh1
 oMZQW+AHqiZP7/Ovl+J/e8vOOmNZIoNuDnnMfQl5vjujWU4mVAHZ6Wp04EXOziEGaFtJE6SY
 FLthM0AGCEEpE52T+HwjlCGFDxaYXeuWLgnzi80BZjgDorZQI2pxrub03SVBJpTM0VPEFORC
 j/Fc4ueWvEDIHa3K9VijydCeLyvUY4n2jmxuQW8x7cxfbmcwTERqZ+2jIs93ObUjxxnrVScb
 uyY2mCJFSRvm38QAiUx1+Z5qFB8zVGK1e55heZZHJpd/aABSR80YLjbyeEyENXuQkTZZN7cb
 V+8Qci9Rxw1QMgwxdAmfEt3Xdmv3VjYxyT/O7YOjPSQAYAstKfV3nz/PcF4nlPPzqo8lB8LR
 sVVNGuprrFy/U7fCt2BiF2XwoCtc6lUxyvR7CGDwG6J6VlfSxJ1WL7ZUGo3Y0zLsZLm60mEQ
 7LG5a0PFAxHxIbCL6JLboesllBaXLL5P9+YZWutmmC2DBLOx7WWbYOsdX9PlCPaQFMJlQwe5
 xPkfUA3GzuhrmTCDTdvCUOnYkXi9vN7oW+6SUl8xh+Dbklo3b64shAPgvnUR/QW17MC8CAvz
 lc8VHO0xdHLEJytowR7faNTScww6hFL2CORtgBwOIChM7E3nkQXIEx8u0Lj0QkyC50Vy5F16
 ixwilMjc+THgAAkFXvQx537N7zJJ3On+Rmub/STwVTCyJOM/axJ7v0kqlLltQXvF0w48nwh3
 cMGthnUrpjMEgcWVor8F0gt8B0v7ZTTeCog/MX50XN2MK+7miDP0ZQlCaF2r3ToN8caK66CG
 ALoRoc/DtKtNfdstlyndBMCM8hN+aRyM87sJJ7kkOa7ee1nmjyhl2FO5otwh1mN+yRLQenNx
 58Zwvuc02NrTh/EhUy6+oDykIFAP3QJG3anjDLjD8hXb7FzeoACDSGvJde2z5NwncylV3ld/
 V+lT1QIva3hMT+bdV/gxkt90UoNoHqosTS1xXp4nnklo7Ge0yrH3+n5PEBeZSgUHi873A2qf
 tj8hstSREWyagk1iBapgCSyj7NWoqhyNSibQEtFeTT3M3A3V6KxsrSYZMscoJgssChRTKG9e
 QXAE+G7/EFcinK5WTQOl1VZP3mwt570ngJ3kjeYJXd39j/CfN1ogA3Y75raTOJQ2TwPQG95j
 yPWDx6yJYrMn53cmpHdv+S5T2/kWIdUdHyh6Iqatzago0BuDwe+mf+bhdDtVwQ3m3yetZEiR
 WDToRDwb5O+nYGzK+F6ZQ9FAFHm6sx1Mp5zmM08idtDvBpSzoXQ9n0Bn2DpNNxd0q+rd3sBS
 wkAxNvN6RTk0klufTqZgpj0XXKHzo59dsG3NykIjzkl4ZkAW8L2pPRU2DF4qV2ioUfNbOhhy
 30DnOA25idSgvlV6lB0lGPHWO9URBMGe3W2x1PSsrXc5O1WfDr9K+HqkhAkwpb4Uffa5VsBE
 HfhJsV4RHU2tJ8gdguTliW0sN6secGMP4hK6VvLyVGZ3rITcs5h0aBb4EgvcWPl4S91kahi0
 0EohMzr+tDAcTsl/brlUEQBaXuqPYVJom6r1eEEwY6Xx9z9RMw+XGpRGsK5F7T2THVI65GFf
 06PCGFu+i3dQOSCW1XFuQE/9CqHEoj3ZSHNYiBHkJM4H0HbfhYXxQkQWH9ScocRMAesyYShd
 U544mpU/Vvksl5WzekuMRDjU2DZrQPuazEuSZHZIgAEpgdFr1zYN8CT9IcRV2lR44GhoQqRK
 2eaexUADGcHXVaBDkziOb/m7MfJ8uyRDO6zZ/XUZrDGpetbXvaOjZWht+kuty6LLdmKN2J+A
 ucT301eQTZmFs6flzhOAy0bmiTRbtKK8Rex/ioky6L3uP/vWQ/p+c6OE+4IaIoppErw2PbZc
 bHA10MbYX5C25gBxGHF0u0a1V8W0WR1ciW1VK4HvmjLRb7RnaleC1gabTlyPY1G9fFZvEEFN
 MjFh9fyzrM9gOQyDgIPcFX7mdyyI+EOLXu8MlzvG0uBcriLb26uoYm/ceanRLtcgf8B/QW3o
 iqeGlT/My6rkj70S1awPOsKgCzRb3k88MmtNx1qD2bkVtfvbBa2ZcR2gTMByroxnnrWNGQYP
 FCUnGtSo7fW4S4K252X+kRE6Wd5a/aJkWCV4ruAQn7zmeRmCGJ4mrACiEk=
IronPort-Data: A9a23:jVIkR6xqhoxGhum5VQ56t+dswirEfRIJ4+MujC+fZmUNrF6WrkUGm
 mMdW2qFb6vfZmT8eot2aI2z8BhX7Z7Qx9NmGwI9r1hgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEALjim4c3l48sfrZ80sz5KWq4Vv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPAnMVBIWI1JrdH1fxzM2pPp
 dwmFW8SO0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKlgHsqFGvSQo4AItNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2QA8gjP//VrvwA/yiR165TfbIbaQeCaXMVTxVmai
 0vg/27AV0Ry2Nu3kGfZrCv12IcjhxjTU4UZH7yQ7e9vmFTVx2oJCRRQW0HTnBWioku5Rs4ZN
 EEevCYjxUQvyKC1ZvWibzKVg32fhEEzQd5iGOxqyD+wlbWBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvVONB/jFGGYS/ErObF9lteLQBEcT5bPUfoWCNfu4GLnW0lsv7YZvpOeJNZY/XwHizsh
 S+Hpm4yit3/bPLnNY3qpDgrYBr2/vAlqzLZAC2JBgpJCSskNeaYi3SAswSz0Bq5BN/xoqO9l
 HYFgdOCy+sFEIuAkieAKM1UQuHxtqnVbmeB0QYwd3XEy9hL0yH8FWy3yG4hTHqFzu5fJlcFn
 WeO5FwKvcY70IWCNP8uP9LZ5zsWIVjITIm5CKmNMLKik7AoOlbP/SdyaFSW0nylmUdErE3ME
 cfzTCpYNl5DUf4P5GPuGY81iOZ3rghjmz+7bc2kl3yPj+HEDFbLEuhtDbd7RrtkhE9yiF6Jq
 Ik32grj40k3bdASlQGNod9OdgBUdSBjbX00wuQOHtO+zsNdMDlJI5fsLXkJIuSJRowFyb+az
 WL3QUJC1lv0iFvOLAjAODgpa6riUdw75Tg3NDAldwTgkXUyQ5ed3IFGfbsOfJ4j6LNCy9xwR
 KI7YMmuOKlEZQnG3DU/VqPDirJeWi6lvi+wGha0QSMeesdgTjPZ+9W/cQrI8jIPPxWNtsA/g
 uOB01rFTao6Wgg4Msfybcir7lKuvEoynPB5cFvIL+JyJmTt0tlOAA7ggsAnJ/ojLU34+QKb8
 AKNEzI0lPLosaZs1PXo3Ieq95yIFcl6FWpkR1jr1668b3TmzzDy0L1+X/atVhGDcmHNoYGJR
 /hfltP4O905xGd6iZJ2SetX/Phv9unUhuFoyyp/Fy/2dHWtMLRrJ0eG0eRptqFgwrx4uxO8a
 nmQ++t1aKm4B8f4LGE/fAYVTPyP9fUxqAng6f4YJEbb5igu8oGXDmRUHR2H0xJGIJVPbYgK/
 OYGuewt0TKZtCYECNi8s31rxzy+FUBYC6QDnbMGMbDvkTsumw1jY4SDKyrY46OvStRrM2txE
 AC1mZjturV47WjBekoVCnLi87d8h5MPmRYS134EBQ2DteTkj88N/i960GoIXCFK6C5YwsRPO
 mRPHG9kF5WkpjtHqpBKYDGxJltnGhacxH3U93IIs2/oF2+TSW3HKTwGC9anpUw23TpVQWlGw
 eu+1m3gbDfNefPx1AsUXWpOiaTqbf51xz34tPGXJea3NLhkXmO9mY6rX3QClDX/C8BohEHnm
 /hjzNwtVYLFbxwvs48JIKjE84RIUx2VBn1wcdc49oMzIGzsUjWT2z+PFkOPRv1wN8H6qU+VN
 sg/Cf9MBjKf1TmPpA81HaQjAaF5t9936csgeoHEH38nsbyeomBXsbbVzCzfhXAqcfpqg80SO
 oPcTBPcM22y1F9/uX7Bk9lAAUW8OeI7XQzb2Pun1ck0DLcBjb1cSl4z2b6KoHmlCgtr0BaKt
 gflZaWN7ehd5alzvonrSINvOh6VLI7taeG27wyDidRCQtfRO8PotQlOiF3GPRxTDIQBSeZMi
 rWBn97m7nzr5I9sfTjipKCAMK1V6eGZfuldaJv3JUYHuxqyYpbn5h9b9l2oLZBMrshm2fCmY
 AmGOfuALYtfH58XwXBOcCFRHioME6m9PO+quSq5qO/KERQHlxDOKNS873LycGVHbWkyNobjD
 hPv8eObjjyCQF+g2Ddfbx2nP3N5HLMnca4hasG3qjSSSGWl6r9HVn0OijJ4gQwnyFHdeCo53
 X4BbgfzflK+tckkCflH5pdqsER/4GlV2IENk4F0xzKyoy+3BigKIIzx9HnA5o58ykTP6X0zW
 N0BgKbOx8kwsfSovCgQOOjeYzo=
IronPort-HdrOrdr: A9a23:ZmZXLq1BzKYXCN550MEJRwqjBGwkLtp133Aq2lEZdPUnSL36qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFg7X5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,331,1673910000"; 
   d="scan'208";a="102222744"
X-MGA-submission: =?us-ascii?q?MDGOHpYpbtsumB0bjqIrYrQL3tAuIttb7tQy0n?=
 =?us-ascii?q?m9gdE5+0m0VMeK2NN+rykXSuxXlG14gWXWn02Izyy3DQ1O89W9B7SmUP?=
 =?us-ascii?q?SOt4hz/C9+xxlKQ30uEpRfenClU1mYKcCztNFG0F9cAotEpc14GZ7U6C?=
 =?us-ascii?q?PM6xDWRtXd4c/WSvODNwTx8Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 20:41:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681065663; i=markus.elfring@web.de;
	bh=WZz3R8L2wcE1CqxyIbT+kV8hFYbtI5k9RHBGL4aB6EY=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=Nbr/pia4c6o04ad0XcWdv3Qwb8iM3vM7YosX60+e1ofww64t+l5zjUhx1O8ObBRYd
	 ZMLV2Qhvjzw6w9//c9ZuV7ijQ1uam+NFF1NPbzo4ssYSNKFGmxCQKrWa3i9h5XzphY
	 hHIOlxnVpr++1bcGRVTCt6a9E/PmEJvYHJCuquml8XNwWQ6vxwUVVsq8rgdkOLhvHj
	 5aXH/uTO5j6UjwatAOCRRtju1iz0J2i8bQD0fX7DCse8v9dl50Rn8pn35pla1rzhA+
	 e0cJK5KwdAqF44kqsW9iw0mHop+k49MXsiGcnbF1vqSCkHK6cC+OYzo3RGy/MBBzjj
	 MnrdYPtvq9mWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoeY7-1q9hV02K65-00ok0k; Sun, 09
 Apr 2023 20:41:03 +0200
Message-ID: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Date: Sun, 9 Apr 2023 20:41:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
In-Reply-To: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sdtDHNLemm8+BrGIJWjp9b49n1dDufwYCkpOJ5S9blFHPmtodmK
 ZWRGoSmUnK9IA855Q1ucR5xu1A8sSJMDF2wF0UKjnr8zIrUhnGhdRiPtsj0d0d9qQCx1tPv
 VJ1QZtkEIl6/atbUFv5rsUqSZuqFwLmGj0yGJFx+8orO29v4Z1iXtGSfF0hYeccRM4JZZVs
 dkQZiOah4MTndjtcNNIHg==
UI-OutboundReport: notjunk:1;M01:P0:UuKpwCmB+pk=;rJo3JQZL087FgYeRVvOZM9Nw579
 j7cgN80h2pupLEulVaC1u5dRgs1+ecCcVacwLBuaoTD6LL9z+ja60zcub+dzcoDIh6uyPFX+T
 DFqJVdKzFd7fueX7Xc7xpNahkt/16AT4do8ILiP1kZLJ78PEKp1rBbNaxJx4ipFa+OstRDJML
 tTMTX+upA/S3dwy+ryS6L/7+5AiLm/hZ6luXcaMGGy9Iox2VgOMrKJLJvNNFtQ2qUpuNgh3Ss
 sw7Lh4CHCPaXy1wkjBEr+UfEVqWPQ8YMcGAjq/TChLqaiArPfEDrUyoNwPgJnzMk0vKBy8HZ+
 I8i86yzpzjXqIMBPsIhB9YQNeMZTAnt+2pC2oQmES6WTHYAy+9rJqWsi8xRzSLjxlH5kNdime
 s2uyCV3NDLBQjWuKgwD9VuJcCs/plMIXLaweImE5IjShOjkh5JVmfFztDwS12QN/NkwxssfFI
 A/lyjuV4NRoKUjhqtTCHLbEPPxnHJxQsnMhrJIDf96ifjVisxL6tzEV8Mhb9GdTu9zTbsWCzY
 T3BtDFPIOvgqh94bZ+HG738TVcYdTG2JNKUge1DGlQqKGEaDleLowNRppyQ3iiJJgtQF1A5zT
 ISJ9xwp7Ikw8RMX4crtVZEnueSs+dGesvdjUzUib8ZxEqDTZikGW74rHHPZlgyfnUiG/IXQev
 jnH49TZc5g2mffxPfv8NuuLlOrOnzv/qQwJV/kWBzmyQm2l9IwgHmv1yf1HDOdcrNLxmZIfet
 BAvDRctkzAK9WlI5Pl0lNvmYewcQ4QyNEt47K8mwyL/aEb6ggrhCNntOi1QxJ+/tlpKzrKj9H
 DoyCRqFg8Td2SEzo6diCJqK/x6rROjmMF1Ul18CY8R32mWxZBUOXnTewjORyGdmMTw6f1X6S7
 XGjh5PgLF+kQSzAvGLiRyJ7zafIkz7xTJpbGKbtZln0hYLigvbwoo3WAS
Subject: [cocci] Reconsidering pointer dereferences before null pointer
 checks (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1015
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/1a11455f-ab57-dce0-1677-6beb8492a257%40web.de>

Hello,

I tried the following SmPL script out also on the source files from
the software =E2=80=9CLinux next-20230406=E2=80=9D.

@display@
expression action, input, target;
identifier member, var;
type t;
@@
(
*t var =3D \( &input->member \| action(..., &input->member, ...) \);
 ... when !=3D input
     when any
|
*target =3D \( &input->member \| action(..., &input->member, ...) \);
 ... when !=3D input
     when any
)
*if (input =3D=3D NULL || ...)
    return ...;


31 source files were found where it was tried to determine the address of
a data structure member (which includes a pointer dereference)
before a null pointer check.
I imagine that such code should be reconsidered once more and improved acc=
ordingly.

How do you think about to achieve any adjustments in this design direction=
?

Regards,
Markus
