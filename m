Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE0AC43334
	for <cocci@archiver.kernel.org>; Fri,  1 Jul 2022 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=owwGuI24f79YBlC7qhKy4Xqhx58Zw/8Fw0Av1pJnkEM=;
  b=fzI6vNmAdocuoGr3qYggCRyzdX61XNp1kglvFOQQIylWkCnFGAycxYHx
   mKSunGn2oKPUns9dK4BEwysrUAiMrpr6Q/9A8scqmf0xDBEv0TbOIpKBG
   WykfAYx8oUfPs37IeT6IicLK+003ejoDvY95OhtdVBSsDYNTJbMsRqP62
   c=;
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
X-IronPort-AV: E=Sophos;i="5.92,238,1650924000"; 
   d="scan'208";a="43893125"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2022 21:30:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E79FE034D; Fri,  1 Jul 2022 21:30:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6F47AE0092
	for <cocci@sympa.inria.fr>; Fri,  1 Jul 2022 21:30:51 +0200 (CEST)
IronPort-SDR: U3Mw8K5Y7J9V/kBfrzZCi6tVhP4D6eb2COBiIvlwonh2TLD7hk+hTVmbqjsFKLoZBKSiob4SUE
 2mT43XLcUCtLONAJ367847PgL/bOsIWbsj9bqE3SRZPu2HD9Cue7D9FRW+o/2zVbEfTfEVEdAI
 PurgQ2lHolZCsWyOzJALV2VAnzq0AG6d3gwke84zBA3Vd7w0rTSQV4GB63CyebALvEU8etaB2/
 BPJAt5DGJmPOpqhdkRRYu4mrs+W9eftB63xlxOsOPEFc5EJZ6fSdZWSWXAjT8GjhW2FcgrXuEP
 viERKZGto/CBg421Gz1CoCmx
X-IPAS-Result: =?us-ascii?q?A0AaAABGSr9ihwMP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPgMBAQELAYIjgVcuBAtEhE6QXzGEI4cNhxyMIwsBAwENPwECBAEBh?=
 =?us-ascii?q?QQChUsCHQcBBDMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBA?=
 =?us-ascii?q?QEMDQkFCAoHDhAFNgZeBmQEgUsEgXQLNA2CNSkBg2QBAgIBIwQZAQERJgEEC?=
 =?us-ascii?q?wsaAiYCAlcGAQwIAQGCeYJlAQMNIwetGn8ygQGCCAEBBoRLHywiUoFcCYERL?=
 =?us-ascii?q?AGKXYMkeicQgVVEgRUngRWBPjA+gQ+HC4Jll3GCNyYEDwMaLS8SgR9uAQgEA?=
 =?us-ascii?q?wMHCgUwBgIMGBQEAhMSTQYcAhIFBwoGFQ4UHBISFwwPAxIDEQEHAgkSCBUrC?=
 =?us-ascii?q?AMCAwgDAgMgCwIDFgkHCgMdCAocEhAUAgQRHgsIAxkeLAkCBA4DQAgLCgMRB?=
 =?us-ascii?q?AMTGAkWCBAEBgMILw0nCwMFDw0BBgMGAgUFAQMgAxQDBSQHAyEPJg0NBBsHH?=
 =?us-ascii?q?QMDBSUDAgIbBwICAwIGFQYCAhhWLg0IBAgEGB8kDwUCBy8FBC8CHgQFBhEIA?=
 =?us-ascii?q?hYCBgQFAgQEFgIQCAIIJxcHExgbGQEFMicQCSEWBgofCgYFBhUDIUcmBQo7D?=
 =?us-ascii?q?yg0NjwsHxsKgRosCSIWAwQEAwIGGgMDIgIQKQYyAxUGLRUUBiIBGwKbP3GWN?=
 =?us-ascii?q?a5VNAeCFIE9gUQMnjEGEy2WVg4GkXqWcyCnI4F3gX8zGiSDN04BAgECDQECA?=
 =?us-ascii?q?gMBAgECCQEBAo4dGR6DbootPzQ7AgYBCgEBAwmFRwEBiTwBAQ?=
IronPort-PHdr: A9a23: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
 chWIoI=
