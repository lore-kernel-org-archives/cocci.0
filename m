Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE260C433F5
	for <cocci@archiver.kernel.org>; Sat, 12 Mar 2022 13:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=5a2S0lV3QrPpXTvgN0GKeORDte/n6yFVAPMzWFzJvfI=;
  b=KWf644JxNYFkFLc+45JklamgU+zXraIemsUf1UELDd/OEh8fyYdf6MyH
   iPUy4xawVrE0LR5BxVtggRuVIvbLHjjOq/McnR7HcgMakdmqiZgaF1VVT
   UINSm3eK4uAS1QBHsJ+G83dKE99+8UYq4vOQ2KTAEqIwIN9VHSZt7M/Pk
   s=;
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
X-IronPort-AV: E=Sophos;i="5.90,175,1643670000"; 
   d="scan'208";a="25791755"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Mar 2022 14:38:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AB9DAE0048; Sat, 12 Mar 2022 14:38:57 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 68BA9E0045
	for <cocci@sympa.inria.fr>; Sat, 12 Mar 2022 14:38:51 +0100 (CET)
IronPort-SDR: ZWTZz8qHd45WvMSbwpFBSDrKD9W9qjc7lIQXIom7BYoHIvh4VoFKlZV08+zRhBdTC696GbPGI+
 SzOOzpKUAUrVhdUPk8cXMlYGl87teVuJEifz+Y8dmGMCIC3seNkD89wPO3RYvjxDY8SbFAMUNz
 Iu6qKZQQzLbfxQIp3VydBOVdDLw8veEAvFmbbQ3UnOM5N+TPHeoUn8Z4O33r+cVWBbT1e/aGHn
 yJ9z3vMNamUcrPKA3lzfmdQ8ycsx9DSNxt0FObVkjInxjcrRasp6X94fB4TrmJ2t0E0bvsP4DP
 7mWd6BYg/AbFDOYlcCndA3rM
X-IPAS-Result: =?us-ascii?q?A0CBCADHoSxihwMP49RaFnOBXAGBOQIBAQFnaRVXKwQLR?=
 =?us-ascii?q?IRUkGounl4LAQMBDRIBASUFAQIEAQGCEocbAh0HAQQ1BQ0BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIDBAETAQEBDA0JBQgKBw4QBTYGXgZkBIFLBIF0C?=
 =?us-ascii?q?zQNQAEBBAsBgWMihBUdAQERJzQCJgJsCAEBgwABgmQBAzILriuBMYEBgggBA?=
 =?us-ascii?q?QaBPwETQUiBbB8sIlKBWwmBECoDAQEBAYYPFEKIBRCBVUSBPIYZCwEBAgGCK?=
 =?us-ascii?q?oJNgmWWNlOBAVgBgh8SkjsREK1aNAeCEoE6BYE7C4gigR2UTAYULoVBkHkOB?=
 =?us-ascii?q?pFplleNE5QwhTiBeYF9MxokgzgJRQECAQINAQICAwECAQIJAQECjjaDWTOBC?=
 =?us-ascii?q?4NWhUtANAIJLQIGAQoBAQMJhUcBAYIWggyIegEB?=
