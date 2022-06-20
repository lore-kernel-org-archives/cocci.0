Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5F9CCA479
	for <cocci@archiver.kernel.org>; Mon, 20 Jun 2022 10:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ILEnbRYvonf2S7mGAzAmKBX9/6Aj79WeRokQ5H1y8UY=;
  b=Akd84Mxbnh/NcBC6eRMaE/jLVkjmM/KwarmlMJvfi492SbCF66w2tNNw
   ysgKwfU1OpeQVq6k+HhQ8/xKMmGavQ82njo3hSa1s0M55C6d3NYANLaoN
   kKtZQTWqf5A2BHXGT/ErUIdPA2ktpO5Ch9jxLtP5mXXqGxUGVRh58MlkN
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linbit-com.20210112.gappssmtp.com
X-IronPort-AV: E=Sophos;i="5.92,306,1650924000"; 
   d="scan'208";a="41922784"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jun 2022 12:43:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 37301E2680; Mon, 20 Jun 2022 12:43:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7FC52E0094
	for <cocci@sympa.inria.fr>; Mon, 20 Jun 2022 12:43:06 +0200 (CEST)
IronPort-SDR: aZXMKkq4uXqDIB+iudfL7KDtvw+mzSjY2vZrFtAUVGk6tQzs1FD1fDmlZHsuVa9OsUsbEJfqbt
 6WAaNHKFIIQHQxoa5ucwmvP9xSibREOWhJFihMHfz6zLadd52k2CBa196W31+zApQBfApakoun
 KSRPdsUCNvjgToPTAbkMSOGylZvEgnglv/3c5TTxXymbrYv6So0a+LajY/kA/jMYLUNv+sPPtb
 YeyeSCw7g6ieiPCxk/dPNIi04Oequa55ERA8qTjLdZNZEx3Lci3HxX5eVImJSJw8hi2oYWIiNC
 ooIt8TAiL5N1l5ogr2B0AxlL
X-IPAS-Result: =?us-ascii?q?A0DvAgCbTrBifzTaVdFagQmDc4FXLgRPhE6QXoRSmW8DV?=
 =?us-ascii?q?AsBAwEMAUIEAQGCD4J0hUsCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAQBEwEBDQsJBwgKBw4OBT5kaIFPgXQLNA2CNSKEBBEECwENAQE4N?=
 =?us-ascii?q?AImAjYBBQEvCAEBHoJbgxkDBKFLgQRCizJ/MoEBgggBAQaCXoNpgR4JCQEIf?=
 =?us-ascii?q?yyPHIIpgTwMgkgBhRorOIMJgmWZWyYEDwMaLTQSgSFBMAEIBgMDBwoFMgYCD?=
 =?us-ascii?q?BgUBAITElMdAhIFBwocDhQcJBkMDwMSAxEBBwILEggVLAgDAgMIAwIDLAIDF?=
 =?us-ascii?q?wkHCgMdCAocEhAUAgQTHgsIAxkfLAkCBA4DQwgLCgMRBAMTGAsWCBAEBgMJL?=
 =?us-ascii?q?w0oCwMUDQEGAwYCBQUBAyADFAMFJwcDIQcLJg0NBCMdAwMFJgMCAhsHAgIDA?=
 =?us-ascii?q?gYXBgICbgomDQgECAQcHSQQBQIHMQUELwIeBAUGEQkCFgIGBAUCBAQWAgISC?=
 =?us-ascii?q?AIIJxsHFhkdGQEFXQYLCSEcCh8RBQYWAyNxBQo+Dyk1NjwQHyEbCoEjLC0hB?=
 =?us-ascii?q?iIcApsqXoMCwVkHg1EFn3kGDwQtllUUkXqWbqcNAgoHBhAjgVVQgS5wgzhOA?=
 =?us-ascii?q?QIBAg0BAgIDAQIBAgkBAQKSD4pgPzQCOQIGAQoBAQMJgjqKAIJHAQE?=
