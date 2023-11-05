Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795F1C4332F
	for <cocci@archiver.kernel.org>; Sun,  5 Nov 2023 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=XnlbwNHie530LxC0yiFLhQqwtRmGYWrWwVFbbdKDN4o=;
  b=KhDIr31orw7gS8dIpM5T48xBRpkDwvJ7jS7l0hjrSmLiNsW8xiE0sFcQ
   I22uuO0RXyL8UJ25qAc9py5qLAhISsEU7qzxt2BMbZuRN+ExlOW8dHjGt
   uexDf1s8xZkD127EN47oQ/7qDNFMrrSi/OM6SUj7ETLUa7/FTuNrdQFZp
   c=;
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
X-IronPort-AV: E=Sophos;i="6.03,279,1694728800"; 
   d="scan'208";a="134660349"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2023 16:50:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 55257E0CD5; Sun,  5 Nov 2023 16:50:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9751BE00B6
	for <cocci@sympa.inria.fr>; Sun,  5 Nov 2023 16:50:20 +0100 (CET)
IronPort-SDR: 6547b9bb_48pDFMRiZTyH5iRsoEuTnuWvVDsSKTQx2BlfFBhgf6CaclS
 rc97gBnERc3tEmsnfKplpPmlsQyzVdKtVMqEEDw==
X-IPAS-Result: =?us-ascii?q?A0GTBAB4uEdlhwMP49RaHgEBCxIMQIQIgVAwBAtIhFORM?=
 =?us-ascii?q?YFDgyiHNIdKiG+DFj4PAQMBDUEBAgQBAQMENwGER4cmAh4HAQQ0EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDhAnhWgNgjcrARGBD?=
 =?us-ascii?q?IEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHawQZAQERJgEuAQUCJgJfARICAQGCe?=
 =?us-ascii?q?oIqAQMxB6sOfzOBAYIJAQEGr1QfLCJVgV8JgRouiAoBhVGEXA+BVUSBFSeCS?=
 =?us-ascii?q?wdviB6CaIkuBzKCI4NTjHyBAAVCcBsDBwOBABArBwQtIgYJFC0jBlEELSQJE?=
 =?us-ascii?q?xI+BIM0CoECPw8OEYI/YTYZSIJVCRUMNARGdhAqBBQXgRJuHRUeNxESFw0DC?=
 =?us-ascii?q?HYdAhEjPAMFAwQ0ChINCyEFVwNFBkkLAwIaBQMDBIE2BQ0eAhAtJwMDE00CE?=
 =?us-ascii?q?BQDOwMDBgMLMQMwVUQMUQNsHzYJPA8MHwIbHg0nKAI1QwMRBRICDAQOAxkrH?=
 =?us-ascii?q?UACAQttPTUGAwsbBj4CnySCdnsTgnbEWTQHgjGBXoFfDJ8jBhMvlyAOBpJLA?=
 =?us-ascii?q?S6HRpBKIKgxgXojgVwzGiSDNk8DGQ+OIBmEEo8JAT1ANTsCBwsBAQMJhUYBA?=
 =?us-ascii?q?YNagikBAQ?=
