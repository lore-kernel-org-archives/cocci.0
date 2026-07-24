Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2EBC531FC
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:to:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/We2fES3DvWZfOA0GaOmUB9kcX+Pood0ugmqxojMX1s=;
  b=TH4fqAFOfbHrnGoqV5vHUxJyYLyZOXS+MdHPm/IFfCO+33mG7zke72iE
   SqjteN9Q8Fj3KfP7ilOT94HZ0tJwoWAJsreBWBu7gTFSpgNSi0Y6SjCsk
   5rGE8iv7hTujJoX5J1nq35BjP+s5x6VJnIsszMW6UveeKJirsPAfEkiZw
   o=;
X-CSE-ConnectionGUID: XKacGlJOQFW9y3Qr3c+Ybw==
X-CSE-MsgGUID: lSEJpryITXq7sC2KhhMrBg==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287734802"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:55:04 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 195B7804C8; Fri, 24 Jul 2026 10:55:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 778AF81B6A
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 07:06:30 +0200 (CEST)
X-CSE-ConnectionGUID: 5WaFUBMBQVSFe7/ReQHDXw==
X-CSE-MsgGUID: zeXuYN05S1WOKCEf3CP9Cg==
IronPort-SDR: 6a62f2bb_CXVxQMrATzZBqMSrAOLo9wKwUIZcp8kE/lV3+DcX6dAmAul
 leViR8UZZSA7cBgczI8PqEOeKOV3OP36ShjTN1w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EbAABq8mJqgRI4ZTRaHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?W1TQgFHYDIHUYRYg00BAYRMX4h5A4Q7hykHkFuBVRSBKz8PAQMBCwEBPRQEA?=
 =?us-ascii?q?QEBAgSEfgKNYSAGAQQwCQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBA?=
 =?us-ascii?q?gQDAQEBAQIQAQE7Bw47hk8NgmIBgSRRDQMHPgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQUCDV4BAR4BAQEDEhEEEQgBATcBDwsYAgImA?=
 =?us-ascii?q?gIgESUGAQoIAgEBHoJgAYIkBBIDNwQCDgS1awGBPQICiyJ/M4EBggwBAQYEB?=
 =?us-ascii?q?NsqDYJbAwYJAQoBgQouAYg7IAGFdzuEQYIMQ4EVJ4MEPoIfgW8BEgEIGYNbg?=
 =?us-ascii?q?mqDMoM/iH2FclJ4HANZLAFVExcLBwWBIxAzAyAKLy0CFA0QEg8EFgUtHXAMJ?=
 =?us-ascii?q?xIPHRcWHlgbBwUSICpBRSMDFC0mEDgLQwWBVgKBeD8jHwM5f4EvCmtKdy1pA?=
 =?us-ascii?q?QIQF0o4JIEYAQMCgisCBoExAgELbT03BgMLGQQ9jmEjgjIOAYEOK4ERbA6QC?=
 =?us-ascii?q?oNPRJEPaIgil38BBWsDBAOEHYwhjz6GAQYTL4QEjRSZVJkII4R8iGuECZFbh?=
 =?us-ascii?q?SoCBAIEBQIQAQEGgWg6bHBwgzdQAxkPjiEMFoNghD2LAAG6bD00PgEHAgcPA?=
 =?us-ascii?q?oFzkDSBTAEB?=