IronPort-PHdr: A9a23:gfw7rhN2vsM/hbOqnbcl6nZtBBdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv64r1QWVFtmEo9t/yMPu+5j6XmIB5ZvT+FsjS7drEyE/tMMNggY7C9SEA0CoZNTjbig9A
 dgQHAQ9pyLzPkdaAtvxaEPPqXOu8zESBg//NQ1oLejpB4Lelcu62/689pHJfglEmjWwbbx9I
 Ri0sA7cqtQYjYx+J6gr1xDHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S
 6dYDCk9PGAu+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VDK/5
 KlpVRDokj8KOT03/m7YhMN+kqJVrg+9qBJw2IPUfIKYOeBicq/Bc94XR2xMVdtRWSxbBYO8a
 pMCAvQBPeZCron9vEcOrRymBQmsHOzi1zlQhn/z3aw0yeshFRzJ0xI6H9kTt3nbsNX1NL0TU
 eCu0KnIyi3Db/NM1Tjm74jHbBAhofSCXL1qdcre1FcgFxneg1WUqIzlOSia1uURs2SB8+VgU
 uevhnchpgpsrTeh2t0ihZPVhoIJ1F/E7yN5zZ46KNO3VUJ2btypHZpSuiyEKYZ7TMAvT31pt
 SonyrMLt4O3cicXxJk72hPRa/iKfYiV7x/+WuicPSt0iG9mdb+8gRu57EuuyvXkW8WqzFpHq
 jBJn9rMu3wXyRDf98uKRuF980u/wTqC1B7f5vtaLUwplqfXMYAtz70qmpYOsknPAyn7k1jsg
 qCMbEUr4O2o5vznYrr4op+cMJd5igTkPaQvnsyzGPo3MgoTU2SC9+Sx1KPv8Vf2QLVNif02n
 a3Zv47AKcsHoa65BhdZ0ocl6xmhEzeryMoUkWUDIV5fex+Kj5LlN0/TLP37F/uyg0qgnC9ux
 //cP73hBpvNLmLEkLfkZbty905cyBAyzdBE+5JUDakBIPLpVkDqs9zXEB85Mwm6wun9DNVyy
 50RWXiUD6+dMaPSt0SH5uMzI+WWeIAVvzP9J+Aj5/H1lXA5g0MSfbG13ZsLb3C1BulqL12DY
 XXwmtcBDXsKvg0mQeP2j12NTSJcZ3epUqIn5jA7DZqmAp3ZSoCshryBxia7EYdMamBIEFDfW
 UvvIo6DUPwNQCOUOM5o1DIeBpa7TIp0/hG0tRTmzKJnGcBK+igHvJbv2cI9s+bTjxAp6TtsD
 4KX1GyNSn59mm8FXRcy3aZ1oFA7wVCGh/sry8dEHMBesqsaGjwxMoTRmrQS47HaXwvAeo3MU
 1O6WpC8Bjp3SNstwtgIakI7GtO4jxmF0TD5S6QNmemtA5o5urnZw2C3P9x0nn3Gzqg6k14+Q
 o1FMmCmg7F28wTeHabNkkOTlrrsfqMZj2bW7GnW9WOVpwlDVRJoF6DMXHQRfEzT+N/5/ELZU
 7i2CfItNQZBzNGLLqdHcPXtjFNMReulM9PbMCqqg2nlIxGOy/uXaZbyPWUQ2CKIEE8fjwUa5
 mqLLyA7Dyal5m/cVXlgSAipbETr/u1z7ni8SyfY1imsaEtsn/qw8x8R37mHTu8Lm6gDs2Eno
 il1G1C025TXDcCBrkxvZvcUZ9R1+1pB2W/D0m41dpW9M6BvgEIfeAVrrgvv0RtwEIBJjcktq
 jsj0gNzLauS1F4JeSmf2Nj8PbjeK2+6+x7KCeae0VHE0c2K/b8Prv4/plXmowitGkc423Fm1
 dNUzz2X4ZCLRAseXJTtU1omogBgruK/AGF17IfV2HtwdKis52WaipR5Wa1/k0bmIo0MVcHMX
 BX/GMAbGcW0fekjmlzzKwkBIPgX7qk/ecWva/qB3qeveudmhjOvy2pds+UfmgqB8TRxTunQ0
 tML2fadi0GMVy39l0umqsCxk4dJZTQNF26zxDLMAI9XbKxuO40MDC39Rq//jsU7nJPrV3NCo
 RSoB0kHw9OuYRrUZVvw3QhP3EAbrGaPnSq+xT1o1Touq+DMuU6Gi/Snfx0BNGlRQWBkhlq5O
 om4gecRW02wZhQonh+ojarj75BSv783b2zaQEMSOjPzM3knSKy78LyLf89I7pos9yRRSuW1J
 16AGPbxpB4T0iWrGGU7pnhzfDGwu47lmAR6zmiaIXZ2s3Pddcxq7RPe4tbdWbha2T9OSCRji
 DbRD0SxJJHzpYTSx8qF6LnuET/7HpRIFEujhZuNri66+XFnDVWkkva/l8emWQk23Cnn1sV7A
 CDBrRLyeI7uhOyxNeNqeFUtBUepsZIrXNEj1NFp1NdNgyt/5N3d53cMnGbtPM8O3Kv/aCBIX
 jsX25vP5wOj3kR/L3WPzoa/V3OHw8InacPpBwFeki878c1OD7+ZqbJemi4g6FG4twPKff9ln
 nEXzvYu7WETh+0EoiIpzyOXA6xUFk5dd3+J9VzA/5WloaNbaXz6O7Owzktlgde5DPeIpQxcX
 WnwfpsvBwd078N1MU6K23r2oNKBGpGYfZcYsRualA3Fhu5eJccql/YEsiFgPHr0oXwvz+Nox
 Qwrx5yxu5KLbnl85K/sSAANLSX7PolAn1OlxbYbhMud2JqjW4lsCileFoW9VuqmSXoTrai1b
 FvISWxk7C3HRvyHWlXDoEZ+8yCRT9bxbCrRfSdBi40lHUj4RgQXgRhIDmtk2MdhTEbygpSmK
 h8x5yhNtACm7EEQm6Q4b1+nFT2H7AawNmVrEt7GcFwPv1sEvwCMYan8pqpyB30KocHn9VbQb
 DTdP0MRUykIQhDWXgizeODxup+QtbDfXLP2LuOSM+zR8qoHBqvOndT3ldI4mlTEfsSXYis4V
 6x9ihcFBCopXZyewmpHSjRLxXiUMYjG9FHlq3cx9ofmobzqQF69v9LRTeEJYJM0oVbuxv7SU
 ozYzDBwLTISvn8V7VnPzrVXnFsbiiU0MiKoDaxFrynGCqTZhq5QCRcfLSJ1LspBqawmjEFLP
 obAh9X526Qd7LZ9AkpZVVHnhsCiZNAba2C7OlTdAU+XNbOAbTTVysDzaKm4RPVeluJR/xG3v
 D+aFQfkMFHh33HxUAuzNOhXkCyBFBlXuYX4fxQ0TGa+FpTpbRq0NNIxhjozgPU1in7MKW8AI
 G18fkdK/djypWtThvRyHXAE72Iwd7HV3XbEqbOBetBL66gOYGw8je9R7XUkxqEA6ShFQKYwg
 y7Otpt0pFrglOCTyz1hWR4IqzBRhYvNs18xXMeRvpRGR3vA+woAqGuKDBFf7dBlENz0p6dIy
 p7Fk6/zLShL997Z5+MYBs7eKd7BO30ke0mMenacHE4eQDinOHuKzVRai+2X/2aJo4ISr5Htn
 N8DSOYeWgFvUPwdDUthEZoJJ5I9DVZG2faLycUP43S5thzYQs5X64vGWvylCvLqMD+FjLNAa
 nPgIJv9JIUXc4D5gglsNwM8k4PNFE7dG9tKp385BufRiEFM9nJ/Uis43Ee3MmtFD1cXFPi+n
 wJwgQx7M71FyQ==
