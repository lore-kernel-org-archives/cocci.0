Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E58C433F5
	for <cocci@archiver.kernel.org>; Sun,  3 Apr 2022 08:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LeSbFuzN4Dv3NRXZ6oLbyalIf2cp9BQsgjUGCU91m/Q=;
  b=jjv38r6Pp/UF28OD6hzUVPeCrWuFh4EQNVmS4oGIXIE3lhXL12kn6X1N
   Zyrkpaco9jpFUI8lFmiVwPbHfL29omuyLiSmCNnqL0EyouT52WB6gkMt+
   pkqxlYG4ULFbbie4uHs4m7TulG8dfSJXMj15bKOxVehwWE1AIkFCnAHrK
   U=;
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
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29729028"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2022 10:33:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ADE74E033B; Sun,  3 Apr 2022 10:33:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2541DE00A8
	for <cocci@sympa.inria.fr>; Sun,  3 Apr 2022 10:33:01 +0200 (CEST)
IronPort-SDR: EM74bnNM6+p5TVYg86x0kPe88AlKyP3GjtsnGDCz9ul0T37SjTc1sHIHiHeQghsreb/AtjjKI9
 N07IdJcA2tq3MKCnrgdx/ifaQWA46QzYMOALRoj9LwTvnJp2ebTS12o1UiqCWA+q9yaHFWfQ2K
 SOm5ixcOI+qp1NChe4ViAAxuxBZy9u4eeFy5sXo1/ZWpmYhC2CdcFr9lJRySrrNJRRjNY2zLyt
 IvmN1gC+bCHvux2rtXVSu3cdU00CKA+nm04OmJN4U0Kt1dvvJWL6NIapYJioDeUMcZcuM7TdF3
 UYWt8b4dNhgiX9nACTaOsfqM
X-IPAS-Result: =?us-ascii?q?A0AkAgD2WklihwMP49RaHgEBCxIMQIQCgVUrBAtEhFSOc?=
 =?us-ascii?q?4IoiyaHGowjCwEDAQ1AAQIEAQGCEoJ1AoRaAh0HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDhAFNgZeBmQEgUsEgXQLN?=
 =?us-ascii?q?A2CNSKDbAECAgEjHQEBESYBBAsLDgwCJgICVwYNCAEBgwCCZQEDDSWuT4Exg?=
 =?us-ascii?q?QGCCAEBBoRIHywiUoFcCYEQLI5OJxCBVUSBPAyCdz6HX4JDIphfggIbgWFqk?=
 =?us-ascii?q?jiPQZ5ONAeCEoE6gUIMnhoGFC6DYgGSYg4GkXaWXqcMgXiBfjMaJIM4TgECA?=
 =?us-ascii?q?QINAQICAwECAQIJAQECjh0ZhAyKLT80OAIGCwEBAwmFRwEBij0BAQ?=
IronPort-PHdr: A9a23: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
 SdxeQVBo+/IhR4=