IronPort-PHdr: A9a23:YQyg7RQ7FI9CQ5YIhKKz8DQvPtpsonKSAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSA8ODsrkZ0rGP+4nbGkU+or+5+EgYd5JNUxJXwe43pCcHROOjNwjQAcWuURYHG
 t9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oI
 xi7owTcutMKjYd/Jao8ygbFr3VVd+9L2W5mOFWfkgrz6cu34JNt6Tlbteg7985HX6X6fqA4Q
 qJdAT87LW0759DluAfaQweX6XUSSmoZngNWDgbK8R/2Rpj+vDf0uep7wymaINb5TasoVjS47
 qdkUwHnhSEaPDMk6m7Xi8hwjKVGoBK9ohF03oDZbJ2JOPd4Y6jQZs0RS3ZfUclNVixBGoK8Y
 JUJD+odJuZTso3xq0IToReiGQWgAeXiwSJKiHDrx603y+cvHw/I0wI9AdwDrnrUotX3O6gOX
 u66w7LFzSnBYv5MxTvx9JbEfxInrPqRXbxwa83RyUw3Gg/LiVuQtI/lPy6T1usQqWeU6vJsW
 u2ui24ltQ5xpCWgyd02ioXHm4kYzU7E9SR7wIkrI923VVR0YcS+HJtVqiGaNJZ2QsU/TG5yo
 ys10LgGtoOhcCcWz5QnwgfSZvqaeIeH/hztTvyeIStkhH17YrK/gQ6//FSgx+DiSMS53llHo
 jZbn9TRtn4A2Rzd5MiHRPV9/Uqv1zmB2Q/O5+1ZIE05i6nWJpogz7A/lJcdv1rPECD1lUjwk
 aSYeEIk+u2y5OTmZLXrvoWTN4xuhQ3kN6QugcqyCvk7PAgWR2WW+fqw2Kf+8UHlXblGlP07n
 6jDvJzHJskXvrC1Dg5J3ost7huzEiuq388ZkHQCL19IfQyLgor1NFzLJf31DvGyiEm2njhx3
 fDJJLjhD43NLnfdlLfheq5w5lNExgYu195R+45YB74fLf39RkP9qMLUAgU+Mwyp3+boE9J91
 p4YWW2SGKOZKLnSsViU5u0xP+aMeI4VuDH7K/Q/4P7ukGM5mVsafamu3psbcmy3HvNjI0mBY
 HrshMkOEXsSswc+UuDmkkCOXSJOa3qoX68x5ys3BJ+lAIvbQ4Cimr2B3CO1Hp1MYWBGD0iBH
 njpd4WGRfgMbj+dLdV7kjAeUrahVowh1QyotADn0bVqNfDb+igFup75yNd14OjTmQko9TNoF
 8Sdz32NT2Zsk2wUQD85wLxwoU1mx1eY0al4huRYGsZJ6/NIVAc6L5/cwPZgB9D8QALNZs2JR
 0q+QtW6HTExSco8w9sUbEdzAdqiihTD0jGrAr8UkryEH4Y0/bjG03jwIcZ90XfG27M7g1koW
 MtDLWumibVn+AjJG4HJi1mZl7qtdakEwiLB7GiDwnSJvE9bSgB9SavKU20HakvMs9v5+EDMQ
 aW2BLQiKARByMqCJrJUZdLzllVGWOrjOM/Ab22rmmawAhCIyq6RYIb2ZmkRwDnRBFUHngwJ+
 naGKBQ+CTymo2LDCjxhCEjjY1v28el5tHO0UFM7zx2Lb01m0bq54BkVheGAS/MX2bIEvyQhp
 y9oE1a62tLaE8ePpwlgfKVZed4z+FhJ2mzHuQJhIpGuKbhuiUMbcwttpUPhyw16BJ1Zn8Yyo
 30m1BFyKbqW0F5ZbT2VwY3+NKDPJmnp5BCvZbbZ2lHA39aS/acC8O42pkn+sg+0RQIe9CBc2
 t9alluR4ZOCLgcVV9qlX0U5+QUg/+mCM3kV6Ibd1HkqOq6x5HuK+c8tBeJj7h+/dtNbGKKCD
 g77VcMAQ4CKKeUv03eodB4bO+devPowMMK8e+SB36KDM+NpnTbghmNCtsQ190uW9GJWUOnX2
 d5Ryeuf2Q2GWh//gU2nv8SxnppLM3VaPGOlzjPgDZAZRbxpcIICQTO2Lte61v1mioTgSzhT5
 gjnT28P28ayeRvaTkP03EUEyUUIqH2Pgjajwnp/lDR/6uK00T7H2fWqTh0FN3FQR2gq2VzhM
 4GunpYAW0qlcBMqlTOk41r3w+5Qo6EpayHrTFtFZWDLLW9rVrart/LWe8NT5YlurCdZWeChe
 lGyTr/7vgtc0iX/Em8Yzzc+IXXikJzjk1ReiWuaZCJisXzWPMpw2B7ZotjdTPl52jsAWTk+i
 D/LC1z6NN6sq5HctJ7C+t6zV2eoUJBVOX3oxILGqia74GRsDBuXm/G1h82hEA4m3Cu93N5vA
 2GAlwf4fYTwy6mgecRuYVNvD1z9o55hXId3jZE3j5IR8WMTg46I+3VBmmD2Z5ET9av4bXcJD
 RQCx8PJ6UCx1ERlL3+NgYjwUmiBy+Nnd8H8aWQTjHET9cdPXe2x8b9Zmyd85mS5rw/XbfFn1
 H9J1/os5XgWivtPvRcu0yORC5gbGEUeNivpwUfbp+uipblaMT78OYO701BzyJX4VOnqSmB0X
 X/4fsxnBips9oBkN0qK1nTv64bicd2WbNQJtxTSnQ2Tx/NNJscXkfwHzTFiJXq7pWcsnvA6j
 xFo0Zig+o2aKHhr8KuRCxtUcDbyYpBb4Snj2J5Xhd3exIWzBtNkEzQPUoHvSKeWETAfs/juL
 UCrDT4hrHuSMbPaEUmU70I152nXHcWTPmqMbGIc0c0kRBSZIxlHhxsIWTwhgpMjPiqMnfTbK
 BtS22hJvBj/twdGzf9uO1/nSGDDqQy0azAyDp+CMB5R6QIE7EDQWSCHxsR0GSwQvpiorQjWb
 3eeexwNFmYRHEqNG1HkOLCqo9jG6emRQOSkfbPIZv2VpOpSWu3tp9rn25Z6/zuKKsSEP2VzR
 /w91E1ZWHllGsPf0zwRQi0TnijJYoaVvhC5siFwq8m+9rzsVmeNrcORCrlfN9lm4VaznKSeM
 eKZrC98JXBT0ZZNjX7Exb4D3UID3jl0fmrIc/xIvirMQaTM365PWkNBLXorbY0VseRljlooW
 4aTkN7+279mg+RgDl5EUQekgcS1fYkRJHn7MlrbBUGNPbDAJDvRwsixb7nvLN8YxOhSqRC0v
 i6WVkH5OTHW3QfoVR2pPehWygSGPwFYtIiVexNhT2PkSZi1D3/zeM8yljAwzbAu0znUNGwRN
 zR1aQVIs76N6y9Rqvx6FypK6X8vfozm026JquLfLJgRq/5iBC95wvlb7HoNwLxQ9ChYRfZxl
 UM+t/ZWqkq92qmKwztjC19VrypTwZmMpQNkMLnY8Z9JXTDF+ggM5COeEUZCq9xgA9zp86der
 7qH3JzyKjpE/9vOu+4BBNXSJMuvOX8tdxHuHXbYARAEQjiiKWzEzxEH1qjKrzvI8N5j+tDlg
 9IWR6VeVUApG/9/aAwtB9EELJptH3slnbOdkM8U9C+7pRjVSt9du8OPXfaTDPPzbTeB2OQeI
 UJQmPWlc8JKZt6euQQqcFRxkYXUFlCFWNlMpnYkdQoouABW92A4SGQv2kXjYwfr4XkJFPfyk
 ARl72k2Kekr6jro5E86Y1TQoy5l2ncwm9jjjTmLNhvsL7q2UYh+Ai/48UM2N9moJmQ9JR33h
 kFiODreEvhvjrltc2xikkn5pJhSH/JVZaRBbFkbwvTdNJBKmRxM7y6gw0FA/+7MD5BvwRArf
 ZCbpHVFwwt/bdQxKP+YNO9Tw1NXnK7Loj6w27V73loFP0hUujD3GmZAqAkSO7IhPSbt4uF89
 VnIhW5YYGZVH/sy/qA2rgVsYaLYiXqniuMLK1jtZbDHafrB5C6Y05bPGw1VtAtAllEZr+Usl
 557KwzMERholebZFgxVZ5eYb1gNNYwKsiCUJHjGsP2Rk88vedzlTaawC7fJ7flx4ArsHR51T
 d1UsoJdQd/0lhmfdJivLaZbm08kvF25fQzcXvoVIErZwnBb86TdhNd2xdcPfDhFWDckaHzl6
 OqP/V14x6bSFNYuPCVAV9NdZCtvAZ+0x3YC7SQYVGHlgKVEkW3gp3f9vnqCVjCkNog6Pa7Ga
 080U4O9oW1nofrx1Aef842AdTvzbY0w44aWu+1G/83VBasMFesv9BqG08xRQ3jgO4LWOea8P
 IO4K4wlbNivT22/TkT6kDUtCcH4INeqKKGMxwDuX4dd9oeBjngvMsq0FzdWHBkVxalL/KVne
 QgKeIY2ezbCkV0GDfTjCzrAio/oRHuxIzxLSfUZ1f+9e7Fc0ysraKm91WckSZY5ieKw9CtvD
 NkGgwrfyvCqe4RFGXWpXCUFIkOS+2xgxyBoLa4qz/06wQ/UvFVUKD2NeOFzKSRFs9w6GVKOM
 CB2B24/FDr+xcLI5g+h2axX/jMIwowSiLUc9iWg+MaPM1fOEOSxpJ7YsjQtd40jqqx1asn4J
 9ee8YjZhnrZRYXRtQuMVGi7EeBbk55eOnE9IrEAlGc7NMgBoYcE51A2U5J0Gb1NBa8gr6rsT
 CdnECgexAcQUo/G1zsHyLTZufOShlKLfZIuPQZR+o1FmccYWjVqbzk2jon6b7+Oy0S5EjBRZ
 gAO8Q5L+QQM0Jdqefzo65bJS5kKzCNKp/VzUW3AEZwipD6ZAimGxFP/Tvumiemg2wlfment3
 tcsUxl6EUFBxuxSmxhgOPRtJqIXpIKPri6QeBawojf20OX/bgo0q4WcZxjiAYHCr2a5TiAM5
 SheW9pU0H+GXZUKz1glMOB6/hMUZtjhIxu25iR4ldgxWeDgCobzgQ5i9ChjJW/iEsIdWbw89
 guPAHs9Jcjs8citOo0OEDIKvsTF8REB1h0qanDxyIIAeZwXpGdUB34X523a5YTXKoUL2NcqX
 cZUfpEj5DGlXvsDYcfZomVo6ObmkiaLomll4lnmnG3hSejkH4c7tyUfAlt7fW3G8xt2VrJ+/
 DuKqQKf9Qwlt+ZDWOrVhB0o8m8kR8JAWm4ShyD9dwwhHj4b6oA4YOzUa5IOGfBqPE32YkVsG
 6J+hB6CpRkszyW+PnU6txMEqXrUB1BmDHBM0LmxwWZMpJn/YW1IDM8SJXAoayOPQ+p6sQpx5
 S5lMx1BZshBWJBC5q0R2pZS8ozaU0GwJCoZXRtkcAUlzf5Ykk0Fu0KdK3m15e+AfPPD9BZwe
 JXJxCZGBP388EFMjYa16YgF