IronPort-Data: A9a23:pfQIS6L/bNCvcaP1FE+Rz5MlxSXFcZb7ZxGr2PjKsXjdYENShjcBy
 jAWUW+FaPaPa2f8ftEiaIvg9EoO6pTWn4dlSwsd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M58wIFqtQw24LhXVrT4
 Y+aT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhptFtx
 /RispyLVEQrIaiLptg3SwJhHHQrVUFG0OevzXmXtMWSywjLcSKpzag0Sk4xOoIc96B8BmQmG
 f4wcmhcKEDewbjvkPTmEIGAhex7RCXvFIgfoHB70TbBDbAsRp3DRrrD4dNVxh80h8ZEHOqYb
 M0cAdZqREiZMkcVZQhIYH44tOKpqn3iVQxakRWupvMY+FqU5h0u27e4ZbI5ffTTHZkP9qqCn
 UrN+G/yAzkBJdmHwHyE9Gitj6nBh0vGtJk6EbS58rtnggTWyDFJThIRUlS/rL+yjUvWt89jx
 1I8wysyookd80yQU5r/QBj/nkKupgUlVI8FewEl0z2lxq3R6gefI2ELSD9dddAr3PPaoxR6h
 jdlePu5VVRSXK2ppWG1rejL8GvjUcQBBSpTOn9eFFptD8zL+dlr1nryosBf/LlZZ+AZ9Bn1y
 jGO6SU83vAd0JRN2KK88lTKxTmro/AlrzLZBC2HBQpJDSsjPOZJgrBED3CFsJ6sy67HEDG8U
 IAswZT20Qz3JcjleNaxaOsMBqq1wP2OLSfRh1Vid7F4qWnwpSD4IdoNsWsnTKuMDiriUW+5C
 KM0kVMBjKK/wFP3BUOKS9ntV557k/KI+SrND6+ENYQmjmdNmP+vpXkyPyZ8Lkjil08jlaxXB
 HtoWZfEMJruMow+lGDeb75Fj9cDn3lirUuOG82T50n4idK2OS/NIZ9YYQDmRr1ovMus/l+Jm
 /4BbJDi40sEAIXDjtz/q9F7waYidihlW/gbaqV/Koa+H+aRMDt9WqWPnO95J9QNcmY8vr6gw
 0xRk3RwkDLX7UAr4y3TApy6QL+wD5t5s1whOikgYQSh13Q5ON796KYZfZorO7Ig8bU7n/JzS
 vAEfeSGA+hOE2yfomlHM8ah8oEyJg62gQ+uPja+ZGRtdZBXQQGUqMTveRHi9XVTAyfu7Zk+r
 rSs2xn1W50GQwg+Xs/aZOj2lwG1vH4Xmf40VEzNe4EBdELp+YlsCirwkv5ue5lVdE+dmWfE2
 l/PUxkCpOTLr4sky/XzhPiJ/9WzDu9zPktGBG2Hv7y4Ai/Xozi4yohaXefUID3QWT+m+KimY
 ukJnfjwPOddxwRPuot4VrtplOcwuoGpqLhdwQBpWn7Mag3zWL9nJ3CH2+hJt7FMluAF41roA
 hrX94kII6iNNePkDEUVeFgvYNOF2KxGgTLV9/k0fBj36XMl5raBSkkObRCAhDYHd+lwOYIhh
 Ooj4YsYtlb5hR0tPdKLyCtT8j3UfHAHVqwmsLAcAZPq2lV3kAAcOcSEB3+k+oyLZvVNLlIuf
 m2eip3EiukO3UHFaXcySSXA0Oc1aU7iY/yWIILu5mhlm+YpQtcy1RxVtDk1F0Fbk08B3OV0N
 WxmcUZyIM1iOtuuaNdrBwiR98NpXXV1OXAdD3MNlWvTTlXuXWvIRIH4EfjY51gXqgqwYRACl
 Ix1Cw/ZvfLCeMD31CouH0VirpQPiDC3GhLqwKiaIihOI3X2jfcJTENjiarkZiYL2f8MuXA=