IronPort-Data: A9a23:CoEM7KOaVfMOjMXvrR35kcFynXyQoLVcMsEvi/4bfWQNrUog1zdTy
 GAcDWuCaK3eZjbzet0iYdjgoRsEvpHQnYM2SXM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNfYHpn2EoLd9IR2NYy24DlW1jV4
 LsenuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2qu8lqz
 uVQl6CNTAgIebDxhMAZQgJXRnQW0a1uoNcrIFC6ttGPiVLLeT3gzp2CDmlsZNdeoLwoRzgTs
 6dwxDMlNnhvg8qTyai4V/Iqq8AtNsjtM6sAt3smwTyx4fMOG8GcGfSSv4MwMDEYodJSBtbOS
 +Ula2BwMESRTxofE3hJB8dr9AuvriCiL2MB8Qz9SbAMy2PUxwdw+KP8NcLcPN2MX8Rc2EiCz
 l8q5Ez8BQwGcsOSw3yJ/xpAm9MjgwvYfJsJEo2l1MJXhVKygXEuFDkSREC09KzRZlGFZ/pTL
 Ekd+ywLpKc09VC2QtSVYyBUsEJorTZBAoABQrZSBBWlm/aFul7x6n0sFGYZAOHKovPaUhQG+
 ze0cz7BADtyrPuKRHjb+rr8QdKO1co9fTBqicwsFFVtDzzfTGcb0EunojFLTvfdszENMWusq
 w1mVQBn71npseYF1r+g4XfMiC+2q57CQ2Ydv1uLDjP/slkhPNX5NuREDGQ3C94ffO51qXHe7
 RA5dzS2t71m4WylyXDcHr5XdF1Xz6zZamGG6bKQI3XR323wpyD6JN44DMBWfQkwescCZTLzZ
 kLP8QpejKK/z1P6BZKbl7mZUpxwpYC5TYqNfqmNMrJmP8YtHCfaonAGTRPBhwjFzRl3+Ylia
 MfzWZj2UR4yV/89pBLoHLh17FPe7ntjrY8lbcunlEvPPHv3TCL9dIrpx3PVNb9ptPrU+VqNm
 zudXuPToyhivCTFSnG/2eYuwZoidBDX3Lj69J5acPCtOA1jFD1zAvPd2+1zZIFv2ahYz7+a8
 na4U05e6Vz+mXyedVTUMC8+Muu3UMYtt28/MAwtIU2shSopb7Gv26FDJZE5Sr8qqb54xvluQ
 vhZIMiNW6wdSjnO9zkHQ4P6qYhuKEaiiQ6UYXi6bTJ5c5M5H17F/drtfw3O8igSD3Pr5JVk/
 OD6jlvWGMNRSR5jAcDabOOU42mw5XVNyvhvW0boI8VIfBu++oZdKxv30q09LfYKJEiR3TCdz
 QuXXUwVqOSR8Y849N7F2fKNo4uzSrIsG01HAy/E4LzwOSSDpjivxopJUeCpezHBVTqoqfv4O
 rgPl6nxYK8dgVJHk4tgCLI1n6gw0NvYoeMIxApTGniWPU+gDaltIyXd0MQT5LdBwKRV5Vm/V
 k6Vo4AIPLKUJIX6HVRXKAd8NraP0vQdmz/z6/UpIRymtXEto+fdCR1fb0uWlShQDLppK4d7k
 +0vj84h7VDtgBQdNNvb3Dtf8H6BLyBbXqgq3n3A7FQHVub2JpB+jZ3g5uve5ZaSd5NTP0NsL
 jL8aG8uQVhD7hKqTpbxPSGlMSlhaVAmpx1AilMPT7hMssSQnec5hXW97hxuJjm4DXx7PyZbJ
 WVhcUF4TUlLE/GEm+AbN12R98p96NF1N6A/J5blVIEUcqVwalHwEQ==
IronPort-HdrOrdr: A9a23:N4SsF627X1wGInjCCRXbpAqjBJYkLtp133Aq2lEZdPWaSL3+qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SODUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyUMbEQt6bHCWeDYrQdKZW8kZxBno3lvgxQpOxRGttdBz4SMHfnLqX8KTMtOaYE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29729024"
X-MGA-submission: =?us-ascii?q?MDFpgUdSUcKCkQWdbHgQ4N/fgW8hQ2Ibsiw/xn?=
 =?us-ascii?q?fvxqyBqYqamHTdopIglD0Pd6bIuTX7moYiQCs5SNCEdf4xrgAPJ7ZyAP?=
 =?us-ascii?q?B2nB/O3o4O/TtIj+wcRYUDabs6zdkt05HxjdUyMZZmk9sFg9e11TG3SP?=
 =?us-ascii?q?yvIVrnBnbfsyvsrIUww52Kag=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 10:33:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648974780;
	bh=LeSbFuzN4Dv3NRXZ6oLbyalIf2cp9BQsgjUGCU91m/Q=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
	b=fbb06oOVyrSj1ftWC77nx51+37uOQDzo9tt8V/NbQiftLWS6MP0aq8lf4FxiVelzD
	 Z6Ov94i0/nFDljKSAKwPTmCIQnu8JwN5/dRUrhNerrhDAt09zukYMjEudckeviitO4
	 qths3h+d+XnxnQK8U9y5xd4uotrUuLwO1dH8ZnZI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.114.24]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43GO-1navfP3xD6-0009Dh; Sun, 03
 Apr 2022 10:33:00 +0200