IronPort-PHdr: A9a23:BxwU8hZUq7mm4j9Jy7+bDd3/LTGP2YqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1g+PBNyBoK0Vw6qO6ua8AzJGuc7A+Fk5M7V0HycfjssXmwFySOWkMmbcaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 Au1oAnLq8UanJVuJqkzxxbNv3BEf/hayX5yKV+cgRrx59288IJ//yhVpvks69NOXaLmcqoiU
 LdWFi4mM2c75M3qsRnMUw6C7WYCX2sVjxRFHRHL4An1UZntvCT6sPF92DSBMs3tUb80QzWi4
 Lx1RxLulSwKKiQ28GDTisx3kaJbvBesrAFxzoLIfI2YMud1c7jDdt0GW2VOQsdRVzRAAoyia
 YsPE/EBNvtco4XkulcCsQeyCQyqCejyyDFHm2X20LU53eovHg7J0hIuEdITvnnKsNr7O7wfU
 fyszKTS0TnPc+1a1DX75YPVch4hu/aMXbdofMTW00YvDQDFjkiLqYf4MD2V0uoNs3Ka7+pmW
 uKklmkqpQZrrTi1xccsl5LJipgaxFDA+yV52oc1Jdu3SENgb9+rDoBfuzuHOIRoW84vRXxjt
 ykmxLMco5G7YDQKx4o9xx7Zc/GKfZaE7g/sWeueLzl1mXFodbGwihi870Ss1+LxW8mq3FpXs
 ydIkMXAu3EC2hHN5cWJReZw80ai1DuLywze6uNJLEYpnqTYM54s2qA8mocNvUjZACP6hkf7g
 LWLekgk4OSl5fzrb7Hpq5OGOYJ4lxvyP6cylsClBek1Mg4DVHWB9+umzr3s50j5Ta1KjvIol
 qnZt4jXJcEcpq6kHw9ZyIgi5AikADu8zdsXg2ELLFNDeB2Zk4jkI0/CLO3mAfulnVigjjVmy
 +rbMrDhGJnAIGDPkLL7crZ8705cxhAzzdda559MDb8OOujzWkzstNzDFBM3PAi0w+j9CNV80
 IMeVnmCA6GHP6zJq1OH+/wgL/GKZIAOoDn9MeQq5+byjX8lnl8QZbel0YMNaH+kBvRmP1mZY
 X30j9gdFmcFohYxTO3xhV2ZUT9TYm6yULgm6jE6DoKmF4bDSZq3jLyPxie3BodWaXxeClCQD
 XfocJ2JW/MWZyOcOMBhljgEWKOgSo8g0BGhrxX6xKB9IurV/C0Yr5Pj28Jv6+3djxFhvQBzW
 uaA12CEB0V9gWoMQ3di/r17oEU77l6c2Kx8q/1eD91aof1TBENyHJrR3+V8B8r/EijMetOOT
 lfuFtyiDCE4SN4rzpkEbkJ5HNOjphrE2DauArlTnLuOUth827/W3n65DMF70GrP0rJp21A7S
 MpJc2ahgLVj/g7IL4vImF+enKarbeIX2yubsC+oyWOTsEBFGCR9Q6PIVDhLbU/fsNj4+wXIQ
 q2oBL0PLhZRzsjEJqZUPJmhq1RNQ/PqI5zwbnirli/kAxeDwbeFd8zkdn8H0Q3YCUMelAsT/
 G7APg87UGPpnmbQRBxnE0n0ZEWkpfR6pjW7R0kv1AaMR0lg0bOv/VgSn/PKD7sX37QZqGIkr
 j5cAlmwxZTVBsCGqg4ne79TJZs54VFaxSfQrQk4PZG6Ka1mrlofaBhs+ULo2Q9+BohJnY4tt
 nxuhAl/M6SV1BZDfjWZwZfqIZXJJWTouhOicajb3hfZytnF1L0I7aEdok/goRrhO04s6XRh3
 JEB9nKG5YjRSicWX4jwVEkf6BVw4b3XNHpur7jI3GFhZPHn+gTJ3MgkUa58kk7Il7Z3NaqFE
 FS3CMgGH421L/RsnVG1bxUCNeQU9aguPsrgeeHVkLWzMrNGmzSrxX9C/Jg7yliFog91UO3Vx
 NAox/+C3w2IfyjxhhGtv5O/gphKMAkbBXH30i34HMhUb6x2c5wMDDKLKte02844qprjQX9e+
 3a8CllA1ML6MQGKYQnb2gtdnV8SvWThmSa8yGlslCo1q6OEwCHU6+HlaQZBJWNBAmVv5bv1C
 a6zid1SHE2hbgxy0QCg+V6/3K9D4qJ2M2jUR05MOSnwNWBrFKWq5PKEZIZU5ZUkvD8yMqz0a
 E2GSrP7vxoR0j/yV2pYyjchcji2u5L/1xVkgWOZJXx3oTLXY8Z1jRvY4dXdQ7ZW0F9kDGFdg
 CPUG0P6Et2n59SSmL/cv+r4W2/gHpxffC/3zJ+R4TOh7D4iChm+kvav39z/RFJji2mhjYYsD
 HiO90WZAMGjzamxPON5c1M9AVb975E/AYRiis4rg4lW33EGh5KT9H5BkGHpMNwd17itCRhFD
 TMN3dPR5xDonUN5KXfcjafwTHaA2Y1MY9egY2UZ8j0w5YZGBe3Hid4M1TswuVe+oQ/LNLJYl
 y0e1OBoxXoUmeAPtyIywy/bDr1YTiw6dWT80h+P6d65tqBeYm2iJKOx2ERJltekFLieowtYV
 R4VY78aFDRrpoV6OVPIizjo7538PcLXdZQVvwGVlBHJi65ULogwn7wEn3gvNWX4tHwjg+k16
 H4mlbSzpouaMCNA+KyjAxhXHiL4bYUf93nhgL1fkcCfw420Vs84QHNRBsSuFK/uS3obrrz/O
 hyLESEgp3v+e/KXBgKZ5Ep87jrOH52tK3CLNSwcxNRmSgOaIR8XiwQVUTMm258hQ1rznoq7K
 hg/v21XvQ2dyFME0O9jOhjhX32KoQ6pbmxxU52DNF9N6RkE4U7JMMuY5+Y1HidC/5TnohbeT
 w7TLwlOE2wNXVSJQl75Obz7r/zJ6euFHayTK/XUYLOBgfNTXbGEyNj8t+kutybJLciJMnR4W
 rce01BAQGs/NsDXgTQJRAQImiiLY8PR93LesmVn68u49vrsQgfm44CCXqBTPdtY8Bezma6fN
 uSUiXUxOXNC25gL33ON1KkH0QtYlXR1bzf0W+dl12aFXOfKl6RQFRJedy5jKJ4C8fcnxgcUc
 c/D1oGvj+Q+1KRqTQ4fCxq4wJHuP5FvQSn1NUubVhzSbvLcf2KNmpyxOeTmFPVRlLkG7UTq/
 2zBTAm6YXLb0GO2HxG3bbMW1X7dY0YY4dDnNEwxWS+5HbeEIlW6KIMl3WdwmONpwCqXZChEd
 mIiO0JV8u/KtHwe3a85QTQeqCIid7bMmj7FvbOBddBJ670yU34yyb4duipfqfMd7TkYFqwv3
 nKM85g0+QDgy7LXgjt/DEge8HAS2t/N5x46f/+Dvo9JXXKOlP4UxUOXDRlC595sC9m0/rtV1
 sCKj6XrbjFL79PT+8IYQcnSMsOOdnQ7Y1LvH3bPAQ0JQCTOVymXjlFBkPyU6nyer4Qr4pnql
 p0UT7ZHVVszXvoEA0VhFdYGLd95RDQh2bKciccJ4zK5onyzDI1CuYvbU/uJHfj1ADOekKUCe
 BYCh7/1bMwSOoD9x01+ewx6kYDNSC+yFZhGpixsaBNxoV0YqiEkCDdphAS8N0X2sxpxXbauk
 xU7ixVze7Eo/TbouBIsI0bS4TA3iA83kMnkhjaYdHjwKr2xVMdYEXmR1QB5P5XlTgJydQD3k
 1ZjMWKOYrtLjKZ7M01vhhXdv5RnBvNWC6FJKkx1p7nfd7Az3FJQpz/yj1dA/vfAAIB+mRECd
 JmxszRf1gglYNN/dsmybOJZi1NXgKyJpCqh0Os8lRQfK0g6+2SXYCcUuUYMO9HOwgK38+Yq5
 QHQw1OrmUAJUOc25O1n/AUxNrbYp8oP+6FOIAa9Or7GR54=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Rq2UGapCGxBm0o5uT+gU03waV5rzeYIsimQD101hICG9vPbo8/
 xG785rtiMc7wxhPk3I+OrwX5VoJEm2yXcb2+Ys1NuZLWvbUQiTQr2Kj7GP/9SIIUSXm9K1vp
 0QFpSWZueRMXFHrYLd/BSyFcomzeKK6aaymI7lvgxQpE1RCp2J9G1Ce3+m+6BNNXF77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:4uHPdmHsWhxNG5MdqmJ312sFHvl9dUH6j2vME1SIFzhwb7usHAo=
