Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3611049524
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Mh00NQrg2lIKNWkDXvNhPe2GMjEhYIMI8kQ4tCuMao4=;
  b=FIWIV3ozlWQkjcGiA0rql3axtyIwE502FXEYGdhs1f73MT63kSjsGjZg
   EtprL3Uco3HuO74kwTfQfr4a8/w9hOtQWKXwTj5qDtTddWGq4cSPfMn+u
   WKK159cJJPJaKrdOvpeIkAqiqp/Dx/Sd/xkbC1erqbV3BHVKZ0s6wfQws
   Y=;
X-CSE-ConnectionGUID: PZ4DgNZeT+ii+bM7ziVzgw==
X-CSE-MsgGUID: CVO9j4VdQu2IpOJyywIs8g==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
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
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267245885"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:15 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 05C9F818CD; Wed, 11 Mar 2026 10:46:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5882B800CB
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 09:17:04 +0100 (CET)
X-CSE-ConnectionGUID: 26y3WAETSpO0aM0bkLevmw==
X-CSE-MsgGUID: SXgcnjc9RLakRffKnB6vow==
IronPort-SDR: 69b12501_aO/llHjc8/LNfARzMHL91Wc/281WHTTwWLPMEN+sZYnOO/T
 EzPjl+Qykk41d1FbzLwWmEox1dEAC0lE/UIFIMQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EZAQDTI7FpjxBBr8ZaHgEBCxIMQIFFC4FuU4FoMQRUh?=
 =?us-ascii?q?FiDTAOOJQOBE4pRkQuBK4FANQgCDwEDAQsBAS4gAQIEAQEDBIUAAhaNDQIeB?=
 =?us-ascii?q?wEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBA?=
 =?us-ascii?q?QE5BUmGTw2CYgGBJF4HCTgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eA?=
 =?us-ascii?q?R4BAQEBAwEREREMAQE3AQsEAgEIDgMEAQEDAiYCAgIeBwoVCAgCBAENBQgag?=
 =?us-ascii?q?mCCIwEGEQM2AwECAqFqAYE9AooqeoEygQGCDAEBBgQE2ycNglUJCQEKAYEKL?=
 =?us-ascii?q?oU8gnkeAQGBcIF3U4EgARmEAHongWVDgRVCgjA4PoIfgiYVg0Q6gi+DNIxNh?=
 =?us-ascii?q?lYJSXgcA1ksAVUTFwsHBWFCEDMDIAovLQIUDRASDwQWBS0dcAwnEg8dFxQfW?=
 =?us-ascii?q?BsHBRIhKgeBQXiBZhsPhmh5Ay5eGg4iAigSAzIEI4EGC1oFgiwCHAMLbT03B?=
 =?us-ascii?q?g4bAwQ6ewWNaz2CFB8BAYEOgQY9fBiTNwGDKkquZXEDBAOEHJlcggCGMheqa?=
 =?us-ascii?q?y6HZZBzIpFwlwQCBAIEBQIQAQEGgWg6gVxwgzdPAxkPjiEMDQkcg0KPPQG5c?=
 =?us-ascii?q?EUzPAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23:TBLMzx1IVOD9QG0bsmDObREyDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeDo601xwWZBt6Lo9t/yMPo8InYEVQa5piAtH1QOLdtbDQizegwoUkLLfXBN3fGKuX3ZTcxB
 sVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+KPjrFY7OlcS30P2594HObwlSizewb7x/I
 A+qoQnNucUan4hvJ6g/xxbKv3BFZ/lYyWR0KF2cmBrx+t2+94N5/SRKvPIh+c9AUaHkcKk9U
 LdVEjcoPX0r6cPyrRXNQhOB6XQFXmgInRRGHhDJ4x7mUJj/tCv6rfd91zKBPcLqV7A0WC+t4
 LltRRT1lSoILT858GXQisxtkKJWpQ+qqhJjz4LIZoyeKeFzdb3Bc9wEWWVBX95RVy1fDYO6c
 4sPFPcKMeJBo4Xgu1cCsR6yCA+xD+3t1zBInGf7060k3ek/DA/GwAIuEdEAsHvWsNr7O6gdX
 PupzKbT0TnPc+9a1Sv/5YXObxsvoeuMXbV1ccfJx0UhEQTFjlaMqYzkODOV0OMNs3ae4OZ4S
 Omil2onpB9yoji03MgsjJTGhpgbxlvZ8ih22oI1KsO7SE5ge9GkFoZftzuAO4tyRcMiQH1ou
 Cc9yr0Avp67YjMHyJUhxx7DdfOHd5KE7Q7kVOaUODp1gm9ud72jiRio60eg1vH8Wdeu0FZMt
 idIksfAumwN2RHN5MaKSOVx8Eiu1zqR1w7d6vxJL08omaTbJZAsxqI9mJQNvUnBECH7nEv7g
 bGXe0k45uSl5Pnrb7P7rZGfL495khzyP6Atl8ClHOg1MAgDU3Ka9Om8zrHv4Ez0TK1UgvA3j
 qXUvpXXKdkHqqGiAgJY15gv5wq8Ajqj0NkVn3sKIVdAdR6ZkoTkPUzFLuriAvelmVuslS9mx
 /DYMb3lBZXANn3DkLj7crZ48UFcyQ4zwcpe55JSFrEOPvbzVlXtu9zfCx81Kw20w+D5B9Vhz
 o4SRGaCD6yDPK/Ps1KF5vgjLuiMaYMPpTrwKuAp5/v0gn84nV8dc7Op3ZwSaH2gBPtmJ1uWY
 Xn3gtgbF2cFoxA+QPbuiF2FUj5Te3eyX6U65jE8FoKrFobDRoaxgLOf2Ce3BIFZZmdDClyUC
 3fna52EW+sQaCKVOsJujjsEWqS9RI8gzhyurw/7y79/LuXO4CEYtJTj1MJ05+LJjx0y+yZ0A
 9yb026WV250hH8HRycq3KBjpkxw0kqP3bB3g/NGEtxd5OlHXx80OpDB1+B6Ec79WhzCcNmTU
 FumR9qmDis0Tt0rwt8OZ1xxG9SkjhDfwSWqB6UZmKCMBJwx6q7TwnvxJ8d4y3vezKcvgFcpT
 NVTO2C6gKBz7xXcB4vTnEWDi6mnbbwS0jfV+mmM1WaOp1lYUABoXKvfQX0Re1bYoczi5kPaQ
 b+hEbQnPRVFyc6FMqZEcsTng01JSqSrBNOLW2Kwn2aoHV6oz7OKJN7ye2wd2mDaE1Msmh4Wu
 3qLY0x2TC6kryfRAixGEVP0f1iq//NzpX+2VUwoyBnMaFdunfLh8xsZwPOSW9sX36kYo2Evs
 Th5EFum3M7RE5yHvQU3OO0WaMsl6U1C0njxsw1mIofmMqp/gEIDNQ9wugmmgxxvEoxalM8wh
 Hcr1xZpb7+SzVVdanWT2pWmfvWdIHH81A6gZrSQ2VzE1tuSvKAV575w/1/7sim3GUc4tXZqy
 d9Y1z2b/JqcSEJYWp/pUgM7+gZ3o5nEbSQnoYDZz3thNe+zqDCIk4YiCfMljxqtYdpbGL2LG
 RW0EMAAAcWqbuswlA7tJlgPO+tZ9YY1Odmnfr2IwuTjaO1nlzmnpWVB+oF0lEyWoW40AOLNm
 poI3fyc9g+GTCvnylOgtN3n34xJe3taSma6jCTpGoNVTqlzZpoQT2OvJdCngNlzmcipEzRU7
 l/mC14Y1cuBfRuJc0e70xdd2Egaun+7njP+yCZ72Xl9orCemSDD3enmXB4GIXJQAmd4gFrgL
 JO3k9cCGk+yYF5t3FGq612g76xav7hkaW3SR1pYOST7MSsqBqS+reCqZ89U9IhutSRRTfT6b
 V2EHPq16Roczy7nWmRQ1Bg/diq2odP3hRF3hG+GL2p0tDzeY846jUPe4sDRQbte0CouQChjl
 SKRCEKxMtWk5taIkI+FtfqxASbpHJxVbSTviJyBria3oGljBzW7nuuvgZvgChU9yiu90MNlH
 22crRDgb42uyKWgPO4iekBuLFv98NZhXIZlj4wrgNcXw3dMwt3f/H0ClHrbNdRAxbm4aHsLW
 C5Nz9PLqkCx2UpmK2+hw4PiSm7bxspnesn8bm4IjGZ1pcNUDY+K47Fe2yh4uFy1qUTWe/c31
 mMe1/4G9nEXmacKtRArwyHbBaodSw0QdyjtkQmYqtmkqeBUaXypfLyY0EtlgcvnDbeMuAhQV
 X/1PJA4EmU4usF+Nk/clXTp78TndcPWYNY7shyPjwyGju5bMps9m/MGwy19NjS59Tchyugmn
 Vlk2Zaxv6CZJGh3uqG0GBhVMnvyfcxZsmXpjKBDjoOc24ekHb1/FTgRGpjlV/SlFHQVr/uxc
 07EFDw6t2feE77CEBOY71tmh2zAHortNHyNInQdi9J4S1PVcEhehh0EGT8+g5MlEQe2xOT/f
 0pjoDMc/Fj1rl1L0O0+c1G1VmbZuRftYCsuRoO3MhVb9EdB6l3TPMjY6fh8VWkM+pynsRzII
 HCBaR9gE24EQAqHCkrlM73o4sPPpazQTO6/KebeJL6Pp/d2SfiF39Ss35Fg8jLKMd+AdDE2C
 /w9x1oGVnF3AOzHlDgVDS8ajSTAa4icvhjqvmU9qsG57eSuUwbszZWABqEUMth1/R2yx6CZO
 KTY0CJ4LytIk5gIxlfWx7UFml0fkSdjc3+qC7tW8WaHSKPWh78SAgQcZThbMMpT87l62RtJM
 MTAzNTv2fQw2vo0DUpVEFH7nc+yTcgLOH2mclTVAE+BL/KBPzKdh4m9ZaK6VK0VgfVI6zWut
 juBVUzuJDKOk3/uTR/lebVIjSeGLFlTqJ3hWghiBHKlT9/8bBC/dthtgmtyifcwh3XXJSsSK
 jRxbU5JhqOf4DkegfhlHWFFqH1/IqPMzyKY6fTIb5gNvfZ1DyBcie1X+jI5xqFT4SUCQ+Z6z
 m+a5NpvpUy21+aXyz1PThVDsHBIiZiNsEEkPr/WvNEUXXfC4QJI4n2RDDwUqNZ/TN7ioaZdz
 p7Ijq2lbH8I99PS4NtZB9nMJdiZGGQuPACvGzPOCgYBCzmxOiuX00hcluyCs32EtpUgtLDyl
 5cUDLxWTlo4ErUdEEszWJRIJJZxQyNhkLiDkdIg+3Wztl/SSd9cs5SBUeidS727LDefkKkBZ
 h0Q3K/QM4seLMv41lZkZ108m57FTQ6YF9RMpDBxKww5ukNA9FBgQWApnUHocAWg5DkUD/H+1
 koyiw1jcaEu+S3q7lMfOFXHvm0znVM3lNGjhiqeJnq5ZqOxW5xGTi75u1MZLJz2WUB2YBe0k
 EgiMy3LDfoFi7pmaHAujALQorNRFvNGC65JehkdwbeQffp+lRwWriSh2F8C4ObJCJJKigQna
 9ivomhG1gYla8Q6b+SEIKtP00gVg6+CvyaAyO882kkdKlwL/WfUfzQH7ghAfL0nITe4u+lt8
 ReqhTROYi4PWuAsr/Ys8VkycazUyyPmzq4GL0GpLMSBIK6D/WvNj8iFRhU3zExe0wEP+blwz
 Ndmdk+8VF4mx7jXEA4Gf4KWLQBTctoX8X37fjiHuuaLxoh6acH1XOTpS/Ke8aMTjl+gER0BA
 YsB9IICE4Oq3UWeKt3oZvZRzRQr+RSuIVKJEfBEYzqVnzod5cKy1pl62c9aPD5LRS03NSSx+
 6aSoxMmqP6CR8stJHYcUJENOn8/VIu9gSET9yBEDT+qwqcc1ASq6z7nuj+WDT/yddNvaf6YI
 xR2B4fysX878q6rmRvR/I72OW73L5Jht8XJ5OdcoIyIQbsASbh7rleZnYdDb2KlXnSJEtOvI
 ZX0LY42YoqwQjy+U1qim3cySs7pFMiiI7LOggzyQ4tQ9o6B03prYcu8ECwOXhB1rvkr+q1xf
 0sAboA9bBqusB4xYej3agOZ1Mi+Bn6tOBNSTuJD1qO7YbJNxiYhZ+P8z2EvBNluy+ix7F5IX
 JEbphXf3uq4IYhYXzL6FnFUd0PIvyVv0yArMuc03/d62Bbgr1YRKXaIefZvZWgCuMszTxvGJ
 XRwF3p9X1q0k4XO+Eiv0qoU8i8bmMxbh6kN+nz/uILPJSirU6+gqZTNmy4hdsQ95ax3P5bqL
 saPuNXZhDOVBM3UswuYQGugEPFZkdhROApcQeJUgickP8IcsIZM4EZ3Ud0xcfgHQq0toK26L
 CE/XHY60yAUTcWD0SYEj+P63KHV3F/EdJUkLQxBq84T2vMDXCNsJCATvqmuU8PRjWDSDiBBJ
 AYV8BQJ/wkbl6duce3/ponFVplBz3hRuf0+Gn/PF5915x7gQXqXqUb3Re/nkOGz2w9WivX23
 Y9fEFR7CE5A16NNnVcwAK94JrNWvYPQtDKMM0TgsyilnO+nIkRBjNbfa0XQEoXIryz/Xzca9
 HlSQpVAnjWXX5ATlRdpLb0mr0hWIZy3P0P56yEgyqx3ELSiE8Om3VAoqTABXSjgW45FCud7o
 BfMVTZ4eZG3udDgPJlPRmJ45pKQsRFanV9rPir/zoBTfYUFqDoNWiVf5C6dlMW9RdcF2sJsC
 ZIIZNBltD21TKdFPoWB5mY2kqLgx2Wf+D0mtlq+gjKpFPn8B6hd/msDCkAyIHmYpmExAOY2t
 GTf6FbAthZz5egRTuyLjENssHNmGY1ICh5X2n2/aVd+Vn9Lt6NdMquDN4QWR/g0eA/qIAA7T
 qQOxFDM+E0xmH74Zyl7sE1B5yfHWhM5TS0ExLzqnHdW/sWmPyIKDolUaG57RzzZbgeX3CVev
 RJaYkcsQIweGNNf9qkfzM1f+c+UDQ7mLSADQQwnKhgx2vcalkNZtkicUT7SABDudvvVtBBzO
 8CLo4ThePD4+hpXz5/9ues1sqYOXXurnSWzTt3E6YzxrNuHsg2Jbqiud6X2ZX7HUSiJkAu6r
 akrAoOM/CXJNgdfbZ5gxjBsNZzgD3PbeAldLYoFKEdBE6N3c9NLpqZdfcAyPO5D/a5rGwLCW
 RL1FYiit+JuMFneX3LdIj+H/+j5ppjcp/SJTenme9zJ2HfdTqZ6JYxS9zb2AfHp3JVY906w3
 e1ioAcyA17LLyyMsvz/KQ4RosqvbE3vutsuBzycSMN2nWbhy19oacUaWWup/Y4exZcf72z/H
 6YwmE7vvvYJ371l8pUspbRoz9qkY6vfN74S5Ul7DAPPLgFr7Yk2Rmx+QX1BJOMcNqGVNe4Ch
 MXkoqXrGqcX7hye8uhxbdrcO1qHgcC6ADjaTgZL1k9VsjcfJALZy/OOm6l1Qs+hjez4wV42p
 UO3KxQPird36tHAsuCTr+/aY17c3aQsXqnxWti1qrUqplPU6fA63vZaYWd1bgHiHfgBfsoc3
 Xv7i6Qryz88Vc/OAeSksLRfXmg2ky6ll51jElE+BPwZB/yI8J5Yk2N+nPbWfJVCbqlYlWuTU
 BKpDLIG4WCk5jHRI2R/hBzKlRbqTjX3pBXqrDdzBCfN1Nz+iVFUUb+fAUZJQzHvIkhlqjiCM
 g3yu9exv6kppgliLm38v5eBlXCqJahMHsr5DNidOjUv4kkQkYc6S9Kow48WX9ywPIFVuDtgP
 /XFw2eqiDNa5aNGgZfOpM2Y5L+fSWfxgbayr7SW2Cseznk+oEF55t2+YKLg/dqPFr6M0GUNT
 iB5vBWFFzexp7/AplYYIwbDhE7PlY8RN9dVxz880UL65e8lR8wb9QNCG4KGbPQH82OgcADoy
 EqSNopkHhKV1CFaSxesSQEQ8MkU3WvxuJiMjnLM4xgyQYI2cUX7hBtxBoF+KEQ36VFRzDBQW
 RMVZ0W9C7elTV/gMZNCTVIKPB2D0buhc6E7xwt3xbCz5ejVavJUBqwRO/IbhQmLzxBAApxDi
 aQFW/pnfkNFsqvepwzsEY/iCvHimHkrPPu5WIZe9sMFtnwk5RiXRhy85JMF5LEe29iTbqARR
 5/KsYhn6lt/oz4CcisYmB9kkxawSvwRvsjm7dHeuZusrOeoSKspAe4Q8nDYHkxYiJ39yBAmq
 NDTjaJHT5HNzJ74+0ZLKmKLv4DT1199L/APIsSlZuQo8XJPPCUYK38UWLjeI/Ah/y9gNinS7
 F1eE4sNY90fJs/EhQFTjAXgRrhS8sPRHlLQBZ10cogk6G/+yTZ99pVZMK6o4Tu7JovW6V1Xe
 fdEjzltk9TFusAUx+bfDG4c5nzYIxl5zyWeyoWcXu7q9LbpqpmcXFcHEygqFoZFcWPTqUr+G
 bfzysivC13Hj627yIgzf0+RWHGryaEMs6IWVPVFlj2+xD9VUIb8m/OStdOormpRrFxOVohpv
 ninUO1SOIt2PRPgm4ylXE95U2H2fMzXbRMotPDQwuAP/+R5MUzgTY4dPh8Ajbn97DAGK2kmA
 K6zpVufUe8LMZFvTP7HtXlT5ZgmL6gMIFmaopv0hjZOtF0yRgQubfVjy14SPlmLlwpTVaHuv
 bcGgQZJSt91t3hHHmeoMX4/7T7KPUhMpJGYE+ddsjCaT6hUFl5tLjs7WRS+npNnZ7qum/lD9
 GJAhCJ05vYwgXRqQx61uCukoKxou3po8bW1ty4Iv3BfCOGZkDvJDlNE0twLi7sRDzDp7ln0b
 HQYbYT06aVqPoy5pNlnuitiJ0t+OXRYFe27bkO4x7uFGImOrM5RiFaWtcPCYKXyZSkeO7Ihy
 A7yEn100wzQhhFtoyMARjSt6sNhJZ3oYJd1gHP3RC6FKRBVvPAs0oO5r1MAQeooZEk0xWxi1
 pLCXSgRXInVHG1ziAE4aGJCeZYF6BkAFqBujCzb28sOtgwSfjrQFZyov4fKmsKdk3A5QNRxz
 2TavOuBgZA20XpjnM1c7yiStXBUfOvdGZwJYDC7xsJExOryau/4+OkDRYh9wbKtSrkGNcq/+
 Gyw34tCW0m5y7BYFF28erxmpP+TQ2KuTmuWXv6Oem6HkmMiM0L80hKvK0U+dMZAq0JuevuHn
 JNXkBftFK9lXijF70GO13QtaKlJEmB+8JfiYQEBS/QdIvSRNfR7iuNrE0MCNjfIBXckUr7m9
 wfywc4lZjM4ph+kKaHk9gSsWDeLMj8DF4OS7pt4+PjgA3mEJWcl1hp5ek996+bYEV018O5aa
 ZeY29bK1Zx91qYeevFhPDdY2JZbk59/6YSSzMaBcA3Ahpf0K9bPp/GEAvrZh000c2BeW7Adb
 Ev7/YI/dtI+XrTSG/Nes3F+TeAiR4c9Mm7q6KxuBAZ8ewvYZbDyg8/2q+bNbZxR5jfX4l82M
 CbAqkgDx/izHmkZJ9ihg3T/Jox1RyoU9ow9TEI5Qc0RRoVZ8VnCYdbcgqywht6v9lkvvuYLt
 fC1EfXWzJGj2I43WZFG5EuNNTKXBa9xg00jgP7h55WImpT3F87mfssJEeZhRWuQILbCE4akI
 zSCIIT4fE1a8rma16xRUxONaSS/VK2D/n7BVr0s8QAgx4p0cfCGhiQq9K3e0cDuantzoyiqq
 HeIMN1e6kDHAarVWBceGp/nuC51WKYQa4Xz7uIHN9cvlcOd7wdE5zNHyMKZIqKloyckO2p+e
 pveJUrtnSc/RYQOZh+4NBl06Yc2gnXbHXlYaMOjLJs06D5wJh3r+0R132oqYzwZclc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ypoDaaDS4V+vkkTlHei6sseALOsnbusQ8zAXPh9KOGdom52j5r
 iTdaogpGbJYW4qKQcdcdDpAtj/fZquz+893WB3B8blYOCGghruEGgG1+DfKlLbal/DH4JmpN
 tdmu1FearN5DtB/J/HCWuDYqMdKbC8mcjH9IKuqwYLPGcaEdAc0+46MHfuLqQffngVOXNTLu
 vs2iMznUvSRZ1hVLXKOpBqZZm9m/T70LjdTVotARkh5AOSjTWuxoLbPnGjtHYjegIK640PtU
 zenSLExojLiZza9jbsk0PD5ZVfn9XsjuBEGNGNjcYtLDDtgBaDZYhqWbGO1QpF+N1Hr2xa8+
 UkpS1NULUQ11rhOkWO5Tf90Qjp1zgjr1X4z0WDvHflqcvlABonFston+tiA0DkwntlmOs5/L
 NA3mqfuZYSJwjHhj7B69/BUAwvvlaooEAljfUYgxVkINEjgf5q3NEiFXFuYcg99RHBmd4a+S
 5VfZDhDcNtAA+nhrbizzlSKZKXLycO91y9MwA/U4SuonNrdTZCvh4lLYUk7z093YN4RJ9e6+
 veNKN00LlIU88NdKp4QPwMWM2tFwX2MFDx2U+pUBTa/Zs8SjHwgo+y5K9w6PCheZQOwpd3kJ
 PdUElAvWp3f071E8WB0JBC7xiIGQyGLHDQ49Ab44I8tqz3RbLtPyHGQFcyk9G4q/FaBsHAQf
 68NJ9fHvemJ2rzHoRC2RH4RvBpWDwjedxQvsx+V0OFo8rNJIGvvuvHcOzLLL6oCjogUnOXOA
 pDYNEyHrQP0qmGYA62vPGKYQKhRqXWx+M9LJTn