IronPort-Data: A9a23:3ew4BqMM1xIftQjvrR2qnMFynXyQoLVcMsEvi/4bfWQNrUoi0j0Ax
 jYfUGCEb/fcNmX1L4h2b9vk/EJTvcOAmIMwHAZtpSBmQlt09fbIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVqicfHw3HVY6IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bNNwRcawr40Ird7kky1BjOkGlA5AJmOqoX5AO2e0Q9VfrzG4nhdxMUfaEPRoZWd
 86bpJml82XQ+QsaC9/Nut7Tbk0QT7fOChOFg3xQVrLKqkAqSvsaj87XnNJFAatmo23hc+JZk
 b2hhrTpIesdBZAgrcxBO/VuO3EnbPceoNcrFlDk2SCb5xWun3IBWJyCBmluVWET0r8f7W2ja
 ZX0gd3CB/yOr7ve/V61dgVjrpkcJefWFqY1g09b4zyGSswreLDvc7qfsLe03B9o7ixPNdz4P
 vIjMWZEUUyYOVtIJ0sdD484kKGwnH7jfjZEqVWT460q/2zUyw8327/oWDbXUoHQA5wNxwDF+
 CSfrwwVATlCXDCb4QSE8H+qiubV2wbmW58UGLSQ//tmxlaUwwT/DTVPCAHr+qTg2h/Wt9R3O
 UEk5xsI9fUJrXOMbfLQUUaTmC+vsUtJMzZXO7Zhsl3SokbO2C6SAWMPTxZaedk+vYk3QyYr3
 xmHhbvBATVwubmRYWCc872OpHWzPzIUJCkMf0c5oRAt5tDipMQ+hwnTU805GbyyiISsQWiom
 2na6i8jm78UkMgHkb2h+kzKiC6toZ6PSRMp4gLQXSSu6QYRiJOZi5KAtGfSw8tqCaygcGKvs
 SdDocWnzMw+EsTY/MCSe9nhCo1F8BpsDdExqVtmHp1k+j2252O4J4lC5zcnfR8wap5dKXnuf
 VPZvh5X6NlLJny2YKRrYoW3TcM30aznEtejXffRBjavXnSTXFDalM2NTRfOt4wIrKTKuf1lU
 Xt8WZr1ZUv28Yw9kFKLqx41iNfHPBzSOl8/tbiglE77jtJylVaQSLwfN0CJYPxx56SeuG3oz
 jqrDOPTk083eLSmPEH/qNdPRXhUdyRTLc6t8aR/KLXcSjeK7Ul7Wpc9N5t6I9Q9x8y4V47go
 hmAZ6Ov4AOn2y2WcFTaMysLhXGGdc8XkE/X9BcEZT6As0XPq671hEvGX8JvIul1x/8p1vNuU
 fgOduOJB/kFGHyN+C0QYdO55MZufQiiz1DGdSe0QikNT7g5TSzw+/jgYlTO8gsKBXGJrscQm
 eCr+T7aZpshfD5cKvjqRsih9H6LhkhFqtlOBxPJBvJxZHTT9JNbLn2tr/0vfOAJBxbx5hqb8
 Ae0Wx4nve3HprU1+9iUmay7s96jFtF+J2V0A1vwsLS8b3Hb2kGBwoZwdvmCUh6AdWHz+ZmSW
 /9Z8Kz/AcYXo191q452FoxrxqMctv/Eha5W8RRgJ1rPN2+UM7JHJmLc+9tirYhP++NpghS3U
 Uex5dVqA7WFF8f7Glo3JgB+TOC8+dwLuzvVt9IZHV7b4XJpwb+5TkliBRmApyhDJr9TMol+4
 +MAutYT2jOvmCgRLdeKoSBFxVuidkVaff0ciagbJ4v3hi4A6FJIO8XcAxCrxqC/UYxHN01yL
 wKEgKbHua9n+XPDVHgODlnI4/tWgMUfmRJNzWJaHW+zpPj+uqYV0iFSoBMNdSYE6jVc0ul2B
 HpnCF0tG4WK4AVTpZZiW0KCJlh/ISO3q23L9ksxtWzGTkOXeHTHA08jNM2sok0I0WJuUQJK3
 bOfyV/mDSbXUuDu+AYUZ2tJgu3HSI0o+iLghsyYQsehGbMra2Hfhp71X3IC8Uf6C5gP3Efo9
 Pdj7btyY/ejNAo7ga4yO6+F35s+FTGGI21jR6l63aUrRGvzRhC76QKsGWuQJPxfAuPsylCpL
 fBhPeRNXEmO7zmPpTUlGqI8Gb94s/o37t4keLmwB2o5n5aAjzhuorTC3zPfgTI1ftBQjsoNE
 IPdWDacGGi2h3EPuWvsrtFBC1Woc+s/ewzw8+CkwtonT6tZnrlXTngz9b+os1G+EghtpUuUt
 TyeQZ7m9bVpzIA0krb8FqlGOR6PFuryc+a16yG2jcVFaILeEMXJtj5NkGLdASZtAeIzVeh0x
 JO3i/ym+GPevb0zbXLVpInZKYlN+veJfbR2NuDZESBkuBWsCeHQ5ykNwWSaEaBysch845CnT
 jSoacHret8yXcxc9UJvaCNfMkg8D5bvZ6LeuBGSgeWoCUFE2Ff5MeGI21bYUjhYUiouJZfFK
 xTVvsy27Ytyt7V8Bx4jBtBnDaRnIVTlZ7AUSt3puRScDUiqmlmkuLDysTYBsBblUmKlFuT+6
 rL7HinOTgy44vz0/YsIor5MsQ0yJ1cjp+sJJ2Y22cN80hK+B044ddUtC40MUMxoo3ajxaPDR
 W//aUU5An/ARhVCSxL35erjUiq5BuAjPtTYJCQjz3iLahWZVZ+xP798yhhOu3tGWCPv7OWCG
 +Es/nfdOhuQwJYwYc0x4ve9o/lsx9KE53Yu1H3+rffPAEclMe1X7EBiIQtDa3WWWYWF3kDGP
 nM8Sm14UVm2Axy5W9ppf3lOXgoVpnXzxjEvdj2C28vbp57d9uBb1fnjIKvm59XvtijRyGImH
 hsbhldh4lx6HlQ5n/IRgYp1qpIsUajNGdWmJqj+QwFUh7u39mksI8IFm2wIUd0m/wlcVVjak
 1FAJlAgUV+dJhk5NKK+kG00F1BZCxrgzA0lSCb2oDOAmhs8pzQcUwb/1xr1cPkctIC613i1g
 14ugIK5qlia8jDjoFGScxjdSkOvWaksKJUPbszkol4eXPthpK+x2Y2NC30H6u8=