X-Talos-MUID: 9a23:hebfpAmEcv88xwIj5Yshdno/O5t43pyUBnlQz44a5+qOFjcuYGu02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,279,1694728800"; 
   d="scan'208";a="70555716"
X-MGA-submission: =?us-ascii?q?MDHMFtdBMOCuVLbTR/gu37lhmH+w/Ai5NDnyZB?=
 =?us-ascii?q?CotT3l09WeUACqJe8+CEnqzNttu5214fmUYO3lmCuSfX7ahKM+xBrQWq?=
 =?us-ascii?q?hCcGzDYH41seumo6G7HNHQAlA8yKHMto9KSKsH8w9QbbAesBZ0IrMBOr?=
 =?us-ascii?q?xqbEyZANIB6lGH1pQZpOnCgw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 16:50:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699199415; x=1699804215; i=markus.elfring@web.de;
	bh=r9OwS1ivzSWe+FjftUfNAX167xv+AilwuKPkbzNdkTI=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=QnP4mZKZ+4SYxL2AJg7rZW0ShKW2s2yI9EF29FbrXQsnRTAZSLnlLS6HUoeX2/qZ
	 oP86/tpwDqXhl6mdOFbzyRLTuILXs/R49f3QfuBMOwXBYPxAlIJw79WEUt9QiwtEs
	 7elI5dSgl9S2nUTXRcXfUwYEQoSsF6bgO0ZiViQ+oW7eoMNQgCFDmtLRjpVGO5+wX
	 bFXEIpXoW909pjT21uaVNZ0f5P0qHX8sqd9ysqQ+AquzpWpkJNTa9VRkql061vPhY
	 XryFxKADTLTAQZtuaemajdosp/ZG3i5wAuXjgJauRSvQVizzyjH6cALLmXeAJhZW1
	 delpBsohl2Sw8lrlEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUSE-1rESQG3vh4-00GIYD; Sun, 05
 Nov 2023 16:50:15 +0100