IronPort-Data: A9a23:ULbnRa6b/BVYWaXAyN1p4wxRtBTBchMFZxGqfqrLsTDasY5as4F+v
 jdOX2yPOPqCY2qmLthxYYmzpkhXv8SHztFrSldl/C80Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2OaEvfDjW1nX4
 Yyq+pWEULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 PBTuaeRER55AvbzgaMvdTJoEA9lGpQTrdcrIVDn2SCS50jBbmeq3PhkSk07VWEa0rwuWycUr
 6NecW1LNXhvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2TtYQDg2lu3KiiG97Rb
 NogVQVrSi78RDlpGXUaDMkYw82B0yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RKhUTK9WbzRKX83emnOaJnCXhWYtUGqfQyxJxqFiU23BVFxAcE1e2yRWktqKgc/dBJ
 3c1ojN+kfMN7QuZaPLNXDOjh0fR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9hDoO65deqdsCi
 Qbhoj/5OdB8mOHEESrGrd94uRviZXJKcQfucAdZFVNt3jX1nG0kpj7iJjqJOI28lNnuAyzwz
 lhmRwBh2exI0qbnO42R9FzKhXeTDUzTUhI44w/aRG3N0++UTIuiepDu9lXRq/pNRGp4crVjl
 Cha8yR9xLlfZX1oqMBraLhcdF1Oz6jdWAAweXY1Q/EcG82FohZPh7x47jBkP1tOOc0ZYzLva
 0K7kVoPucEMZCPwNvQpPtnZ5yEWIU7ISouNuhf8MYomX3SNXFPelM2TTRPMjj62yiDAb4llY
 M7FLa5A8kr2+Yw+kWboHr5DuVPa7nlwnCvSQ4z21RKqzfKXaxaopUQtYDOzghQCxPrc+m39q
 o4BX+PTkkk3eLCgPkH/rNBCRXhXfCBTLc2n8KR/K7/TSiI4Qj1JI6GKm9sJJdc695m5Y8+To
 xlRrGcDlAGg7ZAGQC3WAk1ehETHBsch8CpnZnF3YT5FGRELOO6S0UvWTLNvFZFPyQCp5acco
 yAtd5rSD/JRZC7A/jhBP5DxoJY8Jgumj0SCMnP9MjQ4epdhQS3P+8PlJ1e+qnNRU3Dv7cZu8
 ae90g77QIYYQ1owBsjhaMWpkwG7s08blb8gREDPONRSJB7h/dEyeSz8h/M6Oe8WLhDHymfI3
 gqaG0lKuuTH5YM4qYGbiaeBpoavMu1/AksDQziFt+nrb3GC8zP6k4FaUeuOcTTMb0/O+f2vN
 bdP0vXxEPwbh1IU4YByJLZcy/5s7dXYobIHnB9vG2/GbgjwB75tfiuG0M1IuvEfz7NVo1LvC
 EeI58UcJriDfs/oSQZDKA0gZ+WF9PcVhjiLsaVrehqnvncv8erVS1hWMjmNlDdZcul/PrQl9
 uF96sQY3Aqy10gxOdGcgyEIrGmBci4aX6M8us1ICYPnkFNymFRFfICaFSL8pp2CMo0ePk4vK
 z6SpazDm7UFmhucKSVuTyCV0LoPn4kKtTBL0EQGeQaDlO3FsflrjhdfxjI6E1ZOxRJd3uMvY
 WVmOiWZ/0lVE+uEWSSCY4ytJ+2FLBie51C31FYD0mHUJ6VtuqohM0VlUdthPmhAm46fQtSf1
 K6VwiDpXF4GuenvizAqVxcNR+PLFLRMG86rpCxjN9uIFd82bFIJR0NoiXUg83PaPC/6uKELS
 SSGMgq9hW0X+BP8e5EGNrQ=
IronPort-HdrOrdr: A9a23:WH8MFaGoSAlvoFQHpLqEzMeALOsnbusQ8zAXPo5KOHlom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjVQX+xA/DGdmprY/ts2Ik0dNz2DUstbnnpE4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,238,1650924000"; 
   d="scan'208";a="18337662"
X-MGA-submission: =?us-ascii?q?MDGUTT8Wibn+yUpkt2/mSFETJvSpARS/A2UCyZ?=
 =?us-ascii?q?4YePQlaSCSXovKFcaIY6Ax0ghbDfqZnOiztxCvjZdyO9CGvkRVlaJHEC?=
 =?us-ascii?q?3HhgYeFIZQV1mpm743IZEUD3W3aSSC+suPqUjr/lPJYZX5ahpSy3XeiN?=
 =?us-ascii?q?IO5Dtn97DKW8ZF9f/haggT2Q=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 21:30:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656703848;
	bh=l8ADlg8QBmXQurVUvHPlaF7mJ2uwLBqtHk0nGygkVMY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Lz3fOPLISo5Wfesaodh12NZJojwRr4uLtShNb6lagRxdVHVvPgjS0m2hogllrpsJD
	 QfZQxLolJ/m0hLmV3nxc7tYN0w+hSsSoHLQ3ZPflLijcrd2Mly57LdKU8i2ZqKea/2
	 y7J/c+5RGp+65lynu8MhuyEsfEFLN3yUoz6Yf9Xc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.132.48.14]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnpGw-1nIOKw1Z98-00pCOD; Fri, 01
 Jul 2022 21:30:48 +0200