IronPort-HdrOrdr: A9a23:5Iy8MKwhU9OLkzm6YTxSKrPxwOskLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9wYh4dcB67Sc69qADnhOdICO4qTMqftWjdyRGVxeRZgbcKrAeQeBEWmtQtrZ
 uINpIOc+EYbmIK8/oSgjPZLz9I+rDunsGVbKXlvhFQpGlRGt5dBmxCe2Om+yNNNW177NYCZf
 ihDp0tnUvdRZ1bVLXMOlA1G8z44/HbnpPvZhALQzYh9Qm1lDutrJr3CQKR0BsyWy5Ghe5Kyx
 mMryXJooGY992rwB7V0GHeq7xQhdva09NGQOiBkNIcJDnAghuhIK5hR7qBljYop/zH0idirP
 D85zMbe+hj4XLYeW+45TPrxgnbyT4rr0TvzFeJ6EGT1PDRdXYfMY5slIhZehzW5w4Lp9dnyp
 9G2Gqfqt5+EQ7AtD6V3amFazha0m6P5VYym+8aiHJSFaEEbqVKkIAZ9ERJVL8dASPB7pw9Gu
 UGNrCQ2B9vSyLVU5nlhBgv/DT1NU5DXituA3Jy8PB96gIm00yQlCAjtY8idnRpzuNOd3AL3Z
 WHDk1SrsA8ciYnV9MNOA4/e7rGNoXse2O5DIvAGyWRKEhAAQOHl6LK