Message-ID: <c70c100a-ebfd-442e-875f-738593faf0dc@web.de>
Date: Sun, 5 Nov 2023 16:50:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Aubin Constans <aubin.constans@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I12YPWcJkgb4qemXUDa5g2yz/0EJ7eNy6kviteJVU6Jvyx1IXDS
 fJCuAXKh/vFUy8tuheOX3CCAluN1Ta3/1IAR1zYa8HJvRrKv87P4jqzVRFa/BLvwn6jCnra
 7u3ncddjTjh6cn2V8NnXoXAOGWwDJ/kEAWfTmS4gd/zAx2atAkrTnRA63noA/yiikSwnP+t
 1AKh+NT4Rfn+v4pEcqAzg==
UI-OutboundReport: notjunk:1;M01:P0:95EuTFPbeDk=;WTLQLz2c0Yh4z0Rz5KBypRlAh7E
 +KLcnoIYyd4sX8G1993JEzz4y5+58I4wZPDuWHsqJc5aYDs6veaR0PCq2qwzooyP1JPzeav/U
 OOQ2Ul2+69foGufNMAJCuoQkd1ywW2D9YZ3uxXyoig165upItMG+uAOhldvawIfFegXwmdqt6
 kY4S3SFdx+5lfSStNt30OWRxVvDvUDCNZF+/NaSkmWgOoZuTMT6rh4YtwSAMsu/qDtalOjsiS
 VY80UtvKoO8HHnnkUHfsFIE4gtX4fff4pGkkvoBegyl6VQj00u7mrcHueB0JIUeAuIjYruavk
 m295PBP1h2Eg+6kTgj/KqEq6SmbPyU8ueToIYGdfxPUxA1WNfTHzkGYnJd4SQR65V+AYJcbMf
 O2QXxvvhmD6rZZVyZwXLCYzkBdWiH32t7nFGcAi/s8eZVDjfBViHNW6fbj+g0pv0yVNYWZ5Xb
 sJ7uZl8jbpNb41bgFa3GTCVq6TCxXZ2XHIkm3Jr4e+JlMRCPO/ixhZHUNMqmL0gYkoPuBKvwk
 Q3Go1WhiKNL0CPSl9833Z5DwZr0VQb8vN4+gmXd6X7K/EJ+bADYRWKDbGqT3Pm4QGNEP5+2+J
 qviuj0GmAP7Zy1Fj7VF9EC0Pxt8KAvi0XMSkCxm6bwFU5D8duSnjFUfy8WswThqTsuWw7EZ+I
 zK7X/8sYOHgShaRYPuM4Hc3+CMfDQ2h8+3VfMzOZIXE5AGyRLtj/ijzo2KVjL6HUR/UNC3iXp
 q6fyeFWCStCNnFUOQNr7gOAmAxzS8Ppk7Dh84fAiiwCv1RE49j3ldVq49Ky1BbYxTkt6I+ZPK
 vl4tpZQXpt0P1v/Tj7G+ycR013OQBY6uSRjZ6/VRZtulThv5R49UQYJ/XeB5vSDj3lNgV7t1m
 Dj/eRMdKIN3QzKXhMwWBnrEn71dFKmk2y9NuyD/naS7G32GdJk8u77zdgjCgmPkimaVZa9eH/
 ZJelYA==