X-Talos-CUID: 9a23:h/vWjW+UP9Ime1xK+GKVvxRKC5saW1Dh92/3e0adUWxqbLCLTEDFrQ==
X-Talos-MUID: 9a23:HUIDmAbKelvwSuBTjA/jjzdgP5ZSx62tMk4DspMs5deDKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267220094"
X-MGA-submission: =?us-ascii?q?MDH2pxz6sbXN80xdFHWeT9aa4dvJ51X1iEFIRF?=
 =?us-ascii?q?1QfJLcaUuAjc63pG/3V7MJ2x8H0GF1pRseouNS+mNftldChuwasvwEo1?=
 =?us-ascii?q?YH2V5HqbIlUQFegn7aqIkg6rDaCvsuimNBBLycLgSugRutVS78pnZ40p?=
 =?us-ascii?q?I9Rqtn8EXE3UJbJ5zUOqBB9w=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 09:16:59 +0100
X-CSE-ConnectionGUID: M7lTIY2UTC+K/m+6bswCdA==
X-CSE-MsgGUID: dSR/SQpcSwaldLinWeiC1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74467605"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74467605"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:16:55 -0700
X-CSE-ConnectionGUID: BMGoJHUZRWmghWNXe/Zk3Q==
X-CSE-MsgGUID: g5YTB1s2Sqi+a6FaJQciMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217077384"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:16:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:16:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 01:16:51 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 01:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Opo9MpRJtwx0zLgDgZOZFJvPXyHqHHtJzkUiUwVJCsz4tKEKo07LreqxtnrsCjwVojH4U+UwLGvLUj6tWPkc6m4pF4S6tJD49D6pQ27s7xGcfs0lsvws5Mc4Crewz36bF2iEdApjb3wgDXOINHplZ8RrYmMyGB9KiYtvU5ZM7+8PPHQ4D+mLJZuIVu46F87G8kMLHuO5LzweNhPlt1T0hwPb8bjCxWtbmFufuecYQPnZ5Losrc+UeFJp5bjwsqeLk92kr09MQxsBmElWGC1C55jrobnIuiBTr7MkzzIlRr7ETHdfc04dd2ppiR3SK20FP0U+KXkotq1HmCcVeC5k6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh00NQrg2lIKNWkDXvNhPe2GMjEhYIMI8kQ4tCuMao4=;
 b=PvZIA67maJcJZMl8ktUdh9e+oCmpUPO8uwMtDhImWg/7I0jtaQ97c2U03ZqEoY5MA8kxm/yaPjMOIZv/MRKJR5724vKgt3Zy0JtPGquxl+oby5wgXKR+gL5+Or5WdIAw4vi7PIP0s32fyfKM3StEJoqnrE68jqMTix3K03Ob2M8ClebhUzWxUWTTpgzEU+9ptB0YRzkwnLjf3Gbc5uI4fJXkLyhlVjPmb83qjchjgoQt/KAwPjnhtyjdlxnRgmuNmCsuQLP2UvSKZFbsiecOE8S+TAZM+vodeF7mGh4J2QrbQPRzL3dwaH393UaCBjVAY6A3gLotIzLPB/B5adEJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA0PR11MB8379.namprd11.prod.outlook.com (2603:10b6:208:488::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 08:16:43 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 08:16:43 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Philipp Hahn <phahn-oss@avm.de>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "apparmor@lists.ubuntu.com"
	<apparmor@lists.ubuntu.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "cocci@inria.fr"
	<cocci@inria.fr>, "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ntfs3@lists.linux.dev"
	<ntfs3@lists.linux.dev>, "samba-technical@lists.samba.org"
	<samba-technical@lists.samba.org>, "sched-ext@lists.linux.dev"
	<sched-ext@lists.linux.dev>, "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "v9fs@lists.linux.dev"
	<v9fs@lists.linux.dev>
CC: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Thread-Topic: [Intel-wired-lan] [PATCH 03/61] ceph: Prefer IS_ERR_OR_NULL over
 manual NULL check
Thread-Index: AQHcsKJtosLQvJfHUESbmHNNZ0gghLWo/XCg
Date: Wed, 11 Mar 2026 08:16:43 +0000
Message-ID: <IA3PR11MB89868EDCF9D093C501E01FA3E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-3-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-3-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA0PR11MB8379:EE_
x-ms-office365-filtering-correlation-id: e34e8a58-dab4-497e-6b65-08de7f4687c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: jQMLhYHNcc8rWLFFel/x2sMvHTNauRhuYBG4bf+v7DsJZFhupIQte49LtN3UoUBak4B1IEWtI5P1CmysS1a+awGpSJz1r40isgFFN6L4/mibvFUKClT/MHdIMjSE4HQukbYf0M2IxFRTmvLUaDZO/+OqT2RCKgtSBSNwPfxfWkRyzOeF2hz7VqpT/bP5wowbzNc66q4wL8xr7nzirI6YWKRsmxf1DWqNzDJq0ZDssnFrN3NJVD+DmQgHzvk6oU6znVEUc7rJrNuDvx5SfI22I0vk5YAHgZS3r3GWilsK/mH0/G6jWruqtyFazGqdS4YPo4VggHYRFgUF4hMOlNHdsU7DcnNMARrbZ0SGm+HoHpUKEXC4slgRMBk4pTRlS1bNRHmu7dctE53a4eld7MfvX4/VCisN7uIrH3H7wkgEnlsZFrITVWlYj6tCEICkv95CBNqOFL+vcNYaZDnlXRN4h4ieBBAs4bkxgJo51IR6odZkbLzjMXpzGcqsI/mt6RfxXqC8AL1RcxFJ07fcXv73zoGCVGHcwPZIItHDvtrPE46pL/lO0UByfnfuhJKRNACe4ge0dP0jWubYBPg4uKPCBIlEiu1E9lLwYWDODI+MxWMdCnw7Hi6ZWZe7Crnx98PGgc8WM8q+qFjTlWci6orACn3nPHmShktAHNmKZLfzUy4xRYweFBtNzgWrA73evyHgmwW3MabvCgHgm+V/f7BaRNGziMylCelvMtY5LRr3SVkxqtpuIWlU2tl6maVXxD/6Zma/pAGcxVD3vEAJpHEREdZUf+Id82qWyMcEFNe8aBamRKZIZReDd6IYnkL9aw8J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0JnUUFIYlQxQkxQM3YrYlVCSThmZkoyOGZMejBVUmpSTW1IdDhLdTdBRVBI?=
 =?utf-8?B?MjRuT09YQWdUSjNsclQ2Yi8wSDZBQjdiVzhCZmxXZkhQSTkxNjhXWExvNkZB?=
 =?utf-8?B?dGNLYlNJbi9SNlMwSG1HNTd0RmVRT2NJRmVYMklXdjdDNFI0Rnd4dWtKUFZk?=
 =?utf-8?B?YnZQVDBHelJaTmluU1FFQXZTelZZUlRNblJGMjVPT3Q5VkFpQXFLeW9UNmNJ?=
 =?utf-8?B?Vmc0bEkwVVBOSk5xcVJJMzh3b3NNWlI0MnVPVmE4SGxuUVJiaXF1NkNkUXBK?=
 =?utf-8?B?NmFLa2tEeWU4UEVPWERuTzVsVFZzREQyYnArUWdRVWRTRW5OK3FQcXZWRHpZ?=
 =?utf-8?B?MXdxUmtzUC9uS011RnlNZmYydWZHSVMrcDl6b3JnWEl1MnpIZk13eFZpVHda?=
 =?utf-8?B?UXJpT3RRRmtyOFdkUHVyKzZUN2s3NVMzNkZIU0ozUUgxNzRES3pjOHZaRTlw?=
 =?utf-8?B?YXBqeUMwaUg4WmNTWkdUWlpaV29vWVVVSWk4Rzhnb0dDeGlZWVVPbVZHN2lm?=
 =?utf-8?B?VUFobVB5cDM5K1ptdG5kcFFJUXd0aEJhNVFYanZKUkRIOFJKZUlweGZvWGxW?=
 =?utf-8?B?SVRwaEpvQk5nQmJTVCtPQ2RGZ0NnNWNiYWRaQzkyWmlpMzVzbThGZ3B6RFVX?=
 =?utf-8?B?UGxTOHJUSWFyeWZDSlZWSmtSM2Uwc3BEQ0dsM3hJS3J1S3FObTVvOW5sVzQz?=
 =?utf-8?B?YWRoekI0Wk40R1Z0Smh6VHpwZlRCRlBXc3BqQzgzZmZVYVd1ZXRtL3NHc0Jk?=
 =?utf-8?B?YWtqTEFtSHh2ODd6a29LYkpwSS9nUlQxU0xjdVA0c2JqUG9pT2VxMHloakNK?=
 =?utf-8?B?NnZmMTZXOGczQzBZLzhyWDNna1dmdWtXVUFaTlZnTHM5c3kvektGNEg5TG51?=
 =?utf-8?B?M2tieDF4dTBhUUJaRUJvQkNqcGkyMTJSYVl6eUpDNEZsbG42SCs0YWRNT3hp?=
 =?utf-8?B?UFQvVzJTTis5RnFEWE1WWjlSZVdFSFAwb0dLQkIvNlpUODdtdHFlT3JKeXhJ?=
 =?utf-8?B?cUN6em01SW5RQ0p2djM2NDR6UUxiQis2OGJGSHBzY3VURTZ2enhCT3Y0aDlC?=
 =?utf-8?B?aEZNeWdVTmlBK3hBUHBuWjRVSmRFZmJNWE40NVJ0RE9mc1IydUJmYlU5WitW?=
 =?utf-8?B?WVZKUXk4dUJGaE9tNUd1WmJ2ckN1V0VveVpqOGhXekxZeUxTcVRENWVFeVhr?=
 =?utf-8?B?V3dpSWZYajNPZWdZTkdpTWlta3RtK25uTTBpZENMUTU2NE9YeS80bE1uQi9D?=
 =?utf-8?B?SmFQdDQ3bUpRWmJwT3lKcVRFdEpHd1VwSHU3cXlBbnAraVBaR1NVQ2lSblVo?=
 =?utf-8?B?aVN4eXBTcmRHSHJNaFhITWpCeG81dFl0dE1VTUwraTc5SVBmTEFBMzR4eFJ1?=
 =?utf-8?B?bHZFYk1EZEYyaEVDTjlPUlBxN0ZhQmRRRms3YUdlZGpwTmVNMGp2UlJLS3h3?=
 =?utf-8?B?UVBhZzZJLy9XQ1FVVElVeHBVTzRBTHRPNXQwam92ZGFJaXlLQXp4TWxaMkxY?=
 =?utf-8?B?d1hGU1M1ck0yZkF4WVQxaXJaTlhjTGxXSTE1dUVwMVhzMmhmbC9JRk1yV0Yy?=
 =?utf-8?B?RDhWQThtL2xpT1E4aEt3OFBVcnU4bHJrVDBvVXpMM0RhSXNqSDdpcjVSVzFh?=
 =?utf-8?B?SWYyZDVLWUtBMExrcmQzdmJZYkhaN2c1VVR6SXUyWWVKNFE1Vit1dHdLcWF5?=
 =?utf-8?B?RTRaWUF2YkdtVGxHSVFTakRabXU4Y0lYOVMyMURmb3FrK1lPRVQvQ1NQZFpC?=
 =?utf-8?B?YWgzeEhPTjB0TjRNZ1NkVTZBeE1IMG9FelU3Qk8yYkRML3dwQ2RuTXJWdU43?=
 =?utf-8?B?ZFZPUS85bmw0dnc5cmFGWDlxbm5PbGlOdzJKTWhTSUk3clNXNTc4NW9NQWIy?=
 =?utf-8?B?MlJTR2JkQ0xiYkYrdE5LbXF2RkVERllYMzFZWCt2RFB3SlV3K0ZSeFJ1VTMz?=
 =?utf-8?B?ODA1bk45VERFZ2hiRXlWeFNJOUJLZ1AzTk9DSDJVMEZSYXNxWnlqalU4b0tP?=
 =?utf-8?B?K3RtZTFCb1VRK2l2K29abWdZZFpRWFl5d25GYmRURUlPbGxtTUJWWWpVem1a?=
 =?utf-8?B?bXcvR054UUd5WUVTNnlKUFAxdzdaa1NtN1BJSjJXWFFjY3h6eWp0TmdDS1A3?=
 =?utf-8?B?MWlybnExWTFMRytzeTVXNytOcFRNME42eU9wNk9xc3pQd05tNk42V0hhQm1L?=
 =?utf-8?B?dTl3YTBjbGxkYjUvMDdmV2NTNnlPdjl4Y09Ec2VrNXZZYW01amJOM3pZdWp6?=
 =?utf-8?B?YVAwSjFoV0FydDhMS0J0VWNWUmFDNVBtTXRnUEVKNnJ3R0N3RnJHNk42SEN0?=
 =?utf-8?B?eDA3ajdsQ0EzTkVhcXhBV0lsOU9vdk0rU0gwWmpnYzNnMHdBcjM0TXViZ2Yv?=
 =?utf-8?Q?pmu1iw0JdmpqlrD8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lS2x9ZIERkqgSn6Qc2Rfme6olSfFFxn2kmThqyIUm9Tyig3CNDNpPt1RwVWn7smwbBGJOzGfzCUuSOp27IHdik5xKs6rWV3ymJopLnDQSlVKAM6dlmNiDO3CJSy8X/IwO/YZdVRbsCsLTnoDX/jQ7pe8NGHKIbWh/d/7lgxquo77YLgktOmX9UtHTSiUFZKVZNxDUkmF1ReoboNIUri7zvoUg3oS177Awk4d+KM4Mj0dBehbim9Vu9HmZcBLy7DO0/CV06JdE98SmKBKqBbfyaW51ogywi/q2lMNh4w0K3qwNL6po5vnFnNYH1EUfdnz2mU2G/+qIrH7ce+ltJ6kWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34e8a58-dab4-497e-6b65-08de7f4687c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 08:16:43.5293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICks5v4abd3Mi47kJZ/Surb/+jNIrlILUiXV7SvcOuIRk0/oIphN5Js5Fof8QKa29fKfn+Kf31+5teG4Pxt9Lzf6o71UCRgFr4PD3RuzL9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8379
X-OriginatorOrg: intel.com
X-Validation-by: victor.gambier@inria.fr
Subject: RE: [cocci] [Intel-wired-lan] [PATCH 03/61] ceph: Prefer
 IS_ERR_OR_NULL over manual NULL check
Reply-To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 3394
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/hZJrnqnZR4sRrssuGi-U1Q>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgUGhp
bGlwcCBIYWhuDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDEwLCAyMDI2IDEyOjQ4IFBNDQo+IFRv
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgYXBwYXJtb3JAbGlzdHMudWJ1bnR1LmNv
bTsNCj4gYnBmQHZnZXIua2VybmVsLm9yZzsgY2VwaC1kZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGNv
Y2NpQGlucmlhLmZyOyBkbS0NCj4gZGV2ZWxAbGlzdHMubGludXguZGV2OyBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBnZnMyQGxpc3RzLmxpbnV4LmRldjsgaW50ZWwtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgaW50ZWwtd2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBpb21tdUBsaXN0cy5saW51eC5kZXY7IGt2bUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBsaW51eC1idHJmc0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBjaWZzQHZnZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGVyb2ZzQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWV4dDRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsg
bGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtbGVkc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBtZWRpYUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LW1pcHNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7
DQo+IGxpbnV4LW1vZHVsZXNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtDQo+IG5mc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW9tYXBAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBtQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LXMzOTBAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gc2NzaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LXNjdHBAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zZWN1cml0eS0NCj4gbW9kdWxlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtc2hAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gc291bmRA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29t
Ow0KPiBsaW51eC10cmFjZS1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4gd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOw0KPiBudGZzM0BsaXN0cy5saW51eC5kZXY7IHNhbWJhLXRlY2huaWNhbEBs
aXN0cy5zYW1iYS5vcmc7IHNjaGVkLQ0KPiBleHRAbGlzdHMubGludXguZGV2OyB0YXJnZXQtZGV2
ZWxAdmdlci5rZXJuZWwub3JnOyB0aXBjLQ0KPiBkaXNjdXNzaW9uQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldDsgdjlmc0BsaXN0cy5saW51eC5kZXY7IFBoaWxpcHAgSGFobg0KPiA8cGhhaG4tb3NzQGF2
bS5kZT4NCj4gQ2M6IElseWEgRHJ5b21vdiA8aWRyeW9tb3ZAZ21haWwuY29tPjsgQWxleCBNYXJr
dXplDQo+IDxhbWFya3V6ZUByZWRoYXQuY29tPjsgVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2YUBk
dWJleWtvLmNvbT4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIDAzLzYxXSBj
ZXBoOiBQcmVmZXIgSVNfRVJSX09SX05VTEwNCj4gb3ZlciBtYW51YWwgTlVMTCBjaGVjaw0KPiAN
Cj4gUHJlZmVyIHVzaW5nIElTX0VSUl9PUl9OVUxMKCkgb3ZlciB1c2luZyBJU19FUlIoKSBhbmQg
YSBtYW51YWwgTlVMTA0KPiBjaGVjay4NCj4gDQo+IENoYW5nZSBnZW5lcmF0ZWQgd2l0aCBjb2Nj
aW5lbGxlLg0KPiANCj4gVG86IElseWEgRHJ5b21vdiA8aWRyeW9tb3ZAZ21haWwuY29tPg0KPiBU
bzogQWxleCBNYXJrdXplIDxhbWFya3V6ZUByZWRoYXQuY29tPg0KPiBUbzogVmlhY2hlc2xhdiBE
dWJleWtvIDxzbGF2YUBkdWJleWtvLmNvbT4NCj4gQ2M6IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwu
b3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6
IFBoaWxpcHAgSGFobiA8cGhhaG4tb3NzQGF2bS5kZT4NCj4gLS0tDQo+ICBmcy9jZXBoL2Rpci5j
ICB8IDIgKy0NCj4gIGZzL2NlcGgvc25hcC5jIHwgMiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvY2Vw
aC9kaXIuYyBiL2ZzL2NlcGgvZGlyLmMgaW5kZXgNCj4gODZkN2FhNTk0ZWE5OTMzNWFmM2U5MWE5
NWMwYTQxOGZkYzFiOGE4YS4uOTM0MjUwNzQ4YWU0ZmQ0YzE0OGZkMjdiZGY5MQ0KPiAxNzUwNDdj
Mjg3N2QgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvZGlyLmMNCj4gKysrIGIvZnMvY2VwaC9kaXIu
Yw0KPiBAQCAtODg5LDcgKzg4OSw3IEBAIGludCBjZXBoX2hhbmRsZV9ub3RyYWNlX2NyZWF0ZShz
dHJ1Y3QgaW5vZGUgKmRpciwNCj4gc3RydWN0IGRlbnRyeSAqZGVudHJ5KSAgew0KPiAgCXN0cnVj
dCBkZW50cnkgKnJlc3VsdCA9IGNlcGhfbG9va3VwKGRpciwgZGVudHJ5LCAwKTsNCj4gDQo+IC0J
aWYgKHJlc3VsdCAmJiAhSVNfRVJSKHJlc3VsdCkpIHsNCj4gKwlpZiAoIUlTX0VSUl9PUl9OVUxM
KHJlc3VsdCkpIHsNCj4gIAkJLyoNCj4gIAkJICogV2UgY3JlYXRlZCB0aGUgaXRlbSwgdGhlbiBk
aWQgYSBsb29rdXAsIGFuZCBmb3VuZA0KPiAgCQkgKiBpdCB3YXMgYWxyZWFkeSBsaW5rZWQgdG8g
YW5vdGhlciBpbm9kZSB3ZSBhbHJlYWR5DQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL3NuYXAuYyBi
L2ZzL2NlcGgvc25hcC5jIGluZGV4DQo+IDUyYjRjMjY4NGY5MjJiZmVkMzk1NTAzMTFlNzkzYmZl
MzYyMmNkMjYuLjUyOGFkNTgxYmUxNjA3MTNmOTE0MTYxMTU2NTkNCj4gZTJkYzZmMjU5NTc2IDEw
MDY0NA0KPiAtLS0gYS9mcy9jZXBoL3NuYXAuYw0KPiArKysgYi9mcy9jZXBoL3NuYXAuYw0KPiBA
QCAtOTAyLDcgKzkwMiw3IEBAIGludCBjZXBoX3VwZGF0ZV9zbmFwX3RyYWNlKHN0cnVjdCBjZXBo
X21kc19jbGllbnQNCj4gKm1kc2MsDQo+ICBiYWQ6DQo+ICAJZXJyID0gLUVJTzsNCj4gIGZhaWw6
DQo+IC0JaWYgKHJlYWxtICYmICFJU19FUlIocmVhbG0pKQ0KPiArCWlmICghSVNfRVJSX09SX05V
TEwocmVhbG0pKQ0KPiAgCQljZXBoX3B1dF9zbmFwX3JlYWxtKG1kc2MsIHJlYWxtKTsNCj4gIAlp
ZiAoZmlyc3RfcmVhbG0pDQo+ICAJCWNlcGhfcHV0X3NuYXBfcmVhbG0obWRzYywgZmlyc3RfcmVh
bG0pOw0KPiANCj4gLS0NCj4gMi40My4wDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlv
bm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==