X-Talos-CUID: 9a23:RRrgvWAx9RyT96v6E3RY/WApMOUPS0Pm4nqPZHW1MEZFeKLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3ATdhcVA99DIQeH7op4uwInuKQf9Vl07mfLhhQqsw?=
 =?us-ascii?q?5nOqvGCIrEA/MpzviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152835189"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFpue2JrTtCg6RCnt4Ih+DV7SXlQmR+JLJh61?=
 =?us-ascii?q?6f91UwD7ya97grRyGoHoGTtpjpJc2AwqyHhZaBAwTSHv7Bmo1mbjGIJB?=
 =?us-ascii?q?X6JL1XErp4F1g75vfU0Gr2Uq8qMuCJrdumWVSp69e8B62jzB7HRc+cBN?=
 =?us-ascii?q?Vo8m0Ns0TGRy4GOwOqrpnfqQ=3D=3D?=
Received: from mail-eastus2azon11010018.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.18])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 07:06:02 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMaq29DqcOES40g+rxuqPQtDJQqiYY96c01F4YeT5nsbriclYjZZaLOOlwfOtpzKNCCgigZkaJwRv6MZVQusaE6nEAXhG7+/27SHsnis+iPhEasgDC0A4p6e/r32OJjnVzctdedafSaWWdMn+x4f17FgzgBmhBIcRR1KF9qQLH95a++hY6aOJYWW1QfDf+ozc+iaSWx4aoYnyvouQBmQ4FfD81jlB/cQhsKZVOINETc4yfgQizx6PfkAXe36611Y3hJLVPb3wtgpXGilxqNitY/U3nAPlHLl/Ld5BiK1uQN8kxjgpTBLXJzY2IKM4tu9cVmtDM9i9luODBLkDemKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/We2fES3DvWZfOA0GaOmUB9kcX+Pood0ugmqxojMX1s=;
 b=K1aA4gf8NKkOv9f8PqN9ZPorULBe7HVE+hup33RN/Z1BId4RapjnJLmjbJ6d153of2DwdS5qAWpm0wRZ77bmsqgxjV3bIJ5Va5hRS9YoZ+sjbzbG0RekdnGrq9zfH1WnIoXyjgu7ZfdP0xsPpFCesUdMTUy3s9uopmkDoHnNUqEkVwpW5HvmoV9W13lZupMn6ezTN98/ddgg/H+edMzrKoGrzUuXwQXxVNkTumi9F78E3aIbVH9VbxzoSWwYwco/UTeKT3eRlKXTzow3k62ymKvE0gbogtUWOnF41OMsOn+DcsQoBKx9abVIYDskTi1pTZ7cqtAAzXBF/D34UDvv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH1PPF989868826.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 05:05:53 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 05:05:53 +0000