Subject: [cocci] [PATCH] mmc: atmel-mci: Use common error handling code in
 atmci_of_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1289
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/c70c100a-ebfd-442e-875f-738593faf0dc%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 Nov 2023 16:36:58 +0100

Add a jump target so that a bit of exception handling can be better
reused at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mmc/host/atmel-mci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index dba826db739a..1e83119d1dcb 100644
=2D-- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -675,10 +675,9 @@ atmci_of_init(struct platform_device *pdev)
 					      "cd", GPIOD_IN, "cd-gpios");
 		err =3D PTR_ERR_OR_ZERO(pdata->slot[slot_id].detect_pin);
 		if (err) {
-			if (err !=3D -ENOENT) {
-				of_node_put(cnp);
-				return ERR_PTR(err);
-			}
+			if (err !=3D -ENOENT)
+				goto put_node;
+
 			pdata->slot[slot_id].detect_pin =3D NULL;
 		}

@@ -690,15 +689,18 @@ atmci_of_init(struct platform_device *pdev)
 					      "wp", GPIOD_IN, "wp-gpios");
 		err =3D PTR_ERR_OR_ZERO(pdata->slot[slot_id].wp_pin);
 		if (err) {
-			if (err !=3D -ENOENT) {
-				of_node_put(cnp);
-				return ERR_PTR(err);
-			}
+			if (err !=3D -ENOENT)
+				goto put_node;
+
 			pdata->slot[slot_id].wp_pin =3D NULL;
 		}
 	}

 	return pdata;
+
+put_node:
+	of_node_put(cnp);
+	return ERR_PTR(err);
 }
 #else /* CONFIG_OF */
 static inline struct mci_platform_data*
=2D-
2.42.0