IronPort-PHdr: A9a23:cLQ9yheBSQmINUr0/Cd9Vin6lGM+5tTLVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWTG9yBt7kZ0KL/iOPJYSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNfQlEniexba19I
 Rm5rQjcuNQdjJd/JKo21hbHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2U
 bJXDDI9M2Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VDK/5
 KptVRTmijoINyQh/W/UhMJ/g6xUrgyhqRJi34Hab5qYNOZnfq7HYd8WWWRMU8RXWidcAo28d
 YwPD+8ZMOhftYb9vVgOrQalBQKxC+3vzjFIhmX33a083OQqDAbL0gs6ENIUs3TUsc71OL0dX
 +CxwqnI1zTDb/VZ2Trm5onHbAsureuRUr1uaMfcz1QkGAzZgFuKs4PlIy+V2foXs2id9+dtV
 OOihnMppQxsrTahycMhhIfXio8V113K+jl1zoY6KNC5SEB3fNGpHpReuS+VK4Z7QMMsT39mt
 ig6yrALpZ61cS4Xw5opwB7fbuaIc4mO4h/7VeaRJy14hHN/d76liRay61CsyuL9Vsmo0FZKs
 zFKnsPQuXAK0hzf8saGSvp+/kegwTaAyR3c6uBeLkwukqrbMZEhz7gtnZQQqUTOBjH6lFjog
 KOMaEko5Oql5/76brjmvJOROZd4hh/kPqgwlcGyDv40PhUBUmWa4+iwyr3u8E3/Tb5XlPM5i
 LPZv4rfJckDpq62HQtV0oE75ha6CDemzcgYkWMJLV1bYx2LlZXmNE/WLPD5C/ewnUisnS91y
 /zbILHtGIvBImbBnbv7YLpw61RQxQQrwdBa/Z1UC7UBIPzpWk/2sdzVFhg3PBauw+bkFdV9z
 ZkSV22LAq+XKqPSsFmI5u00LuiCeoAaoyzxJOU76PL2i382gkcSfbO10psPdHC4AvNmLl2Eb
 Xb0mNcODX8KvhYiTOztkFCNTTlTaGquUKI9/Tw7E4KnDYLbRo+3mrCB3SG7HodXZm9cEFyMH
 23oJM24XKIHbymZI+dglCYFXP6vUdwPzxar4Srz0bl6NaL5/iMCtJTsnIxQ7vfQiAp02Dh6F
 cWb3EmSQmsykm5eFGx+57x2vUEokgTL6qN/mfENTbS7httMWwY+b9vHyvBiTsr1UUTHd8uIT
 1CvRpOnByswR5Q/2YxGeF5zTvOliB2LxC+2G/kNjbXeIZUu8b/HmVX1Kdx8zXnuy6QryVUrE
 YNULWPzvqdk7EDIApLR1UCQlqKkb6MZiQvE7mSe1iyjuE9CUQh/ebrIVzYTaxietsz3s2XFS
 bLmErE7Kk1BxMqFf7NNccHshE5aSe3LPdPDfySulm32CRvgKqqkSo3sdi1d2SzcDBJBiAUP5
 TOcMgN4AC69omXYBTgoFFT1Ykqq//Ms4HW8BlQ5yQ2HdSgDn/K85wIViPqASvgSwqNMuSEvr
 C9xFUq82NSeAsSJpg5odqFRKd0n51IP2WXcvg17dpuuSsIqznsXaQdqpAXD0xttC4NPudcnp
 jUmwUs6KK6V1k9AayLNxYr5afXcLmj/+gzqaraDgAiElozMpeFWtbJj+DCB9EmzG0Ev8mtqy
 YxQ2nqYvNDRCRYKFIj2WQAx/gR7oLfTZm884ZnV3DtiK/rR0HeK1tQ3Ce8i0hvlcc1YNfbOM
 QboENABQeWqJvYrnVeBcR8Oeuxfvv1RXYvuZ76d1ainMfw11hevl2da+8ZQ1kyW9ixzYvHF1
 dAJzrvLu2nPHye5h1CnvMftnIlCbjxHBWuzxx/vA4tJb7Fzd4IGYYu3C/W+3c42x5vkWnoCs
 UWmG0tDwsiiPxybc1362wRUk0URu32u3yWinXR4lDQgr6zX2yKroayqURMdOXNQAkRmg03tJ
 4eckN0QGkSlJwQkjxqq40/myrMT/v0laTOJHgERIm6tZ2h5GrO9rL+Df9JC5PZK+W1MXeKwb
 ErbAr/xrh0G0j/ySm5XxTQ1bTav6d3ymx13jn7YLW4m9iODP5sqmlGGuZqHFpszlnIcSSJ1i
 CfaHA25Ntitp5CPkovb9/q5XCSnX4FSdi/iycWBsjG67CtkG07a/bj7l9v5HAw9ySK+2cNtU
 HCCiR/mYZTwkYm+P/hmeEZAG1L2rcZ3UNIb8MN4lNQL1H4Wi4/At18Oi2TuKpN23azkbXwCb
 SEGyZjZ7UK2vS8rZmLMzIX/WHKHx8JnbNTveWIa1BU26MVSAbuV5rhJzmNl50C1pgXLbb1hj
 y8QnLEwvWUCjbhD629Phm2NR6ofFk5CMWnwmgSUupqg+b5Paj/ncKDshhAnx5b7Vu7E+1sCH
 i+jKtB4QEoSpo1+KA6eiiSprNu+J5+JMJRL8UfJ2xbY07oPcch3zKBVw3M4fzq65yJtyvZn3
 0Y3gtfl5s7eej8rpv7pRUQJU1+9L8ILpmO91+AHwJvQht3+WM0mQGtDXYO0H6jxT3RN77K9b
 1nISHpm9T+aAeaNR1bArhg86SueSdb1azbNehx7hZ1jXEXPdBYZ2V5JGm9gz9hgTVjixdS9I
 hcjoGlPuxii8UMKkLggchD7Vi23SB6ATDAyRdDfKRNX6lsH/ELJKYmE6ek1GShE/5qnpQjLK
 2qBZg0OA3tbEkqDT0vuOLWj/7yiu6CRG/a+Iv3SYL6Ptf0WVvGGwoiq25dn+DDEP9uGP31rB
 fk2kkRZWnUxF8PckjQJAysZ8kCFJ9acvwu58zZro9qX9fP2RETw6IHJB7YTedRj9haqgLuSY
 u6dgCEqTFQQnpgIxHLO1P0exAtI0nsoLWPyV+1d83WeKcCY0rVaBBMadS5pYc5B7qZmmxJIJ
 daekNT+kLhxkv8yDV5BE13ngMCgI8IQcATffBvKAliGMLOeKHjF2cbyNOmZQKdTkf4Smhm+o
 zedHGf8Mz7FmzSjBHXNealcyTqWOhBTotT3ahF2FW3qV87rcDW+N8JryyI7y/s4izmZUAxUe
 Sg5eERLoLqK6CpeifgqAG1N4E1uKuyckjqY5e3VQn75meRmCGJ4mrADiJzf46RY5mdISa4t8
 MMzhttpvk3gjeSFjDZqAkImlw==