Message-ID: <53a757fb-c716-4f71-bb43-80a3e04a3b8f@amd.com>
Date: Fri, 24 Jul 2026 10:35:22 +0530
User-Agent: Mozilla Thunderbird
To: Sang-Heon Jeon <ekffu200098@gmail.com>, Julia.Lawall@inria.fr,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 sound-open-firmware@alsa-project.org,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-15-ekffu200098@gmail.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20260723184538.3888637-15-ekffu200098@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::11) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH1PPF989868826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d16d970-d60f-4a7f-d693-08dee9413c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|921020|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	YSv43cWBvKYvDaYm/mLR6UOqoRfLgrXlwE2v4bfev8ILYsreK8V9luI68cxM1jGI5Co1gSgVHzD5yzC1h3iNlAHB+mW/vr1YGMFGVHIsXOiGwhCd9gc1KGULtAXe9rmNFW0KkdB5qGc5qShfG7gYJSMmcY4E15pSl6TdOFyUBar/rkBp2L947bQW+E2QtiOizjtpykxmV/dntjiJRMY4dzkHwpzdVQspwyGszgYbEst5lG5Bei76M9ECeQa/BSQZceJGm9IqUlN/Mq40W3GbKfUCRQfSLfqMdafw6U0dQ+W8hNygKVPTFOrRhVgYLld+j6tb4QDrexcbeAl0+BU8CQhDGb2UxVKE6AK7U7kmgLlAo4PsiKCVUIWhDoD1YKhRiX2SJZuw7kA9qmzR2W9u4cNbfVLrX/EQTq/unFo617LC4n4ybeLljnx8z1CYpC+xM5QHAjeZbWQRgdICZYbqCekY6T5UlfkDJOpa+4V0FTWUo6S2qRkh+9kQ5pHzNpLqBtSLI2CI5LesNJUvwh3qsqxFA2hXjzY4PdV45cskr23OS+F0dFkFEPo0Fn+MgiTL7EINCefo0V0VkBR7lTS9eb5NJnuRtAxUntPRMCsqg/M8v+VTkujkJoUhuIrkgi0Yfdfs6V1smf3f+vtBrB2MnD7sl4cg6EpZ9rh6xPU/XM9GWafqGczRQ0vqx+ZMaj74l6OlmlVi+pGcFiELg8PHRA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(921020)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU1PTnVuN2c3ZUwyWVpJREdiUHRleW9LU0ZwdDNFQWRwQjFiR09MUmVNdmJ6?=
 =?utf-8?B?ME1OYWZtU3FUZzNQcnZGMU14NmVveE1VQUdxY2RIK2x4K0RCajZlSHVPZ3Zt?=
 =?utf-8?B?ckpzZHNyc0gyMk1iTlV1Vjl3MGpyVDF6NTA1QkNwbjR5ajF2TjdGVmFYVmRj?=
 =?utf-8?B?T2NROTRlRFd1SnU3SGhCN2Y3Q2hjVjR2YjJzaEZGUDJnK00yRlNrOXNGZVEz?=
 =?utf-8?B?UWQwcDJZaW1GYU1jZEVxN2dIcHYrSEN6a1JJSXVLODRycmpSZm5CeUIxVmwr?=
 =?utf-8?B?Ykw1Yml6L3ZyU0xtaFNyb0ZLV002Q1ZCdUhtSnQ2OWNrYmVGS2JFOGRWeW1E?=
 =?utf-8?B?YXM1SUYwK0tiTlZVVWxUSHVmUWtGYWlDaXR4VVlBU0ZTdFJVN2lrelE5ZVhp?=
 =?utf-8?B?UHpFWjBqVWZHaG1WQ1kyeWNRZW9wUzlxanFCS0psUVdVWDVhVjNSME92NjF3?=
 =?utf-8?B?ejZxVmwwL0taR2hXUHdWaWNxUlJiOWZnekIrcmQ3ekF0Wkh3Z21HdHJHSFlK?=
 =?utf-8?B?UDRsR2hUWldndGFaT0VrUWJWUVcweWJnT3p6TVI2RkdOdUQ4SkI3V3dNbjNW?=
 =?utf-8?B?S2J0R01GOHZ4YWptc3ZSMDg5aDExdC85a1o3YWYyYjcyM3RvU2U3YkVWRElG?=
 =?utf-8?B?T2p6SlBwMkJKQStPQWhqS1R6dXZHS0ExR0NVQkxxNUxuZjQ5VHdoQ25YZisr?=
 =?utf-8?B?M2o0ZWJUYnFGTWNFN2JuOUVFTVF2QnRyMVluaHg5SzdrWnAwV0JIcGt1UVBQ?=
 =?utf-8?B?VFBOR2REL1l1R2pYdG12K3FKN1Q0N21rUmhBRXQ3Q0hMYlBZZHpRbFE0UWk5?=
 =?utf-8?B?dzBrTUNKZ0MxczdMdHRaSWJFU3pYU3FHNXl1TWZiTDdvdzJnd3ovNDhRWXpj?=
 =?utf-8?B?Z1ZHR1hDcUpOenBoZkt2OXpEc2grMFhvK2U1OVBzclIxNVZqeld5NSsyWTcz?=
 =?utf-8?B?UnNmUzc4YTEzQ000U2IycGtsZWpxMi95UFFNVWdINDNuRGNUYmIramk2VkNB?=
 =?utf-8?B?S0Z1RGhYajNBTnVMdXBCbVQzcW50SFNFNDkwbUdrVlA2QzgvL0hlYTVkY2tC?=
 =?utf-8?B?cTdCQnVNVlhaY3g2emdwbzFDa3hWaitzaE1QZytmWGFZYlVUeW1JaXNFR3Jl?=
 =?utf-8?B?SkJ2MERrd3VqeExJc21IY2JIdzlURXlnOTB5K215U2paRjBHRGJZS01yOGt4?=
 =?utf-8?B?aXA2eEM0V2FQN0lCT2JDMG9vc2lWSTFvRmlWTnRZUnlKSUQ1UENrOU1iMlVJ?=
 =?utf-8?B?bUNUd0hZcXY1WDMranpYNmU2U0RtUFhDQ1dVL0E3S1gxZDVTNzA2Q3drbEFq?=
 =?utf-8?B?bEZaN2w5RlVKajRWcWN3N0ZlZmhGNEtCMTBFUjhQVXR6K0NUa3IyVUlhK0V6?=
 =?utf-8?B?ek5lVGZ2VWorcXhjaGVUYzdHWnJZMHNlTjRwQ3ZVbDg4QzV0T0xYNHhiVGV2?=
 =?utf-8?B?ZGJjR25QVlZxSWxraWF0cko5UzY4cmJZMk8vTDMxRUR4VlNVcm13YTZFaE95?=
 =?utf-8?B?UkxWZFV2c2YvektUZ1BUdWlGNWNYQlFzb0NYNWtYbmxWYWVHYis2YlQvVUc0?=
 =?utf-8?B?dzUrQVF1Z2UwNUhMTytWSXk1c3ZMd1VMbmVTSlZBTVllcjFwU3RFUmZsUyti?=
 =?utf-8?B?dUY0dVdqN0dwYk9JZW12enFMb0JEeUpmTWJNMStGcmhBanhLZWRKaEJLUFJ6?=
 =?utf-8?B?VzdhT2V4UFp3Y1Y5S0dFMHFUdTRrKzdPc1hBK2d4a2g4b1VWVURSUEdiR00x?=
 =?utf-8?B?QUtEdHJjWGM5eXUyRk83NkpqL0ZXT1NUMHRrb3kxaWlHMDFjTWt4a3V2NTZP?=
 =?utf-8?B?UWptOXdjY2JqVkJhd0R1NlhoU1RhZWxOZFpPR0xFV2JPVnU3bHRzSlIrRHVX?=
 =?utf-8?B?ZlowRXRVSjg2VVlmaEpDWnpWem1jbkY0L0pMby9VZ291V0x6NUJaV0Y2eWJB?=
 =?utf-8?B?VElyUUx3ZkdzZkpNeHJUTmtBMnJqRU5VVDdWTUk4Vjc2Rkh5bXMrS1l1U1ZY?=
 =?utf-8?B?YlpTcUJrRnE3TERmcUtydEFiQkw4QUZEVHZxblFVSnVkWUxPUDBQNThyMm4r?=
 =?utf-8?B?RnlLSjZnNG0rWHlsWVJVVEhoQzVjelRLd2dnblVkV3V5WkRLRnNpT3d6VEk4?=
 =?utf-8?B?V1pLSDJQOWFBMVJvNTFWajJPRlBXcXFNTEZvWUp1cFR6WjRDYUg2Y0VYTC8w?=
 =?utf-8?B?TnBiU09ub1pWbEtWVkJUdit3TjE4WnZGTmUzaXhsc3BrclowUkRPdFBndFNw?=
 =?utf-8?B?bWRmZ3JLdDFLdTBsTDFpQ0RLSDlwbkRWVkloZ0pNK3RHSEpPRXc0RHJwZVJt?=
 =?utf-8?B?VEgxcFhVcm5QVnQwK3RrRmIzK29taFRabG5GbENXOUZnYzVXZXFWUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d16d970-d60f-4a7f-d693-08dee9413c9c
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 05:05:53.6129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yU7JnGtL4jLNEYq4jlancYrAtSWwNSfjD4VKxiWlyiRXZ57TndQjerd8aHGOzEVdGBBwisl4YzecvR2N5jnnPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF989868826
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 14/36] ASoC: remove conditional return with no
 effect