Message-ID: <632c81ca-3d53-4ff5-505e-f8da998e47db@web.de>
Date: Fri, 1 Jul 2022 21:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: Julia Lawall <julia.lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AS8PR03MB7603EE9F885BA2573CD56CF993BD9@AS8PR03MB7603.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wI7mlIEfk30ZnQk+X3NrsqBZvMb866H0PclozP7NO1/N5vYoYO5
 L2bJXjX3zIzUC5cyglbL13QUdkiNFCa/Vh3QYF1Hc8GSzM2BeAAmraJhBw0xAySDnga1i5O
 IiWbOR48XYOJFe9/C5nGAaogMMQb6BCisrHiFxPbYPPK8AQt9Ap2DBWNVCwjvge8rgTiGUt
 /eNULo82TC5V67ZIiKfPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZDT5TS7NEYs=:MaVUPqeF5QOuOfYaupVZd2
 nANgOVfQcka67RpSxv9Dao/7kslzAVj/OZEJmZU181UwUHaWs8kSGUvqRMhaGb/lwAMfCGehm
 3MUPduGKc4FPYkfutQ4NfTir/uZSpQed01FBjT0QTBb/CMkWvs1HvU+BjAS4Ggbbrs1W0Z1iX
 Tdra54aGgw56t0pH7lXtpVw0iRZjlkH2rQwWeloWeOcW1lFeQTmauyuw4CacKOURqOofb6A2b
 WDY3ooorKHyk+F5QRW33K8jvWbsAdTAz8xgsmEaXZa8QJNyZXhZhBWEea2KlUnCe2dcEPpNNm
 1wrbW8izBK9Rwv4eH/QKx4JG41AOfEe41oRIQ1ZZASpnqW+Kn+2r0x/nCfgpgaQIP7GkXKI5x
 gRGRaBXm//eaAhYDCyFem35TOWzYSGDRAdKKkq4Fpc1dflCdCkF/yW18Dz+Iz+69NBaOS13Dr
 iwf0wQ60sGEhIs8RwTqoAKp2nFL2Ty45gUjAnfJoFGxS2G1OgzeTXnUtqXXbt0JkBcYPLtgcF
 TiP7q4JS6n7vSeBYKk/anBevNJWQChiSZCfpP80bQEcdHjuYTfYzaqQmb6Xcrm2iTEXfnRnCg
 LhrY/dIOcf4m1xkYkvQ8whL1FL1Tt/nXM0vG6QoLPEQkfUeMUxLbJZotuTj3zKe8g04jhU9Ig
 994h3cfbvkAccSQwcrBAMF2Dw3UYEK+I8Yx4mOJSRvLuNcxBffPsRx4L9cnmSwbJnqv3V1SvU
 za5dT4Hi/2BKT9l419rOcFfNsKJsdFxoXCBwvwGihsb2XE6fw5Ih+WW3lCRUNDrH5lI842Cmz
 wuddBLKk8GcFMwMH2VifiYcJFvhfMqeh1lyIypw/pK+2EVdeC5xAdBQtpp3d9VxN3zNcAXM2H
 hMbQGXwLwMRpi2MikvIbdJM5m4rlGKdJj2PzYjvLx2PusE9H6qzKJLEHP9uSxQzMygi+g8iHm
 C1RYubKxe9ZZ+lwfEyM/M38zpdL8erCbY8Qim64/WVyWvGARGoN/KBOaFD7bBuzfvc8C7nPGi
 ua2ULdgZlQt3BwHZuxQVoUzUGgp7C2je+gP7B5wAHleHOIJVf/ZbrALC/sfcPqOuRVnJ1Zaxz
 0HWxBLcx5cHUEdSTzEv09y+vzqo8eiJ8UyIh0Rz2lbvpm/rk6Bdkz/y8Q==
Subject: Re: [cocci] [PATCH v5] coccinelle: Extend address test from ifaddr
 semantic patch to test expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 473
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/632c81ca-3d53-4ff5-505e-f8da998e47db%40web.de>

> This change aims at detecting an address test in more complex conditions
> and not only in if statements.
=E2=80=A6
> v4 -> v5: Change semantic patch to match explicit tests to NULL +
> improve commit message
=E2=80=A6
>  scripts/coccinelle/misc/{ifaddr.cocci =3D> test_addr.cocci} | 4 +---
=E2=80=A6
> @@ -14,12 +14,10 @@ virtual context
>
>  @r@
>  expression x;
> -statement S1,S2;
>  position p;
>  @@
>
> -*if@p (&x)
> - S1 else S2
> +*\(&x@p =3D=3D NULL \| &x@p !=3D NULL\)

=E2=80=A6


Can another SmPL code example help with the clarification of proposed
implementation details?

@display@
expression x;
binary operator bo =3D { =3D=3D, !=3D };
@@
* &x bo NULL


Regards,
Markus