IronPort-HdrOrdr: A9a23:SvoEC6FfWueEKaz8pLqE5seALOsnbusQ8zAXPiFKOGVom6mj/K
 2TdZsgpHjJYUkqKRQdcLy7VJVoIkmsk6Kdn7NhWYtKNTOO0AHHEGgI1+TfKlPbehEXt4RmpM
 Vdml9FaKySMWRH
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,306,1650924000"; 
   d="scan'208";a="41922777"
X-MGA-submission: =?us-ascii?q?MDFfmzURnkJE5sJpt9vK+XbsoLOM8cpze6lztX?=
 =?us-ascii?q?DvQKFfBNWc+TR2VZDK0ZoSffTpAAcHBZ32dzlctjfqrCq1AA7lJWokDg?=
 =?us-ascii?q?lfiTj1zBB3JwAca/ct85xlJRldL5wJRJ0iGfQtbdUQ2nGjSYgOSPf9MR?=
 =?us-ascii?q?vSeBN9rfJqe+uWL8QpCk+oNA=3D=3D?=
Received: from mail-ej1-f52.google.com ([209.85.218.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 12:43:05 +0200
Received: by mail-ej1-f52.google.com with SMTP id fu3so20242132ejc.7
        for <cocci@inria.fr>; Mon, 20 Jun 2022 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=ILEnbRYvonf2S7mGAzAmKBX9/6Aj79WeRokQ5H1y8UY=;
        b=wXLOE0/zhZoCE2tTPiKfE/beMG4/2UGmLSmutq6NyIhv2zERKFsBW2V/xEQmwrfjKw
         aYLY+S7YJzVIj+yuma4vP9QLAkSpFIBY/5ryPS0H5GrPLEGlrEHpNFmrk54KKmMh75nz
         tanJ7Cn5qbEQuWeL1sXtQrSK2n/JDZtkYJFxR5p1sEoXVozpuAv9wCRN740AxY3HT4DR
         NvB14Le5nSCPYc9XLHjoe/6AhdFFBNIviGn17nWAJPr6T+PLP8LmjjLdg5wXcm1dfuXv
         NHGaUgONM6oCkWO0qMNWnIYMPVz2WDQ3XhqDYIiIyAXNp0o0RGK3e33NcCud5xQKvfMu
         qNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=ILEnbRYvonf2S7mGAzAmKBX9/6Aj79WeRokQ5H1y8UY=;
        b=gIiROGRSPWM85+5IebImdYZu1lMqp03NLFSCyJgBSpY+Y2/JkfoUaSlOQSICdcnXJj
         IgQj1ZDfGo184jbDAiYvD+mqYnk5nRTlVFuF+43nVaxqPXKyBikQs+xsPEidScZYUnHa
         TcnBkFNa/dSjQUqI26ag0cVVbx1MPJUFPtVL+Yfg8Jvtgf9+rLGwyKClfAuW5rTWehQs
         oJfMDEx9JTboK4qni5gR0MqatRHueyxb0Gxk4wr/lG79NCYlKdK7c///sLfP0ucoHQI9
         G4PWMry2W3oGfJ2c8g5zScbfZQPpoUpyVK0kyW5hF5d9P1+/2gPyOtxPlB6qXK4YdKF4
         U1eg==
X-Gm-Message-State: AJIora+e4mT8Ld0+SYv+CF7h5XigTBllaprc54dqC2y9m7DeCuY1U6Xm
	X/QgUaBUrrX8hvH5aoCpDu5EpibyDDHqSTI4
X-Google-Smtp-Source: AGRyM1tBMEJoohFLiMovlGhw4AOsBTz2L/hx3Zot+t2WCakiMF0PbC0BJUfyjj2gaTAsSycTWq5l+A==
X-Received: by 2002:a17:906:51de:b0:718:d5b0:d171 with SMTP id v30-20020a17090651de00b00718d5b0d171mr20002067ejk.199.1655721785095;
        Mon, 20 Jun 2022 03:43:05 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id s15-20020a056402520f00b004358243e752sm1964308edd.5.2022.06.20.03.43.04
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 03:43:04 -0700 (PDT)
Message-ID: <973ae278-3319-94df-4215-d11dac3b3334@linbit.com>
Date: Mon, 20 Jun 2022 12:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: cocci@inria.fr
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [cocci] Matching either declaration or assignment
Reply-To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
X-Loop: cocci@inria.fr
X-Sequence: 446
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/973ae278-3319-94df-4215-d11dac3b3334%40linbit.com>

Hi,

I have two places where I want to run a similar transformation:

	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
			REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);

and (in a different function):

	struct bio *bio;
	...
	bio = bio_alloc(device->ldev->backing_bdev, nr_pages, peer_req->opf,
GFP_NOIO);


So basically, in one variant the assignment is done in combination with
the declaration, while in the other case the assignment is separate from
the declaration.

I would now like to match both variants with a semantic patch, capturing
"bio" either way. This is what I have intuitively tried:

@@
local idexpression struct bio *b;
expression bdev, opf, gfp_mask, nr_vecs;
@@
b =
- bio_alloc(bdev, nr_vecs, opf, gfp_mask)
+ bio_alloc(gfp_mask, nr_vecs)
;

But it only matches the separate assignment.

On the other hand, this:

@@
identifier b;
expression bdev, opf, gfp_mask, nr_vecs;
@@
struct bio *b =
- bio_alloc(bdev, nr_vecs, opf, gfp_mask)
+ bio_alloc(gfp_mask, nr_vecs)
;

Only matches the combined declaration/assignment.

Is there a way to match both with the same rule?

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