Reply-To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
X-Loop: cocci@inria.fr
X-Sequence: 3643
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/-1GPN1Cx32dyK_Rxk1u9Ow>



On 7/24/26 00:15, Sang-Heon Jeon wrote:
> [You don't often get email from ekffu200098@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
>
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
Could you please separate the changes in to vendor specific patches?
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>   sound/soc/amd/acp/acp-mach-common.c          | 11 +++--------
>   sound/soc/intel/atom/sst-mfld-platform-pcm.c |  7 +------
>   sound/soc/samsung/smdk_spdif.c               |  8 ++------
>   sound/soc/sof/intel/hda-dsp.c                |  6 +-----
>   4 files changed, 7 insertions(+), 25 deletions(-)
>
> diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
> index ef784cca13f2..01a0aaa60246 100644
> --- a/sound/soc/amd/acp/acp-mach-common.c
> +++ b/sound/soc/amd/acp/acp-mach-common.c
> @@ -938,15 +938,10 @@ static int acp_max98388_hw_params(struct snd_pcm_substream *substream,
>          struct snd_soc_dai *codec_dai =
>                          snd_soc_card_get_codec_dai(card,
>                                                     MAX98388_CODEC_DAI);
> -       int ret;
>
> -       ret = snd_soc_dai_set_fmt(codec_dai,
> -                                 SND_SOC_DAIFMT_CBC_CFC | SND_SOC_DAIFMT_I2S |
> -                                 SND_SOC_DAIFMT_NB_NF);
> -       if (ret < 0)
> -               return ret;
> -
> -       return ret;
> +       return snd_soc_dai_set_fmt(codec_dai,
> +                                  SND_SOC_DAIFMT_CBC_CFC | SND_SOC_DAIFMT_I2S |
> +                                  SND_SOC_DAIFMT_NB_NF);
>   }
>
>   static const struct snd_soc_ops acp_max98388_ops = {
> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> index 9ee4d9926e06..a4c8cbfba096 100644
> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> @@ -236,12 +236,7 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
>
>          stream->stream_info.str_id = str_params.stream_id;
>
> -       ret_val = stream->ops->open(sst->dev, &str_params);
> -       if (ret_val <= 0)
> -               return ret_val;
> -
> -
> -       return ret_val;
> +       return stream->ops->open(sst->dev, &str_params);
>   }
>
>   static void sst_period_elapsed(void *arg)
> diff --git a/sound/soc/samsung/smdk_spdif.c b/sound/soc/samsung/smdk_spdif.c
> index 2474eb619882..515e4dfc1432 100644
> --- a/sound/soc/samsung/smdk_spdif.c
> +++ b/sound/soc/samsung/smdk_spdif.c
> @@ -130,12 +130,8 @@ static int smdk_hw_params(struct snd_pcm_substream *substream,
>                  return ret;
>
>          /* Set S/PDIF uses internal source clock */
> -       ret = snd_soc_dai_set_sysclk(cpu_dai, SND_SOC_SPDIF_INT_MCLK,
> -                                       rclk_rate, SND_SOC_CLOCK_IN);
> -       if (ret < 0)
> -               return ret;
> -
> -       return ret;
> +       return snd_soc_dai_set_sysclk(cpu_dai, SND_SOC_SPDIF_INT_MCLK,
> +                                     rclk_rate, SND_SOC_CLOCK_IN);
>   }
>
>   static const struct snd_soc_ops smdk_spdif_ops = {
> diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
> index e9f092f082a1..b9b2bdff4ccb 100644
> --- a/sound/soc/sof/intel/hda-dsp.c
> +++ b/sound/soc/sof/intel/hda-dsp.c
> @@ -1114,11 +1114,7 @@ static int hda_dsp_s5_quirk(struct snd_sof_dev *sdev)
>          usleep_range(500, 1000);
>
>          /* Restore state for shutdown, back to reset */
> -       ret = hda_dsp_ctrl_link_reset(sdev, true);
> -       if (ret < 0)
> -               return ret;
> -
> -       return ret;
> +       return hda_dsp_ctrl_link_reset(sdev, true);
>   }
>
>   int hda_dsp_shutdown_dma_flush(struct snd_sof_dev *sdev)
> --
> 2.43.0
>