IronPort-Data: A9a23:D58XwqMDxxo4pX/vrR2MkMFynXyQoLVcMsEvi/4bfWQNrUoihWMDn
 WQaCz+CaancMWSgf9wgbtm18RtX6MPTx9I3QHM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNfYHpn2EoLd9IR2NYy24DiWlnV4
 LsenuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB23tvdS8
 v58tqXoagYFZI3OhrUNbTJHRnQW0a1uoNcrIFC6ttGPiVLLeT3gzp2CDmlsZNdeoLwoRzgTs
 6dwxDMlNnhvg8qTyai4V/Iqq8AtNsjtM6sAt3smwTyx4fMOG82cEvyVuIUwMDEYqvFLD+j6d
 e4jezNFYwjyPxsSIUoXF8dr9AuvrjymG9FCk3qeoqE84kDI3Qlp2f7sNsDUc5qEX61ocl2wo
 2Xb4yLmDxtcONH3JSe5HmyEuMbovhnQaYErTJ652qRKgkPC1lI4F0hDPbekmsWRhkm7UtNZD
 kUb/CsysKQ/nHCWojTVWhqlvDibsxRaV9c4/wwGBOOlmva8D+Ol6o4sEGQphDsO6pZeeAHGL
 3fQ9z8TOQGDRIa9ECrHnp/N9W3aEXFMcQcqOHFYJSNYvYiLiNxi1nrnE4c4eIbo342dMW+rm
 Vii8nNh74j/eOZQis1XC3ic32nzznUIJyZpjjjqspWNtVooOtT6O9T2tTA2L59ode6kc7VIh
 1Bc8+D20QzEJcjlePWlTLpfEbe3yeyCNTGA01djE4N/pSug8TivcNkIsj15IU5oNOcCeCPoO
 ROC51kOucULZHb6P7VqZ4+RCtgxyfayH9rSVsfSMohEbK93eVLV5yppf0ORgzvgnRF0w6EyM
 JuWa+i2CnMeBfg1xTa6XblPzrIhgCwznDuBSZf+xhWh8LyfeH/MFeZbagTTNLhh4frd8gvP8
 ttZO8+b8DllUbXzMnvN7IoeDVEWNnxlV5r4nMxgcLLRKARRHmx8WeTaxqksetA+kqlYyrXI8
 3W6VhMKwVbznySeewCNd2wld77lG5py9CppMSspNFeu+n4ifYf2sPZBLcRqJ+F/+bwx1+NwQ
 tkEZ96EXKZFRAPHzDJBP5Pzm4pvKUawjgWUMiv5OzUyI8x6SwrS9oO2dwfj7nBXXC+wqNd4v
 LCqkA/WGMJRSwNnBcfQSfSu01Lo4SlDwr0vBROQL4kBYljo/ahrNzf10K09LfYMHhOflDGU4
 ACbXEUDru7Xro5pq9TEiMhodWty/zeSw6abI4Xa0VpyHSzd43bl3oJKFuqFFdwYuKUY5436D
 di5DdmlWBHEoLqOm5VxGfBnwMrSIvPx8qRCwF0M8GrjNjyW53AJHpVC9dZCvOtBy9e1fOdwt
 l2norFnBFlCBC8p/JP96ubogiRvGMz4QgXv0Mk=