Message-ID: <ec394f75-0210-a741-1c85-a1a8e18a715e@web.de>
Date: Sun, 3 Apr 2022 10:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net>
 <alpine.DEB.2.22.394.2203192038220.3204@hadrien>
 <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net>
 <alpine.DEB.2.22.394.2203200732590.3429@hadrien>
 <ac254b9c-3923-5b7b-5d56-564d50e06760@ewheeler.net>
 <alpine.DEB.2.22.394.2204012224060.3048@hadrien>
 <5f832bd0-37e2-3417-df60-4cdbc5cf5fb8@ewheeler.net>
 <alpine.DEB.2.22.394.2204021940530.3208@hadrien>
 <859aa8f6-9b42-b114-bbbc-2964dd47248@ewheeler.net>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
In-Reply-To: <859aa8f6-9b42-b114-bbbc-2964dd47248@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tF/7MoKPj8HVjI688/Cx1LDoT/0IPCn1QY57pa7IHZ079XyGlEq
 kyqLYzBPbUCPgcLo5v2xo6V0OonmQeIKzNKL/MAglEdCjMWI+hr4JoT6u0mBlY2/ZKZ6DRV
 ov46D8aeUnrRMaqDWbUZ4w9BJ5xFF9j9SMYBJtGvCg4t4mGwq7loOD5tBM8JoYl2GFPnyOA
 c/Y6hW/K/wgEAl+QQA3+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wKe5kSCuqN0=:/txxTMmGq/rRLYLmte7cBz
 Z3xNA4+cQAwcN9nALRUzjVrpIjO8lUxaRCLPHJNLKH0roNwhqSODf+1MoAqx/cJVvDzc5yVFK
 DFQTrMVswTo1zymg3Js6ijpwrzBJjmvjAk9wxrbBUl2/DNDhC51GTjCVqgOrSi3qHw+ThhDPg
 HHzMQvJjEmHEhqX8zWVgOU/nS4APh6CLierJeEfyvUQhfBQjVPjrBbNGHbHgvRtH9/kiOFBMx
 qvQ5z/pKMFSX5z4z+y1rr6cYcMVGf8Doj4VKHRNrnZKDmXexYXdDDdRuBY4pjTC810qmKdN5x
 mvP3n+4tsChY790E3khW369fLw/1xEJ/6Jy9B8C4mPJgEUuR2CegJKdgAW7mc3fE64nzZbv8+
 IBtshRXlk5Rx5B7eZdNzVUH5fGl4XfzBIc6VTVzck0L4olBLb8meiFVMeZGeXlPZXaJPzl/Jh
 00u+oFWBXjO85KiSUZ33OoD5ec5+hXsQSYDdlLQIybDAu1iOAa4xpoyuygqy121e3SmlUWalJ
 B/wBuGo9XAyEYoxX0nT48oM7vhKQ+LlGCQz/q5mJvaHj+wsZ2pXdP7wpL2nwp3c8n0xnlYHWY
 cWiwwADSMmNIe+vxXGXABm7ZWgFEtrpOoESwX/MsHLDo0NHnLQ0pkA4/I1ByOJ4AdbA83+pNi
 6GJZnIytWvrE6AwdnF0YnqPhELEiWQkTLxDE2zuQB66J5sUALt4DGlCeavnwBaVmJAHeQ+1fL
 YnwbjZOQB2CLQsGitpynNf8dld8swLeJ7wMdhKn84sHAEv4REklGXs7KMU9m6F0eqZkKQzIZj
 YA+GPohdTxJl/qU/nKDzkFMW6qH9ClY9zeqS5HydNqHEVFdeYBlhDLfqhCGZ38THEfXfCX2Tr
 8sli6WXDNpD9IC5xfRBamvcm9O0nk1PzBAmpXKFWFgmVPdW57b2OVCBYPFCwfJq4c8I3OJzaJ
 ZNfF8hI7OY9T1upJadYjGFR9ETAOPO7Urt1NwYjimTwBZRNL9/uAJFjsJlLeApQTFMvHN0H60
 /lezJh/pcEdJrj61CA74whyGtqMQfqrGCLN6RODKNpVYGAk+6RnzypZe8hmEohKb5kXs7plc2
 DZHwCNrS8aU67g=
Subject: Re: [cocci] Using `parallel` to run over lots of .c files
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 346
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/ec394f75-0210-a741-1c85-a1a8e18a715e%40web.de>

> Ok, then maybe I'm trying to optimize something that doesn't need optimized.


Your understanding is still evolving also for the supported functionality of
the Coccinelle software (and corresponding program parameters).

The run time characteristics might be good enough for your source code transformations.

Additional development ideas can be shared for possible adjustments of implementation details,
can't they?


Regards,
Markus