IronPort-HdrOrdr: A9a23:v+qk066LPmemkqK0EgPXwPrXdLJyesId70hD6qkDc203TiX+rb
 HIoB17726RtN91YhodcL+7V5VoLUmsl6KdgrN+AV7BZmXbUQKTRekO0WKI+UyEJ8SRzI5gPO
 tbEpSXE7fLfD5HZCvBkXCF++9L+qj+zEgi6N2180tQ
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,175,1643670000"; 
   d="scan'208";a="25791752"
X-MGA-submission: =?us-ascii?q?MDEgnIg5PHZedYsOgpPUxfYQHlQV0ZGULoNwA+?=
 =?us-ascii?q?PiG97frzE7TPsG56iQNfX4Nop04eeOxruETr8r0q7lk9Yl0TDgM0Ebf6?=
 =?us-ascii?q?20jC6+yftPC8AFt8j6Vzn+zpZw1nIzMM2ljkGocguqZa2hmtY0OKhSrL?=
 =?us-ascii?q?n+xnjDrB9ft8NUTFGlOaoH2w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 14:38:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647092329;
	bh=5a2S0lV3QrPpXTvgN0GKeORDte/n6yFVAPMzWFzJvfI=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=c2NL+fdqh/ILj1C9vzTG7jjYUV5cJCOI/TDuDebxGyPerqk2HvnGDHWc1jUHbp+fd
	 u2cd2YDSwre+cRDgBxmfeDf+wdBgM+Zso/yMLKaoRGjVUZtqAqjlLeNOAo6O6ck2Od
	 Nnbs/Ln9RtTzg+CXvBPxD/9zZl51/iKiS+4h6IMM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.146.255]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mcpqo-1o2dgp25Qo-00aEjA for
 <cocci@inria.fr>; Sat, 12 Mar 2022 14:38:49 +0100
Message-ID: <d9dae057-06ad-f6a3-f4ac-5cd56c9ce081@web.de>
Date: Sat, 12 Mar 2022 14:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:btxfEgqBFjp8X7kKZ9OwWfqGfnrqORIoFC6Dv5peA1SgN+fM97Q
 zef3skgTKQop12O5jh3sm2K58RpR3WhhvyMXmfPIRjwEfDU3jxpvT3Qy7YVdNOKeYditW71
 Y2z2T5k+wFCVwqfPQLi/sEIXE2D5DwSrmfhXN4tyzCTF/wI27ZqxLCid5heB+R2KZ+yvWIH
 qrneK3Llwak5QfTxFXnHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zGFJXh1fRuk=:7VJxlg7zgtyCNSiK+lXn+s
 QWwQ5k9KUiY2x9fTLPnx+yq58Vu+QfeEKsz/+B5bvD5kE7G/CyF5SW20bIzHEEUuPkxlsjv+U
 HQ55efrnDEeTJDaCSgzdJp2iMvLqxprGT4FEt+hUaZbL+s5V5aeW0J6tVCGj6qoK3HiADQnUs
 MHbcjNK+ZtB+d6RfZPYO/3tDAJhw9QKRpmhgby8G2YVBVaZ5lKWyeREM/JLFSvSwpPbiWKn+F
 Bfs4wq11KqPnLz6IUpzWrpVp04HqLuDIGJOaTWNayuiImp40uLNwIdeM52KMrXeErB+OQcrBq
 aJlefI/I8lxHrbxmV6vEMMJJuHSudzmnfgoIrPKqV5wsAeJWjv6WVFkvAdZAPI5QgQZqd6r19
 tbiMrWBQODTrpxl4ZjuMeDPIXevjjDb3T+bLsVC+zSOqA1D/UCyAqUrgBX0wMJLn0hZ/WYKPq
 JE5swgcZWLspwvOwVQZcGSBYcYqNpnv1l2odcFkHVPeT07GvLKZQBhEYTd1WIastTsgkpkt75
 e0xKiHEs5wxJHHMvbZ+5TxVdTvVjx/JsxNmOEGjFlXYkPpPbwcf2qdd1zsoQEwblY5ZwAdirk
 TGVbBekka7obUnIAIdjKOpJ58RFGPQmkQ8S8+Q6qNhVl5wE1G+LYPpDyey+IQCgnSvCFwM6Ft
 DuEvNXfIjLANL6P4zex8X1XPsgIAYNIq3aRc7rZ83eCv0rMyXnuu1LmkxxoHmJVQCzggjNfZU
 0Ir9B8Kt9pUlTpW7I7bdDDwN0DJcLllPJZ2sfbBw1dj7h/2pZxqa1bQ7KeepuhAho284EwPdQ
 bTnD6ibsuuoIzQsXWPt+VsKJhy0BtM0vnN77ZthHMtYb1me1aA5h4QUn1fznkQjbeSb5iFNpQ
 r2WK6qhJu1PFzfEd7/Suat0geG1uGpSuNtaJtHjMR08w8HsfrtQ4A7FGlhZzBjkO1Hi64d5Xr
 9zvNcbR37r+4phMWkEEHCCvhiKmIk1wiK/zuealnOCJIajBbfCxI5fWH3E68w9JQNS5VjO2Np
 EKAX+qypXg9jbrLNZ9VbZVsBlpOr9AxYN5DRRNk6aNv44pwj8uzBqUKUBmmHg8ndGtjJmXWWl
 +zsDHfDQ6LKhYw=
Subject: [cocci] Collateral evolution because of context-dependent grammar
 of SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 207
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/d9dae057-06ad-f6a3-f4ac-5cd56c9ce081%40web.de>

Hello,

I have taken another look at details from the grammar of the semantic patc=
h language
(Coccinelle software).
I interpret the SmPL script programming structure in the way that optional=
 header
information can be specified before the main data processing part.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5479fc964d209209e84dd=
d5caf3f395667721e7c/docs/manual/cocci_syntax.tex#L31
https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2=
e537f97ab62a/docs/manual/cocci_syntax.tex#L31

The main part usually contains some SmPL rules.
Each SmPL rule is split into two sections.

1. The beginning and end of the metavariable declaration block is denoted =
by
=C2=A0=C2=A0 a pair of @ characters.
=C2=A0=C2=A0 Additional settings can be specified also within the first pa=
ir of @ characters.

2. Code from supported scripting and programming languages can be specifie=
d for
=C2=A0=C2=A0 desired analyses and transformations.
=C2=A0=C2=A0 @ operators can be applied for the combination of metavariabl=
es
=C2=A0=C2=A0 as they would be needed for selected data processing tasks.


I got the impression that such characteristics result in the classificatio=
n
that the grammar of the semantic patch language is context-dependent.

Something was achieved by the application of the software tool =E2=80=9CMe=
nhir=E2=80=9D.
http://gallium.inria.fr/~fpottier/menhir/

This parser generator for the OCaml programming language is using the tech=
nique =E2=80=9CLR(1)=E2=80=9D.

The Chomsky=E2=80=93Sch=C3=BCtzenberger hierarchy denotes some computation=
al properties
for such language categories.
https://en.wikipedia.org/wiki/Context-sensitive_language#Computational_pro=
perties

Advices were published that context-dependent grammars should safely be ha=
ndled
by more sophisticated parsing technologies.
https://en.wikipedia.org/wiki/Comparison_of_parser_generators#Context-sens=
itive_grammars

How do you think about to clarify corresponding design challenges any furt=
her?

Regards,
Markus

